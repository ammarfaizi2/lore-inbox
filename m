Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262427AbSI2JXM>; Sun, 29 Sep 2002 05:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262428AbSI2JXM>; Sun, 29 Sep 2002 05:23:12 -0400
Received: from gzp11.gzp.hu ([212.40.96.53]:14090 "EHLO gzp11.gzp.hu")
	by vger.kernel.org with ESMTP id <S262427AbSI2JXL>;
	Sun, 29 Sep 2002 05:23:11 -0400
To: linux-kernel@vger.kernel.org
From: "Gabor Z. Papp" <gzp@myhost.mynet>
Subject: 2.4.20-pre7-ac3 spurious 8259A interrupt
Organization: Who, me?
User-Agent: tin/1.5.13-20020703-gzp ("Chop Suey!") (UNIX) (Linux/2.4.20-pre8 (i686))
Message-ID: <1333.3d96c7c1.d91c5@gzp1.gzp.hu>
Date: Sun, 29 Sep 2002 09:28:33 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Asus TUSL2-C mobo

ide: Assuming 33MHz system bus speed for PIO modes; override
with idebus=xx
ICH2: IDE controller at PCI slot 00:1f.1
ICH2: chipset revision 2
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x9800-0x9807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x9808-0x980f, BIOS settings: hdc:DMA, hdd:pio

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xb800-0xb807,0xb402 on irq 9
ide3 at 0xb000-0xb007,0xa802 on irq 9

# cat /proc/interrupts 
           CPU0       
  0:     185641          XT-PIC  timer
  1:       3426          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          0          XT-PIC  rtc
  9:     266188          XT-PIC  ide2, ide3, eth0
 14:     229633          XT-PIC  ide0
 15:     229618          XT-PIC  ide1
NMI:          0 
ERR:          0

On heavy ide1 usage (disk present only on the primar
channel) I'm getting

	      spurious 8259A interrupt: IRQ15.

messages all the time.

