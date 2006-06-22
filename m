Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161032AbWFVKL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161032AbWFVKL1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 06:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbWFVKL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 06:11:27 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:49123 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751775AbWFVKL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 06:11:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:references:x-google-sender-auth;
        b=jyWZgSDOmttKKFTj/mG59VdyYZfVtH4jtwxQ9SkoFqdj+DonL3coSYT6cRkVqzfIZfH9vlFE4hpUE1bBpO1vqd+KQs8MHv/TMEeH96uiqQjBJMxZOZxCcgz1rjZuO5CMYYPzg/THTxCUQD7N5hWmj+29JxYOWGGaTDde3s00HVI=
Message-ID: <986ed62e0606220311h2ac75848o646ad623bfad9505@mail.gmail.com>
Date: Thu, 22 Jun 2006 03:11:23 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: bitmap loading related reiserfs changes in 2.6.17-mm1 are broken
Cc: "Nick Orlov" <bugfixer@list.ru>, linux-kernel@vger.kernel.org,
       "Jeff Mahoney" <jeffm@suse.com>, reiserfs-dev@namesys.com
In-Reply-To: <986ed62e0606212209j501e399ai34644f841b410e3e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2719_3848210.1150971083484"
References: <20060622032733.GA5158@nickolas.homeunix.com>
	 <20060621204303.47facd01.akpm@osdl.org>
	 <986ed62e0606212209j501e399ai34644f841b410e3e@mail.gmail.com>
X-Google-Sender-Auth: 9016f355257eae85
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_2719_3848210.1150971083484
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 6/21/06, Barry K. Nathan <barryn@pobox.com> wrote:
> Unfortunately I still haven't gotten around to adding a serial console
> to this box *and* I do not have access to my digital camera for
> approx. 2 weeks. I guess I'll try to add a serial console ASAP. This
> will probably take me a day or two however.

Never mind, it took a lot less time than that. Here's the backtrace...
-- 
-Barry K. Nathan <barryn@pobox.com>

------=_Part_2719_3848210.1150971083484
Content-Type: text/plain; name=capture2.txt; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Attachment-Id: f_eoqwb56r
Content-Disposition: attachment; filename="capture2.txt"

