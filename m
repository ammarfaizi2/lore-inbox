Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSF3SzD>; Sun, 30 Jun 2002 14:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315406AbSF3SzC>; Sun, 30 Jun 2002 14:55:02 -0400
Received: from twinlark.arctic.org ([208.44.199.239]:21453 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S315388AbSF3SzB>; Sun, 30 Jun 2002 14:55:01 -0400
Date: Sun, 30 Jun 2002 11:57:26 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: linux-raid@vger.rutgers.edu,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Can't boot from /dev/md0 (RAID-1)
In-Reply-To: <200206301419.26254.roy@karlsbakk.net>
Message-ID: <Pine.LNX.4.44.0206301152150.1582-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

my system has 4 disks, but /dev/md0 is a RAID1 for /boot.  (/dev/md1 is a
RAID5 and LVM is on top of it...)  anyhow, this is what works for me.
i've even pulled out a disk and it still boots.

btw, you really don't want to put two drives on an IDE controller.  not
just for performance reasons -- if a master drive fails it can easily
prevent access to the slave... so you'll have a two disk failure on your
hands.  or maybe this is just urban legend and i'm spreading it further ;)

-dean

lba32
boot=/dev/md0
root=/dev/arctic/root
install=/boot/boot-text.b
map=/boot/map
prompt
timeout=150
raid-extra-boot=/dev/hde,/dev/hdg,/dev/hdi,/dev/hdk

password=XXXXXXXX

serial=0,38400n8
append="console=tty0 console=ttyS0,38400n8"

default=linux

image=/boot/vmlinuz
        initrd=/boot/initrd-lvm-2.4.19-pre3-ac1.gz
        label=linux
        restricted
        read-only


