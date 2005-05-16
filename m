Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVEPDGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVEPDGE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 23:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVEPDGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 23:06:03 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:37035 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S261255AbVEPDFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 23:05:55 -0400
Date: Sun, 15 May 2005 23:05:52 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Disk write cache (Was: Hyper-Threading Vulnerability)
In-reply-to: <Pine.LNX.4.58.0505160414170.6560@artax.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Message-id: <200505152305.52782.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <1115963481.1723.3.camel@alderaan.trey.hu>
 <200505152156.18194.gene.heskett@verizon.net>
 <Pine.LNX.4.58.0505160414170.6560@artax.karlin.mff.cuni.cz>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 May 2005 22:24, Mikulas Patocka wrote:
>On Sun, 15 May 2005, Gene Heskett wrote:
>> >There is a large amount of yammering and speculation in this
>> > thread.
>>
>> I agree, and frankly I'm just another  of the yammerers as I don't
>> have the clout to be otherwise.
>>
>> >Most disks do seem to obey SYNC CACHE / FLUSH CACHE.
>> >
>> > Jeff
>>
>> I don't think I have any drives here that do obey that, Jeff.  I
>> got curious about this, oh, maybe a year back when this discussion
>> first took place on another list, and wrote a test gizmo that
>> copied a large file, then slept for 1 second and issued a sync
>> command.  No drive led activity until the usual 5 second delay of
>> the filesystem had expired.  To me, that indicated that the sync
>> command was being returned as completed without error and I had my
>> shell prompt back long before the drives leds came on.  Admittedly
>> that may not be a 100% valid test, but I really did expect to see
>> the leds come on as the sync command was executed.
>>
>> I also have some setup stuff for heyu that runs at various times
>> of the day, reconfigureing how heyu and xtend run 3 times a day
>> here, which depends on a valid disk file, and I've had to use
>> sleeps for guaranteeing the proper sequencing, where if the sync
>> command actually worked, I could get the job done quite a bit
>> faster.
>>
>> Again, probably not a valid test of the sync command, but thats
>> the evidence I have.  I do not believe it works here, with any of
>> the 5 drives currently spinning in these two boxes.
>
>Note, that Linux can't send FLUSH CACHE command at all (until very
> recent 2.6 kernels). So write cache is always dangerous under
> Linux, no matter if disk is broken or not.
>
>Another note: according to posix, sync() is asynchronous --- i.e. it
>initiates write, but doesn't have to wait for complete. In linux,
> sync() waits for writes to complete, but it doesn't have to in
> other OSes.
>
>Mikulas
>
Humm, I'm getting the impression I should rerun that test script if I 
can find it.  I believe the last time I tried it, I was running a 
2.4.x kernel, right now 2.6.12-rc1.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
