Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282353AbRKXDGl>; Fri, 23 Nov 2001 22:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282356AbRKXDGb>; Fri, 23 Nov 2001 22:06:31 -0500
Received: from spoke.minihub.org ([203.14.165.194]:62215 "EHLO
	spoke.minihub.org") by vger.kernel.org with ESMTP
	id <S282353AbRKXDGR>; Fri, 23 Nov 2001 22:06:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Iain <iain@minihub.org>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] pcnet_cs
Date: Sat, 24 Nov 2001 14:03:31 +1100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011124030624Z282353-17408+19122@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been experiencing problems with my PCMCIA ethernet card. I think there 
may be an underlying hardware problem but it works with some versions of the 
kernel (and win 98). 

The problem is as follows. If I boot up kernel 2.4.15 (and 2.4.14) with the 
card inserted when cardmanager starts I get:

eth0: interrupt from stopped card

At this stage the system hangs. If i remove the card the above message fills 
the screen.

The same thing happens if i insert the card after booting.

However in 2.4.13 if i insert the card after booting i see different 
behaviour. Firstly I have to insert the card, remove it and then insert it 
again. It now works fine.

In kernel versions previous to this it worked fine from bootup.

My setup is as follows.

Acer Travelmate 514T
Surecom EP-427 ethernet card

192 MB RAM.

from /var/log/dmesg:

Yenta IRQ list 0cb8, PCI irq9
Socket status: 30000007
Yenta IRQ list 0cb8, PCI irq9
Socket status: 30000007

pcmcia-cs version 3.1.29

jackal:/usr/src/linux/drivers# cat /proc/interrupts
           CPU0
  0:     132929          XT-PIC  timer
  1:       2923          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:       6512          XT-PIC  serial
  5:      11136          XT-PIC  ES1938
  8:          1          XT-PIC  rtc
  9:         19          XT-PIC  O2 Micro, Inc. 6832, O2 Micro, Inc. 6832 (#2)
 10:         44          XT-PIC  usb-ohci
 11:       2154          XT-PIC  pcnet_cs
 12:      42917          XT-PIC  PS/2 Mouse
 14:      14554          XT-PIC  ide0
 15:          3          XT-PIC  ide1
NMI:          0
ERR:          0

jackal:/usr/src/linux/drivers# lspci
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1621 (rev 05)
00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5247 (rev 01)
00:06.0 Communication controller: Lucent Microelectronics WinModem 56k (rev 
01)
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge 
[Aladdin IV] (rev 0a)
00:08.0 Multimedia audio controller: ESS Technology ES1969 Solo-1 Audiodrive 
(rev 02)
00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 20)
00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU (rev 09)
00:13.0 CardBus bridge: O2 Micro, Inc. 6832 (rev 34)
00:13.1 CardBus bridge: O2 Micro, Inc. 6832 (rev 34)
00:14.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03)
01:00.0 VGA compatible controller: Neomagic Corporation [MagicMedia 256AV] 
(rev 20)


-- 
public key available at http://www.minihub.org/~iain/iain.asc
