Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752751AbWKBI5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbWKBI5r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 03:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752753AbWKBI5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 03:57:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:34628 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752751AbWKBI5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 03:57:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=ScfiIbG3zOTMbGo1H+2JRn/9Rlog3ER5VtA4dSLxcb6vz7zPr1nRZCtGbVdTrWggP8gJ/5X8Fn7hljJAKEZkE/IEJSwzH4xu+lvrrA5KpJ5pPFb4GOwdW1uBAltVujkJM5jabs6z+L83qpex21z4E8AIXO77t+Wkw6vMx5aAf8g=
Message-ID: <4549B305.7040106@gmail.com>
Date: Thu, 02 Nov 2006 12:57:41 +0400
From: Manu Abraham <abraham.manu@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: hdb lost interrupt
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been seeing this message (twice) "hdb: lost interrupt" on my
console. This happened overnight, so in the morning i had this click
click sound from my HDD, (my heart stopped for a moment on hearing the
click-click-click, thought was a dead HDD) not responding to anything
else other than a hard RESET. On RESET, things came back to normal.




On checking the syslog, the only thing that i could find in the log that
was relevant was this.

Nov  1 12:01:22 Orbit01 kernel: [20715026.956000] hdb: dma_intr:
status=0x30 { DeviceFault SeekComplete }
Nov  1 12:01:22 Orbit01 kernel: [20715026.956000] ide: failed opcode
was: unknown
Nov  1 12:01:22 Orbit01 kernel: [20715026.956000] hda: DMA disabled
Nov  1 12:01:22 Orbit01 kernel: [20715026.956000] hdb: DMA disabled
Nov  1 12:01:29 Orbit01 kernel: [20715034.348000] ide0: reset: success



The log on a reboot,



