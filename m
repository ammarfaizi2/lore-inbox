Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289252AbSA1Qsv>; Mon, 28 Jan 2002 11:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289250AbSA1Qsq>; Mon, 28 Jan 2002 11:48:46 -0500
Received: from ucrwcu.rwc.uc.edu ([129.137.3.94]:33206 "EHLO ucrwcu.rwc.uc.edu")
	by vger.kernel.org with ESMTP id <S289236AbSA1Qs0>;
	Mon, 28 Jan 2002 11:48:26 -0500
Message-ID: <3C557F56.F0415D0@ucrwcu.rwc.uc.edu>
Date: Mon, 28 Jan 2002 11:41:58 -0500
From: ken <koehlekr@ucrwcu.rwc.uc.edu>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: t.sailer@alumni.ethz.ch, linux-kernel@vger.kernel.org
Subject: es1371 2.2.15 OK - 2.4.17 noisy on mic input
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have a Creative Sound Blaster 16 PCI on an FIC-V503+ MB (bios rev.
JE439)
which I use in part for dictation (with viavoice). When I boot a stock
2.2.15 kernel (on a RedHat 6.2 system), it works great. When I boot a
stock 2.4.17 kernel (on a RedHat 7.2 system) the input volume is way
down and noise accompanies all spoken input, rendering it useless for
dictation.

Any ideas?  Thanks in advance,

Ken

Documentation follows:

from system log during boot:::::::::::::::::::::::::::::::::::::::::::

Jan 28 11:14:44 ken kernel: CPU: AMD-K6(tm) 3D processor stepping 0c
...
Jan 28 11:14:44 ken kernel: PCI: PCI BIOS revision 2.10 entry at
0xfb360, last bus=2
Jan 28 11:14:44 ken kernel: PCI: Using configuration type 1
Jan 28 11:14:44 ken kernel: PCI: Probing PCI hardware
Jan 28 11:14:44 ken kernel: PCI: 00:07.3: class 604 doesn't match header
type 00. Ignoring class.
Jan 28 11:14:44 ken kernel: Unknown bridge resource 1: assuming
transparent
Jan 28 11:14:44 ken kernel: Unknown bridge resource 2: assuming
transparent
Jan 28 11:14:44 ken kernel: PCI: Using IRQ router VIA [1106/0586] at
00:07.0
...
Jan 28 11:14:44 ken kernel: es1371: version v0.30 time 11:00:52 Jan 28
2002
Jan 28 11:14:44 ken kernel: PCI: Assigned IRQ 10 for device 00:08.0
Jan 28 11:14:44 ken kernel: es1371: found chip, vendor id 0x1274 device
id 0x5880 revision 0x02
Jan 28 11:14:44 ken kernel: es1371: found es1371 rev 2 at io 0xe800 irq
10
Jan 28 11:14:44 ken kernel: es1371: features: joystick 0x0
Jan 28 11:14:44 ken kernel: ac97_codec: AC97  codec, id: 0x5452:0x4123
(TriTech TR A5)

output of cat /proc/pci::::::::::::::::::::::::::::::::::::::::::::::

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT82C597 [Apollo VP3] (rev 4).
      Master Capable.  Latency=16.  
      Prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=4.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo
VP] (rev 71).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      Master Capable.  Latency=64.  
      I/O at 0xe400 [0xe40f].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 2).
      IRQ 9.
      Master Capable.  Latency=64.  
      I/O at 0xe000 [0xe01f].
  Bus  0, device   7, function  3:
    PCI bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 16).
      IRQ 9.
  Bus  0, device   8, function  0:
    Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 2).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=12.Max Lat=128.
      I/O at 0xe800 [0xe83f].
  Bus  0, device   9, function  0:
    Ethernet controller: 3Com Corporation 3c595 100BaseTX [Vortex] (rev
0).
      IRQ 11.
      Master Capable.  Latency=248.  Min Gnt=3.Max Lat=8.
      I/O at 0xec00 [0xec1f].
  Bus  0, device  10, function  0:
    VGA compatible controller: S3 Inc. 86c325 [ViRGE] (rev 6).
      IRQ 9.
      Master Capable.  Latency=64.  Min Gnt=4.Max Lat=255.
      Non-prefetchable 32 bit memory at 0xe4000000 [0xe7ffffff].

output of cat /proc/es1371:::::::::::::::::::::::::::::::::::::::::::

                Creative ES137x Debug Dump-o-matic
AC97 CODEC state
reg:0x00  val:0x0000
reg:0x02  val:0x0b0b
reg:0x04  val:0x0000
reg:0x06  val:0x000b
reg:0x08  val:0x0000
reg:0x0a  val:0x000a
reg:0x0c  val:0x000b
reg:0x0e  val:0x000b
reg:0x10  val:0x0b0b
reg:0x12  val:0x0b0b
reg:0x14  val:0x0b0b
reg:0x16  val:0x0b0b
reg:0x18  val:0x0b0b
reg:0x1a  val:0x0000
reg:0x1c  val:0x0a0a
reg:0x1e  val:0x0000
reg:0x20  val:0x0000
reg:0x22  val:0x0000
reg:0x24  val:0x0000
reg:0x26  val:0x000f
reg:0x28  val:0x0000
reg:0x2a  val:0x0000
reg:0x2c  val:0x0000
reg:0x2e  val:0x0000
reg:0x30  val:0x0000
reg:0x32  val:0x0000
reg:0x34  val:0x0000
reg:0x36  val:0x0000
reg:0x38  val:0x0000
reg:0x3a  val:0x0000
reg:0x3c  val:0x0000
reg:0x3e  val:0x0000
reg:0x40  val:0x0000
reg:0x42  val:0x0000
reg:0x44  val:0x0000
reg:0x46  val:0x0000
reg:0x48  val:0x0000
reg:0x4a  val:0x0000
reg:0x4c  val:0x0000
reg:0x4e  val:0x0000
reg:0x50  val:0x0000
reg:0x52  val:0x0000
reg:0x54  val:0x0000
reg:0x56  val:0x0000
reg:0x58  val:0x0000
reg:0x5a  val:0x0000
reg:0x5c  val:0x0000
reg:0x5e  val:0x0000
reg:0x60  val:0x0000
reg:0x62  val:0x0000
reg:0x64  val:0x0000
reg:0x66  val:0x0000
reg:0x68  val:0x0000
reg:0x6a  val:0x0000
reg:0x6c  val:0x0000
reg:0x6e  val:0x0000
reg:0x70  val:0x0000
reg:0x72  val:0x0000
reg:0x74  val:0x0000
reg:0x76  val:0x0000
reg:0x78  val:0x0000
reg:0x7a  val:0x0000
reg:0x7c  val:0x5452
reg:0x7e  val:0x4123
