Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbULaSWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbULaSWX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 13:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbULaSWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 13:22:23 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:54264 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S262133AbULaSWQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 13:22:16 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org, ofeeley@gmail.com
Subject: Re: the umount() saga for regular linux desktop users
Date: Fri, 31 Dec 2004 13:22:14 -0500
User-Agent: KMail/1.7
Cc: William <wh@designed4u.net>
References: <200412311741.02864.wh@designed4u.net> <2b8348ba041231094816d02456@mail.gmail.com>
In-Reply-To: <2b8348ba041231094816d02456@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412311322.14359.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [151.205.52.185] at Fri, 31 Dec 2004 12:22:15 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 December 2004 12:48, Ush wrote:
>On Fri, 31 Dec 2004 17:41:02 +0000, William <wh@designed4u.net> 
wrote:
>> Regularly, when attempting to umount() a filesystem I receive
>> 'device is busy' errors. The only way (that I have found) to solve
>> these problems is to go on a journey into processland and kill all
>> the guilty ones that have tied themselves to the filesystem
>> concerned.
>
>Even a lazy umount doesn't work?  "umount -l <filesystem-name>"
>
>> In my opinion, in order for linux to be trully user friendly, "a
>> umount() should NEVER fail" (even if the device containing the
>> filesystem is no longuer attached to the system). The kernel
>> should do it's best to satisfy the umount request and cleanup.
>> Maybe the kernel could try some of the following:
>
>Would it be user-friendly if this forcible umount caused the user to
> lose data?

No, it wouldn't be user friendly, but it would sure be user 
educational when he asked why his resume dissappeared.

Let me toss this out for discussion.

There are some times when the usual 5 second flush schedule should be 
tossed out the window, and the data written immediately.  A quickly 
unpluggable usb memory dongle is a prime candidate to bite the user 
precisely where it hurts.  Floppies also fit this same scenario, I 
don't know at the times I've written an image with dd, got up out of 
my chair and went to the machine and slapped the eject button to 
discover to my horror, that when my hand came away from the button 
with disk in hand, the frigging access led was now on that wasn't 
when I tapped the button.

Usually just re-inserting the disk allows the write to continue and 
nothing is lost.  But I've learned to do a couple of sync's and the 
umount before pulling the disk.  But theres a whole lot more protocol 
to doing that with a usb device.

Thats one of the things that could be done to improve the user 
friendliness of linux.  Really Old Hands are used to those limits, 
but newbies just coming in from the dark side are not impressed when 
its something like that as nearly their first exposure to linux.

>Oisin
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.31% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