[    0.000000] Linux version 2.6.17-mm1nolockdep (barryn@nserv) (gcc versio=
n 4.1.1) #1 Thu Jun 22 00:36:48 PDT 2006
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] sanitize start
[    0.000000] sanitize end
[    0.000000] copy_e820_map() start: 0000000000000000 size: 00000000000a00=
00 end: 00000000000a0000 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] add_memory_region(0000000000000000, 00000000000a0000, 1)
[    0.000000] copy_e820_map() start: 00000000000f0000 size: 00000000000100=
00 end: 0000000000100000 type: 2
[    0.000000] add_memory_region(00000000000f0000, 0000000000010000, 2)
[    0.000000] copy_e820_map() start: 0000000000100000 size: 000000000eef00=
00 end: 000000000eff0000 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] add_memory_region(0000000000100000, 000000000eef0000, 1)
[    0.000000] copy_e820_map() start: 000000000eff0000 size: 00000000000030=
00 end: 000000000eff3000 type: 4
[    0.000000] add_memory_region(000000000eff0000, 0000000000003000, 4)
[    0.000000] copy_e820_map() start: 000000000eff3000 size: 000000000000d0=
00 end: 000000000f000000 type: 3
[    0.000000] add_memory_region(000000000eff3000, 000000000000d000, 3)
[    0.000000] copy_e820_map() start: 00000000ffff0000 size: 00000000000100=
00 end: 0000000100000000 type: 2
[    0.000000] add_memory_region(00000000ffff0000, 0000000000010000, 2)
[    0.000000]  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000000eff0000 (usable)
[    0.000000]  BIOS-e820: 000000000eff0000 - 000000000eff3000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000000eff3000 - 000000000f000000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
[    0.000000] 239MB LOWMEM available.
[    0.000000] DMI 2.2 present.
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] Allocating PCI resources starting at 10000000 (gap: 0f000000=
:f0ff0000)
[    0.000000] Detected 1399.443 MHz processor.
[   70.909638] Built 1 zonelists.  Total pages: 61424
[   70.909643] Kernel command line: BOOT_IMAGE=3Dbzimage lapic root=3D/dev/=
sda1 vga=3D6 console=3DttyS0,57600 console=3Dtty0
[   70.910024] Local APIC disabled by BIOS -- reenabling.
[   70.910029] Found and enabled local APIC!
[   70.910038] Enabling fast FPU save and restore... done.
[   70.910041] Enabling unmasked SIMD FPU exception support... done.
[   70.910047] Initializing CPU#0
[   70.910114] CPU 0 irqstacks, hard=3Dc03be000 soft=3Dc03bd000
[   70.910120] PID hash table entries: 1024 (order: 10, 4096 bytes)
[   70.912324] Console: colour VGA+ 80x60
[   71.389932] Dentry cache hash table entries: 32768 (order: 5, 131072 byt=
es)
[   71.404154] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes=
)
[   71.434455] Memory: 239984k/245696k available (1454k kernel code, 5160k =
reserved, 833k data, 156k init, 0k highmem)
[   71.455362] Checking if this processor honours the WP bit even in superv=
isor mode... Ok.
[   71.619372] Calibrating delay using timer specific routine.. 2800.22 Bog=
oMIPS (lpj=3D14001119)
[   71.636399] Mount-cache hash table entries: 512
[   71.645671] CPU: L1 I cache: 16K, L1 D cache: 16K
[   71.655163] CPU: L2 cache: 512K
[   71.661498] Intel machine check architecture supported.
[   71.671980] Intel machine check reporting enabled on CPU#0.
[   71.683149] Compat vDSO mapped to ffffe000.
[   71.691551] CPU: Intel(R) Pentium(R) III CPU family      1400MHz steppin=
g 01
[   71.705767] Checking 'hlt' instruction... OK.
[   71.750212] SMP alternatives: switching to UP code
[   71.759819] Freeing SMP alternatives: 0k freed
[   71.768730] ACPI: Core revision 20060608
[   71.782088] ACPI: setting ELCR to 0200 (from 1aa0)
[   71.981497] NET: Registered protocol family 16
[   71.990555] ACPI: bus type pci registered
[   72.001402] PCI: PCI BIOS revision 2.10 entry at 0xfb0c0, last bus=3D1
[   72.014133] Setting up standard PCI resources
[   72.033190] ACPI: Interpreter enabled
[   72.040558] ACPI: Using PIC for interrupt routing
[   72.050745] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   72.069104] PCI quirk: region 0400-047f claimed by vt8235 PM
[   72.080471] PCI quirk: region 0500-050f claimed by vt8235 SMB
[   72.133255] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 =
14 15)
[   72.149049] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 *12 =
14 15)
[   72.164810] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 10 11 12 =
14 15)
[   72.180582] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 *7 10 11 12 =
14 15)
[   72.199156] Linux Plug and Play Support v0.97 (c) Adam Belay
[   72.210512] pnp: PnP ACPI init
[   72.221041] pnp: PnP ACPI: found 11 devices
[   72.229662] SCSI subsystem initialized
[   72.237245] PCI: Using ACPI for IRQ routing
[   72.245661] PCI: If a device doesn't work, try "pci=3Drouteirq".  If it =
helps, post a report
[   72.311990] pnp: 00:02: ioport range 0x400-0x47f could not be reserved
[   72.325076] pnp: 00:02: ioport range 0x500-0x50f has been reserved
[   72.337833] PCI: Bridge: 0000:00:01.0
[   72.345189]   IO window: disabled.
[   72.352073]   MEM window: e4000000-e5ffffff
[   72.360505]   PREFETCH window: e0000000-e3ffffff
[   72.370031] NET: Registered protocol family 2
[   72.478540] IP route cache hash table entries: 2048 (order: 1, 8192 byte=
s)
[   72.492456] TCP established hash table entries: 8192 (order: 3, 32768 by=
tes)
[   72.506634] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
[   72.519571] TCP: Hash tables configured (established 8192 bind 4096)
[   72.532299] TCP reno registered
[   72.539661] Initializing Cryptographic API
[   72.547891] io scheduler noop registered
[   72.555832] io scheduler cfq registered (default)
[   72.565728] ACPI: Power Button (FF) [PWRF]
[   72.573965] ACPI: Power Button (CM) [PWRB]
[   72.585364] Linux agpgart interface v0.101 (c) Dave Jones
[   72.596315] agpgart: Detected VIA CLE266 chipset
[   72.607045] agpgart: AGP aperture is 4M @ 0xe7000000
[   72.617162] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sha=
ring disabled
[   72.633066] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[   72.645512] Floppy drive(s): fd0 is 1.44M, fd1 is 1.44M
[   72.670162] FDC 0 is a post-1991 82077
[   72.679948] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
[   72.691474] ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKA] -> GSI 11=
 (level, low) -> IRQ 11
