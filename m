Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161122AbVICDvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161122AbVICDvj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 23:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbVICDvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 23:51:39 -0400
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:44280 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751361AbVICDvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 23:51:38 -0400
Message-ID: <43191DBF.10407@bigpond.net.au>
Date: Sat, 03 Sep 2005 13:51:27 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm1: hangs during boot ...
References: <43184B8A.4040801@bigpond.net.au> <20050902131122.4c634211.akpm@osdl.org>
In-Reply-To: <20050902131122.4c634211.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------030401020801060305040600"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 3 Sep 2005 03:51:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030401020801060305040600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Peter Williams <pwil3058@bigpond.net.au> wrote:
> 
>>... at the the point indicated by the following output:
>>
>>[    8.197224] Freeing unused kernel memory: 288k freed
>>[    8.428217] SCSI subsystem initialized
>>[    8.510376] sym0: <810a> rev 0x23 at pci 0000:00:08.0 irq 11
>>[    8.587731] sym0: No NVRAM, ID 7, Fast-10, SE, parity checking
>>[    8.671531] sym0: SCSI BUS has been reset.
>>[    8.725530] scsi0 : sym-2.2.1
>>[   17.256480]  0:0:0:0: ABORT operation started.
>>[   22.323534]  0:0:0:0: ABORT operation timed-out.
>>[   22.384348]  0:0:0:0: DEVICE RESET operation started.
>>[   27.458702]  0:0:0:0: DEVICE RESET operation timed-out.
>>[   27.527544]  0:0:0:0: BUS RESET operation started.
>>[   32.533775]  0:0:0:0: BUS RESET operation timed-out.
>>[   32.599173]  0:0:0:0: HOST RESET operation started.
>>[   32.669659] sym0: SCSI BUS has been reset.
>>
> 
> 
> Is there no response from sysrq-T?

Now that I've tried it there is a response.  I've attached the complete 
output from the boot including the sysrq-T output in the hang.output 
attachment to this e-mail.

> 
> Maybe adding initcall_debug to the boot command line will show extra info?
> 
> The .config would be useful, thanks.

Attached as origma.config.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------030401020801060305040600
Content-Type: text/plain;
 name="hang.output"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hang.output"

root (hd1,0)
 Filesystem type is ext2fs, partition type 0x83
kernel /vmlinuz-2.6.13-mm1 ro root=/dev/hdb2 psmouse.proto=imps  console=ttyS0,
9600,n8 console=tty0 elevator=cfq initcall_debug
   [Linux-bzImage, setup=0x1c00, size=0x160a00]
initrd /initrd-2.6.13-mm1.img
   [Linux-initrd @ 0x17ed0000, 0x10f799 bytes]

