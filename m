Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132234AbRALReO>; Fri, 12 Jan 2001 12:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132246AbRALReE>; Fri, 12 Jan 2001 12:34:04 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:49169 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S132234AbRALRdx>;
	Fri, 12 Jan 2001 12:33:53 -0500
Date: Fri, 12 Jan 2001 18:33:14 +0100
From: Frank de Lange <frank@unternet.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware related?
Message-ID: <20010112183314.A24174@unternet.org>
In-Reply-To: <3A5F3BF4.7C5567F8@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5F3BF4.7C5567F8@colorfullife.com>; from manfred@colorfullife.com on Fri, Jan 12, 2001 at 06:16:36PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2001 at 06:16:36PM +0100, Manfred Spraul wrote:
> I would first concentrate on the differences between 2.2 and 2.4:
> 
> Frank, could you try what happens with the NMI oopser disabled?

Here's the results with nmi_watchdog=0

Before network hang (nmi_watchdog=0)
====================================
Jan 12 18:24:43 behemoth kernel: SysRq:
Jan 12 18:24:43 behemoth kernel: print_PIC()
Jan 12 18:24:43 behemoth kernel:
Jan 12 18:24:43 behemoth kernel: printing PIC contents
Jan 12 18:24:43 behemoth kernel: ... PIC  IMR: fffa
Jan 12 18:24:43 behemoth kernel: ... PIC  IRR: 0000
Jan 12 18:24:43 behemoth kernel: ... PIC  ISR: 0000
Jan 12 18:24:43 behemoth kernel: ... PIC ELCR: 1e00
Jan 12 18:24:43 behemoth kernel: print_IO_APIC()
Jan 12 18:24:43 behemoth kernel: number of MP IRQ sources: 23.
Jan 12 18:24:43 behemoth kernel: number of IO-APIC #2 registers: 24.
Jan 12 18:24:43 behemoth kernel: testing the IO APIC.......................
Jan 12 18:24:43 behemoth kernel:
Jan 12 18:24:43 behemoth kernel: IO APIC #2......
Jan 12 18:24:43 behemoth kernel: .... register #00: 02000000
Jan 12 18:24:43 behemoth kernel: .......    : physical APIC id: 02
Jan 12 18:24:43 behemoth kernel: .... register #01: 00170011
Jan 12 18:24:43 behemoth kernel: .......     : max redirection entries: 0017
Jan 12 18:24:43 behemoth kernel: .......     : IO APIC version: 0011
Jan 12 18:24:43 behemoth kernel: .... register #02: 00000000
Jan 12 18:24:43 behemoth kernel: .......     : arbitration: 00
Jan 12 18:24:43 behemoth kernel: .... IRQ redirection table:
Jan 12 18:24:43 behemoth kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
Jan 12 18:24:43 behemoth kernel:  00 000 00  1    0    0   0   0    0    0    00
Jan 12 18:24:43 behemoth kernel:  01 003 03  0    0    0   0   0    1    1    39
Jan 12 18:24:43 behemoth kernel:  02 003 03  0    0    0   0   0    1    1    31
Jan 12 18:24:43 behemoth kernel:  03 003 03  0    0    0   0   0    1    1    41
Jan 12 18:24:43 behemoth kernel:  04 003 03  0    0    0   0   0    1    1    49
Jan 12 18:24:43 behemoth kernel:  05 003 03  0    0    0   0   0    1    1    51
Jan 12 18:24:43 behemoth kernel:  06 003 03  0    0    0   0   0    1    1    59
Jan 12 18:24:43 behemoth kernel:  07 003 03  0    0    0   0   0    1    1    61
Jan 12 18:24:43 behemoth kernel:  08 003 03  0    0    0   0   0    1    1    69
Jan 12 18:24:43 behemoth kernel:  09 000 00  1    0    0   0   0    0    0    00
Jan 12 18:24:43 behemoth kernel:  0a 000 00  1    0    0   0   0    0    0    00
Jan 12 18:24:43 behemoth kernel:  0b 000 00  1    0    0   0   0    0    0    00
Jan 12 18:24:43 behemoth kernel:  0c 000 00  1    0    0   0   0    0    0    00
Jan 12 18:24:43 behemoth kernel:  0d 000 00  1    0    0   0   0    0    0    00
Jan 12 18:24:43 behemoth kernel:  0e 003 03  0    0    0   0   0    1    1    71
Jan 12 18:24:43 behemoth kernel:  0f 003 03  0    0    0   0   0    1    1    79
Jan 12 18:24:43 behemoth kernel:  10 003 03  0    1    0   1   0    1    1    81
Jan 12 18:24:43 behemoth kernel:  11 003 03  0    1    0   1   0    1    1    89
Jan 12 18:24:43 behemoth kernel:  12 003 03  0    1    0   1   0    1    1    91
Jan 12 18:24:43 behemoth kernel:  13 003 03  0    1    0   1   0    1    1    99
Jan 12 18:24:43 behemoth kernel:  14 000 00  1    0    0   0   0    0    0    00
Jan 12 18:24:43 behemoth kernel:  15 000 00  1    0    0   0   0    0    0    00
Jan 12 18:24:43 behemoth kernel:  16 000 00  1    0    0   0   0    0    0    00
Jan 12 18:24:43 behemoth kernel:  17 000 00  1    0    0   0   0    0    0    00
Jan 12 18:24:43 behemoth kernel: IRQ to pin mappings:
Jan 12 18:24:43 behemoth kernel: IRQ0 -> 2
Jan 12 18:24:43 behemoth kernel: IRQ1 -> 1
Jan 12 18:24:43 behemoth kernel: IRQ3 -> 3
Jan 12 18:24:43 behemoth kernel: IRQ4 -> 4
Jan 12 18:24:43 behemoth kernel: IRQ5 -> 5
Jan 12 18:24:43 behemoth kernel: IRQ6 -> 6
Jan 12 18:24:43 behemoth kernel: IRQ7 -> 7
Jan 12 18:24:43 behemoth kernel: IRQ8 -> 8
Jan 12 18:24:43 behemoth kernel: IRQ13 -> 13
Jan 12 18:24:43 behemoth kernel: IRQ14 -> 14
Jan 12 18:24:43 behemoth kernel: IRQ15 -> 15
Jan 12 18:24:43 behemoth kernel: IRQ16 -> 16
Jan 12 18:24:43 behemoth kernel: IRQ17 -> 17
Jan 12 18:24:43 behemoth kernel: IRQ18 -> 18
Jan 12 18:24:43 behemoth kernel: IRQ19 -> 19
Jan 12 18:24:43 behemoth kernel: .................................... done.
Jan 12 18:24:43 behemoth kernel: print_all_local_APICs()
Jan 12 18:24:43 behemoth kernel:
Jan 12 18:24:43 behemoth kernel: printing local APIC contents on CPU#1/1:
Jan 12 18:24:43 behemoth kernel: ... APIC ID:      01000000 (1)
Jan 12 18:24:43 behemoth kernel: ... APIC VERSION: 00040011
Jan 12 18:24:43 behemoth kernel: ... APIC TASKPRI: 00000000 (00)
Jan 12 18:24:43 behemoth kernel: ... APIC ARBPRI: 00000000 (00)
Jan 12 18:24:43 behemoth kernel: ... APIC PROCPRI: 00000000
Jan 12 18:24:43 behemoth kernel: ... APIC EOI: 00000000
Jan 12 18:24:43 behemoth kernel: ... APIC LDR: 02000000
Jan 12 18:24:43 behemoth kernel: ... APIC DFR: ffffffff
Jan 12 18:24:43 behemoth kernel: ... APIC SPIV: 000003ff
Jan 12 18:24:43 behemoth kernel: ... APIC ISR field:
Jan 12 18:24:43 behemoth kernel: 0123456789abcdef0123456789abcdef
Jan 12 18:24:43 behemoth kernel: 00000000000000000000000000000000
Jan 12 18:24:43 behemoth last message repeated 7 times
Jan 12 18:24:43 behemoth kernel: ... APIC TMR field:
Jan 12 18:24:43 behemoth kernel: 0123456789abcdef0123456789abcdef
Jan 12 18:24:43 behemoth kernel: 00000000000000000000000000000000
Jan 12 18:24:43 behemoth last message repeated 3 times
Jan 12 18:24:43 behemoth kernel: 00000000010000000000000001000000
Jan 12 18:24:43 behemoth kernel: 00000000000000000000000000000000
Jan 12 18:24:43 behemoth last message repeated 2 times
Jan 12 18:24:43 behemoth kernel: ... APIC IRR field:
Jan 12 18:24:43 behemoth kernel: 0123456789abcdef0123456789abcdef
Jan 12 18:24:43 behemoth kernel: 00000000000000000000000000000000
Jan 12 18:24:43 behemoth last message repeated 7 times
Jan 12 18:24:43 behemoth kernel: ... APIC ESR: 00000000
Jan 12 18:24:43 behemoth kernel: ... APIC ICR: 000008fc
Jan 12 18:24:43 behemoth kernel: ... APIC ICR2: 01000000
Jan 12 18:24:43 behemoth kernel: ... APIC LVTT: 000200ef
Jan 12 18:24:43 behemoth kernel: ... APIC LVTPC: 00010000
Jan 12 18:24:43 behemoth kernel: ... APIC LVT0: 00010700
Jan 12 18:24:43 behemoth kernel: ... APIC LVT1: 00010400
Jan 12 18:24:43 behemoth kernel: ... APIC LVTERR: 000000fe
Jan 12 18:24:43 behemoth kernel: ... APIC TMICT: 0000a322
Jan 12 18:24:43 behemoth kernel: ... APIC TMCCT: 00000be6
Jan 12 18:24:43 behemoth kernel: ... APIC TDCR: 00000003
Jan 12 18:24:43 behemoth kernel:
Jan 12 18:24:43 behemoth kernel:
Jan 12 18:24:43 behemoth kernel: printing local APIC contents on CPU#0/0:
Jan 12 18:24:43 behemoth kernel: ... APIC ID:      00000000 (0)
Jan 12 18:24:43 behemoth kernel: ... APIC VERSION: 00040011
Jan 12 18:24:43 behemoth kernel: ... APIC TASKPRI: 00000000 (00)
Jan 12 18:24:43 behemoth kernel: ... APIC ARBPRI: 000000e0 (e0)
Jan 12 18:24:43 behemoth kernel: ... APIC PROCPRI: 00000000
Jan 12 18:24:43 behemoth kernel: ... APIC EOI: 00000000
Jan 12 18:24:43 behemoth kernel: ... APIC LDR: 01000000
Jan 12 18:24:43 behemoth kernel: ... APIC DFR: ffffffff
Jan 12 18:24:43 behemoth kernel: ... APIC SPIV: 000003ff
Jan 12 18:24:43 behemoth kernel: ... APIC ISR field:
Jan 12 18:24:43 behemoth kernel: 0123456789abcdef0123456789abcdef
Jan 12 18:24:43 behemoth kernel: 00000000000000000000000000000000
Jan 12 18:24:43 behemoth last message repeated 7 times
Jan 12 18:24:43 behemoth kernel: ... APIC TMR field:
Jan 12 18:24:43 behemoth kernel: 0123456789abcdef0123456789abcdef
Jan 12 18:24:43 behemoth kernel: 00000000000000000000000000000000
Jan 12 18:24:43 behemoth last message repeated 3 times
Jan 12 18:24:43 behemoth kernel: 00000000010000000000000001000000
Jan 12 18:24:43 behemoth kernel: 00000000000000000000000000000000
Jan 12 18:24:43 behemoth last message repeated 2 times
Jan 12 18:24:43 behemoth kernel: ... APIC IRR field:
Jan 12 18:24:43 behemoth kernel: 0123456789abcdef0123456789abcdef
Jan 12 18:24:43 behemoth kernel: 00000000000000000000000000000000
Jan 12 18:24:43 behemoth kernel: 00000000000000000100000000000000
Jan 12 18:24:43 behemoth kernel: 00000000000000000000000000000000
Jan 12 18:24:43 behemoth last message repeated 4 times
Jan 12 18:24:43 behemoth kernel: 00000000000000010000000000000000
Jan 12 18:24:43 behemoth kernel: ... APIC ESR: 00000000
Jan 12 18:24:43 behemoth kernel: ... APIC ICR: 000c08fb
Jan 12 18:24:43 behemoth kernel: ... APIC ICR2: 02000000
Jan 12 18:24:43 behemoth kernel: ... APIC LVTT: 000200ef
Jan 12 18:24:43 behemoth kernel: ... APIC LVTPC: 00010000
Jan 12 18:24:43 behemoth kernel: ... APIC LVT0: 00010700
Jan 12 18:24:43 behemoth kernel: ... APIC LVT1: 00000400
Jan 12 18:24:43 behemoth kernel: ... APIC LVTERR: 000000fe
Jan 12 18:24:43 behemoth kernel: ... APIC TMICT: 0000a322
Jan 12 18:24:43 behemoth kernel: ... APIC TMCCT: 000041e1
Jan 12 18:24:43 behemoth kernel: ... APIC TDCR: 00000003


