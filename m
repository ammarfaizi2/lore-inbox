Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315119AbSF3MmW>; Sun, 30 Jun 2002 08:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315120AbSF3MmW>; Sun, 30 Jun 2002 08:42:22 -0400
Received: from babel.spoiled.org ([217.13.197.48]:40088 "HELO a.mx.spoiled.org")
	by vger.kernel.org with SMTP id <S315119AbSF3MmV>;
	Sun, 30 Jun 2002 08:42:21 -0400
From: Juri Haberland <juri@koschikode.com>
To: roy@karlsbakk.net (Roy Sigurd Karlsbakk)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't boot from /dev/md0 (RAID-1)
X-Newsgroups: spoiled.linux.kernel
In-Reply-To: <200206301419.26254.roy@karlsbakk.net>
User-Agent: tin/1.4.5-20010409 ("One More Nightmare") (UNIX) (OpenBSD/2.9 (i386))
Message-Id: <20020630124445.6E95B11979@a.mx.spoiled.org>
Date: Sun, 30 Jun 2002 14:44:45 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200206301419.26254.roy@karlsbakk.net> you wrote:
> hi
> 
> I hope this is not OT - didn't find any LILO mailing list. after trying 
> virtually everything - can anyone help me with a tip?
> 
> Running 2.4.19-pre10-ac2, RedHat 7.3 (LILO version 21.4-4), I have root on 
> /dev/md0 on RAID-1 on /dev/hda1 and /dev/hdb1. I've tried the howto at 
> http://www.tldp.org/HOWTO/mini/Boot+Root+Raid+LILO-3.html#ss3.1, but it still 
> doesn't help me. lilo just tells me "L 99 99 99 99 ..." some half a page, and 
> then stops.I'm trying. All the time it prints this, it seems to be searching 
> the floppy for some reason.
> 
> The lilo.conf suggested by the above HOWTO, is this
> 
> # lilo.conf.hda - primary ide master
> disk=/dev/md0
> bios=0x80
> sectors=63
> heads=16
> cylinders=39770
> partition=/dev/md1
> start=63
> boot=/dev/hda
> map=/boot/map
> install=/boot/boot.b
> 
> image=/boot/bzImage
>         root=/dev/md0
>         read-only
>         label=LinuxRaid

Hi,
I had this once and resolved it with adding a "default" line to the
lilo.conf:
default = LinuxRaid

Also have boot=/dev/md0, not boot=/dev/hda.

Cheers,
Juri

-- 
Juri Haberland  <juri@koschikode.com> 

