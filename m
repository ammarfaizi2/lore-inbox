Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265443AbUBAU64 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 15:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265445AbUBAU6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 15:58:55 -0500
Received: from mail.tmr.com ([216.238.38.203]:17673 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S265443AbUBAU6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 15:58:51 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.2-rc2 Interactivity problems with SMP + HT
Date: Sun, 01 Feb 2004 16:00:31 -0500
Organization: TMR Associates, Inc
Message-ID: <401D68EF.9030109@tmr.com>
References: <Pine.LNX.4.44.0401290901510.21120-100000@crafty.cis.uab.edu> <Pine.LNX.4.58.0401300919520.8217@hosting.rdsbv.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1075669104 10086 192.168.12.10 (1 Feb 2004 20:58:24 GMT)
X-Complaints-To: abuse@tmr.com
Cc: "Robert M. Hyatt" <hyatt@cis.uab.edu>,
       Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org,
       linux-smp@vger.kernel.org
To: Catalin BOIE <util@deuroconsult.ro>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.58.0401300919520.8217@hosting.rdsbv.ro>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Catalin BOIE wrote:
> On Thu, 29 Jan 2004, Robert M. Hyatt wrote:
> 
> 
>>
>>It might be some IDE disk I/O that results from flushing buffers or
>>whatever.  I don't see this on my SCSI boxes, but I have seen an IDE
>>box get sluggish at times due to I/O.
> 
> 
> It is possible.
> vmstat shows a lot of writes when this happen.
> Seems that even reads hangs.
> I remember tat I was in pine and I tried to save a small file (under 1k)
> and it took 5-7 seconds to do it.
> 
> 
>>On Thu, 29 Jan 2004, Nick Piggin
>>wrote:
>>
>>
>>>
>>>Catalin BOIE wrote:
>>>
>>>
>>>>Hello!
>>>>
>>>>First, thank you very much for the effort you put for Linux!
>>>>
>>>>I have a Intel motherboard with SATA (2 Maxtor disks).
>>>>CPUs: 2 x 2.4GHz PIV HT = 4 processors (2 virtual)
>>>>1 GB RAM.
>>>>
>>>>Load: postgresql and apache. Very low load (3-4 clients).
>>>>
>>>>RAID: Yes, soft RAID1 between the 2 disks.
>>>>
>>>>I have times when the console freeze for 3-4 seconds!
>>>>2.6.0-test11 had the same problem (maybe longer times).
>>>>2.6.1-rc2 worked good in this respect but crashed after 2 days. :(
>>>>2.6.2-rc2 is back with the delay.
>>>>
>>>>Do you know why this can happen?
>>>>
>>>>
>>>
>>>There haven't been many scheduler changes there recently so
>>>maybe its something else.
>>>
>>>But you could try the latest -mm kernels. They have some
>>>Hyperthreading work in them (you need to enable CONFIG_SCHED_SMT).

Another possible improvement might come from the recent ide changes 
posted here for evaluation. There was a change to not block all devices 
or even all devices on a cable if one device delayed. I believe it was 
if a command didn't finish as intended, but I don't have it handy since 
I sent it off for testing tomorrow on a system which may have that problem.

There's a good bit of work on hangs happening right now, so you could 
wait or dig up the patches and try them. I think they were by Davin 
McCall if memory serves.


-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
