Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267318AbSLKV7I>; Wed, 11 Dec 2002 16:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267320AbSLKV7I>; Wed, 11 Dec 2002 16:59:08 -0500
Received: from chaos.analogic.com ([204.178.40.224]:63620 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267318AbSLKV7H>; Wed, 11 Dec 2002 16:59:07 -0500
Date: Wed, 11 Dec 2002 17:10:11 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: root@ajvar.org
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Question
In-Reply-To: <Pine.LNX.4.33L2.0212111646060.19911-100000@rtlab.med.cornell.edu>
Message-ID: <Pine.LNX.3.95.1021211165652.27139A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2002 root@ajvar.org wrote:

> How do I see my C: drive in linux?  I wanted to play my mp3's but there is
> not C: drive.
> 
> Also, why can't I use AOL in Linux?  I put the CD in but nothing happens.
> 
> Thanks,
> 
> -- Muffy
> 

I pretend that this is not a troll. From the root account, you
look at  /etc/fstab and see if your distributor put an entry
into this condiguration file. You do "more /etc/fstab" to see
this file. Look for msdos for the type. If you find such a
type, the second column shows where it is mounted. You can
"cd" to that mount-point to look at the file-system.

If you don't have an entry, you can try:

mount -t mdsos /dev/hda1 /mnt

This might mount a ms-dos file-system on your first drive if
it exists. Drive C: might be NTFS instead of DOS. You can just
execute "mount /dev/hda1 /mnt" and see if that works.

As for AOL, maybe you have a AOL CD that will work under Linux.
You need to mount that CD to review its contents. There should
be a cdrom sim-link already installed so you should be able to
do:
   mount /dev/cdrom /mnt
This should make it visible on the /mnt mount-point. I really
doubt if AOL put linux executables on that CD, though. You can
use your favorite web-crawler (Netscape) to connect to AOL and
it will save your configuration after you set everything up. Once
you are on the internet (which you are), you really don't need
that CD/ROM.

Further inquiries should be sent to your distributor's help-desk,
not the linux-kernel list.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


