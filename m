Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263639AbUAHEQZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 23:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbUAHEQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 23:16:25 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:16589 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S263639AbUAHEQW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 23:16:22 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Linus Torvalds <torvalds@osdl.org>, Olaf Hering <olh@suse.de>
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
Date: Wed, 7 Jan 2004 23:16:18 -0500
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200401012333.04930.arvidjaar@mail.ru> <20040107205237.GB16832@suse.de> <Pine.LNX.4.58.0401071801310.12602@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0401071801310.12602@home.osdl.org>
Organization: Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401072316.18169.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.61.108] at Wed, 7 Jan 2004 22:16:21 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 January 2004 21:03, Linus Torvalds wrote:
>On Wed, 7 Jan 2004, Olaf Hering wrote:
>> > Then, user space can just access "/dev/sda1" or whatever, and
>> > the act of accessing it will force the re-scan.
>>
>> How would that work? I mean, what will a tool that cares about a
>> block event do? It will run a fdisk/parted -l /udev/sda to figure
>> out what partitions are there (just to skip an extended partition
>> sda5, as example) and finds no media. That tool will never run
>> again on sda, unless a new block add event comes in. So some sort
>> of polling is required for that class of devices.
>
>What is your problem?
>
>I'll use a very common and simple case that I do myself: use any USB
> media reader to read a camera card. It will be a FAT filesystem on
> the first partition, so your fstab might look like this:
>
>	/dev/sda1               /mnt/smartmedia         vfat   
> noauto,user,ro  0 0
>
>and then you just do "mount /mnt/smartmedia", and you're done.
>
>This works. I do it all the time. You just stick in your card, and
> mount it, and off it foes. No "fdisk" or "parted" _anywhere_.

I do too, except the card is still in my camera when I do it.  But, I 
do have to ask, why the ro?  I regularly do housekeeping in the 
camera once I've downloaded the images I want.  The only problem I've 
had is related to deleting the first images all in a row.  Apparently 
fat thinks an empty sector is the end of the directory.  So one must 
delete on LIFO basis.

>		Linus
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

