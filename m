Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268317AbUJOU1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268317AbUJOU1N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 16:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUJOU1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 16:27:12 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:54682 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id S268317AbUJOU1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 16:27:08 -0400
Date: Fri, 15 Oct 2004 13:27:02 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Alistair John Strachan <alistair@devzero.co.uk>
cc: a.ledvinka@promon.cz, linux-kernel@vger.kernel.org
Subject: Re: promise (105a:3319) unattended boot
In-Reply-To: <200410152112.18691.alistair@devzero.co.uk>
Message-ID: <Pine.LNX.4.61.0410151317090.21618@twin.uoregon.edu>
References: <OF77D5B4E1.A38CC6EC-ONC1256F2E.004E78A5-C1256F2E.0050B72C@promon.cz>
 <200410152112.18691.alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2004, Alistair John Strachan wrote:

> On Friday 15 Oct 2004 15:41, you wrote:
>> Hello.
>>
>> Got here http://pciids.sourceforge.net/iii/?i=105a3319
>> As http://linux.yyz.us/sata/faq-sata-raid.html#tx4 calls it
>> soft/accelerator raid version
>> Going to use latest kernel from /pub/linux/kernel/v2.4/
>>
>> But bios even with keyboard unplugged requires me to press one of 2 keys
>> to either define array OR continue booting in case no array is defined.
>>
>> What would you recommend me to do?
>> - stay with ft3xx module from promise  and 10 level RAID array and not use
>> sata_promise?
>> - define some array in bios and completely ignore that fact and use
>> sata_promise, bypass bios and define custom linux soft raid arrays?
>
> If you define an array, AFAIK the controller doesn't do anything physically to
> the discs. It's just the settings it tells the promise driver (thus software
> RAID). If you define ANY array, the drives should still be detected by Linux
> individually and you can use linux/md to RAID them.

for sanity purposes we generally define spanned volumes each composed of 
one disk. this still bites you ocasionaly because the controller will 
pause when one or more disks are missing which otherwise may or may not be 
catostrophic ie if you have a software raid-5 raid 1 or 10 stripe it'll 
probably do fine with one disk missing, but the promise will freak again.

> This is how I'm doing it on my older PATA promise card.
>
>> - anything else (no bios flashing and no hw hacking)?

non-raid sata or pata promise cards are darn cheap...

>
>

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu 
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2

