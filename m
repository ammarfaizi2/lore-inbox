Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310201AbSB1XrZ>; Thu, 28 Feb 2002 18:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310204AbSB1Xpc>; Thu, 28 Feb 2002 18:45:32 -0500
Received: from nextgeneration.speedroad.net ([195.139.232.50]:65030 "HELO
	nextgeneration.speedroad.net") by vger.kernel.org with SMTP
	id <S310169AbSB1Xjy>; Thu, 28 Feb 2002 18:39:54 -0500
Message-ID: <20020228233954.7840.qmail@nextgeneration.speedroad.net>
From: "Arnvid Karstad" <arnvid@karstad.org>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.x, ThinkPad T23 and HW?!
Date: Fri, 01 Mar 2002 00:39:54 +0100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya, 

I just recieved an new laptop, an IBM ThinkPad T23 and it seems I cannot run 
the os of my choice on it.. Well almost not.. ;-) 

The machine is an PIII Mobile - 1133Mhz with built in ethernet, Bluetooth, 
modem and Wireless adapters. Namly Intel PRO/100 VE, IBM BlueTooth 
USB/UltraPort thingy, Lucent Softmodem AMR and IBM High Rate Wireless LAN 
MiniPCI "combo" card.
The strange thing is, almost none of these come up as "known" devices from 
/proc/pci or lspci. I also noticed that the IBM Wireless adapter, which is 
actually a prism2 (?) card, are mysteriously detected as an device created 
by "Harris Semiconductor" and it won't even try to let me access the card. I 
think I've tried every driver in the Kernel 2.4.18 now. Altho the kernel 
does state that the card in question is supported, it does seem that either 
the pci/device-id has changed (or something) so the driver doesn't notice 
any cards??? 

The hermes modules loads but no interfaces become available. 

This is the lspci: 


00:00.0 Host bridge: Intel Corporation: Unknown device 3575 (rev 02)
00:01.0 PCI bridge: Intel Corporation: Unknown device 3576 (rev 02)
00:1d.0 USB Controller: Intel Corporation: Unknown device 2482 (rev 01)
00:1d.1 USB Controller: Intel Corporation: Unknown device 2484 (rev 01)
00:1d.2 USB Controller: Intel Corporation: Unknown device 2487 (rev 01)
00:1e.0 PCI bridge: Intel Corporation: Unknown device 2448 (rev 41)
00:1f.0 ISA bridge: Intel Corporation: Unknown device 248c (rev 01)
00:1f.1 IDE interface: Intel Corporation: Unknown device 248a (rev 01)
00:1f.3 SMBus: Intel Corporation: Unknown device 2483 (rev 01)
00:1f.5 Multimedia audio controller: Intel Corporation: Unknown device 2485 
(rev 01)
00:1f.6 Modem: Intel Corporation: Unknown device 2486 (rev 01)
01:00.0 VGA compatible controller: S3 Inc.: Unknown device 8c2e (rev 05)
02:00.0 CardBus bridge: Texas Instruments PCI1420
02:00.1 CardBus bridge: Texas Instruments PCI1420
02:02.0 Network controller: Harris Semiconductor: Unknown device 3873 (rev 
01)
02:08.0 Ethernet controller: Intel Corporation: Unknown device 1031 (rev 41) 


The /proc/pci: 

