Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310115AbSCKOOT>; Mon, 11 Mar 2002 09:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310119AbSCKOOL>; Mon, 11 Mar 2002 09:14:11 -0500
Received: from borg.limmat.ch ([62.12.130.253]:29197 "EHLO borg.limmat.ch")
	by vger.kernel.org with ESMTP id <S310115AbSCKOOB>;
	Mon, 11 Mar 2002 09:14:01 -0500
Message-ID: <3C8CBC12.2070609@mitlinks.ch>
Date: Mon, 11 Mar 2002 15:15:46 +0100
From: Fabian Lienert <lienert@mitlinks.ch>
Organization: mitLinks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel crash initializing ide
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernels higher than version 2.4.5 crash when starting the ide part on an 
Maxdata Artist P-III 733 MHz.

Every kernel with greater version than 2.4.5 I tried, self-compiled or 
as a debian-packet crashed on my Maxdata Artist P-III 733 MHz with an 
ide-harddisk and a ide-dvdrom. So I downgraded to kernel 2.4.5, this is 
working. I tried version 2.4.7, 2.4.10, 2.4.16 and 2.4.18, everywhere 
the same problem, the kernel crashes. the output:

-----------

Linux version 2.4.5 (root@jesusmaria) (gcc version 2.95.4 20011002 
(Debian prerelease)) #3 SMP Wed Feb 27 10:10:51 CET 2002
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009fc00 for 4096 bytes.
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01443000)
Kernel command line: BOOT_IMAGE=linux-reiser ro root=306 apm=power-off
Initializing CPU#0
Detected 733.355 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1461.45 BogoMIPS
Memory: 255096k/262144k available (1285k kernel code, 6660k reserved, 
488k data, 192k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 03
per-CPU timeslice cutoff: 731.61 usecs.
SMP motherboard not detected. Using dummy APIC emulation.
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xfb0b0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: queued sectors max/low 169474kB/56491kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later

---------
at this point it crashes.

$ lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo 
PRO133x] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo 
MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 22)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] 
(rev 30)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio 
Controller (rev 20)
00:0e.0 SCSI storage controller: Adaptec AIC-7881U
00:10.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] 
(rev 74)
01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15)

$ lsmod
Module                  Size  Used by
via82cxxx_audio        17056   1
ac97_codec              8608   0  [via82cxxx_audio]
soundcore               4196   2  [via82cxxx_audio]

Hope I send this to the right list.

Regards,
-- 
Fabian Lienert . mitLinks AG . Limmatstrasse 291 . 8005 Z?rich
lienert@mitlinks.ch . ++41 1 444 10 44 . http://www.mitlinks.ch
    pgp public key: http://www.mitlinks.ch/keys/lienert.asc

