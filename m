Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316043AbSHARfA>; Thu, 1 Aug 2002 13:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316161AbSHARfA>; Thu, 1 Aug 2002 13:35:00 -0400
Received: from h-64-105-137-35.SNVACAID.covad.net ([64.105.137.35]:32407 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S316043AbSHARe7>; Thu, 1 Aug 2002 13:34:59 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 1 Aug 2002 10:37:55 -0700
Message-Id: <200208011737.KAA10255@adam.yggdrasil.com>
To: vandrove@vc.cvut.cz
Subject: Re: [PATCH] 2.5.29 IDE 110
Cc: linux-kernel@vger.kernel.org, martin@dalecki.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On  1 Aug 02 at 2:40, Marcin Dalecki wrote:
>> 
>> - Eliminate support for "sector remapping". loop devices can handle
>>     stuff like that. All the custom DOS high system memmory loaded
>>     BIOS workaround tricks are obsolete right now. If anywhere it should
>>     be the FAT filesystem code which should be clever enough to deal with
>>     it by adjusting it's read/write methods.
>
>Hi Marcin,
>  I'm using this on one system here - it has BIOS without LBA32, and
>without support for >30GB disks, but I needed to put large disk with
>already existing system to it, and using some disk manager was only
>choice (EZDrive, using 0_to_1 remap)... I know that 0_to_1 remap
>is broken for nr_sectors > 1, but it is hard to use loop device if
>system does not come up without boot manager at all.
>                                    Best regards,
>                                        Petr Vandrovec
>                                        vandrove@vc.cvut.cz

	You might want to examine:
ftp://ftp.yggdrasil.com//pub/dist/booting/make-ramdisk/make-ramdisk-0.38.tar.gz

	This script builds an initial ramdisk that then switches to
another root (which you can also pass via a lilo command line argument
"root2=/dev/....").  It supports setting up /dev/loop devices for
encrypted root partitions, and you should be able to adapt it use
/dev/loop/nnn for non-encrypted roots.

	Note that I am not arguing whether the "sector remapping" code
should stay or go.  I don't know enough about that right now to have
an opinion.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
