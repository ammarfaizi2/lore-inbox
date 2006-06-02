Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWFBLQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWFBLQu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 07:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWFBLQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 07:16:50 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:48815 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750719AbWFBLQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 07:16:50 -0400
Date: Fri, 2 Jun 2006 13:17:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm2
Message-ID: <20060602111704.GA22841@elte.hu>
References: <20060601014806.e86b3cc0.akpm@osdl.org> <20060602120952.615cea39@localhost> <20060602111053.GA22306@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060602111053.GA22306@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> yeah, it's supposed to work.
> 
> > I've tried enabling something minimal (full config attached):
> 
> please send me the real full config you used for the build - this one 
> has only the =y entries. (from which it's hard to reproduce your 
> original config)

when running it through 'make oldconfig' and grepping for =y it didnt 
match your original config, but the resulting kernel was just as broken 
as yours, so it's good enough for now ;-) Below is the crashlog over 
serial.

	Ingo

[    0.000000] Linux version 2.6.17-rc5-mm2-lockdep (mingo@mercury) (gcc version 4.0.2) #24 Fri Jun 2 13:11:52 CEST 2006
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
[    0.000000]  BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f76f0
[    0.000000] ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fff3040
[    0.000000] ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fff30c0
[    0.000000] ACPI: SRAT (v001 AMD    HAMMER   0x00000001 AMD  0x00000001) @ 0x000000003fff9500
[    0.000000] ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fff9600
[    0.000000] ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fff9440
[    0.000000] ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
[    0.000000] On node 0 totalpages: 256402
[    0.000000]   DMA zone: 1897 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 254505 pages, LIFO batch:31
[    0.000000] Nvidia board detected. Ignoring ACPI timer override.
[    0.000000] ACPI: PM-Timer IO Port: 0x4008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:3 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1 15:3 APIC version 16
[    0.000000] WARNING: NR_CPUS limit of 1 reached. Processor ignored.
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: BIOS IRQ0 pin2 override ignored.
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ14 used by override.
[    0.000000] ACPI: IRQ15 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
[    0.000000] Built 1 zonelists
[    0.000000] Kernel command line: root=/dev/hda5 earlyprintk=serial,ttyS0,115200 console=ttyS0,115200 console=tty 3 nmi_watchdog=0 profile=0 debug initcall_debug apic=debug notsc idle=poll maxcpus=2
[    0.000000] kernel profiling enabled (shift: 0)
[    0.000000] using polling idle threads.
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[   12.131188] Disabling vsyscall due to use of PM timer
[   12.136064] time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
[   12.141784] time.c: Detected 2160.234 MHz processor.
[   12.146728] disabling early console
[   12.152478] Console: colour VGA+ 80x25
[   12.510248] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[   12.518020] ... MAX_LOCKDEP_SUBTYPES:    8
[   12.522144] ... MAX_LOCK_DEPTH:          30
[   12.526356] ... MAX_LOCKDEP_KEYS:        2048
[   12.530740] ... TYPEHASH_SIZE:           1024
[   12.535126] ... MAX_LOCKDEP_ENTRIES:     8192
[   12.539511] ... MAX_LOCKDEP_CHAINS:      8192
[   12.543896] ... CHAINHASH_SIZE:          4096
[   12.548281]  memory used by lock dependency info: 1120 kB
[   12.553706]  per task-struct memory footprint: 1440 bytes
[   12.559132] ------------------------
[   12.562736] | Locking API testsuite:
[   12.566341] ----------------------------------------------------------------------------
[   12.574453]                                  | spin |wlock |rlock |mutex | wsem | rsem |
[   12.582565]   --------------------------------------------------------------------------
[   12.590680]                      A-A deadlock:  ok  |failed|failed|FAILED|failed|failed|
[   12.599300]                  A-B-B-A deadlock:  ok  |failed|  ok  |FAILED|failed|failed|
[   12.607905]              A-B-B-C-C-A deadlock:  ok  |failed|  ok  |FAILED|failed|failed|
[   12.616511]              A-B-C-A-B-C deadlock:  ok  |failed|  ok  |FAILED|failed|failed|
[   12.625124]          A-B-B-C-C-D-D-A deadlock:  ok  |failed|  ok  |FAILED|failed|failed|
[   12.633722]          A-B-C-D-B-D-D-A deadlock:  ok  |failed|  ok  |FAILED|failed|failed|
[   12.642344]          A-B-C-D-B-C-D-A deadlock:  ok  |failed|  ok  |FAILED|failed|failed|
[   12.650950]                     double unlock:  ok  |failed|failed|  ok  |failed|failed|
[   12.659547]                  bad unlock order:  ok  |failed|failed|FAILED|failed|failed|
[   12.668151]   --------------------------------------------------------------------------
[   12.676262]               recursive read-lock:             |  ok  |             |failed|
[   12.684644]   --------------------------------------------------------------------------
[   12.692755]                 non-nested unlock:  ok  |  ok  |  ok  |  ok  |
[   12.699991]   ------------------------------------------------------------
[   12.706889]      hard-irqs-on + irq-safe-A/12:  ok  |failed|  ok  |
[   12.713433]      soft-irqs-on + irq-safe-A/12:  ok  |failed|  ok  |
[   12.719984]      hard-irqs-on + irq-safe-A/21:  ok  |failed|  ok  |
[   12.726536]      soft-irqs-on + irq-safe-A/21:  ok  |failed|  ok  |
[   12.733094]        sirq-safe-A => hirqs-on/12:  ok  |failed|  ok  |
[   12.739639]        sirq-safe-A => hirqs-on/21:  ok  |failed|  ok  |
[   12.746198]          hard-safe-A + irqs-on/12:  ok  |failed|  ok  |
[   12.752742]          soft-safe-A + irqs-on/12:  ok  |failed|  ok  |
[   12.759303]          hard-safe-A + irqs-on/21:  ok  |failed|  ok  |
[   12.768218]          soft-safe-A + irqs-on/21:  ok  |failed|  ok  |
[   12.774763]     hard-safe-A + unsafe-B #1/123:  ok  |failed|  ok  |
[   12.781323]     soft-safe-A + unsafe-B #1/123:  ok  |failed|  ok  |
[   12.787883]     hard-safe-A + unsafe-B #1/132:  ok  |failed|  ok  |
[   12.794434]     soft-safe-A + unsafe-B #1/132:  ok  |failed|  ok  |
[   12.800986]     hard-safe-A + unsafe-B #1/213:  ok  |failed|  ok  |
[   12.807538]     soft-safe-A + unsafe-B #1/213:  ok  |failed|  ok  |
[   12.814106]     hard-safe-A + unsafe-B #1/231:  ok  |failed|  ok  |
[   12.820650]     soft-safe-A + unsafe-B #1/231:  ok  |failed|  ok  |
[   12.827208]     hard-safe-A + unsafe-B #1/312:  ok  |failed|  ok  |
[   12.833753]     soft-safe-A + unsafe-B #1/312:  ok  |failed|  ok  |
[   12.840305]     hard-safe-A + unsafe-B #1/321:  ok  |failed|  ok  |
[   12.846856]     soft-safe-A + unsafe-B #1/321:  ok  |failed|  ok  |
[   12.853407]     hard-safe-A + unsafe-B #2/123:  ok  |failed|  ok  |
[   12.859968]     soft-safe-A + unsafe-B #2/123:  ok  |failed|  ok  |
[   12.866528]     hard-safe-A + unsafe-B #2/132:  ok  |failed|  ok  |
[   12.873087]     soft-safe-A + unsafe-B #2/132:  ok  |failed|  ok  |
[   12.879632]     hard-safe-A + unsafe-B #2/213:  ok  |failed|  ok  |
[   12.886199]     soft-safe-A + unsafe-B #2/213:  ok  |failed|  ok  |
[   12.892744]     hard-safe-A + unsafe-B #2/231:  ok  |failed|  ok  |
[   12.899303]     soft-safe-A + unsafe-B #2/231:  ok  |failed|  ok  |
[   12.905855]     hard-safe-A + unsafe-B #2/312:  ok  |failed|  ok  |
[   12.912416]     soft-safe-A + unsafe-B #2/312:  ok  |failed|  ok  |
[   12.918976]     hard-safe-A + unsafe-B #2/321:  ok  |failed|  ok  |
[   12.925535]     soft-safe-A + unsafe-B #2/321:  ok  |failed|  ok  |
[   12.932095]       hard-irq lock-inversion/123:FAILED|failed|  ok  |
[   12.938639]       soft-irq lock-inversion/123:FAILED|failed|  ok  |
[   12.945198]       hard-irq lock-inversion/132:FAILED|failed|  ok  |
[   12.951742]       soft-irq lock-inversion/132:FAILED|failed|  ok  |
[   12.958293]       hard-irq lock-inversion/213:FAILED|failed|  ok  |
[   12.964845]       soft-irq lock-inversion/213:FAILED|failed|  ok  |
[   12.971397]       hard-irq lock-inversion/231:FAILED|failed|  ok  |
[   12.977949]       soft-irq lock-inversion/231:FAILED|failed|  ok  |
[   12.984500]       hard-irq lock-inversion/312:FAILED|failed|  ok  |
[   12.991059]       soft-irq lock-inversion/312:FAILED|failed|  ok  |
[   12.997603]       hard-irq lock-inversion/321:FAILED|failed|  ok  |
[   13.004162]       soft-irq lock-inversion/321:FAILED|failed|  ok  |
[   13.010706]       hard-irq read-recursion/123:  ok  |
[   13.015889]       soft-irq read-recursion/123:  ok  |
[   13.021079]       hard-irq read-recursion/132:  ok  |
[   13.026262]       soft-irq read-recursion/132:  ok  |
[   13.031454]       hard-irq read-recursion/213:  ok  |
[   13.036644]       soft-irq read-recursion/213:  ok  |
[   13.041827]       hard-irq read-recursion/231:  ok  |
[   13.047016]       soft-irq read-recursion/231:  ok  |
[   13.052200]       hard-irq read-recursion/312:  ok  |
[   13.057391]       soft-irq read-recursion/312:  ok  |
[   13.062581]       hard-irq read-recursion/321:  ok  |
[   13.067773]       soft-irq read-recursion/321:  ok  |
[   13.072955] -----------------------------------------------------------------
[   13.080113] BUG:  20 unexpected failures (out of 210) - debugging disabled! |
[   13.087270] -----------------------------------------------------------------
[   13.095120] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   13.103207] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
[   13.110249] Checking aperture...
[   13.113503] CPU 0: aperture @ 230000000 size 32 MB
[   13.118320] Aperture too small (32 MB)
[   13.127043] No AGP bridge found
[   13.140057] Memory: 1012872k/1048512k available (2660k kernel code, 34912k reserved, 1481k data, 208k init)
[   13.149832] kmem_cache_create: couldn't create cache size-512.
[   13.155690] Kernel panic - not syncing: kmem_cache_create(): failed to create slab `size-512'
[   13.155692] 
[   13.165750]