After network hang (nmi_watchdog=0)
===================================

Jan 12 18:26:21 behemoth kernel: SysRq:
Jan 12 18:26:21 behemoth kernel: print_PIC()
Jan 12 18:26:21 behemoth kernel:
Jan 12 18:26:21 behemoth kernel: printing PIC contents
Jan 12 18:26:21 behemoth kernel: ... PIC  IMR: fffa
Jan 12 18:26:21 behemoth kernel: ... PIC  IRR: 0000
Jan 12 18:26:21 behemoth kernel: ... PIC  ISR: 0000
Jan 12 18:26:21 behemoth kernel: ... PIC ELCR: 1e00
Jan 12 18:26:21 behemoth kernel: print_IO_APIC()
Jan 12 18:26:21 behemoth kernel: number of MP IRQ sources: 23.
Jan 12 18:26:21 behemoth kernel: number of IO-APIC #2 registers: 24.
Jan 12 18:26:21 behemoth kernel: testing the IO APIC.......................
Jan 12 18:26:21 behemoth kernel:
Jan 12 18:26:21 behemoth kernel: IO APIC #2......
Jan 12 18:26:21 behemoth kernel: .... register #00: 02000000
Jan 12 18:26:21 behemoth kernel: .......    : physical APIC id: 02
Jan 12 18:26:21 behemoth kernel: .... register #01: 00170011
Jan 12 18:26:21 behemoth kernel: .......     : max redirection entries: 0017
Jan 12 18:26:21 behemoth kernel: .......     : IO APIC version: 0011
Jan 12 18:26:21 behemoth kernel: .... register #02: 00000000
Jan 12 18:26:21 behemoth kernel: .......     : arbitration: 00
Jan 12 18:26:21 behemoth kernel: .... IRQ redirection table:
Jan 12 18:26:21 behemoth kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
Jan 12 18:26:21 behemoth kernel:  00 000 00  1    0    0   0   0    0    0    00
Jan 12 18:26:21 behemoth kernel:  01 003 03  0    0    0   0   0    1    1    39
Jan 12 18:26:21 behemoth kernel:  02 003 03  0    0    0   0   0    1    1    31
Jan 12 18:26:21 behemoth kernel:  03 003 03  0    0    0   0   0    1    1    41
Jan 12 18:26:21 behemoth kernel:  04 003 03  0    0    0   0   0    1    1    49
Jan 12 18:26:21 behemoth kernel:  05 003 03  0    0    0   0   0    1    1    51
Jan 12 18:26:21 behemoth kernel:  06 003 03  0    0    0   0   0    1    1    59
Jan 12 18:26:21 behemoth kernel:  07 003 03  0    0    0   0   0    1    1    61
Jan 12 18:26:21 behemoth kernel:  08 003 03  0    0    0   0   0    1    1    69
Jan 12 18:26:21 behemoth kernel:  09 000 00  1    0    0   0   0    0    0    00
Jan 12 18:26:21 behemoth kernel:  0a 000 00  1    0    0   0   0    0    0    00
Jan 12 18:26:21 behemoth kernel:  0b 000 00  1    0    0   0   0    0    0    00
Jan 12 18:26:21 behemoth kernel:  0c 000 00  1    0    0   0   0    0    0    00
Jan 12 18:26:21 behemoth kernel:  0d 000 00  1    0    0   0   0    0    0    00
Jan 12 18:26:21 behemoth kernel:  0e 003 03  0    0    0   0   0    1    1    71
Jan 12 18:26:21 behemoth kernel:  0f 003 03  0    0    0   0   0    1    1    79
Jan 12 18:26:21 behemoth kernel:  10 003 03  0    1    0   1   0    1    1    81
Jan 12 18:26:21 behemoth kernel:  11 003 03  0    1    0   1   0    1    1    89
Jan 12 18:26:21 behemoth kernel:  12 003 03  0    1    0   1   0    1    1    91
Jan 12 18:26:21 behemoth kernel:  13 003 03  0    1    1   1   0    1    1    99
Jan 12 18:26:21 behemoth kernel:  14 000 00  1    0    0   0   0    0    0    00
Jan 12 18:26:21 behemoth kernel:  15 000 00  1    0    0   0   0    0    0    00
Jan 12 18:26:21 behemoth kernel:  16 000 00  1    0    0   0   0    0    0    00
Jan 12 18:26:21 behemoth kernel:  17 000 00  1    0    0   0   0    0    0    00
Jan 12 18:26:21 behemoth kernel: IRQ to pin mappings:
Jan 12 18:26:21 behemoth kernel: IRQ0 -> 2
Jan 12 18:26:21 behemoth kernel: IRQ1 -> 1
Jan 12 18:26:21 behemoth kernel: IRQ3 -> 3
Jan 12 18:26:21 behemoth kernel: IRQ4 -> 4
Jan 12 18:26:21 behemoth kernel: IRQ5 -> 5
Jan 12 18:26:21 behemoth kernel: IRQ6 -> 6
Jan 12 18:26:21 behemoth kernel: IRQ7 -> 7
Jan 12 18:26:21 behemoth kernel: IRQ8 -> 8
Jan 12 18:26:21 behemoth kernel: IRQ13 -> 13
Jan 12 18:26:21 behemoth kernel: IRQ14 -> 14
Jan 12 18:26:21 behemoth kernel: IRQ15 -> 15
Jan 12 18:26:21 behemoth kernel: IRQ16 -> 16
Jan 12 18:26:21 behemoth kernel: IRQ17 -> 17
Jan 12 18:26:21 behemoth kernel: IRQ18 -> 18
Jan 12 18:26:21 behemoth kernel: IRQ19 -> 19
Jan 12 18:26:21 behemoth kernel: .................................... done.
Jan 12 18:26:21 behemoth kernel: print_all_local_APICs()
Jan 12 18:26:21 behemoth kernel:
Jan 12 18:26:21 behemoth kernel: printing local APIC contents on CPU#1/1:
Jan 12 18:26:21 behemoth kernel: ... APIC ID:      01000000 (1)
Jan 12 18:26:21 behemoth kernel: ... APIC VERSION: 00040011
Jan 12 18:26:21 behemoth kernel: ... APIC TASKPRI: 00000000 (00)
Jan 12 18:26:21 behemoth kernel: ... APIC ARBPRI: 00000000 (00)
Jan 12 18:26:21 behemoth kernel: ... APIC PROCPRI: 00000000
Jan 12 18:26:21 behemoth kernel: ... APIC EOI: 00000000
Jan 12 18:26:21 behemoth kernel: ... APIC LDR: 02000000
Jan 12 18:26:21 behemoth kernel: ... APIC DFR: ffffffff
Jan 12 18:26:21 behemoth kernel: ... APIC SPIV: 000003ff
Jan 12 18:26:21 behemoth kernel: ... APIC ISR field:
Jan 12 18:26:21 behemoth kernel: 0123456789abcdef0123456789abcdef
Jan 12 18:26:21 behemoth kernel: 00000000000000000000000000000000
Jan 12 18:26:21 behemoth last message repeated 7 times
Jan 12 18:26:21 behemoth kernel: ... APIC TMR field:
Jan 12 18:26:21 behemoth kernel: 0123456789abcdef0123456789abcdef
Jan 12 18:26:21 behemoth kernel: 00000000000000000000000000000000
Jan 12 18:26:21 behemoth last message repeated 3 times
Jan 12 18:26:21 behemoth kernel: 00000000010000000000000000000000
Jan 12 18:26:21 behemoth kernel: 00000000000000000000000000000000
Jan 12 18:26:21 behemoth last message repeated 2 times
Jan 12 18:26:21 behemoth kernel: ... APIC IRR field:
Jan 12 18:26:21 behemoth kernel: 0123456789abcdef0123456789abcdef
Jan 12 18:26:21 behemoth kernel: 00000000000000000000000000000000
Jan 12 18:26:21 behemoth last message repeated 7 times
Jan 12 18:26:21 behemoth kernel: ... APIC ESR: 00000000
Jan 12 18:26:21 behemoth kernel: ... APIC ICR: 000008fc
Jan 12 18:26:21 behemoth kernel: ... APIC ICR2: 01000000
Jan 12 18:26:21 behemoth kernel: ... APIC LVTT: 000200ef
Jan 12 18:26:21 behemoth kernel: ... APIC LVTPC: 00010000
Jan 12 18:26:21 behemoth kernel: ... APIC LVT0: 00010700
Jan 12 18:26:21 behemoth kernel: ... APIC LVT1: 00010400
Jan 12 18:26:21 behemoth kernel: ... APIC LVTERR: 000000fe
Jan 12 18:26:21 behemoth kernel: ... APIC TMICT: 0000a322
Jan 12 18:26:21 behemoth kernel: ... APIC TMCCT: 00001803
Jan 12 18:26:21 behemoth kernel: ... APIC TDCR: 00000003
Jan 12 18:26:21 behemoth kernel:
Jan 12 18:26:21 behemoth kernel:
Jan 12 18:26:21 behemoth kernel: printing local APIC contents on CPU#0/0:
Jan 12 18:26:21 behemoth kernel: ... APIC ID:      00000000 (0)
Jan 12 18:26:21 behemoth kernel: ... APIC VERSION: 00040011
Jan 12 18:26:21 behemoth kernel: ... APIC TASKPRI: 00000000 (00)
Jan 12 18:26:21 behemoth kernel: ... APIC ARBPRI: 000000e0 (e0)
Jan 12 18:26:21 behemoth kernel: ... APIC PROCPRI: 00000000
Jan 12 18:26:21 behemoth kernel: ... APIC EOI: 00000000
Jan 12 18:26:21 behemoth kernel: ... APIC LDR: 01000000
Jan 12 18:26:21 behemoth kernel: ... APIC DFR: ffffffff
Jan 12 18:26:21 behemoth kernel: ... APIC SPIV: 000003ff
Jan 12 18:26:21 behemoth kernel: ... APIC ISR field:
Jan 12 18:26:21 behemoth kernel: 0123456789abcdef0123456789abcdef
Jan 12 18:26:21 behemoth kernel: 00000000000000000000000000000000
Jan 12 18:26:21 behemoth last message repeated 7 times
Jan 12 18:26:21 behemoth kernel: ... APIC TMR field:
Jan 12 18:26:21 behemoth kernel: 0123456789abcdef0123456789abcdef
Jan 12 18:26:21 behemoth kernel: 00000000000000000000000000000000
Jan 12 18:26:21 behemoth last message repeated 3 times
Jan 12 18:26:21 behemoth kernel: 00000000010000000000000001000000
Jan 12 18:26:21 behemoth kernel: 00000000000000000000000000000000
Jan 12 18:26:21 behemoth last message repeated 2 times
Jan 12 18:26:21 behemoth kernel: ... APIC IRR field:
Jan 12 18:26:21 behemoth kernel: 0123456789abcdef0123456789abcdef
Jan 12 18:26:21 behemoth kernel: 00000000000000000000000000000000
Jan 12 18:26:21 behemoth last message repeated 6 times
Jan 12 18:26:21 behemoth kernel: 00000000000000010000000000000000
Jan 12 18:26:21 behemoth kernel: ... APIC ESR: 00000000
Jan 12 18:26:21 behemoth kernel: ... APIC ICR: 000c08fb
Jan 12 18:26:21 behemoth kernel: ... APIC ICR2: 02000000
Jan 12 18:26:21 behemoth kernel: ... APIC LVTT: 000200ef
Jan 12 18:26:21 behemoth kernel: ... APIC LVTPC: 00010000
Jan 12 18:26:21 behemoth kernel: ... APIC LVT0: 00010700
Jan 12 18:26:21 behemoth kernel: ... APIC LVT1: 00000400
Jan 12 18:26:21 behemoth kernel: ... APIC LVTERR: 000000fe
Jan 12 18:26:21 behemoth kernel: ... APIC TMICT: 0000a322
Jan 12 18:26:21 behemoth kernel: ... APIC TMCCT: 00004e26
Jan 12 18:26:21 behemoth kernel: ... APIC TDCR: 00000003

-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
