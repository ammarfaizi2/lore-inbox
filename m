Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbUA3Pdw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 10:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbUA3Pdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 10:33:52 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:21691 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261799AbUA3Pdq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 10:33:46 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Catalin BOIE <util@deuroconsult.ro>
Subject: Re: 2.6.2-rc2 Interactivity problems with SMP + HT
Date: Fri, 30 Jan 2004 10:33:43 -0500
User-Agent: KMail/1.6
Cc: "Robert M. Hyatt" <hyatt@cis.uab.edu>,
       Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org,
       linux-smp@vger.kernel.org
References: <Pine.LNX.4.44.0401290901510.21120-100000@crafty.cis.uab.edu> <Pine.LNX.4.58.0401300919520.8217@hosting.rdsbv.ro>
In-Reply-To: <Pine.LNX.4.58.0401300919520.8217@hosting.rdsbv.ro>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401301033.43909.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.53.166] at Fri, 30 Jan 2004 09:33:44 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 January 2004 02:25, Catalin BOIE wrote:
>On Thu, 29 Jan 2004, Robert M. Hyatt wrote:
>> It might be some IDE disk I/O that results from flushing buffers
>> or whatever.  I don't see this on my SCSI boxes, but I have seen
>> an IDE box get sluggish at times due to I/O.
>
>It is possible.
>vmstat shows a lot of writes when this happen.
>Seems that even reads hangs.
>I remember tat I was in pine and I tried to save a small file (under
> 1k) and it took 5-7 seconds to do it.
>
I'm having similar problems with kmail on the later kernels. Sometimes 
it works just fine, and in the middle of typing a nessage it can get 
laggy as hell, cursor motions with the arrow keys are down to 1 space 
a second, and gkrellm is saying the user apps are at 100% cpu.  
Screen redraws for a page up or page down might take 3 or 4 seconds.
Or it can get over it. (sometimes)

>> On Thu, 29 Jan 2004, Nick Piggin
>>
>> wrote:
>> > Catalin BOIE wrote:
>> > >Hello!
>> > >
>> > >First, thank you very much for the effort you put for Linux!
>> > >
>> > >I have a Intel motherboard with SATA (2 Maxtor disks).
>> > >CPUs: 2 x 2.4GHz PIV HT = 4 processors (2 virtual)
>> > >1 GB RAM.
>> > >
>> > >Load: postgresql and apache. Very low load (3-4 clients).
>> > >
>> > >RAID: Yes, soft RAID1 between the 2 disks.
>> > >
>> > >I have times when the console freeze for 3-4 seconds!
>> > >2.6.0-test11 had the same problem (maybe longer times).
>> > >2.6.1-rc2 worked good in this respect but crashed after 2 days.
>> > > :( 2.6.2-rc2 is back with the delay.
>> > >
>> > >Do you know why this can happen?
>> >
>> > There haven't been many scheduler changes there recently so
>> > maybe its something else.
>> >
>> > But you could try the latest -mm kernels. They have some
>> > Hyperthreading work in them (you need to enable
>> > CONFIG_SCHED_SMT).
>> >
>> > -
>> > To unsubscribe from this list: send the line "unsubscribe
>> > linux-smp" in the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at 
>> > http://vger.kernel.org/majordomo-info.html
>>
>> --
>> Robert M. Hyatt, Ph.D.          Computer and Information Sciences
>> hyatt@uab.edu                   University of Alabama at
>> Birmingham (205) 934-2213                  136A Campbell Hall
>> (205) 934-5473 FAX              Birmingham, AL 35294-1170
>
>---
>Catalin(ux) BOIE
>catab@deuroconsult.ro
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty: soap,
ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