[17179569.184000] Linux version 2.6.13-mm1 (peterw@origma.pw.nest) (gcc version5[17179569.184000] BIOS-provided physical RAM map:
[17179569.184000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[17179569.184000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[17179569.184000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[17179569.184000]  BIOS-e820: 0000000000100000 - 0000000017ff0000 (usable)
[17179569.184000]  BIOS-e820: 0000000017ff0000 - 0000000017ff3000 (ACPI NVS)
[17179569.184000]  BIOS-e820: 0000000017ff3000 - 0000000018000000 (ACPI data)
[17179569.184000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[17179569.184000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[17179569.184000]  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
[17179569.184000] 0MB HIGHMEM available.
[17179569.184000] 383MB LOWMEM available.
[17179569.184000] found SMP MP-table at 000f5b50
[17179569.184000] DMI 2.1 present.
[17179569.184000] Using APIC driver default
[17179569.184000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[17179569.184000] Processor #0 6:6 APIC version 17
[17179569.184000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[17179569.184000] Processor #1 6:6 APIC version 17
[17179569.184000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[17179569.184000] IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23[17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
[17179569.184000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 dfl dfl)
[17179569.184000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[17179569.184000] Using ACPI (MADT) for SMP configuration information
[17179569.184000] Allocating PCI resources starting at 18000000 (gap: 18000000:)[17179569.184000] Built 1 zonelists
[17179569.184000] Initializing CPU#0
[17179569.184000] Kernel command line: ro root=/dev/hdb2 psmouse.proto=imps  cog[17179569.184000] PID hash table entries: 2048 (order: 11, 32768 bytes)
[    0.000000] Detected 498.852 MHz processor.
[  138.776886] Using tsc for high-res timesource
[  138.778122] Console: colour VGA+ 80x25
[  141.445574] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[  141.540255] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[  141.691186] Memory: 383616k/393152k available (1890k kernel code, 8920k rese)[  141.828739] Checking if this processor honours the WP bit even in supervisor.[  142.013460] Calibrating delay using timer specific routine.. 999.15 BogoMIPS)[  142.122666] Mount-cache hash table entries: 512
[  142.182861] CPU: L1 I cache: 16K, L1 D cache: 16K
[  142.244915] CPU: L2 cache: 128K
[  142.286285] Intel machine check architecture supported.
[  142.355089] Intel machine check reporting enabled on CPU#0.
[  142.428541] mtrr: v2.0 (20020519)
[  142.472137] Enabling fast FPU save and restore... done.
[  142.541059] Checking 'hlt' instruction... OK.
[  142.623314]     ACPI-0284: *** Error: Region SystemMemory(0) has no handler
[  142.715171]     ACPI-0115: *** Error: acpi_load_tables: Could not load namesT[  142.828766]     ACPI-0123: *** Error: acpi_load_tables: Could not load tableT[  142.938929] ACPI: Unable to load the System Description Tables
[  143.015900] CPU0: Intel Celeron (Mendocino) stepping 05
[  143.084998] Booting processor 1/1 eip 3000
[  143.149099] Initializing CPU#1
[  143.227221] Calibrating delay using timer specific routine.. 997.64 BogoMIPS)[  143.227288] CPU: L1 I cache: 16K, L1 D cache: 16K
[  143.227297] CPU: L2 cache: 128K
[  143.227325] Intel machine check architecture supported.
[  143.227338] Intel machine check reporting enabled on CPU#1.
[  143.227804] CPU1: Intel Celeron (Mendocino) stepping 05
[  143.690995] Total of 2 processors activated (1996.79 BogoMIPS).
[  143.769611] ENABLING IO-APIC IRQs
[  143.813561] ..TIMER: vector=0x31 pin1=2 pin2=-1
[  144.020385] checking TSC synchronization across 2 CPUs: passed.
[    0.010669] softlockup thread 0 started up.
[    0.068607] Brought up 2 CPUs
ss[    0.068664] softlockup thread 1 started up.
[    0.163373] checking if image is initramfs... it is
[    0.569040] Freeing initrd memory: 1085k freed
[    0.629671] NET: Registered protocol family 16
[    0.688432] EISA bus registered
[    0.745478] PCI: PCI BIOS revision 2.10 entry at 0xfb240, last bus=1
[    0.829207] PCI: Using configuration type 1
[    0.884263] mtrr: your CPUs had inconsistent fixed MTRR settings
[    0.963377] mtrr: probably your BIOS does not setup all CPUs.
[    1.039075] mtrr: corrected configuration.
[    1.097471] ACPI: Subsystem revision 20050815
[    1.154896] ACPI: Interpreter disabled.
[    1.205494] Linux Plug and Play Support v0.97 (c) Adam Belay
[    1.280125] pnp: PnP ACPI: disabled
[    1.326684] PCI: Probing PCI hardware
[    1.374887] PCI: Probing PCI hardware (bus 00)
[    1.451408] PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:07.0
[    1.537487] PCI BIOS passed nonexistent PCI bus 0!
[    1.600544] PCI BIOS passed nonexistent PCI bus 0!
[    1.663647] PCI BIOS passed nonexistent PCI bus 0!
[    1.726738] PCI BIOS passed nonexistent PCI bus 0!
[    1.789844] PCI BIOS passed nonexistent PCI bus 1!
[    1.852938] PCI BIOS passed nonexistent PCI bus 0!
[    1.936721] PCI: Bridge: 0000:00:01.0
[    1.985030]   IO window: d000-dfff
[    2.029753]   MEM window: dc000000-dfffffff
[    2.084827]   PREFETCH window: e0000000-e1ffffff
[    2.149142] apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
[    2.232953] apm: disabled - APM is not SMP safe.
[    2.334327] Initializing Cryptographic API
[    2.388404] Limiting direct PCI/PCI transfers.
[    2.447341] isapnp: Scanning for PnP cards...
[    2.859959] isapnp: No Plug & Play device found
[    3.020394] Real Time Clock Driver v1.12
[    3.079761] PNP: No PS/2 controller found. Probing ports directly.
[    3.166585] serio: i8042 AUX port at 0x60,0x64 irq 12
[    3.235810] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.301494] Serial: 8250/16550 driver $Revision$ 4 ports, IRQ sharing disabld[    3.397393] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    3.464166] ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    3.543623] mice: PS/2 mouse device common for all mice
[    3.612687] io scheduler noop registered<6>input: AT Translated Set 2 keyboa0[    3.728581]
[    3.748259] io scheduler anticipatory registered<6>input: ImPS/2 Generic Whe1[    3.870950]
[    3.890556] io scheduler deadline registered
[    3.946837] io scheduler cfq registered (default)
[    4.036081] RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 bloe[    4.150438] loop: loaded (max 8 devices)
[    4.203175] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[    4.286977] ide: Assuming 33MHz system bus speed for PIO modes; override witx[    4.392561] PIIX4: IDE controller at PCI slot 0000:00:07.1
[    4.464822] PIIX4: chipset revision 1
[    4.512992] PIIX4: not 100% native mode: will probe irqs later
[    4.589856]     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DA[    4.685215]     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DA[    5.068008] hda: IBM-DPTA-372050, ATA DISK drive
[    5.408506] hdb: ST320415A, ATA DISK drive
[    5.517066] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    6.727383] hda: max request size: 128KiB
[    6.791052] hda: 40088160 sectors (20525 MB) w/1961KiB Cache, CHS=39770/16/6)[    6.897811] hda: cache flushes not supported
[    6.954666]  hda: hda1 hda2
[    6.998228] hdb: max request size: 128KiB
[    7.051008] hdb: 39102336 sectors (20020 MB) w/1024KiB Cache, CHS=38792/16/6)[    7.156680] hdb: cache flushes not supported
[    7.213435]  hdb: hdb1 hdb2 hdb3
[    7.270323] ide-floppy driver 0.99.newide
[    7.327515] perfctr: driver 2.7.17, cpu type Intel P6 at 498852 kHz
[    7.411885] NET: Registered protocol family 2
[    7.527718] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[    7.620603] TCP established hash table entries: 16384 (order: 5, 131072 byte)[    7.716885] TCP bind hash table entries: 16384 (order: 5, 131072 bytes)
[    7.805113] TCP: Hash tables configured (established 16384 bind 16384)
[    7.891128] TCP reno registered
[    7.932967] TCP bic registered
[    7.973212] TCP westwood registered
[    8.019103] TCP htcp registered
[    8.060536] NET: Registered protocol family 1
[    8.118000] Using IPI No-Shortcut mode
[    8.170339] Freeing unused kernel memory: 288k freed
[    8.424315] SCSI subsystem initialized
[    8.507646] sym0: <810a> rev 0x23 at pci 0000:00:08.0 irq 11
[    8.584862] sym0: No NVRAM, ID 7, Fast-10, SE, parity checking
[    8.668435] sym0: SCSI BUS has been reset.
[    8.722410] scsi0 : sym-2.2.1
[   17.253600]  0:0:0:0: ABORT operation started.
[   22.316948]  0:0:0:0: ABORT operation timed-out.
[   22.377792]  0:0:0:0: DEVICE RESET operation started.
[   27.448416]  0:0:0:0: DEVICE RESET operation timed-out.
[   27.517235]  0:0:0:0: BUS RESET operation started.
[   32.523798]  0:0:0:0: BUS RESET operation timed-out.
[   32.589181]  0:0:0:0: HOST RESET operation started.
[   32.659650] sym0: SCSI BUS has been reset.
[  266.902844] SysRq : Show State
[  266.943018]
[  266.943021]                                                sibling
[  267.043916]   task             PC      pid father child younger older
[  267.128783] init          S D79A3AB0     0     1      0     2               )[  267.229683] d7ebff54 d79a3ab0 00000000 d79a3ab0 d79a3ab0 d50a1afa ffffffbe d
[  267.329330]        00002cfc 00000000 d79a3ab0 c146dbec c146dab0 c130d160 fad
[  267.439290]        d7ebe000 fab0b0f6 00000001 00000246 d7ebff54 c013b55b c14
[  267.549249] Call Trace:
[  267.583614]  [<c012936e>] do_wait+0x27e/0x3c0
[  267.640986]  [<c0129562>] sys_wait4+0x32/0x40
[  267.698257]  [<c0105199>] syscall_call+0x7/0xb
[  267.756776] migration/0   S C146D570     0     2      1             3       )[  267.857676] d7e23fac c146d030 00000001 c146d570 00000000 001624a0 00000000 d
[  267.957326]        00000466 00000000 0a7a3a4d c146d16c c146d030 c1305160 0a7
[  268.067284]        d7e22000 0a72dc80 00000002 c011fd26 00000000 00000000 c13
[  268.177242] Call Trace:
[  268.211606]  [<c0120ffc>] migration_thread+0x12c/0x190
[  268.279185]  [<c013b2a6>] kthread+0xa6/0xb0
[  268.334166]  [<c01034d9>] kernel_thread_helper+0x5/0xc
[  268.401744] ksoftirqd/0   S 00000000     0     3      1             4     2 )[  268.502645] d7e25fa4 c03e4020 0010c614 00000000 d7e24000 0010e2ea 00000000 d
[  268.602292]        00000334 d7e83ab0 c1305160 d7e83bec d7e83ab0 c1305160 fa3
[  268.712253]        d7e24000 fa368f97 00000001 d7e24000 c03de380 00000000 d7e
[  268.822210] Call Trace:
[  268.856573]  [<c012b198>] ksoftirqd+0x88/0x110
[  268.914992]  [<c013b2a6>] kthread+0xa6/0xb0
[  268.969969]  [<c01034d9>] kernel_thread_helper+0x5/0xc
[  269.037548] watchdog/0    S D7E27F24     0     4      1             5     3 )[  269.138450] d7e27f60 ffffffef 00000282 d7e27f24 c012587c 0354ccaf 00000000 d
[  269.238098]        0000014f 16951a70 00000003 d7e836ac d7e83570 c1305160 150
[  269.348058]        d7e26000 15008537 0000003e c012ed56 00000000 00000282 fff
[  269.458015] Call Trace:
[  269.492378]  [<c02d660c>] schedule_timeout+0x4c/0xc0
[  269.557668]  [<c02d6698>] schedule_timeout_interruptible+0x18/0x20
[  269.638992]  [<c012ff23>] msleep_interruptible+0x43/0x60
[  269.708861]  [<c0148162>] watchdog+0x52/0x80
[  269.765090]  [<c013b2a6>] kthread+0xa6/0xb0
[  269.820069]  [<c01034d9>] kernel_thread_helper+0x5/0xc
[  269.887647] migration/1   S 00000000     0     5      1             6     4 )[  269.988548] d7e29fac d7e29f58 c130d160 00000000 c1305160 00101d13 00000000 d
[  270.088198]        0000048a 682785e2 00000006 d7e8316c d7e83030 c130d160 6c0
[  270.198157]        d7e28000 6c0bb910 00000006 00000000 00000001 c130d1a4 c13
[  270.308114] Call Trace:
[  270.342479]  [<c0120ffc>] migration_thread+0x12c/0x190
[  270.410057]  [<c013b2a6>] kthread+0xa6/0xb0
[  270.465038]  [<c01034d9>] kernel_thread_helper+0x5/0xc
[  270.532616] ksoftirqd/1   S D7E2BF5C     0     6      1             7     5 )[  270.633517] d7e2bfa4 c03e4020 00000000 d7e2bf5c c0138091 0027ccd4 00000000 d
[  270.733164]        00000c2c c03e0050 00000001 d7e89bec d7e89ab0 c130d160 f94
[  270.843125]        d7e2a000 f941cbc3 00000001 00000246 c03de380 00000001 d7e
[  270.953083] Call Trace:
[  270.987445]  [<c012b198>] ksoftirqd+0x88/0x110
[  271.045862]  [<c013b2a6>] kthread+0xa6/0xb0
[  271.100843]  [<c01034d9>] kernel_thread_helper+0x5/0xc
[  271.168421] watchdog/1    S D7E2DF6C     0     7      1             8     6 )[  271.269322] d7e2df60 d7e2df14 c01dc8e9 d7e2df6c 00000000 000fece1 00000000 d
[  271.368969]        00000185 9e7b9f9b 00000002 d7e896ac d7e89570 c130d160 194
[  271.478930]        d7e2c000 1941ad68 0000003f c012ed56 00000000 00000282 fff
[  271.588887] Call Trace:
[  271.623250]  [<c02d660c>] schedule_timeout+0x4c/0xc0
[  271.688539]  [<c02d6698>] schedule_timeout_interruptible+0x18/0x20
[  271.769864]  [<c012ff23>] msleep_interruptible+0x43/0x60
[  271.839732]  [<c0148162>] watchdog+0x52/0x80
[  271.895858]  [<c013b2a6>] kthread+0xa6/0xb0
[  271.950837]  [<c01034d9>] kernel_thread_helper+0x5/0xc
[  272.018416] events/0      R running     0     8      1             9     7 ()[  272.118170] events/1      S 00000000     0     9      1            10     8 )[  272.219071] d7f3df58 d7f3df14 c012ed56 00000000 00000282 00b44d2c 00000000 d
[  272.318718]        000018c1 c01367d6 d7e8ef70 d7fdfbec d7fdfab0 c130d160 f62
[  272.428678]        d7f3c000 6dc798ef 0000003f 00000246 d7f3df58 c013b55b 000
[  272.538638] Call Trace:
[  272.573001]  [<c0136a15>] worker_thread+0x215/0x230
[  272.637143]  [<c013b2a6>] kthread+0xa6/0xb0
[  272.692122]  [<c01034d9>] kernel_thread_helper+0x5/0xc
[  272.759703] khelper       S 00000001     0    10      1            11     9 )[  272.860601] d7f39f58 d7f33ae4 d7f33b64 00000001 d7f39f0c 015d08ed 00000000 d
[  272.960253]        000008c0 00000000 00000003 d7fdf6ac d7fdf570 c1305160 0a7
[  273.070211]        d7f38000 0a72dc80 00000002 00000246 d7f39f58 c013b55b d7f
[  273.180169] Call Trace:
[  273.214531]  [<c0136a15>] worker_thread+0x215/0x230
[  273.278675]  [<c013b2a6>] kthread+0xa6/0xb0
[  273.333655]  [<c01034d9>] kernel_thread_helper+0x5/0xc
[  273.401235] kthread       S D7F31F08     0    11      1    14      70    10 )[  273.502133] d7f31f58 d7f33f34 00000001 d7f31f08 c011fb9b 000ffc99 00000000 d
[  273.601784]        000002c1 00000003 d7f33f34 d7fdf16c d7fdf030 c130d160 fad
[  273.711741]        d7f30000 fab0b0f6 00000001 00000246 d7f31f58 c013b55b d7f
[  273.821700] Call Trace:
[  273.856064]  [<c0136a15>] worker_thread+0x215/0x230
[  273.920206]  [<c013b2a6>] kthread+0xa6/0xb0
[  273.975188]  [<c01034d9>] kernel_thread_helper+0x5/0xc
[  274.042765] kblockd/0     S 00000001     0    14     11            15       )[  274.143664] d7dc5f58 c011d271 00000000 00000001 00000001 00029cac 00000000 d
[  274.244146]        0000388f 00000082 d7fcb4c4 d7fcb16c d7fcb030 c1305160 944
[  274.354106]        d7dc4000 94427d3f 00000001 00000246 d7dc5f58 c013b55b d74
[  274.464067] Call Trace:
[  274.498428]  [<c0136a15>] worker_thread+0x215/0x230
[  274.562571]  [<c013b2a6>] kthread+0xa6/0xb0
[  274.617552]  [<c01034d9>] kernel_thread_helper+0x5/0xc
[  274.685132] kblockd/1     S C01DA354     0    15     11            68    14 )[  274.786029] d7dc7f58 c1760800 d7dc7f04 c01da354 d7dc7f0c 00540524 00000000 d
[  274.885678]        00000888 c172def0 d7dc7f38 d7f6cbec d7f6cab0 c130d160 bc1
[  274.995639]        d7dc6000 bc16f008 00000002 00000246 d7dc7f58 c013b55b c17
[  275.105597] Call Trace:
[  275.139960]  [<c0136a15>] worker_thread+0x215/0x230
[  275.204104]  [<c013b2a6>] kthread+0xa6/0xb0
[  275.259082]  [<c01034d9>] kernel_thread_helper+0x5/0xc
[  275.326663] pdflush       S C130D160     0    68     11            69    15 )[  275.427560] c179df8c c011dac6 c16b1ab0 c130d160 00000000 00006508 00000000 c
[  275.527212]        000003ef c16c9ab0 c1305160 c16c9bec c16c9ab0 c1305160 8b0
[  275.637168]        c179c000 8afe0519 00000000 0000419d 00000000 c179c000 c17
[  275.747130] Call Trace:
[  275.781492]  [<c0150b61>] __pdflush+0x81/0x1a0
[  275.840013]  [<c0150c9e>] pdflush+0x1e/0x20
[  275.894991]  [<c013b2a6>] kthread+0xa6/0xb0
[  275.949970]  [<c01034d9>] kernel_thread_helper+0x5/0xc
[  276.017550] pdflush       S FFFFE8E0     0    69     11            71    68 )[  276.118449] c17a1f8c c012ee36 000001f4 ffffe8e0 c17a1f8c 0009fc4a 00000000 c
[  276.218099]        000004b2 c17a1f7c 00000400 c16c96ac c16c9570 c1305160 413
[  276.328058]        c17a0000 413779c2 0000003d 0000006a 00000000 ffffc6b2 c17
[  276.438016] Call Trace:
[  276.472381]  [<c0150b61>] __pdflush+0x81/0x1a0
[  276.530795]  [<c0150c9e>] pdflush+0x1e/0x20
[  276.585774]  [<c013b2a6>] kthread+0xa6/0xb0
[  276.640755]  [<c01034d9>] kernel_thread_helper+0x5/0xc
[  276.708333] aio/0         S 00000001     0    71     11            72    69 )[  276.809234] c17a7f58 c011d271 00000000 00000001 00000001 00005086 00000000 c
[  276.908882]        000004ef d7fdf030 c16d3f44 c16d3bec c16d3ab0 c1305160 8b1
[  277.018840]        c17a6000 8afe0519 00000000 00000246 c17a7f58 c013b55b fff
[  277.128801] Call Trace:
[  277.163165]  [<c0136a15>] worker_thread+0x215/0x230
[  277.227307]  [<c013b2a6>] kthread+0xa6/0xb0
[  277.282288]  [<c01034d9>] kernel_thread_helper+0x5/0xc
[  277.349864] aio/1         S 00000001     0    72     11           143    71 )[  277.450765] c17a9f58 c011d271 00000000 00000001 00000001 0000bf64 00000000 c
[  277.550414]        00001068 d7fdf030 c16d3a04 c16d36ac c16d3570 c130d160 8b1
[  277.660373]        c17a8000 8afda0e9 00000000 00000246 c17a9f58 c013b55b fff
[  277.770333] Call Trace:
[  277.804697]  [<c0136a15>] worker_thread+0x215/0x230
[  277.868840]  [<c013b2a6>] kthread+0xa6/0xb0
[  277.923819]  [<c01034d9>] kernel_thread_helper+0x5/0xc
[  277.991397] kswapd0       S 00000000     0    70      1           227    11 )[  278.092297] c17a3fa8 00000002 c17a3f60 00000000 00000000 0000ade1 00000000 c
[  278.191946]        0000ade1 00000246 c17a3fa8 c16c916c c16c9030 c130d160 8e9
[  278.301905]        c17a2000 8e923db5 00000000 c17a3fa8 c013b674 00000246 000
[  278.411864] Call Trace:
[  278.446226]  [<c0157265>] kswapd+0x115/0x130
[  278.502352]  [<c01034d9>] kernel_thread_helper+0x5/0xc
[  278.569932] kseriod       S C023E62B     0   143     11                  72 )[  278.670832] d7b93f98 c01da354 d7b93f44 c023e62b d7b93f58 00726e45 00000000 d
[  278.770480]        00001651 d7b93f7c c023dc97 d7ac9bec d7ac9ab0 c130d160 e19
[  278.880438]        d7b92000 e16c48bf 00000000 d7b93f98 c013b674 00000246 d7b
[  278.990398] Call Trace:
[  279.024761]  [<c02279ff>] serio_thread+0xbf/0xf0
[  279.085573]  [<c013b2a6>] kthread+0xa6/0xb0
[  279.140552]  [<c01034d9>] kernel_thread_helper+0x5/0xc
[  279.208130] insmod        D C171DCC0     0   227      1           232    70 )[  279.309031] d7f33b04 d7f33ab8 d8836bb0 c171dcc0 00001055 0fbf64f3 00000000 d
[  279.408678]        0000e83b d7f33acc c01da354 d750e6ac d750e570 c130d160 0a9
[  279.518639]        d7f32000 0a72aa15 00000002 00000246 c172de50 c172de50 d7f
[  279.628599] Call Trace:
[  279.662960]  [<c02d5c74>] wait_for_completion+0xa4/0x110
[  279.732934]  [<c0245c16>] blk_execute_rq+0x66/0xb0
[  279.796035]  [<d8836eb6>] scsi_execute+0xb6/0xd0 [scsi_mod]
[  279.869446]  [<d8836f4d>] scsi_execute_req+0x7d/0xb0 [scsi_mod]
[  279.947438]  [<d88393f6>] scsi_probe_lun+0xb6/0x1d0 [scsi_mod]
[  280.024285]  [<d883995e>] scsi_probe_and_add_lun+0xde/0x1e0 [scsi_mod]
[  280.110295]  [<d883a119>] scsi_scan_target+0xc9/0x140 [scsi_mod]
[  280.189431]  [<d883a208>] scsi_scan_channel+0x78/0x90 [scsi_mod]
[  280.268569]  [<d883a2e9>] scsi_scan_host_selected+0xc9/0x120 [scsi_mod]
[  280.355722]  [<d883a362>] scsi_scan_host+0x22/0x30 [scsi_mod]
[  280.431425]  [<d8864e45>] sym2_probe+0xf5/0x120 [sym53c8xx]
[  280.504835]  [<c01e6ced>] pci_call_probe+0xd/0x10
[  280.566791]  [<c01e6d39>] __pci_device_probe+0x49/0x60
[  280.634369]  [<c01e6d79>] pci_device_probe+0x29/0x50
[  280.699657]  [<c023e0ee>] driver_probe_device+0x3e/0xc0
[  280.768486]  [<c023e25f>] __driver_attach+0x5f/0x70
[  280.832628]  [<c023d7d3>] bus_for_each_dev+0x43/0x70
[  280.897916]  [<c023e289>] driver_attach+0x19/0x20
[  280.959770]  [<c023dc5b>] bus_add_driver+0x7b/0xd0
[  281.022767]  [<c023e692>] driver_register+0x42/0x50
[  281.086910]  [<c01e6fd0>] pci_register_driver+0x70/0x90
[  281.155635]  [<d880202b>] sym2_init+0x2b/0x45 [sym53c8xx]
[  281.226752]  [<c014340c>] sys_init_module+0xec/0x230
[  281.292042]  [<c0105199>] syscall_call+0x7/0xb
[  281.350458] scsi_eh_0     D 00000000     0   232      1                 227 )[  281.451357] d7a51ea0 d7a51e64 1e62bb57 00000000 d7a50000 1e62c494 00000000 d
[  281.551005]        00000106 d79b0ab0 c130d160 d79b0bec d79b0ab0 c130d160 9de
[  281.660963]        d7a50000 9de05c44 00000007 d7a50000 d7a51ef4 d7a51ef0 d7a
[  281.770923] Call Trace:
[  281.805288]  [<c02d5c74>] wait_for_completion+0xa4/0x110
[  281.875159]  [<d8863490>] sym_eh_handler+0x240/0x290 [sym53c8xx]
[  281.954293]  [<d88635fd>] sym53c8xx_eh_host_reset_handler+0x2d/0x50 [sym53c8][  282.050611]  [<d8835e9b>] scsi_try_host_reset+0x2b/0xa0 [scsi_mod]
[  282.132041]  [<d883602c>] scsi_eh_host_reset+0x1c/0xa0 [scsi_mod]
[  282.212324]  [<d88363f7>] scsi_eh_ready_devs+0x57/0x70 [scsi_mod]
[  282.292604]  [<d883654f>] scsi_unjam_host+0x9f/0xc0 [scsi_mod]
[  282.369451]  [<d8836629>] scsi_error_handler+0xb9/0xe0 [scsi_mod]
[  282.449734]  [<c01034d9>] kernel_thread_helper+0x5/0xc