Nov  2 11:08:51 Orbit01 kernel: [17179571.232000] Uniform Multi-Platform
E-IDE driver Revision: 7.00alpha2
Nov  2 11:08:51 Orbit01 kernel: [17179571.232000] ide: Assuming 33MHz
system bus speed for PIO modes; override with idebus=xx
Nov  2 11:08:51 Orbit01 kernel: [17179571.232000] ICH5: IDE controller
at PCI slot 0000:00:1f.1
Nov  2 11:08:51 Orbit01 kernel: [17179571.232000] PCI: Enabling device
0000:00:1f.1 (0005 -> 0007)
Nov  2 11:08:51 Orbit01 kernel: [17179571.232000] ACPI: PCI Interrupt
0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 17
Nov  2 11:08:51 Orbit01 kernel: [17179571.232000] ICH5: chipset revision 2
Nov  2 11:08:51 Orbit01 kernel: [17179571.232000] ICH5: not 100% native
mode: will probe irqs later
Nov  2 11:08:51 Orbit01 kernel: [17179571.232000]     ide0: BM-DMA at
0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
Nov  2 11:08:51 Orbit01 kernel: [17179571.232000]     ide1: BM-DMA at
0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
Nov  2 11:08:51 Orbit01 kernel: [17179571.520000] hda: ST340014A, ATA
DISK drive
Nov  2 11:08:51 Orbit01 kernel: [17179571.800000] hdb: WDC
WD2500BB-00DWA0, ATA DISK drive
Nov  2 11:08:51 Orbit01 kernel: [17179571.856000] ide0 at
0x1f0-0x1f7,0x3f6 on irq 14
Nov  2 11:08:51 Orbit01 kernel: [17179572.148000] hdc: ST3160212A, ATA
DISK drive
Nov  2 11:08:51 Orbit01 kernel: [17179572.932000] hdd: HL-DT-ST DVDRAM
GSA-4163B, ATAPI CD/DVD-ROM drive
Nov  2 11:08:51 Orbit01 kernel: [17179572.988000] ide1 at
0x170-0x177,0x376 on irq 15
Nov  2 11:08:51 Orbit01 kernel: [17179572.988000] hda: max request size:
512KiB
Nov  2 11:08:52 Orbit01 kernel: [17179572.992000] hda: 78165360 sectors
(40020 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(33)
Nov  2 11:08:52 Orbit01 kernel: [17179572.992000] hda: cache flushes
supported
Nov  2 11:08:52 Orbit01 kernel: [17179572.992000]  hda: hda1 hda2 < hda5
hda6 >
Nov  2 11:08:52 Orbit01 kernel: [17179573.024000] hdb: max request size:
512KiB
Nov  2 11:08:52 Orbit01 kernel: [17179573.040000] hdb: 488397168 sectors
(250059 MB) w/2048KiB Cache, CHS=30401/255/63, UDMA(33)
Nov  2 11:08:52 Orbit01 kernel: [17179573.044000] hdb: cache flushes
supported
Nov  2 11:08:52 Orbit01 kernel: [17179573.044000]  hdb: hdb1
Nov  2 11:08:52 Orbit01 kernel: [17179573.048000] hdc: max request size:
512KiB
Nov  2 11:08:52 Orbit01 kernel: [17179573.080000] hdc: 312581808 sectors
(160041 MB) w/2048KiB Cache, CHS=19457/255/63, UDMA(33)
Nov  2 11:08:52 Orbit01 kernel: [17179573.104000] hdc: cache flushes
supported
Nov  2 11:08:52 Orbit01 kernel: [17179573.104000]  hdc: hdc1
Nov  2 11:08:52 Orbit01 kernel: [17179573.132000] hdd: ATAPI 40X DVD-ROM
DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Nov  2 11:08:52 Orbit01 kernel: [17179573.132000] Uniform CD-ROM driver
Revision: 3.20
Nov  2 11:08:52 Orbit01 kernel: [17179573.140000] mice: PS/2 mouse
device common for all mice
Nov  2 11:08:52 Orbit01 kernel: [17179573.140000] oprofile: using NMI
interrupt.
Nov  2 11:08:52 Orbit01 kernel: [17179573.140000] NET: Registered
protocol family 2
Nov  2 11:08:52 Orbit01 kernel: [17179573.164000] input: AT Translated
Set 2 keyboard as /class/input/input0
Nov  2 11:08:52 Orbit01 kernel: [17179573.168000] IP route cache hash
table entries: 32768 (order: 5, 131072 bytes)
Nov  2 11:08:52 Orbit01 kernel: [17179573.168000] TCP established hash
table entries: 131072 (order: 8, 1572864 bytes)
Nov  2 11:08:52 Orbit01 kernel: [17179573.168000] TCP bind hash table
entries: 65536 (order: 7, 786432 bytes)
Nov  2 11:08:52 Orbit01 kernel: [17179573.168000] TCP: Hash tables
configured (established 131072 bind 65536)
Nov  2 11:08:52 Orbit01 kernel: [17179573.168000] TCP reno registered
Nov  2 11:08:52 Orbit01 kernel: [17179573.168000] ip_conntrack version
2.4 (7168 buckets, 57344 max) - 172 bytes per conntrack
Nov  2 11:08:52 Orbit01 kernel: [17179573.272000] TCP bic registered
Nov  2 11:08:52 Orbit01 kernel: [17179573.272000] NET: Registered
protocol family 1
Nov  2 11:08:52 Orbit01 kernel: [17179573.272000] NET: Registered
protocol family 17
Nov  2 11:08:52 Orbit01 kernel: [17179573.272000] Using IPI Shortcut mode
Nov  2 11:08:52 Orbit01 kernel: [17179573.272000] Freeing unused kernel
memory: 212k freed
Nov  2 11:08:52 Orbit01 kernel: [17179573.464000] logips2pp: Detected
unknown logitech mouse model 90
Nov  2 11:08:52 Orbit01 kernel: [17179573.500000] ACPI: PCI Interrupt
0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 17
Nov  2 11:08:52 Orbit01 kernel: [17179573.500000] ata1: SATA max
UDMA/133 cmd 0xEC00 ctl 0xE802 bmdma 0xDC00 irq 17
Nov  2 11:08:52 Orbit01 kernel: [17179573.500000] ata2: SATA max
UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 17
Nov  2 11:08:52 Orbit01 kernel: [17179573.664000] ATA: abnormal status
0x7F on port 0xEC07
Nov  2 11:08:52 Orbit01 kernel: [17179573.664000] scsi0 : ata_piix
Nov  2 11:08:52 Orbit01 kernel: [17179573.828000] ATA: abnormal status
0x7F on port 0xE407
Nov  2 11:08:52 Orbit01 kernel: [17179573.828000] scsi1 : ata_piix




the kernel/gcc versions,

Nov  1 12:05:50 Orbit01 kernel: [17179569.184000] Linux version 2.6.16
(root@Orbit01) (gcc version 4.0.2 20051125 (Red Hat 4.0.2-8)) #9 SMP
PREEMPT Thu Jul 20 16:15:33 GST 2006


The hardware what i have is a Pentium 4 processor on an Intel D865 PERL
motherboard
(http://www.intel.com/products/motherboard/D865PERL/index.htm)


[root@Orbit01 proc]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
stepping        : 7
cpu MHz         : 2394.314
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 4796.49



Any idea as to what could be causing the lost interrupt ?

Regards,
Manu
