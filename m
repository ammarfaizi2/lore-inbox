Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317018AbSFWOjH>; Sun, 23 Jun 2002 10:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317032AbSFWOjG>; Sun, 23 Jun 2002 10:39:06 -0400
Received: from quimbies.gnus.org ([80.91.231.2]:14208 "EHLO quimbies.gnus.org")
	by vger.kernel.org with ESMTP id <S317018AbSFWOjF>;
	Sun, 23 Jun 2002 10:39:05 -0400
Mail-Copies-To: never
X-Now-Playing: Various's _American Breakbeat (1)_: "Electric Company -
 Octelo Gopod"
To: linux-kernel@vger.kernel.org
Subject: ALI15X3 (was: Problems with Maxtor 4G160J8 and 2.4.19-* +/- ac*)
References: <m3ofe2vpa4.fsf@quimbies.gnus.org>
From: Lars Magne Ingebrigtsen <larsi@gnus.org>
Date: Sun, 23 Jun 2002 16:38:44 +0200
In-Reply-To: <m3ofe2vpa4.fsf@quimbies.gnus.org> (Lars Magne Ingebrigtsen's
 message of "Sun, 23 Jun 2002 01:58:59 +0200")
Message-ID: <m3hejurrez.fsf@quimbies.gnus.org>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.2.50
 (i686-pc-linux-gnu)
X-Face: |J<QVf=k`T-jXM)(_(Kd|tqyDY1F9w~?HqTZRE,BiLSV.!iapu2!y8nzv|(}$38JkG.?nkl
 TE9i$9P*ulVWX+].9ixf)@S
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Magne Ingebrigtsen <larsi@gnus.org> writes:

> I've tried quite a few of the 2.4.19-pre patches, with or without
> various -ac patches, including pre10 + ac2, and they all basically
> display one of two behaviors: The machine either hangs just before
> detecting the disk, or when doing the partition check for the disk.

[...]

> ALI15X3: IDE controller on PCI bus 00 dev 20
> PCI: No IRQ known for interrupt pin A of device 00:04.0. Please try using pci=biosirq.
> ALI15X3: chipset revision 196
> ALI15X3: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xd400-0xd407, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: hdc:pio, hdd:DMA

After poking around a bit, it seems like the real problem might be
with the ALI15X3 driver.  I disabled that driver, and now I can boot
using 2.4.19-pre10-ac2.  Of course, that leaves me with no DMA...

So -- is this a general problem with this driver, or does it only
show up when using disks bigger than 128GiB?

-- 
(domestic pets only, the antidote for overdose, milk.)
   larsi@gnus.org * Lars Magne Ingebrigtsen