--------------030401020801060305040600
Content-Type: text/plain;
 name="origma.config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="origma.config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.13-mm1-PS
# Fri Sep  2 21:22:06 2005
#
CONFIG_X86=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
# CONFIG_IKCONFIG is not set
CONFIG_CPUSETS=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_EXTRA_PASS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Processor type and features
#
# CONFIG_X86_PC is not set
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
CONFIG_X86_GENERICARCH=y
# CONFIG_X86_ES7000 is not set
CONFIG_X86_CYCLONE_TIMER=y
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMII=y
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_SMP=y
CONFIG_NR_CPUS=32
# CONFIG_SCHED_SMT is not set
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_BKL=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_DELL_RBU is not set
CONFIG_DCDBAS=m
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
# CONFIG_SPARSEMEM_STATIC is not set
CONFIG_HIGHPTE=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
# CONFIG_IRQBALANCE is not set
CONFIG_HAVE_DEC_LOCK=y
CONFIG_ATOMIC_TABLE_OPS=y
CONFIG_REGPARM=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_PHYSICAL_START=0x100000
# CONFIG_KEXEC is not set

#
# Performance-monitoring counters support
#
CONFIG_PERFCTR=y
# CONFIG_PERFCTR_INIT_TESTS is not set
CONFIG_PERFCTR_VIRTUAL=y
CONFIG_PERFCTR_INTERRUPT_SUPPORT=y
CONFIG_PERFCTR_CPUS_FORBIDDEN_MASK=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
# CONFIG_SOFTWARE_SUSPEND is not set
CONFIG_SUSPEND_SMP=y

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_HOTKEY=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
CONFIG_ACPI_IBM=m
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_X86_PM_TIMER is not set
CONFIG_ACPI_CONTAINER=y

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_LEGACY_PROC=y
# CONFIG_PCI_DEBUG is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
CONFIG_EISA=y
CONFIG_EISA_PCI_EISA=y
CONFIG_EISA_NAMES=y
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG_CPU=y

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=m

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=m
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=y
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_TCP_CONG_ADVANCED=y

