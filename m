Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274857AbTHFEVi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 00:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274858AbTHFEVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 00:21:38 -0400
Received: from hydrogen.one-2-one.net ([217.115.142.89]:13578 "EHLO
	hydrogen.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S274857AbTHFEVe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 00:21:34 -0400
From: Dieter =?iso-8859-15?q?N=FCtzel?= <d.nuetzel@wearabrain.de>
Organization: WEAR-A-BRAIN
To: Tony Lindgren <tony@atomide.com>
Subject: 2.4.22-rc1 + ACPI patch: amd76x_pm do not work any longer
Date: Wed, 6 Aug 2003 06:21:06 +0200
User-Agent: KMail/1.5.3
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net, Adrian Bunk <bunk@fs.tum.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308060621.06216.d.nuetzel@wearabrain.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I had it running very well on my dual Athlon MP 1900+ for several months 
before. Latest Kernel was 2.4.22-pre5+ACPI patch.

Any changes?
I changed lm_sensors from 2.7.0 (?) to 2.8.0

System:
dual Athlon MP 1900+
MSI K7D Master-L

2.4.22-rc1
acpi-20030730-2.4.22-pre8.diff
preempt-kernel-rml-2.4.21-1.patch
IDE as modules

SunWave1 /home/nuetzel# modprobe amd76x_pm
/lib/modules/2.4.22-rc1-rl/kernel/drivers/char/amd76x_pm.o: init_module: 
Device or resource busy
Hint: insmod errors can be caused by incorrect module parameters, including 
invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.22-rc1-rl/kernel/drivers/char/amd76x_pm.o: insmod 
/lib/modules/2.4.22-rc1-rl/kernel/drivers/char/amd76x_pm.o failed
/lib/modules/2.4.22-rc1-rl/kernel/drivers/char/amd76x_pm.o: insmod amd76x_pm 
failed

dmesg:
amd76x_pm: Version 20020730
amd76x_pm: Initializing northbridge Advanced Micro Devices [AMD] AMD-760 MP 
[IGD4-2P] System Controller
amd76x_pm: Could not find southbridge		<----!!!!!!!!

2.4.22-pre5
older ACPI patch
preempt-kernel-rml-2.4.21-1.patch

<6>amd76x_pm: Version 20020730
<6>amd76x_pm: Initializing northbridge Advanced Micro Devices [AMD] AMD-760 MP 
[IGD4-2P] System Controller



PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System 
Controller (rev 17).
      Master Capable.  Latency=32.
      Prefetchable 32 bit memory at 0xe8000000 [0xebffffff].
      Prefetchable 32 bit memory at 0xf1101000 [0xf1101fff].
      I/O at 0xc800 [0xc803].
  Bus  0, device   1, function  0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge 
(rev 0).
      Master Capable.  Latency=32.  Min Gnt=14.
  Bus  0, device   7, function  0:
    ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 5).
  Bus  0, device   7, function  1:
    IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 4).
      Master Capable.  Latency=32.
      I/O at 0xc000 [0xc00f].
  Bus  0, device   7, function  3:
    Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 3).
      Master Capable.  Latency=32.
  Bus  0, device   9, function  0:
    SCSI storage controller: Adaptec AIC-7892A U160/m (rev 2).
      IRQ 17.
      Master Capable.  Latency=32.  Min Gnt=40.Max Lat=25.
      I/O at 0xc400 [0xc4ff].
      Non-prefetchable 64 bit memory at 0xf1100000 [0xf1100fff].
  Bus  0, device  16, function  0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 5).
      Master Capable.  Latency=32.  Min Gnt=6.
  Bus  1, device   5, function  0:
    VGA compatible controller: ATI Technologies Inc Radeon R200 QL [Radeon 
8500 LE] (rev 0).
      IRQ 17.
      Master Capable.  Latency=32.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xe0000000 [0xe7ffffff].
      I/O at 0xb000 [0xb0ff].
      Non-prefetchable 32 bit memory at 0xed000000 [0xed00ffff].
  Bus  2, device   0, function  0:
    USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB (rev 7).
      IRQ 19.
      Master Capable.  Latency=32.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xf0122000 [0xf0122fff].
  Bus  2, device   4, function  0:
    Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 8).
      IRQ 16.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=20.
      I/O at 0x9000 [0x901f].
  Bus  2, device   4, function  1:
    Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 8).
      Master Capable.  Latency=32.
      I/O at 0x9400 [0x9407].
  Bus  2, device   5, function  0:
    Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 4).
      IRQ 17.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
      Prefetchable 32 bit memory at 0xf1000000 [0xf1000fff].
      I/O at 0x9800 [0x981f].
      Non-prefetchable 32 bit memory at 0xf0000000 [0xf00fffff].
  Bus  2, device   6, function  0:
    SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U (rev 1).
      IRQ 18.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=8.
      I/O at 0x9c00 [0x9cff].
      Non-prefetchable 32 bit memory at 0xf0120000 [0xf0120fff].
  Bus  2, device   9, function  0:
    Ethernet controller: Intel Corp. 82559ER (rev 9).
      IRQ 17.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xf0121000 [0xf0121fff].
      I/O at 0xa000 [0xa03f].
      Non-prefetchable 32 bit memory at 0xf0100000 [0xf011ffff].

Thanks.

-- 
Dieter Nützel
Leiter F&E, WEAR-A-BRAIN GmbH, Wiener Str. 5, 28359 Bremen, Germany
Mobil: 0162 673 09 09

