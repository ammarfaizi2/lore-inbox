Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261990AbSJIUnj>; Wed, 9 Oct 2002 16:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262039AbSJIUnj>; Wed, 9 Oct 2002 16:43:39 -0400
Received: from sitemail3.everyone.net ([216.200.145.37]:61564 "HELO
	omta01.mta.everyone.net") by vger.kernel.org with SMTP
	id <S261990AbSJIUni>; Wed, 9 Oct 2002 16:43:38 -0400
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Date: Wed, 9 Oct 2002 13:49:20 -0700 (PDT)
From: Dionysio Calucci <dionysio@vr-zone.com>
To: linux-kernel@vger.kernel.org
Subject: bondind 6 NICs
Reply-To: dionysio@vr-zone.com
X-Originating-Ip: [213.16.155.15]
Message-Id: <20021009204920.6F0B74483@sitemail.everyone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i achieved in bonding four NICs in every computer, but i cannot bond six NICs. The computer boots OK but it freezes when i start using the network.
I use a Compex RE100ATX NIC with the 8139too driver. BTW when I use 4 Compex NICs and 2 3COM 905CX-TX-M i can bond 6 NICs. I use the MMIO mode of the above driver. There must be something wrong with the driver.


cat /proc/ioports
---------------------------------------------------
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
03c0-03df : vga+
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
a000-afff : PCI Bus #01
  a000-a0ff : ATI Technologies Inc Radeon VE QY
b400-b41f : VIA Technologies, Inc. UHCI USB
  b400-b41f : usb-uhci
b800-b81f : VIA Technologies, Inc. UHCI USB (#2)
  b800-b81f : usb-uhci
bc00-bcff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
  bc00-bcff : 8139too
c000-c0ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C (#2)
  c000-c0ff : 8139too
c400-c4ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C (#3)
  c400-c4ff : 8139too
c800-c8ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C (#4)
  c800-c8ff : 8139too
cc00-ccff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C (#5)
  cc00-ccff : 8139too
d000-d0ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C (#6)
  d000-d0ff : 8139too
d400-d407 : CMD Technology Inc PCI0649
  d400-d407 : ide0
d800-d803 : CMD Technology Inc PCI0649
  d802-d802 : ide0
dc00-dc07 : CMD Technology Inc PCI0649
e000-e003 : CMD Technology Inc PCI0649
e400-e40f : CMD Technology Inc PCI0649
  e400-e407 : ide0
  e408-e40f : ide1

cat /proc/interrupts
---------------------------------------------------
           CPU0       
  0:     806493          XT-PIC  timer
  1:       3618          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
 10:     153058          XT-PIC  eth1
 11:     153169          XT-PIC  eth0
 12:     161560          XT-PIC  PS/2 Mouse
 14:     153721          XT-PIC  eth2
 15:     304568          XT-PIC  ide0, usb-uhci, usb-uhci, eth3
NMI:          0 
ERR:          0

_____________________________________________________________
Select your own custom email address for FREE! Get you@yourchoice.com w/No Ads, 6MB, POP & more! http://www.everyone.net/selectmail?campaign=tag
