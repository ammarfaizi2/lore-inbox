Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262967AbSJGKah>; Mon, 7 Oct 2002 06:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262969AbSJGKah>; Mon, 7 Oct 2002 06:30:37 -0400
Received: from 62-190-216-92.pdu.pipex.net ([62.190.216.92]:11015 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S262967AbSJGKaf>; Mon, 7 Oct 2002 06:30:35 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210071044.g97Ai838001683@darkstar.example.net>
Subject: Re: LILO probs
To: roy@karlsbakk.net (Roy Sigurd Karlsbakk)
Date: Mon, 7 Oct 2002 11:44:07 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200210071057.16311.roy@karlsbakk.net> from "Roy Sigurd Karlsbakk" at Oct 07, 2002 10:57:16 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Disk /dev/hda: 16 heads, 63 sectors, 38792 cylinders
> > > >
> > > > Nr AF  Hd Sec  Cyl  Hd Sec  Cyl    Start     Size ID
> > > >  1 80   1   1    0  15  63  609       63   614817 83
> > > >  2 00   0   1  610  15  63 1023   614880 10486224 83
> > > >  3 00  15  63 1023  15  63 1023 11101104  4194288 83
> > > >  4 00  15  63 1023  15  63 1023 15295392 23806944 0f
> > > >  5 00  15  63 1023  15  63 1023       63  2097585 83
> > > >  6 00  15  63 1023  15  63 1023       63  1048257 83
> > > >  7 00  15  63 1023  15  63 1023       63  1048257 82
> > > >  8 00  15  63 1023  15  63 1023       63 19612593 83
> >
> > It's a very confusing table, but more importantly it seems to imply that
> > /dev/hda{5,6,7,8} all start at cylinder 63, and end in a variety of places.
> >
> > If this is an accurate representation of the partition table on this disk,
> > I would suggest you recover what you can from it, and start over.
> >
> > Better would be to have a look at the partition table with something that
> > can fix it, like fdisk, sfdisk or parted. Example:
> >
> > sfdisk -l /dev/hda
> 
> hm
> 
> root@pbx /usr/src/asterisk># sfdisk -l /dev/hda
> 
> Disk /dev/hda: 38792 cylinders, 16 heads, 63 sectors/track
> Units = cylinders of 516096 bytes, blocks of 1024 bytes, counting from 0
> 
>    Device Boot Start     End   #cyls   #blocks   Id  System
> /dev/hda1   *      0+    609     610-   307408+  83  Linux
> /dev/hda2        610   11012   10403   5243112   83  Linux
> /dev/hda3      11013   15173    4161   2097144   83  Linux
> /dev/hda4      15174   38791   23618  11903472    f  Win95 Ext'd (LBA)
> /dev/hda5      15174+  17254    2081-  1048792+  83  Linux
> /dev/hda6      17255+  18294    1040-   524128+  83  Linux
> /dev/hda7      18295+  19334    1040-   524128+  82  Linux swap
> /dev/hda8      19335+  38791   19457-  9806296+  83  Linux
> 
> just lists the table
> 
> but - it works, but I need to boot off a floppy, and I really don't want to 
> start over reinstalling this.
> 
> any ideas how I can make LILO/GRUB work with this?

When you say, 'boot off a floppy', what do you mean:

1. Boot a raw kernel image from a floppy

or

2. Boot a floppy containing LILO/GRUB?

If you mean 1, you are accessing the hard disk with the BIOS.

If you mean 2, you are never accessing the hard disk with the BIOS.

John.