PCI devices found:
 Bus  0, device   0, function  0:
   Host bridge: PCI device 8086:3575 (Intel Corp.) (rev 2).
     Prefetchable 32 bit memory at 0xd0000000 [0xdfffffff].
 Bus  0, device   1, function  0:
   PCI bridge: PCI device 8086:3576 (Intel Corp.) (rev 2).
     Master Capable.  Latency=96.  Min Gnt=12.
 Bus  0, device  29, function  0:
   USB Controller: PCI device 8086:2482 (Intel Corp.) (rev 1).
     IRQ 11.
     I/O at 0x1800 [0x181f].
 Bus  0, device  29, function  1:
   USB Controller: PCI device 8086:2484 (Intel Corp.) (rev 1).
     IRQ 11.
     I/O at 0x1820 [0x183f].
 Bus  0, device  29, function  2:
   USB Controller: PCI device 8086:2487 (Intel Corp.) (rev 1).
     IRQ 11.
     I/O at 0x1840 [0x185f].
 Bus  0, device  30, function  0:
   PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (-M) (rev 65).
     Master Capable.  No bursts.  Min Gnt=4.
 Bus  0, device  31, function  0:
   ISA bridge: PCI device 8086:248c (Intel Corp.) (rev 1).
 Bus  0, device  31, function  1:
   IDE interface: PCI device 8086:248a (Intel Corp.) (rev 1).
     IRQ 11.
     I/O at 0x1f0 [0x1f7].
     I/O at 0x3f6 [0x3f6].
     I/O at 0x170 [0x177].
     I/O at 0x376 [0x376].
     I/O at 0x1860 [0x186f].
     Non-prefetchable 32 bit memory at 0x28000000 [0x280003ff].
 Bus  0, device  31, function  3:
   SMBus: PCI device 8086:2483 (Intel Corp.) (rev 1).
     IRQ 11.
     I/O at 0x1880 [0x189f].
 Bus  0, device  31, function  5:
   Multimedia audio controller: Intel Corp. AC'97 Audio Controller (rev 1).
     IRQ 11.
     I/O at 0x1c00 [0x1cff].
     I/O at 0x18c0 [0x18ff].
 Bus  0, device  31, function  6:
   Modem: PCI device 8086:2486 (Intel Corp.) (rev 1).
     IRQ 11.
     I/O at 0x2400 [0x24ff].
     I/O at 0x2000 [0x207f].
 Bus  1, device   0, function  0:
   VGA compatible controller: PCI device 5333:8c2e (S3 Inc.) (rev 5).
     IRQ 11.
     Master Capable.  Latency=64.  Min Gnt=4.Max Lat=255.
     Non-prefetchable 32 bit memory at 0xc0100000 [0xc017ffff].
     Prefetchable 32 bit memory at 0xe8000000 [0xebffffff].
     Prefetchable 32 bit memory at 0xe4000000 [0xe7ffffff].
     Prefetchable 32 bit memory at 0xe0000000 [0xe1ffffff].
 Bus  2, device   0, function  0:
   CardBus bridge: Texas Instruments PCI1420 (rev 0).
     IRQ 11.
     Master Capable.  Latency=168.  Min Gnt=192.Max Lat=5.
     Non-prefetchable 32 bit memory at 0xc0201000 [0xc0201fff].
 Bus  2, device   0, function  1:
   CardBus bridge: Texas Instruments PCI1420 (#2) (rev 0).
     IRQ 11.
     Master Capable.  Latency=168.  Min Gnt=192.Max Lat=5.
     Non-prefetchable 32 bit memory at 0xc0202000 [0xc0202fff].
 Bus  2, device   2, function  0:
   Network controller: PCI device 1260:3873 (Harris Semiconductor) (rev 1).
     IRQ 11.
     Master Capable.  Latency=64.
     Prefetchable 32 bit memory at 0xec000000 [0xec000fff].
 Bus  2, device   8, function  0:
   Ethernet controller: Intel Corp. 82801CAM (ICH3) Chipset Ethernet 
Controller (rev 65).
     IRQ 11.
     Master Capable.  Latency=66.  Min Gnt=8.Max Lat=56.
     Non-prefetchable 32 bit memory at 0xc0200000 [0xc0200fff].
     I/O at 0x7000 [0x703f]. 

I tried the Wlan-NG drivers but they didn't seem to work out as planned 
either... 

init_module: prism2_pci.o: 0.1.13 Loaded
init_module: dev_info is: prism2_pci
PCI: Found IRQ 11 for device 02:02.0
PCI: Sharing IRQ 11 with 00:1d.2
PCI: Sharing IRQ 11 with 00:1f.1
A Prism2.5 PCI device found, phymem:0xec000000, irq:11
, mem:0xe97b5000
ident: nic h/w: id=0x8013 1.0.0
ident: pri f/w: id=0x15 1.0.7
ident: sta f/w: id=0x1f 1.3.6
MFI:SUP:role=0x00:id=0x01:var=0x01:b/t=1/1
CFI:SUP:role=0x00:id=0x02:var=0x02:b/t=1/1
PRI:SUP:role=0x00:id=0x03:var=0x01:b/t=4/4
STA:SUP:role=0x00:id=0x04:var=0x01:b/t=1/9
PRI-CFI:ACT:role=0x01:id=0x02:var=0x02:b/t=1/1
STA-CFI:ACT:role=0x01:id=0x02:var=0x02:b/t=1/1
STA-MFI:ACT:role=0x01:id=0x01:var=0x01:b/t=1/1
Prism2 card SN: 124112003411 

p80211knetdev_hard_start_xmit: Tx attempt prior to association, frame 
dropped.
p80211knetdev_hard_start_xmit: Tx attempt prior to association, frame 
dropped. 

Tried both having "default" settings on the AP and a SSID configured. And 
setting ssid on the linux machine. 

 From what I can see in the kernel source, config help and the web it seem 
that most of the hardware in this machine is actually supported (not sure 
about the chipsets tho).. 

What files can I start looking at to see if this card can be used by the 
drivers allready in the kernel, or is there any other thing I can try or do? 

I really want this machine to be running Linux =) 

Best regards, 

Arnvid Karstad.
