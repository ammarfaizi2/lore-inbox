Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269175AbUINGnC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269175AbUINGnC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 02:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269169AbUINGnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 02:43:02 -0400
Received: from palma.portsdebalears.com ([195.53.243.35]:29865 "EHLO
	cochise.portsdebalears.com") by vger.kernel.org with ESMTP
	id S269179AbUINGfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 02:35:46 -0400
Date: Tue, 14 Sep 2004 08:35:37 +0200
From: Kiko Piris <kernel@pirispons.net>
To: linux-kernel@vger.kernel.org
Subject: [2.6.8-rc1] lost DMA on my Intel 82801EB (ICH5) Serial ATA 150 Storage Controller
Message-ID: <20040914063537.GA3954@fpirisp.portsdebalears.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
User-Agent: Mutt
X-No-CC: Please respect my Mail-Followup-To header
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Since 2.6.8-rc1, DMA does not work for me. I've tried (almost) all
kernels since that one: 2.6.8-rc[1234], 2.6.8.1 and 2.6.9-rc2.

With all of them I get the same result:

A hdparm -d tells me that DMA is off (and in fact, it is off as I can
see from the numbers of a hdparm -t).

And if I try to activate it with hdparm -d1, it gives me a "operation
not supported" error.

The last one that I've ben able to make DMA work is 2.6.7.

Attached is the output of:

* lspci -v
* hdparm -I /dev/hda
* /proc/cpuinfo
* cat /boot/config-2.6.9-rc2 | grep -i ^config
* dmesg (right after booting both 2.6.7 and 2.6.9-rc2)

Am I doing something wrong? Do I need to provide more information?

Many thanks in advance.

-- 
Kiko
Private mail is preferred encrypted:
http://www.pirispons.net/pgpkey.html

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci-v.txt"

0000:00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub Interface (rev 02)
	Subsystem: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub Interface
	Flags: bus master, fast devsel, latency 0
	Memory at c4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [e4] #09 [0106]
	Capabilities: [a0] AGP version 3.0

0000:00:01.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to AGP Controller (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, fast devsel, latency 96
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: c0100000-c01fffff
	Prefetchable memory behind bridge: d0000000-efffffff

0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (rev 02) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 0285
	Flags: bus master, medium devsel, latency 0, IRQ 16
	I/O ports at 1800 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (rev 02) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 0285
	Flags: bus master, medium devsel, latency 0, IRQ 19
	I/O ports at 1820 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 0285
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at 1840 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
	Subsystem: IBM: Unknown device 0285
	Flags: bus master, medium devsel, latency 0, IRQ 23
	Memory at c0000000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: c0200000-c02fffff

0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
	Flags: bus master, medium devsel, latency 0

0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: IBM: Unknown device 0285
	Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 18
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at 1860 [size=16]

0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
	Subsystem: IBM: Unknown device 0285
	Flags: medium devsel, IRQ 17
	I/O ports at 1880 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
	Subsystem: IBM: Unknown device 0285
	Flags: bus master, medium devsel, latency 0, IRQ 17
	I/O ports at 1c00 [size=256]
	I/O ports at 18c0 [size=64]
	Memory at c0000800 (32-bit, non-prefetchable) [size=512]
	Memory at c0000400 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV350 AP [Radeon 9600] (prog-if 00 [VGA])
	Subsystem: Giga-byte Technology: Unknown device 4022
	Flags: bus master, fast Back2Back, 66MHz, medium devsel, latency 66, IRQ 16
	Memory at d0000000 (32-bit, prefetchable) [size=256M]
	I/O ports at 2000 [size=256]
	Memory at c0100000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [58] AGP version 3.0
	Capabilities: [50] Power Management version 2

0000:01:00.1 Display controller: ATI Technologies Inc RV350 AP [Radeon 9600] (Secondary)
	Subsystem: Giga-byte Technology: Unknown device 4023
	Flags: bus master, fast Back2Back, 66MHz, medium devsel, latency 66
	Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Memory at c0110000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 2

0000:03:08.0 Ethernet controller: Intel Corp. 82562EZ 10/100 Ethernet Controller (rev 02)
	Subsystem: IBM: Unknown device 0285
	Flags: bus master, medium devsel, latency 66, IRQ 20
	Memory at c0214000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 3000 [size=64]
	Capabilities: [dc] Power Management version 2

0000:03:09.0 Communication controller: Conexant: Unknown device 2702 (rev 01)
	Subsystem: Conexant: Unknown device 2002
	Flags: bus master, medium devsel, latency 32, IRQ 21
	Memory at c0200000 (32-bit, non-prefetchable) [size=64K]
	I/O ports at 3040 [size=8]
	Capabilities: [40] Power Management version 2

0000:03:0c.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Procomp Informatics Ltd: Unknown device 15c5
	Flags: bus master, medium devsel, latency 32, IRQ 20
	Memory at c0215000 (32-bit, non-prefetchable) [size=2K]
	Memory at c0210000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hdparm-I.txt"


/dev/hda:

ATA device, with non-removable media
	Model Number:       Maxtor 6Y160M0                          
	Serial Number:      Y444CX9E            
	Firmware Revision:  YAR51EW0
Standards:
	Supported: 7 6 5 4 
	Likely used: 7
Configuration:
	Logical		max	current
	cylinders	16383	65535
	heads		16	1
	sectors/track	63	63
	--
	CHS current addressable sectors:    4128705
	LBA    user addressable sectors:  268435455
	LBA48  user addressable sectors:  312581808
	device size with M = 1024*1024:      152627 MBytes
	device size with M = 1000*1000:      160041 MBytes (160 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 1
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Advanced power management level: unknown setting (0x0000)
	Recommended acoustic management value: 192, current value: 254
	DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 udma6 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	NOP cmd
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
	   *	SMART feature set
	   *	FLUSH CACHE EXT command
	   *	Mandatory FLUSH CACHE command 
	   *	Device Configuration Overlay feature set 
	   *	48-bit Address feature set 
	   *	Automatic Acoustic Management feature set 
		SET MAX security extension
		Advanced Power Management feature set
	   *	DOWNLOAD MICROCODE cmd
	   *	SMART self-test 
	   *	SMART error logging 
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
		frozen
	not	expired: security count
	not	supported: enhanced erase
Checksum: correct

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=cpuinfo

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 3
model name	: Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping	: 4
cpu MHz		: 2794.270
cache size	: 1024 KB
physical id	: 0
siblings	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe pni monitor ds_cpl cid
bogomips	: 5521.40

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 3
model name	: Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping	: 4
cpu MHz		: 2794.270
cache size	: 1024 KB
physical id	: 0
siblings	: 2
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe pni monitor ds_cpl cid
bogomips	: 5570.56


--C7zPtVaVf+AK4Oqc
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="kernel.config.bz2"
Content-Transfer-Encoding: base64

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
U+/qeheBJAYLuSKcKEgQc6kOgA==

--C7zPtVaVf+AK4Oqc
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="dmesg.2.6.7.out.bz2"
Content-Transfer-Encoding: base64

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
nu0g

--C7zPtVaVf+AK4Oqc
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="dmesg.2.6.9-rc2.out.bz2"
Content-Transfer-Encoding: base64

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

--C7zPtVaVf+AK4Oqc--