[   72.709030] sata_sil 0000:00:08.0: Applying R_ERR on DMA activate FIS er=
rata fix
[   72.723965] ata1: SATA max UDMA/100 cmd 0xCF804080 ctl 0xCF80408A bmdma =
0xCF804000 irq 11
[   72.740392] ata2: SATA max UDMA/100 cmd 0xCF8040C0 ctl 0xCF8040CA bmdma =
0xCF804008 irq 11
[   72.756827] ata3: SATA max UDMA/100 cmd 0xCF804280 ctl 0xCF80428A bmdma =
0xCF804200 irq 11
[   72.773263] ata4: SATA max UDMA/100 cmd 0xCF8042C0 ctl 0xCF8042CA bmdma =
0xCF804208 irq 11
[   72.789666] scsi0 : sata_sil
[   73.277654] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   73.290920] ata1.00: ATA-7, max UDMA/133, 585940320 sectors: LBA48=20
[   73.303477] ata1.00: applying bridge limits
[   73.312878] ata1.00: configured for UDMA/100
[   73.321453] scsi1 : sata_sil
[   73.807094] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   73.820677] ata2.00: ATA-7, max UDMA/100, 781422768 sectors: LBA48=20
[   73.833240] ata2.00: applying bridge limits
[   73.842975] ata2.00: configured for UDMA/100
[   73.851561] scsi2 : sata_sil
[   74.346527] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   74.359798] ata3.00: ATA-6, max UDMA/100, 625142448 sectors: LBA48=20
[   74.372350] ata3.00: applying bridge limits
[   74.381753] ata3.00: configured for UDMA/100
[   74.390326] scsi3 : sata_sil
[   74.716118] ata4: SATA link down (SStatus 0 SControl 310)
[   74.727111]   Vendor: ATA       Model: Maxtor 4A300J0    Rev: RAMB
[   74.741105]   Type:   Direct-Access                      ANSI SCSI revis=
ion: 05
[   74.756053]   Vendor: ATA       Model: ST3400832A        Rev: 3.01
[   74.770033]   Type:   Direct-Access                      ANSI SCSI revis=
ion: 05
[   74.784952]   Vendor: ATA       Model: WDC WD3200JB-00K  Rev: 08.0
[   74.798927]   Type:   Direct-Access                      ANSI SCSI revis=
ion: 05
[   74.814010] ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI 11=
 (level, low) -> IRQ 11
[   74.831559] PCI: VIA IRQ fixup for 0000:00:11.1, from 255 to 11
[   74.843537] ata5: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xE400 irq=
 14
[   74.857501] scsi4 : pata_via
[   75.016563] ata5.00: ATA-7, max UDMA/133, 490234752 sectors: LBA48=20
[   75.030066] ata5.00: configured for UDMA/133
[   75.038732]   Vendor: ATA       Model: Maxtor 6Y250P0    Rev: YAR4
[   75.052702]   Type:   Direct-Access                      ANSI SCSI revis=
ion: 05
[   75.067593] ata6: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xE408 irq=
 15
