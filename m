Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265935AbTFVWGN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 18:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265937AbTFVWGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 18:06:13 -0400
Received: from lucidpixels.com ([66.45.37.187]:48558 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S265935AbTFVWGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 18:06:09 -0400
Date: 22 Jun 2003 22:20:14 -0000
Message-ID: <20030622222014.7827.qmail@lucidpixels.com>
From: war@lucidpixels.com
To: linux-kernel@vger.kernel.org
Subject: Spurious 8259A Interrupt IRQ 7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jun 22 09:29:51 p500 kernel: spurious 8259A interrupt: IRQ7.

# cat /proc/interrupts 
           CPU0       
  0:    6486628          XT-PIC  timer
  1:          6          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:     647546          XT-PIC  serial
  5:          0          XT-PIC  Crystal audio controller
  8:          1          XT-PIC  rtc
  9:    3548883          XT-PIC  eth2, eth3
 11:    2601852          XT-PIC  ide2, ide3, eth0, eth1
 12:         38          XT-PIC  PS/2 Mouse
 14:     121950          XT-PIC  ide0
 15:         25          XT-PIC  ide1
NMI:          0 
LOC:    6486487 
ERR:         11
MIS:          0

Is there anyway to narrow down what could be causing this error, as nothing uses IRQ7?

The system is a Dell Optiplex GX1 p.

http://docs.us.dell.com/docs/systems/d_gx1p/irq.htm

It says IRQ7 is the parallel port.

I have the parallel port disabled on in the bios.

http://www.ussg.iu.edu/hypermail/linux/kernel/0301.2/0960.html

An earlier thread on LKML, a lot of different opninions as to if this is a serious problem or not and what to do about it.

Should I take each board out and run the system until I see the message again?

I've only seen this message once.

Today that is.

Using all PCI nics.

kern.warn:Jun 10 23:30:43 p500 kernel: spurious 8259A interrupt: IRQ7.
kern.warn:Jun 11 22:29:44 p500 kernel: spurious 8259A interrupt: IRQ7.
kern.warn:Jun 14 20:24:34 p500 kernel: spurious 8259A interrupt: IRQ7.
kern.warn:Jun 20 00:10:24 p500 kernel: spurious 8259A interrupt: IRQ7.

Could this have anything to do with using the onboard ISA Sound card?

(It uses IRQ5).

I am using Kernel 2.4.21.

 linux-2.4.21.tar.bz2 . . . . . . Jun 13 14:52  27865k

And those logs go back to the 10th, before I was running 2.4.20, so it is nothing to do with the kernel.

What did *I* change?

The only Ithing I've recently change wd was: I went from 3 ISA boaerds to PCI

and took out an ol dd ATA/100 board and put in a ATA/133 board (Promise) (both)

the 3isas were 53com 90509s, 2 TP only, 1 aui,bnc,tp

it is the same configuration now but with PCI and 3com 905bs (2), and 1 3com 900 combo (pci)

here is lspci output

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:0e.0 Unknown mass storage controller: Promise Technology, Inc. 20269 (rev 02)
00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
00:11.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X/2X (rev 5c)
02:09.0 Ethernet controller: 3Com Corporation 3c900 Combo [Boomerang]
02:0a.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
02:0b.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)

what would be the best way to determine what is causing his this problem?

