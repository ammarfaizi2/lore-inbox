Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318028AbSIJUS1>; Tue, 10 Sep 2002 16:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318035AbSIJUS1>; Tue, 10 Sep 2002 16:18:27 -0400
Received: from ursa.calvin.edu ([153.106.4.1]:1668 "EHLO ursa.calvin.edu")
	by vger.kernel.org with ESMTP id <S318028AbSIJUSZ>;
	Tue, 10 Sep 2002 16:18:25 -0400
Message-ID: <3D80B528.9080305@mvpsoft.com>
Date: Thu, 12 Sep 2002 11:39:20 -0400
From: Chris Snyder <csnyder@mvpsoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.1) Gecko/20020904
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-wlan-user@lists.linux-wlan.com,
       linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
CC: csnyder@mvpsoft.com
Subject: Issues with wlan and usb
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Fujitsu P-series notebook with integraded Prism wireless lan 
and an Ali USB chipset.  I've been having issues with both of these, 
with the error messages containing a common error number, leading me to 
believe that they might be related, which is why I'm sending it to both 
lists, as well as Linux-kernel.

Kernel version is 2.4.19.

I'll start off with the wlan issues.  Every so often (as little as 5 
minutes after booting) my wlan card with stop working.  When I try to 
run iwconfig to see what's going on, it can't detect the card anymore. 
Looking at the kernel logs, I'm getting the following error message:
eth1: Error -110 writing Tx descriptor to BAP
This happens before it stops working, but with much greater frequency 
right before it stops.

The USB problem is less annoying, but still a problem.  Sometimes when I 
hook up a USB device, it gives an error such as "Error -110, device not 
accepting address."  If I unplug it and plug it back in, I can get it to 
work.

I've tried passing the noapic option to the kernel - before this, I 
couldn't get USB working at all, but it didn't help with the other 
issues.  I've also tried compiling a kernel without USB support, but 
that didn't help either.  Any ideas on what's going on?  Enclosed below 
are some /proc files that might come in handy.  Thanks in advance.

/proc/interrupts:
            CPU0
   0:     114800          XT-PIC  timer
   1:       5222          XT-PIC  keyboard
   2:          0          XT-PIC  cascade
   9:       1507          XT-PIC  ALi Audio Accelerator, eth1, Texas 
Instruments PCI1410 PC card Cardbus Controller
  12:      32042          XT-PIC  PS/2 Mouse
  14:       3996          XT-PIC  ide0
NMI:          0
LOC:          0
ERR:          0
MIS:          0

/proc/pci:
PCI devices found:
   Bus  0, device   0, function  0:
     Host bridge: Transmeta Corporation LongRun Northbridge (rev 1).
       Non-prefetchable 32 bit memory at 0xfc000000 [0xfc0fffff].
   Bus  0, device   0, function  1:
     RAM memory: Transmeta Corporation SDRAM controller (rev 0).
   Bus  0, device   0, function  2:
     RAM memory: Transmeta Corporation BIOS scratchpad (rev 0).
   Bus  0, device   2, function  0:
     USB Controller: Acer Laboratories Inc. [ALi] USB 1.1 Controller 
(rev 3).
       IRQ 11.
       Master Capable.  Latency=64.  Max Lat=80.
       Non-prefetchable 32 bit memory at 0xfc100000 [0xfc100fff].
   Bus  0, device   4, function  0:
     Multimedia audio controller: Acer Laboratories Inc. [ALi] M5451 PCI 
AC-Link Controller Audio Device (rev 1).
       IRQ 9.
       Master Capable.  Latency=64.  Min Gnt=2.Max Lat=24.
       I/O at 0x1000 [0x10ff].
       Non-prefetchable 32 bit memory at 0xfc101000 [0xfc101fff].
   Bus  0, device   6, function  0:
     Bridge: Acer Laboratories Inc. [ALi] M7101 PMU (rev 0).
   Bus  0, device   7, function  0:
     ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge 
[Aladdin IV] (rev 0).
   Bus  0, device  12, function  0:
     CardBus bridge: Texas Instruments PCI1410 PC card Cardbus 
Controller (rev 1).
       IRQ 9.
       Master Capable.  Latency=168.  Min Gnt=192.Max Lat=5.
       Non-prefetchable 32 bit memory at 0x10000000 [0x10000fff].
   Bus  0, device  15, function  0:
     IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 195).
       Master Capable.  Latency=32.  Min Gnt=2.Max Lat=4.
       I/O at 0x1400 [0x140f].
   Bus  0, device  16, function  0:
     Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C 
(rev 16).
       IRQ 9.
       Master Capable.  Latency=64.  Min Gnt=32.Max Lat=64.
       I/O at 0x8000 [0x80ff].
       Non-prefetchable 32 bit memory at 0xfc102000 [0xfc1020ff].
   Bus  0, device  18, function  0:
     Network controller: PCI device 1260:3873 (Harris Semiconductor) 
(rev 1).
       IRQ 9.
       Master Capable.  Latency=64.
       Prefetchable 32 bit memory at 0xfc108000 [0xfc108fff].
   Bus  0, device  19, function  0:
     FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394 
Controller (PHY/Link) 1394a-2000 (rev 0).
       IRQ 9.
       Master Capable.  Latency=64.  Min Gnt=2.Max Lat=4.
       Non-prefetchable 32 bit memory at 0xfc102800 [0xfc102fff].
       Non-prefetchable 32 bit memory at 0xfc104000 [0xfc107fff].
   Bus  0, device  20, function  0:
     VGA compatible controller: ATI Technologies Inc Rage Mobility P/M 
(rev 100).
       IRQ 9.
       Master Capable.  Latency=66.  Min Gnt=8.
       Non-prefetchable 32 bit memory at 0xfd000000 [0xfdffffff].
       I/O at 0x1800 [0x18ff].
       Non-prefetchable 32 bit memory at 0xfc103000 [0xfc103fff].

