Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264091AbRGBLzq>; Mon, 2 Jul 2001 07:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263970AbRGBLzg>; Mon, 2 Jul 2001 07:55:36 -0400
Received: from scan2.fhg.de ([153.96.1.37]:36004 "EHLO scan2.fhg.de")
	by vger.kernel.org with ESMTP id <S264091AbRGBLzY>;
	Mon, 2 Jul 2001 07:55:24 -0400
Message-ID: <3B40611D.F1485C1B@N-Club.de>
Date: Mon, 02 Jul 2001 13:55:09 +0200
From: Juergen Wolf <JuWo@N-Club.de>
Organization: FeM e.V.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem with SMC Etherpower II + kernel newer 2.4.2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

currently I experience some strange problems with every kernels newer
than 2.4.2 and my SMC Etherpower II network card. While running such a
kernel, the network hangs and I get lots of errors like these listed
below:

Jul  2 13:06:59 localhost kernel: eth0: Too much work at interrupt,
IntrStatus=0x008d0004.
Jul  2 13:07:06 localhost last message repeated 5 times
Jul  2 13:07:20 localhost kernel: NETDEV WATCHDOG: eth0: transmit timed
out
Jul  2 13:07:20 localhost kernel: eth0: Transmit timeout using MII
device, Tx status 4003.
Jul  2 13:07:22 localhost kernel: eth0: Too much work at interrupt,
IntrStatus=0x008d0004.


The /proc/pci lists the following system components:

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev
3).
      Master Capable.  Latency=32.  
      Prefetchable 32 bit memory at 0xd8000000 [0xdbffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
(rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 34).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 16).
      Master Capable.  Latency=32.  
      I/O at 0xc000 [0xc00f].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 16).
      IRQ 9.
      Master Capable.  Latency=32.  
      I/O at 0xc400 [0xc41f].
  Bus  0, device   7, function  3:
    USB Controller: VIA Technologies, Inc. UHCI USB (#2) (rev 16).
      IRQ 9.
      Master Capable.  Latency=32.  
      I/O at 0xc800 [0xc81f].
  Bus  0, device   7, function  4:
    Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 48).
  Bus  0, device   7, function  5:
    Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 32).
      IRQ 11.
      I/O at 0xcc00 [0xccff].
      I/O at 0xd000 [0xd003].
      I/O at 0xd400 [0xd403].
  Bus  0, device   9, function  0:
    Multimedia audio controller: Xilinx, Inc. RME Digi96/8 (rev 4).
      IRQ 10.
      Non-prefetchable 32 bit memory at 0xde000000 [0xdeffffff].
  Bus  0, device  10, function  0:
    Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 2).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=12.Max Lat=128.
      I/O at 0xdc00 [0xdc3f].
  Bus  0, device  11, function  0:
    Ethernet controller: Standard Microsystems Corp [SMC] 83C170QF (rev
9).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=28.
      I/O at 0xe000 [0xe0ff].
      Non-prefetchable 32 bit memory at 0xe0000000 [0xe0000fff].
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation NV11 (rev 161).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xdc000000 [0xdcffffff].
      Prefetchable 32 bit memory at 0xd0000000 [0xd7ffffff].


Does anybody else got these errors or knows about a solution for this ??
The 2.2.x kernels and all kernel versions below (including) 2.4.2 work
fine on the same system and I did not find any entries in the changelogs
for the SMC driver code.

Thx 
	Juergen