[   75.081548] scsi5 : pata_via
[   75.246438] ata6.00: ATA-6, max UDMA/100, 625142448 sectors: LBA48=20
[   75.260036] ata6.00: configured for UDMA/100
[   75.268710]   Vendor: ATA       Model: WDC WD3200JB-00K  Rev: 08.0
[   75.282674]   Type:   Direct-Access                      ANSI SCSI revis=
ion: 05
[   75.297678] SCSI device sda: 585940320 512-byte hdwr sectors (300001 MB)
[   75.311128] sda: Write Protect is off
[   75.318516] SCSI device sda: drive cache: write back
[   75.328545] SCSI device sda: 585940320 512-byte hdwr sectors (300001 MB)
[   75.341991] sda: Write Protect is off
[   75.349380] SCSI device sda: drive cache: write back
[   75.359340]  sda: sda1
[   75.367974] sd 0:0:0:0: Attached scsi disk sda
[   75.376982] SCSI device sdb: 781422768 512-byte hdwr sectors (400088 MB)
[   75.390413] sdb: Write Protect is off
[   75.397805] SCSI device sdb: drive cache: write back
[   75.407812] SCSI device sdb: 781422768 512-byte hdwr sectors (400088 MB)
[   75.421246] sdb: Write Protect is off
[   75.428635] SCSI device sdb: drive cache: write back
[   75.438594]  sdb: unknown partition table
[   75.464089] sd 1:0:0:0: Attached scsi disk sdb
[   75.473084] SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
[   75.486529] sdc: Write Protect is off
[   75.493910] SCSI device sdc: drive cache: write back
[   75.503925] SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
[   75.517360] sdc: Write Protect is off
[   75.524744] SCSI device sdc: drive cache: write back
[   75.534712]  sdc: sdc1 sdc2
[   75.561786] sd 2:0:0:0: Attached scsi disk sdc
[   75.570779] SCSI device sdd: 490234752 512-byte hdwr sectors (251000 MB)
[   75.584220] sdd: Write Protect is off
[   75.591614] SCSI device sdd: drive cache: write back
[   75.601616] SCSI device sdd: 490234752 512-byte hdwr sectors (251000 MB)
[   75.615108] sdd: Write Protect is off
[   75.622496] SCSI device sdd: drive cache: write back
[   75.632453]  sdd: unknown partition table
[   75.658873] sd 4:0:0:0: Attached scsi disk sdd
[   75.667861] SCSI device sde: 625142448 512-byte hdwr sectors (320073 MB)
[   75.681304] sde: Write Protect is off
[   75.688698] SCSI device sde: drive cache: write back
[   75.698713] SCSI device sde: 625142448 512-byte hdwr sectors (320073 MB)
[   75.712156] sde: Write Protect is off
[   75.719546] SCSI device sde: drive cache: write back
[   75.729504]  sde: unknown partition table
[   75.755625] sd 5:0:0:0: Attached scsi disk sde
[   75.764637] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[   75.777027] PNP: PS/2 controller doesn't have AUX irq; using default 12
[   75.790438] serio: i8042 AUX port at 0x60,0x64 irq 12
[   75.800581] serio: i8042 KBD port at 0x60,0x64 irq 1
[   75.810774] mice: PS/2 mouse device common for all mice
[   75.821331] NET: Registered protocol family 1
[   75.830101] Testing NMI watchdog ... OK.
[   75.938071] Using IPI Shortcut mode
[   75.945152] ACPI: (supports S0 S1 S3 S4 S5)
[   75.954083] Freeing unused kernel memory: 156k freed
[   75.964047] Time: tsc clocksource has been installed.
[   75.974213] Write protecting the kernel read-only data: 298k
[   75.992335] ReiserFS: sda1: found reiserfs format "3.6" with standard jo=
urnal
[   76.006670] ReiserFS: sda1: using ordered data mode
[   76.018727] ReiserFS: sda1: journal params: device sda1, size 8192, jour=
nal first block 18, max trans len 1024, max batch 900, max commit age 30, m=
ax trans age 30
[   76.050463] ReiserFS: sda1: checking transaction log (sda1)
[   76.109979] input: AT Translated Set 2 keyboard as /class/input/input0
[   76.162999] ReiserFS: sda1: Using r5 hash to sort names
[   99.661389] ------------[ cut here ]------------
[   99.670669] kernel BUG at fs/reiserfs/bitmap.c:1307!
[   99.680622] invalid opcode: 0000 [#1]
[   99.687980] 4K_STACKS=20
[   99.692793] last sysfs file: /block/sda/sda1/dev
[   99.702055] Modules linked in:
[   99.708239] CPU:    0
[   99.708241] EIP:    0060:[<c017ab78>]    Not tainted VLI
[   99.708243] EFLAGS: 00010202   (2.6.17-mm1nolockdep #1)=20
[   99.734127] EIP is at reiserfs_cache_bitmap_metadata+0x78/0x85
[   99.745819] eax: 00000001   ebx: 00000000   ecx: c02ca4f4   edx: 0000000=
1
[   99.759409] esi: cee10d24   edi: 00000000   ebp: ce808d70   esp: ce808d6=
4
[   99.773000] ds: 007b   es: 007b   ss: 0068
[   99.781222] Process mount (pid: 338, ti=3Dce808000 task=3Dcef9d560 task.=
ti=3Dce808000)
[   99.795677] Stack: cee10d24 cef6ea00 00000001 ce808d88 c017ac76 cf812000=
 cf812004 cef6ea00=20
[   99.814530]        ceecf1c4 ce808d9c c017b211 00008180 fffffff4 ceecf210=
 ce808e84 c0185172=20
[   99.831737]        ceecf210 ce808ea8 c017f465 cef6ea00 00c1ceff 00000001=
 00000000 00000000=20
[   99.848912] Call Trace:
[   99.854631]  [<c017ac76>] reiserfs_read_bitmap_block+0xf1/0xfb
[   99.866663]  [<c017b211>] reiserfs_choose_packing+0x4d/0x7c
[   99.878177]  [<c0185172>] reiserfs_new_inode+0x90/0x609
[   99.889023]  [<c017ff3a>] reiserfs_create+0x71/0x12b
[   99.899334]  [<c01564ea>] vfs_create+0x67/0xad
[   99.908539]  [<c0158d86>] open_namei+0x181/0x636
[   99.918083]  [<c0149608>] do_filp_open+0x1f/0x35
[   99.927598]  [<c0149676>] do_sys_open+0x58/0xe3
[   99.936931]  [<c014972d>] sys_open+0x16/0x18
[   99.945741]  [<c026adf7>] syscall_call+0x7/0xb
[   99.954713] Code: 66 89 41 02 4b 83 fb ff 75 e2 8b 46 14 83 ea 04 39 c2 =
73 af 31 d2 b8 f4 a4 2c c0 66 83 39 00 0f 94 c2 e8 b4 62 03 00 85 c0 74 08 =
<0f> 0b 1b 05 f8 60 28 c0 5b 5e 5f 5d c3 55 89 e5 57 89 d7 56 89=20
[   99.995769] EIP: [<c017ab78>] reiserfs_cache_bitmap_metadata+0x78/0x85 S=
S:ESP 0068:ce808d64
[  100.012596]  BUG: warning at kernel/exit.c:855/do_exit()
[  100.023494]  [<c0103079>] show_trace_log_lvl+0x54/0xfd
[  100.033885]  [<c010363d>] show_trace+0xd/0x10
[  100.042708]  [<c01036da>] dump_stack+0x19/0x1b
[  100.051694]  [<c01178a8>] do_exit+0x5f/0x8ab
[  100.060409]  [<c0103566>] die+0x218/0x220
[  100.068533]  [<c01035ea>] do_trap+0x7c/0x96
[  100.076997]  [<c0103cbb>] do_invalid_op+0x89/0x93
[  100.086501]  [<c0102c9d>] error_code+0x39/0x40















------=_Part_2719_3848210.1150971083484--
