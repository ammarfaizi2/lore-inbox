Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318422AbSGSCfa>; Thu, 18 Jul 2002 22:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318429AbSGSCfa>; Thu, 18 Jul 2002 22:35:30 -0400
Received: from pD9E23646.dip.t-dialin.net ([217.226.54.70]:19584 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318422AbSGSCf3>; Thu, 18 Jul 2002 22:35:29 -0400
Date: Thu, 18 Jul 2002 20:37:42 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andrea Arcangeli <andrea@suse.de>, Andre Hedrick <andre@linux-ide.org>
Subject: Severe problems with 2.4.19-rc2-aa1 on k6-II
Message-ID: <Pine.LNX.4.44.0207182027480.3525-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running 2.4.19-rc2-aa1 on an AMD K6-II 450 (bluemoon).
The CPU is family 5, model 8, stepping 12. It's constantly at no more 
than fifty degree Fahrenheit, so it's certainly not a temperature bugset.

The problems are:

1. When booting, I always have to specify hde=none hdf=none ... hdl=none, 
because otherwise IDE will start probing wildly. (never had that before)
2. Mouse and keyboard are both on one port. Now if I load gpm, the whole 
PS/2 controller gets stuck until I unplug both mouse and keyboard and then 
re-plug them. It all worked fine ever before.

bluemoon:/proc/pci

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 4).
      Master Capable.  Latency=64.  
      Non-prefetchable 32 bit memory at 0xd0000000 [0xdfffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Acer Laboratories Inc. [ALi] M1541 PCI to AGP Controller (rev 4).
      Master Capable.  Latency=64.  Min Gnt=8.
  Bus  0, device   2, function  0:
    USB Controller: Acer Laboratories Inc. [ALi] USB 1.1 Controller (rev 3).
      IRQ 9.
      Master Capable.  Latency=64.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xce800000 [0xce800fff].
  Bus  0, device   3, function  0:
    Bridge: Acer Laboratories Inc. [ALi] M7101 PMU (rev 0).
  Bus  0, device   6, function  0:
    Multimedia audio controller: ESS Technology ES1969 Solo-1 Audiodrive (rev 1).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=24.
      I/O at 0xd800 [0xd83f].
      I/O at 0xd400 [0xd40f].
      I/O at 0xd000 [0xd00f].
      I/O at 0xb800 [0xb803].
      I/O at 0xb400 [0xb403].
  Bus  0, device   7, function  0:
    ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev 195).
  Bus  0, device   9, function  0:
    SCSI storage controller: Advanced Micro Devices [AMD] 53c974 [PCscsi] (rev 16).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=4.Max Lat=40.
      I/O at 0xb000 [0xb07f].
  Bus  0, device  10, function  0:
    Ethernet controller: 3Com Corporation 3cSOHO100-TX Hurricane (rev 48).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=10.Max Lat=10.
      I/O at 0xa800 [0xa87f].
      Non-prefetchable 32 bit memory at 0xce000000 [0xce00007f].
  Bus  0, device  11, function  0:
    Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 4).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=20.
      I/O at 0xa400 [0xa41f].
  Bus  0, device  11, function  1:
    Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 1).
      Master Capable.  Latency=32.  
      I/O at 0xa000 [0xa007].
  Bus  0, device  13, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS) (rev 0).
      IRQ 9.
      I/O at 0x9800 [0x981f].
  Bus  0, device  15, function  0:
    IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 193).
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=4.
      I/O at 0x9400 [0x940f].
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 21).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xcf000000 [0xcfffffff].
      Prefetchable 32 bit memory at 0xe6000000 [0xe7ffffff].

bluemoon:/proc/ide/ali:

                                Ali M15x3 Chipset.
                                ------------------
PCI Clock: 33.
CD_ROM FIFO:No , CD_ROM DMA:Yes
FIFO Status: contains 0 Words, runs.

-------------------primary channel-------------------secondary channel---------

channel status:       Off                               Off
both channels togth:  Yes                               Yes
Channel state:        OK                                OK            
Add. Setup Timing:    1T                                1T
Command Act. Count:   8T                                8T
Command Rec. Count:   16T                               16T

----------------drive0-----------drive1------------drive0-----------drive1------

DMA enabled:      Yes              Yes               Yes              Yes
FIFO threshold:    8 Words          8 Words           4 Words          4 Words
FIFO mode:        FIFO On          FIFO On           FIFO Off         FIFO Off
Dt RW act. Cnt     3T               3T                3T               4T
Dt RW rec. Cnt     1T               1T                1T               3T

-----------------------------------UDMA Timings--------------------------------

UDMA:             OK               OK                No               No
UDMA timings:     2.5T             2.5T              1.5T             1.5T

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

