Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316885AbSFVX7Y>; Sat, 22 Jun 2002 19:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316892AbSFVX7X>; Sat, 22 Jun 2002 19:59:23 -0400
Received: from quimbies.gnus.org ([80.91.231.2]:4736 "EHLO quimbies.gnus.org")
	by vger.kernel.org with ESMTP id <S316885AbSFVX7X>;
	Sat, 22 Jun 2002 19:59:23 -0400
X-Now-Playing: Herbert's _Around The House_: "In The Kitchen"
To: linux-kernel@vger.kernel.org
Subject: Problems with Maxtor 4G160J8 and 2.4.19-* +/- ac*
From: Lars Magne Ingebrigtsen <larsi@gnus.org>
Date: Sun, 23 Jun 2002 01:58:59 +0200
Message-ID: <m3ofe2vpa4.fsf@quimbies.gnus.org>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.2.50
 (i686-pc-linux-gnu)
X-Face: |J<QVf=k`T-jXM)(_(Kd|tqyDY1F9w~?HqTZRE,BiLSV.!iapu2!y8nzv|(}$38JkG.?nkl
 TE9i$9P*ulVWX+].9ixf)@S
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got an ASUS A7A266-E motherboard and a 160GB Maxtor hard drive.
The only kernel I've managed to work with this combination is 2.4.18
with Hedrick's IDE patches.

I've tried quite a few of the 2.4.19-pre patches, with or without
various -ac patches, including pre10 + ac2, and they all basically
display one of two behaviors: The machine either hangs just before
detecting the disk, or when doing the partition check for the disk.

Below is the relevant section from dmesg from 2.4.18.

Anybody got any ideas?  What can I do to help debug this?

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 20
PCI: No IRQ known for interrupt pin A of device 00:04.0. Please try using pci=biosirq.
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd400-0xd407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: hdc:pio, hdd:DMA
hda: FUJITSU MPG3307AT, ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hdd: Maxtor 4G160J8, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 60046560 sectors (30744 MB) w/2048KiB Cache, CHS=3737/255/63
hdd: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63
Partition check:
 hda: hda1 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 >
 hdd: hdd1

-- 
(domestic pets only, the antidote for overdose, milk.)
   larsi@gnus.org * Lars Magne Ingebrigtsen