#
# TCP congestion control
#
CONFIG_TCP_CONG_BIC=y
CONFIG_TCP_CONG_WESTWOOD=y
CONFIG_TCP_CONG_HTCP=y
# CONFIG_TCP_CONG_HSTCP is not set
# CONFIG_TCP_CONG_HYBLA is not set
# CONFIG_TCP_CONG_VEGAS is not set
# CONFIG_TCP_CONG_SCALABLE is not set
# CONFIG_IPV6 is not set
# CONFIG_NETFILTER is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_SCHED is not set
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NETFILTER_NETLINK is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_IEEE80211 is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_FW_LOADER is not set
# CONFIG_DEBUG_DRIVER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_ISAPNP=y
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_BLK_DEV_INITRD=y
# CONFIG_LBD is not set
# CONFIG_CDROM_PKTCDVD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=y
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=m
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
# CONFIG_CHR_DEV_SG is not set
CONFIG_CHR_DEV_SCH=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
# CONFIG_SCSI_ISCSI_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=m
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA24XX is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_EXT_ADAPTEC=y
CONFIG_I2O_CONFIG=m
CONFIG_I2O_CONFIG_OLD_IOCTL=y
# CONFIG_I2O_BUS is not set
CONFIG_I2O_BLOCK=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# PHY device support
#
# CONFIG_PHYLIB is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
CONFIG_NATSEMI=m
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
CONFIG_NS83820=m
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_KGDBOE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=m
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
CONFIG_HWMON=y
# CONFIG_HWMON_VID is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Misc devices
#

#
# Multimedia Capabilities Port drivers
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set
CONFIG_VIDEO_SELECT=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_MDA_CONSOLE=m
CONFIG_DUMMY_CONSOLE=y

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
# CONFIG_USB is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# SN Devices
#

#
# Distributed Lock Manager
#
# CONFIG_DLM is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISER4_FS is not set
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y

#
# XFS support
#
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
# CONFIG_FUSE_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
# CONFIG_CONFIGFS_FS is not set
CONFIG_RELAYFS_FS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ASFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V3_ACL is not set
# CONFIG_NFSD_V4 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Profiling support
#
CONFIG_PROFILING=y
# CONFIG_OPROFILE is not set

#
# Kernel hacking
#
CONFIG_PRINTK_TIME=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_SCHEDSTATS=y
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_HIGHMEM=y
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_INFO=y
# CONFIG_PAGE_OWNER is not set
# CONFIG_DEBUG_FS is not set
CONFIG_FRAME_POINTER=y
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_STACKOVERFLOW=y
# CONFIG_KPROBES is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
# CONFIG_KGDB is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES_586 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_DEFLATE=m
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC16 is not set
CONFIG_CRC32=y
# CONFIG_LIBCRC32C is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_PC=y

--------------030401020801060305040600--
