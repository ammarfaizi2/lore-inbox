Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbVJYVAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbVJYVAc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 17:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbVJYVAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 17:00:32 -0400
Received: from [139.30.44.2] ([139.30.44.2]:35631 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S932380AbVJYVAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 17:00:31 -0400
Date: Tue, 25 Oct 2005 23:00:28 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Call for PIIX4 chipset testers
In-Reply-To: <Pine.LNX.4.64.0510251042420.10477@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0510252257280.5647@gans.physik3.uni-rostock.de>
References: <Pine.LNX.4.64.0510251042420.10477@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Famous Asus P2B-DS Mainboard doesn't show up anything special:

> dmesg -s 1000000 | grep PIIX4
PCI quirk: region e400-e43f claimed by PIIX4 ACPI
PCI quirk: region e800-e81f claimed by PIIX4 SMB
PIIX4 devres B PIO at 0290-0297
PIIX4: IDE controller at PCI slot 0000:00:04.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later

> cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
a400-a41f : 0000:00:0c.0
  a400-a41f : ne2k-pci
a800-a87f : 0000:00:0b.0
  a800-a87f : FM801
b000-b0ff : 0000:00:06.0
b400-b41f : 0000:00:04.2
  b400-b41f : uhci_hcd
b800-b80f : 0000:00:04.1
  b800-b807 : ide0
  b808-b80f : ide1
d000-dfff : PCI Bus #01
  d800-d8ff : 0000:01:00.0
e400-e43f : 0000:00:04.3
e800-e81f : 0000:00:04.3
  e800-e807 : piix4-smbus

> /sbin/lspci -xxx
00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host 
bridge (rev 02)
00: 86 80 90 71 06 01 10 22 02 00 00 06 00 40 00 00
10: 08 00 00 e4 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP 
bridge (rev 02)
00: 86 80 91 71 17 01 20 02 02 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 d0 d0 a0 22
20: 80 e0 60 e1 f0 e2 f0 e3 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 88 00

00:04.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
00: 86 80 10 71 0f 00 80 02 02 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
00: 86 80 11 71 05 00 80 02 01 80 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 b8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01)
00: 86 80 12 71 05 00 80 02 01 00 03 0c 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 b4 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 04 00 00

00:04.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
00: 86 80 13 71 03 00 80 02 02 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:06.0 SCSI storage controller: Adaptec AHA-2940U2/U2W / 7890/7891
00: 05 90 1f 00 16 00 90 02 00 00 00 01 00 20 00 80
10: 01 b0 00 00 04 00 00 e0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 05 90 0f 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 09 01 27 19

00:09.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 02)
00: 9e 10 6e 03 06 00 80 02 02 00 00 04 00 20 80 00
10: 08 00 00 e2 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 10 01 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 10 28

00:09.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 02)
00: 9e 10 78 08 06 00 80 02 02 00 80 04 00 20 80 00
10: 08 00 80 e1 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 10 01 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 04 ff

00:0b.0 Multimedia audio controller: Fortemedia, Inc Xwave QS3000A [FM801] 
(rev a0)
00: 19 13 01 08 07 00 90 02 a0 00 01 04 00 20 80 00
10: 01 a8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 19 13 19 13
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 04 28

00:0b.1 Input device controller: Fortemedia, Inc Xwave QS3000A [FM801] 
(rev a0)
00: 19 13 01 08 07 00 90 02 a0 00 80 09 00 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 19 13 19 13
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 02 04 28

00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
00: ec 10 29 80 03 00 00 02 00 00 00 02 00 00 00 00
10: 01 a4 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 29 80
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC AGP 
(rev 7a)
00: 02 10 5a 47 87 00 90 02 7a 00 00 03 08 40 00 00
10: 08 00 00 e3 01 d8 00 00 00 00 80 e0 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 10 84 00
30: 00 00 fe e2 5c 00 00 00 00 00 00 00 48 00 08 00

