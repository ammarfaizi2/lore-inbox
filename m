Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318898AbSHEWh2>; Mon, 5 Aug 2002 18:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318891AbSHEWh1>; Mon, 5 Aug 2002 18:37:27 -0400
Received: from h53n2fls24o900.telia.com ([217.208.132.53]:49894 "EHLO
	oden.fish.net") by vger.kernel.org with ESMTP id <S318898AbSHEWh0>;
	Mon, 5 Aug 2002 18:37:26 -0400
Date: Tue, 6 Aug 2002 00:40:59 +0200
From: Voluspa <voluspa@bigfoot.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 MAESTRO sound /dev/dsp3 broken (luxury problem)
Message-Id: <20020806004059.43db99fb.voluspa@bigfoot.com>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The fourth channel, aka /dev/dsp3, of the MAESTRO sound driver is broken (yeah, sob, sob) in 2.4.19 and -ac1. Last working that I've used, compiled as a module, was 2.4.19-pre10-ac1. The "sound" now coming out of that channel is a cry from the wilderness (confirmed with RealOne Player and gqmpeg and xine and...)

First three channels are all A OK.

Machine is a Compaq Presario 5640 (PII 400) with 128 meg mem. Builtin sound chip.

>From /etc/modules.conf
[...]
alias sound maestro
options maestro dsps_order=2
pre-install maestro /sbin/modprobe soundcore

>From /var/log/messages:
[...]
Aug  5 23:45:38 loke kernel: PCI: Sharing IRQ 5 with 01:00.0
Aug  5 23:45:38 loke kernel: maestro: Configuring ESS Maestro 2 found at IO 0x20
00 IRQ 5
Aug  5 23:45:38 loke kernel: maestro:  subvendor id: 0xb0b80e11
Aug  5 23:45:38 loke kernel: maestro: not attempting power management.
Aug  5 23:45:38 loke kernel: maestro: AC97 Codec detected: v: 0x414b4d00 caps: 0
x0 pwr: 0xf
Aug  5 23:45:38 loke kernel: maestro: 4 channels configured.
Aug  5 23:45:38 loke kernel: maestro: version 0.15 time 21:52:54 Aug  5 2002

loke:loke:~$ cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 2).
      Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0x44000000 [0x47ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 2).
      Master Capable.  Latency=64.  Min Gnt=140.
  Bus  0, device   5, function  0:
    Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 65).
      IRQ 11.
      Master Capable.  Latency=96.  Min Gnt=20.Max Lat=40.
      I/O at 0x2400 [0x247f].
      Non-prefetchable 32 bit memory at 0x41100000 [0x411003ff].
  Bus  0, device   6, function  0:
    Multimedia audio controller: ESS Technology ES1968 Maestro 2 (rev 0).
      IRQ 5.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=24.
      I/O at 0x2000 [0x20ff].
  Bus  0, device  20, function  0:
    ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 2).
  Bus  0, device  20, function  1:
    IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 1).
      Master Capable.  Latency=64.  
      I/O at 0x24a0 [0x24af].
  Bus  0, device  20, function  2:
    USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 1).
      IRQ 11.
      Master Capable.  Latency=64.  
      I/O at 0x2480 [0x249f].
  Bus  0, device  20, function  3:
    Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 2).
      IRQ 9.
  Bus  1, device   0, function  0:
    VGA compatible controller: ATI Technologies Inc 3D Rage LT Pro AGP-133 (rev 220).
      IRQ 5.
      Master Capable.  Latency=66.  Min Gnt=8.
      Non-prefetchable 32 bit memory at 0x40000000 [0x40ffffff].
      I/O at 0x1000 [0x10ff].
      Non-prefetchable 32 bit memory at 0x41000000 [0x41000fff].

Regards,
Mats Johannesson
