Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315337AbSF3RS6>; Sun, 30 Jun 2002 13:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315338AbSF3RS5>; Sun, 30 Jun 2002 13:18:57 -0400
Received: from [62.70.58.70] ([62.70.58.70]:60293 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S315337AbSF3RS4> convert rfc822-to-8bit;
	Sun, 30 Jun 2002 13:18:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: linux-raid@vger.rutgers.edu,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Can't boot from /dev/md0 (RAID-1) (more info)
Date: Sun, 30 Jun 2002 19:21:26 +0200
User-Agent: KMail/1.4.1
References: <200206301419.26254.roy@karlsbakk.net>
In-Reply-To: <200206301419.26254.roy@karlsbakk.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206301921.26503.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

see below for my original post

I've uploaded some files to http://karlsbakk.net/bugs/ that may help to 
explain the problem. Still - I can't boot from nothing but floppy.

thanks

roy

On Sunday 30 June 2002 14:19, Roy Sigurd Karlsbakk wrote:
> hi
>
> I hope this is not OT - didn't find any LILO mailing list. after trying
> virtually everything - can anyone help me with a tip?
>
> Running 2.4.19-pre10-ac2, RedHat 7.3 (LILO version 21.4-4), I have root on
> /dev/md0 on RAID-1 on /dev/hda1 and /dev/hdb1. I've tried the howto at
> http://www.tldp.org/HOWTO/mini/Boot+Root+Raid+LILO-3.html#ss3.1, but it
> still doesn't help me. lilo just tells me "L 99 99 99 99 ..." some half a
> page, and then stops.I'm trying. All the time it prints this, it seems to
> be searching the floppy for some reason.
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
>
> sector/head/cylinder is corrected to the actual data reported from 'fdisk
> -ul'.
>
> When trying to set. boot=/dev/hdm (which is the first drive on the on-board
> chipset), lilo installs, and I get LI instead of L 99 99 ... Same result
> with LBA32.
>
> I also have another box with Linux, running SuSE 7.2 (LILO version 21.7-5)
> with RAID-1 on two drives. Here everything works fine
>
> thanks for all help
>
> roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

