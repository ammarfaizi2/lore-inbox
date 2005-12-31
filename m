Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbVLaPvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbVLaPvn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 10:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbVLaPvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 10:51:43 -0500
Received: from [202.67.154.148] ([202.67.154.148]:25756 "EHLO ns666.com")
	by vger.kernel.org with ESMTP id S1751335AbVLaPvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 10:51:42 -0500
Message-ID: <43B6A901.3050101@ns666.com>
Date: Sat, 31 Dec 2005 16:51:29 +0100
From: Mark v Wolher <trilight@ns666.com>
User-Agent: Mozilla/4.8 [en] (Windows NT 5.1; U)
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mark v Wolher <trilight@ns666.com>
CC: Jesper Juhl <jesper.juhl@gmail.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Lee Revell <rlrevell@joe-job.com>,
       Folkert van Heusden <folkert@vanheusden.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
References: <43B53EAB.3070800@ns666.com>	 <200512310027.47757.s0348365@sms.ed.ac.uk>	 <43B5D3ED.3080504@ns666.com>	 <200512310051.03603.s0348365@sms.ed.ac.uk>	 <43B5D6D0.9050601@ns666.com> <43B65DEE.906@ns666.com>	 <9a8748490512310308g1f529495ic7eab4bd3efec9e4@mail.gmail.com>	 <43B66E3D.2010900@ns666.com> <9a8748490512310349g10d004c7i856cf3e70be5974@mail.gmail.com> <43B67DB6.2070201@ns666.com> <43B6A14E.1020703@ns666.com>
In-Reply-To: <43B6A14E.1020703@ns666.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark v Wolher wrote:
> Mark v Wolher wrote:
> 
>>Jesper Juhl wrote:
>>
>>
>>>On 12/31/05, Mark v Wolher <trilight@ns666.com> wrote:
>>>
>>>
>>>
>>>>Jesper Juhl wrote:
>>>>
>>>>
>>>>
>>>>>On 12/31/05, Mark v Wolher <trilight@ns666.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>>g'morning !
>>>>>>
>>>>>>the memtest86 went 40 times over the memory, no errors detected.
>>>>>>
>>>>>
>>>>>Give memtest86+ a spin (http://www.memtest.org/) as well. memtest86 is
>>>>>good, but I've found in the past that memtest86+ sometimes finds
>>>>>errors that memtest86 does not, so giving both a sin fo an extended
>>>>>period of time is usually a good idea.
>>>>>Also, make sure you enable all the tests of both tools.
>>>>
>>>>Hi Jesper,
>>>>
>>>>Oh i thought they were the same, i used memtest86+ which comes with
>>>>debian and not the "older" memtest86.
>>>>
>>>>Right now i booted the kernel with nomce since one never knows with dell
>>>
>>>
>>>Surpressing MCE's (Machine Check Exceptions) is a really bad idea
>>>usually. MCE's indicate a hardware problem, so unless it's known that
>>>a certain MCE is reported wrongly they should *not* be ignored.
>>
>>
>>Hi Jesper,
>>
>>Yes, i rather not disable it, but since i found some reports also
>>related to dell machines which somehow do not follow always the standard
>>this caused false exceptions on them. I'll re-enable it, and see if the
>>update of the intel microcode made a difference. I have now only the nv
>>module loaded. If a crash occurs i'll open the box and remove the tvcard.
>>
>>Also, i wonder, i downloaded the DSDT table from the bios and when i
>>recompiled it with IASL from intel it showed 7 errors, one of them
>>related to DMA. It is known that alot of companies like Dell use
>>microsoft compilers which easily skip such errors or not report them,
>>this is what i read.
>>
>>I'm pasting the DSDT errors occured during recompile, who knows, this
>>could also a help a little bit.
>>
>>DSDT Table / Recompile:
>>
>>Intel ACPI Component Architecture
>>ASL Optimizing Compiler version 20050930 [Dec 15 2005]
>>Copyright (C) 2000 - 2005 Intel Corporation
>>Supports ACPI Specification Revision 3.0
>>
>>dsdt.dsl   338:         Notify (\_SB.PCI0.USB0, 0x02)
>>Error    1061 -        Object does not exist ^  (\_SB.PCI0.USB0)
>>
>>dsdt.dsl   351:         Notify (\_SB.PCI0.USB1, 0x02)
>>Error    1061 -        Object does not exist ^  (\_SB.PCI0.USB1)
>>
>>dsdt.dsl   364:         Notify (\_SB.PCI0.USB2, 0x02)
>>Error    1061 -        Object does not exist ^  (\_SB.PCI0.USB2)
>>
>>dsdt.dsl   377:         Notify (\_SB.PCI0, 0x02)
>>Error    1061 -   Object does not exist ^  (\_SB.PCI0)
>>
>>dsdt.dsl   384:         Notify (\_SB.PCI0.PCI4, 0x02)
>>Error    1061 -        Object does not exist ^  (\_SB.PCI0.PCI4)
>>
>>dsdt.dsl   400:         Notify (\_SB.PCI0.ISA.KBD, 0x02)
>>Error    1061 -           Object does not exist ^  (\_SB.PCI0.ISA.KBD)
>>
>>dsdt.dsl  1784:                 Device (DMA)
>>Error    1094 -                           ^ syntax error, unexpected
>>PARSEOP_DMA, expecting PARSEOP_NAMESEG or PARSEOP_NAMESTRING
>>
>>ASL Input:  dsdt.dsl - 3096 lines, 93624 bytes, 515 keywords
>>Compilation complete. 7 Errors, 0 Warnings, 0 Remarks, 53 Optimizations
>>
>>
>>====
>>
>>LSUSB:
>>Bus 004 Device 002: ID 0d8c:0001 C-Media Electronics, Inc.
>>Bus 004 Device 001: ID 0000:0000
>>Bus 003 Device 003: ID 051d:0002 American Power Conversion Back-UPS Pro
>>500/1000/1500
>>Bus 003 Device 002: ID 046d:c00e Logitech, Inc. Optical Mouse
>>Bus 003 Device 001: ID 0000:0000
>>Bus 002 Device 001: ID 0000:0000
>>Bus 001 Device 001: ID 0000:0000
>>
>>
>>=====
>>
>>cat /proc/meminfo:
>>
>>MemTotal:       512548 kB
>>MemFree:         10684 kB
>>Buffers:         17252 kB
>>Cached:         221508 kB
>>SwapCached:      10120 kB
>>Active:         355392 kB
>>Inactive:        49652 kB
>>HighTotal:           0 kB
>>HighFree:            0 kB
>>LowTotal:       512548 kB
>>LowFree:         10684 kB
>>SwapTotal:     4883680 kB
>>SwapFree:      4739048 kB
>>Dirty:             132 kB
>>Writeback:           0 kB
>>Mapped:         347756 kB
>>Slab:            49344 kB
>>CommitLimit:   5139952 kB
>>Committed_AS:   635544 kB
>>PageTables:       2108 kB
>>VmallocTotal:   515796 kB
>>VmallocUsed:     25556 kB
>>VmallocChunk:   486608 kB
>>
>>=====
>>
>>cat /proc/cpuinfo:
>>
>>processor       : 0
>>vendor_id       : GenuineIntel
>>cpu family      : 15
>>model           : 2
>>model name      : Intel(R) Xeon(TM) CPU 2.40GHz
>>stepping        : 9
>>cpu MHz         : 2392.630
>>cache size      : 512 KB
>>physical id     : 0
>>siblings        : 2
>>core id         : 0
>>cpu cores       : 1
>>fdiv_bug        : no
>>hlt_bug         : no
>>f00f_bug        : no
>>coma_bug        : no
>>fpu             : yes
>>fpu_exception   : yes
>>cpuid level     : 2
>>wp              : yes
>>flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca
>>cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
>>bogomips        : 4791.93
>>
>>processor       : 1
>>vendor_id       : GenuineIntel
>>cpu family      : 15
>>model           : 2
>>model name      : Intel(R) Xeon(TM) CPU 2.40GHz
>>stepping        : 9
>>cpu MHz         : 2392.630
>>cache size      : 512 KB
>>physical id     : 0
>>siblings        : 2
>>core id         : 0
>>cpu cores       : 1
>>fdiv_bug        : no
>>hlt_bug         : no
>>f00f_bug        : no
>>coma_bug        : no
>>fpu             : yes
>>fpu_exception   : yes
>>cpuid level     : 2
>>wp              : yes
>>flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca
>>cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
>>bogomips        : 4784.99
>>
>>processor       : 2
>>vendor_id       : GenuineIntel
>>cpu family      : 15
>>model           : 2
>>model name      : Intel(R) Xeon(TM) CPU 2.40GHz
>>stepping        : 9
>>cpu MHz         : 2392.630
>>cache size      : 512 KB
>>physical id     : 3
>>siblings        : 2
>>core id         : 3
>>cpu cores       : 1
>>fdiv_bug        : no
>>hlt_bug         : no
>>f00f_bug        : no
>>coma_bug        : no
>>fpu             : yes
>>fpu_exception   : yes
>>cpuid level     : 2
>>wp              : yes
>>flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca
>>cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
>>bogomips        : 4785.12
>>
>>processor       : 3
>>vendor_id       : GenuineIntel
>>cpu family      : 15
>>model           : 2
>>model name      : Intel(R) Xeon(TM) CPU 2.40GHz
>>stepping        : 9
>>cpu MHz         : 2392.630
>>cache size      : 512 KB
>>physical id     : 3
>>siblings        : 2
>>core id         : 3
>>cpu cores       : 1
>>fdiv_bug        : no
>>hlt_bug         : no
>>f00f_bug        : no
>>coma_bug        : no
>>fpu             : yes
>>fpu_exception   : yes
>>cpuid level     : 2
>>wp              : yes
>>flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca
>>cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
>>bogomips        : 4785.12
>>
>>=====
>>
>>lspci -v:
>>0000:00:00.0 Host bridge: Intel Corporation E7505 Memory Controller Hub
>>(rev 03)
>>        Subsystem: Dell: Unknown device 012c
>>        Flags: bus master, fast devsel, latency 0
>>        Memory at e8000000 (32-bit, prefetchable) [size=128M]
>>        Capabilities: [40] #09 [0104]
>>        Capabilities: [a0] AGP version 3.0
>>
>>0000:00:01.0 PCI bridge: Intel Corporation E7505/E7205 PCI-to-AGP Bridge
>>(rev 03) (prog-if 00 [Normal decode])
>>        Flags: bus master, 66MHz, fast devsel, latency 64
>>        Memory at e0000000 (32-bit, prefetchable) [size=128M]
>>        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
>>        Memory behind bridge: fc000000-fdffffff
>>        Prefetchable memory behind bridge: f0000000-f7ffffff
>>        Capabilities: [60] #0e [0035]
>>
>>0000:00:02.0 PCI bridge: Intel Corporation E7505 Hub Interface B
>>PCI-to-PCI Bridge (rev 03) (prog-if 00 [Normal decode])
>>        Flags: bus master, 66MHz, fast devsel, latency 64
>>        Bus: primary=00, secondary=02, subordinate=04, sec-latency=0
>>        I/O behind bridge: 0000e000-0000efff
>>        Memory behind bridge: fe300000-fe6fffff
>>
>>0000:00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM
>>(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 01) (prog-if 00 [UHCI])
>>        Subsystem: Dell: Unknown device 012c
>>        Flags: bus master, medium devsel, latency 0, IRQ 21
>>        I/O ports at ff80 [size=32]
>>
>>0000:00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM
>>(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 01) (prog-if 00 [UHCI])
>>        Subsystem: Dell: Unknown device 012c
>>        Flags: bus master, medium devsel, latency 0, IRQ 22
>>        I/O ports at ff60 [size=32]
>>
>>0000:00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM
>>(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 01) (prog-if 00 [UHCI])
>>        Subsystem: Dell: Unknown device 012c
>>        Flags: bus master, medium devsel, latency 0, IRQ 18
>>        I/O ports at ff40 [size=32]
>>
>>0000:00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M)
>>USB2 EHCI Controller (rev 01) (prog-if 20 [EHCI])
>>        Subsystem: Dell: Unknown device 012c
>>        Flags: bus master, medium devsel, latency 0, IRQ 20
>>        Memory at fe700800 (32-bit, non-prefetchable) [size=1K]
>>        Capabilities: [50] Power Management version 2
>>        Capabilities: [58] #0a [2080]
>>
>>0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 81)
>>(prog-if 00 [Normal decode])
>>        Flags: bus master, fast devsel, latency 0
>>        Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
>>        I/O behind bridge: 0000d000-0000dfff
>>        Memory behind bridge: fe100000-fe2fffff
>>        Prefetchable memory behind bridge: f8000000-f80fffff
>>
>>0000:00:1f.0 ISA bridge: Intel Corporation 82801DB/DBL (ICH4/ICH4-L) LPC
>>Interface Bridge (rev 01)
>>        Flags: bus master, medium devsel, latency 0
>>0000:00:1f.1 IDE interface: Intel Corporation 82801DB (ICH4) IDE
>>Controller (rev 01) (prog-if 8a [Master SecP PriP])
>>        Subsystem: Dell: Unknown device 012c
>>        Flags: bus master, medium devsel, latency 0, IRQ 18
>>        I/O ports at <unassigned>
>>        I/O ports at <unassigned>
>>        I/O ports at <unassigned>
>>        I/O ports at <unassigned>
>>        I/O ports at ffa0 [size=16]
>>        Memory at 30000000 (32-bit, non-prefetchable) [size=1K]
>>
>>0000:00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM
>>(ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 01)
>>        Subsystem: Dell: Unknown device 012c
>>        Flags: medium devsel, IRQ 4
>>        I/O ports at cc80 [size=32]
>>
>>0000:00:1f.5 Multimedia audio controller: Intel Corporation
>>82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
>>        Subsystem: Dell: Unknown device 012c
>>        Flags: bus master, medium devsel, latency 0, IRQ 23
>>        I/O ports at c800 [size=256]
>>        I/O ports at cc40 [size=64]
>>        Memory at fe700400 (32-bit, non-prefetchable) [size=512]
>>        Memory at fe700000 (32-bit, non-prefetchable) [size=256]
>>        Capabilities: [50] Power Management version 2
>>
>>0000:01:00.0 VGA compatible controller: nVidia Corporation NV34GL
>>[Quadro FX 500/600 PCI] (rev a1) (prog-if 00 [VGA])
>>        Subsystem: nVidia Corporation: Unknown device 01ba
>>        Flags: bus master, 66MHz, medium devsel, latency 248, IRQ 21
>>        Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
>>        Memory at f0000000 (32-bit, prefetchable) [size=128M]
>>        Expansion ROM at fd000000 [disabled] [size=128K]
>>        Capabilities: [60] Power Management version 2
>>        Capabilities: [44] AGP version 3.0
>>
>>0000:02:1c.0 PIC: Intel Corporation 82870P2 P64H2 I/OxAPIC (rev 04)
>>(prog-if 20 [IO(X)-APIC])
>>        Subsystem: Dell: Unknown device 012c
>>        Flags: bus master, 66MHz, fast devsel, latency 0
>>        Memory at fe3ff000 (32-bit, non-prefetchable) [size=4K]
>>        Capabilities: [50] PCI-X non-bridge device.
>>
>>0000:02:1d.0 PCI bridge: Intel Corporation 82870P2 P64H2 Hub PCI Bridge
>>(rev 04) (prog-if 00 [Normal decode])
>>        Flags: bus master, 66MHz, fast devsel, latency 64
>>        Bus: primary=02, secondary=03, subordinate=03, sec-latency=48
>>        I/O behind bridge: 0000e000-0000efff
>>        Memory behind bridge: fe500000-fe6fffff
>>        Capabilities: [50] PCI-X bridge device.
>>
>>0000:02:1e.0 PIC: Intel Corporation 82870P2 P64H2 I/OxAPIC (rev 04)
>>(prog-if 20 [IO(X)-APIC])
>>        Subsystem: Dell: Unknown device 012c
>>        Flags: bus master, 66MHz, fast devsel, latency 0
>>        Memory at fe3fe000 (32-bit, non-prefetchable) [size=4K]
>>        Capabilities: [50] PCI-X non-bridge device.
>>
>>0000:02:1f.0 PCI bridge: Intel Corporation 82870P2 P64H2 Hub PCI Bridge
>>(rev 04) (prog-if 00 [Normal decode])
>>        Flags: bus master, 66MHz, fast devsel, latency 64
>>        Bus: primary=02, secondary=04, subordinate=04, sec-latency=64
>>        Capabilities: [50] PCI-X bridge device.
>>
>>0000:03:0d.0 Mass storage controller: Promise Technology, Inc. 20269
>>(rev 02) (prog-if 85)
>>        Subsystem: Promise Technology, Inc. Ultra133TX2
>>        Flags: bus master, 66MHz, slow devsel, latency 64, IRQ 19
>>        I/O ports at ecf8 [size=8]
>>        I/O ports at ecf0 [size=4]
>>        I/O ports at ece0 [size=8]
>>        I/O ports at ecd8 [size=4]
>>        I/O ports at ecc0 [size=16]
>>        Memory at fe5fc000 (32-bit, non-prefetchable) [size=16K]
>>        Expansion ROM at fe600000 [disabled] [size=16K]
>>        Capabilities: [60] Power Management version 1
>>
>>0000:03:0e.0 Ethernet controller: Intel Corporation 82545EM Gigabit
>>Ethernet Controller (Copper) (rev 01)
>>        Subsystem: Dell: Unknown device 012c
>>        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 16
>>        Memory at fe5c0000 (64-bit, non-prefetchable) [size=128K]
>>        I/O ports at ec80 [size=64]
>>        Capabilities: [dc] Power Management version 2
>>        Capabilities: [e4] PCI-X non-bridge device.
>>        Capabilities: [f0] Message Signalled Interrupts: 64bit+
>>Queue=0/0 Enable-
>>
>>0000:05:0c.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A
>>IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
>>        Subsystem: Dell: Unknown device 012c
>>        Flags: bus master, medium devsel, latency 64, IRQ 4
>>        Memory at fe1ff800 (32-bit, non-prefetchable) [size=2K]
>>        Memory at fe1f8000 (32-bit, non-prefetchable) [size=16K]
>>        Capabilities: [44] Power Management version 2
>>
>>0000:05:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1
>>(rev 07)
>>        Subsystem: Creative Labs SBLive! 5.1 Model SB0100
>>        Flags: bus master, medium devsel, latency 64, IRQ 24
>>        I/O ports at dce0 [size=32]
>>        Capabilities: [dc] Power Management version 1
>>
>>0000:05:0d.1 Input device controller: Creative Labs SB Live! MIDI/Game
>>Port (rev 07)
>>        Subsystem: Creative Labs Gameport Joystick
>>        Flags: bus master, medium devsel, latency 64
>>        I/O ports at dcd8 [size=8]
>>        Capabilities: [dc] Power Management version 1
>>
>>0000:05:0e.0 Multimedia video controller: Brooktree Corporation Bt878
>>Video Capture (rev 02)
>>        Subsystem: TERRATEC Electronic GmbH: Unknown device 1134
>>        Flags: bus master, medium devsel, latency 64, IRQ 17
>>        Memory at f80ff000 (32-bit, prefetchable) [size=4K]
>>
>>0000:05:0e.1 Multimedia controller: Brooktree Corporation Bt878 Audio
>>Capture (rev 02)
>>        Subsystem: TERRATEC Electronic GmbH: Unknown device 1134
>>        Flags: bus master, medium devsel, latency 64, IRQ 10
>>        Memory at f80fe000 (32-bit, prefetchable) [size=4K]
>>
>>
>>====
>>
>>ver_linux script output:
>>If some fields are empty or look unusual you may have an old version.
>>Compare to the current minimal requirements in Documentation/Changes.
>>
>>Linux sigma-9 2.6.14.5 #5 SMP Fri Dec 30 19:50:12 CET 2005 i686 GNU/Linux
>>
>>Gnu C                  3.3.5
>>Gnu make               3.80
>>binutils               2.15
>>util-linux             2.12p
>>mount                  2.12p
>>module-init-tools      3.2-pre1
>>e2fsprogs              1.37
>>reiserfsprogs          line
>>reiser4progs           line
>>PPP                    2.4.3
>>nfs-utils              1.0.6
>>Linux C Library        2.3.2
>>Dynamic linker (ldd)   2.3.2
>>Procps                 3.2.1
>>Net-tools              1.60
>>Console-tools          0.2.3
>>Sh-utils               5.2.1
>>udev                   056
>>Modules Loaded         nv
>>
>>
>>====
>>
>>results of memtest86+ after 40 passes with all tests enabled: no errors
>>
>>====
>>
>>cat /proc/interrupts:
>>           CPU0       CPU1       CPU2       CPU3
>>  0:     501324     492735     492754     492100    IO-APIC-edge  timer
>>  1:       2555       2761       2861       2451    IO-APIC-edge  i8042
>>  7:          0          0          0          0    IO-APIC-edge  parport0
>>  8:    2369118    2386295    2363140    2356586    IO-APIC-edge  rtc
>>  9:          0          0          0          0   IO-APIC-level  acpi
>> 14:         21          0          0          0    IO-APIC-edge  ide0
>> 15:         13          0          0          0    IO-APIC-edge  ide1
>> 16:      28924          0          0          0   IO-APIC-level  eth0
>> 17:      97407     105474     103650     103304   IO-APIC-level  bttv0
>> 18:         48          4          0          7   IO-APIC-level
>>uhci_hcd:usb4
>> 19:      28880      54020      48433      23791   IO-APIC-level  ide2, ide3
>> 20:          6          0          1          0   IO-APIC-level
>>ehci_hcd:usb1
>> 21:     398859     319390     317707     425780   IO-APIC-level
>>uhci_hcd:usb2, nv
>> 22:     200970     244113     220837     191613   IO-APIC-level
>>uhci_hcd:usb3
>> 23:          0          0          0          0   IO-APIC-level  Intel
>>82801DB-ICH4
>> 24:       9460       9468      12491       8706   IO-APIC-level  EMU10K1
>>NMI:          0          0          0          0
>>LOC:    1978858    1979111    1979110    1979109
>>ERR:          0
>>MIS:          0
>>
>>
>>====
>>
>>2.6.14.5 vanilla kernel .config file see attachment
>>
>>====
>>
>>I hope this gives more complete picture of the current running setup.
>>
>>
> 
> 
> Ok, got some more data now, i did recompile the kernel with alot of
> debugging options turned on in kernel hacking section.
> 
> Maybe because of those debugging options the system won't freeze quickly
> but rather display the errors and continue to run, because of
> detect_soft_lockups and nmi watchdog i think.
> 
> Here is new data, this time it had to do with bttv:
> 
> Dec 31 16:11:35 localhost kernel: Unable to handle kernel paging request at
> virtual address d162e000
> Dec 31 16:11:35 localhost kernel: printing eip:
> Dec 31 16:11:35 localhost kernel: c036037a
> Dec 31 16:11:35 localhost kernel: *pgd = 46063
> Dec 31 16:11:35 localhost kernel: *pmd = 46063
> Dec 31 16:11:35 localhost kernel: *pte = 1162e000
> Dec 31 16:11:35 localhost kernel: Oops: 0002 [#1]
> Dec 31 16:11:35 localhost kernel: SMP DEBUG_PAGEALLOC
> Dec 31 16:11:35 localhost kernel: Modules linked in: nv
> Dec 31 16:11:35 localhost kernel: CPU:    2
> Dec 31 16:11:35 localhost kernel: EIP:    0060:[bttv_risc_packed+394/432]
> Not tainted VLI
> Dec 31 16:11:35 localhost kernel: EFLAGS: 00210202   (2.6.14.5)
> Dec 31 16:11:35 localhost kernel: eax: 14000008   ebx: d5ce9800   ecx:
> d162e000   edx: 00000008
> Dec 31 16:11:35 localhost kernel: esi: 00000008   edi: 000000ff   ebp:
> cd06dde8   esp: cd06ddd0
> Dec 31 16:11:35 localhost kernel: ds: 007b   es: 007b   ss: 0068
> Dec 31 16:11:35 localhost kernel: Process xawtv (pid: 31110,
> threadinfo=cd06c000 task=ca871aa0)
> Dec 31 16:11:35 localhost kernel: Stack: df80bbf8 c3b25fbc 00000fd0 00000c00
> 000d8000 c3b25ef8 cd06de40 c0361b0b
> Dec 31 16:11:35 localhost kernel: c06ccba0 c3b25fbc d5ce8000 00000c00
> 00000c00 00000c00 00000120 000001b1
> Dec 31 16:11:35 localhost kernel: 00000008 c3b25f1c c06cd168 00000000
> cd06de40 c037022a df80bbf8 c3b25f1c
> Dec 31 16:11:35 localhost kernel: Call Trace:
> Dec 31 16:11:35 localhost kernel: [show_stack+127/160]
> Dec 31 16:11:35 localhost kernel: [show_registers+347/448]
> Dec 31 16:11:35 localhost kernel: [die+256/384]
> Dec 31 16:11:35 localhost kernel: [do_page_fault+1084/2083]
> Dec 31 16:11:35 localhost kernel: [error_code+79/96]
> Dec 31 16:11:35 localhost kernel: [bttv_buffer_risc+1371/1696]
> Dec 31 16:11:35 localhost kernel: [bttv_prepare_buffer+268/464]
> Dec 31 16:11:35 localhost kernel: [buffer_prepare+69/80]
> Dec 31 16:11:35 localhost kernel: [videobuf_read_zerocopy+108/304]
> Dec 31 16:11:35 localhost kernel: [videobuf_read_one+522/560]
> Dec 31 16:11:35 localhost kernel: [bttv_read+272/352]
> Dec 31 16:11:35 localhost kernel: [vfs_read+213/432]
> Dec 31 16:11:35 localhost kernel: [sys_read+75/128]
> Dec 31 16:11:35 localhost kernel: [syscall_call+7/11]
> Dec 31 16:11:35 localhost kernel: Code: 00 0d 00 00 00 10 89 01 8b 43 08 83
> c1 04 89 01 8b 43 0c 83 c1 04 83 c3 10 29 c2 8b 43 0c 39 c2 77 df 89 d0 89
> d6 0d 00 00 00 14 <89> 01 8b 43 08 83 c1 04 89 01 83 c1 04 eb 8a 8d b4 26 00
> 00 00
> 
> 
> 
> 

(please don't see nv as any module, a copy/paste accident of mine while
commenting my log)

I just had xchat crash, nothing in the log, it just disappeared.
The system is now very slow but i guess that's because of the debugging
options enabled.

