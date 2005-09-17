Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbVIQKGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbVIQKGh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 06:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbVIQKGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 06:06:37 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:51616 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S1751023AbVIQKGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 06:06:36 -0400
Message-ID: <432BE7F7.90508@linuxtv.org>
Date: Sat, 17 Sep 2005 13:55:03 +0400
From: Manu Abraham <manu@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: free free irq and Oops on cat /proc/interrupts
Content-Type: multipart/mixed;
 boundary="------------020706000500010000090805"
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020706000500010000090805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Can somebody give me a pointer as to what i am possibly doing wrong.

The module loads fine.. Attached dmesg and stat [1]
The module unloads fine.. But i get a "free free IRQ" on free_irq().. 
Attached dmesg [2]
I do a cat /proc/interrupts [5].. I get an Oops.. Attached dmesg [3] & [4]
I am trying to build it on a 2.6.13 kernel.


Thanks,
Manu



[1] dmesg_module_load.txt
[2] dmesg_module_unload.txt
[3] dmesg_after_cat_int.txt
[4] stat_after_unloading.txt
[5] interrupts_after_unloading.txt

--------------020706000500010000090805
Content-Type: text/plain;
 name="dmesg_after_cat_int.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_after_cat_int.txt"

[42949372.960000] Linux version 2.6.13 (root@deploy.auh.itecno.com) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #4 SMP Sun Sep 11 21:54:16 GST 2005
[42949372.960000] BIOS-provided physical RAM map:
[42949372.960000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[42949372.960000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[42949372.960000]  BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
[42949372.960000]  BIOS-e820: 0000000000100000 - 000000003ff30000 (usable)
[42949372.960000]  BIOS-e820: 000000003ff30000 - 000000003ff40000 (ACPI data)
[42949372.960000]  BIOS-e820: 000000003ff40000 - 000000003fff0000 (ACPI NVS)
[42949372.960000]  BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
[42949372.960000]  BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
[42949372.960000] Warning only 896MB will be used.
[42949372.960000] Use a HIGHMEM enabled kernel.
[42949372.960000] 896MB LOWMEM available.
[42949372.960000] found SMP MP-table at 000ff780
[42949372.960000] On node 0 totalpages: 229376
[42949372.960000]   DMA zone: 4096 pages, LIFO batch:1
[42949372.960000]   Normal zone: 225280 pages, LIFO batch:31
[42949372.960000]   HighMem zone: 0 pages, LIFO batch:1
[42949372.960000] DMI 2.3 present.
[42949372.960000] Intel MultiProcessor Specification v1.4
[42949372.960000]     Virtual Wire compatibility mode.
[42949372.960000] OEM ID: ASUSTek  Product ID:  APIC at: 0xFEE00000
[42949372.960000] Processor #0 15:2 APIC version 20
[42949372.960000] I/O APIC #2 Version 32 at 0xFEC00000.
[42949372.960000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[42949372.960000] Processors: 1
[42949372.960000] Allocating PCI resources starting at 40000000 (gap: 40000000:bfb80000)
[42949372.960000] Built 1 zonelists
[42949372.960000] Kernel command line: ro root=LABEL=/ rhgb quiet vga=795 
[42949372.960000] mapped APIC to ffffd000 (fee00000)
[42949372.960000] mapped IOAPIC to ffffc000 (fec00000)
[42949372.960000] Initializing CPU#0
[42949372.960000] CPU 0 irqstacks, hard=c046e000 soft=c0466000
[42949372.960000] PID hash table entries: 4096 (order: 12, 65536 bytes)
[    0.000000] Detected 2606.014 MHz processor.
[   21.122663] Using tsc for high-res timesource
[   21.122682] Console: colour dummy device 80x25
[   21.123068] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   21.123715] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   21.137497] Memory: 904792k/917504k available (2343k kernel code, 12132k reserved, 892k data, 216k init, 0k highmem)
[   21.137502] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   21.280029] Calibrating delay using timer specific routine.. 5217.61 BogoMIPS (lpj=26088070)
[   21.280068] Mount-cache hash table entries: 512
[   21.280147] CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
[   21.280156] CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
[   21.280166] CPU: Trace cache: 12K uops, L1 D cache: 8K
[   21.280169] CPU: L2 cache: 512K
[   21.280171] CPU: Physical Processor ID: 0
[   21.280173] CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
[   21.280181] Intel machine check architecture supported.
[   21.280186] Intel machine check reporting enabled on CPU#0.
[   21.280189] CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
[   21.280193] CPU0: Thermal monitoring enabled
[   21.280199] mtrr: v2.0 (20020519)
[   21.280205] Enabling fast FPU save and restore... done.
[   21.280208] Enabling unmasked SIMD FPU exception support... done.
[   21.280213] Checking 'hlt' instruction... OK.
[   21.320027] CPU0: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
[   21.320057] Total of 1 processors activated (5217.61 BogoMIPS).
[   21.320134] ENABLING IO-APIC IRQs
[   21.320304] ..TIMER: vector=0x31 pin1=2 pin2=0
[   21.539431] Brought up 1 CPUs
[   21.539530] checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
[   21.585558] Freeing initrd memory: 120k freed
[   21.585813] NET: Registered protocol family 16
[   21.585899] PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
[   21.585906] PCI: Using configuration type 1
[   21.586308] Linux Plug and Play Support v0.97 (c) Adam Belay
[   21.586457] SCSI subsystem initialized
[   21.586465] PCI: Probing PCI hardware
[   21.586468] PCI: Probing PCI hardware (bus 00)
[   21.586734] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[   21.586911] Boot video device is 0000:01:00.0
[   21.587205] PCI: Transparent bridge - 0000:00:1e.0
[   21.587637] PCI: Using IRQ router PIIX/ICH [8086/24d0] at 0000:00:1f.0
[   21.587652] PCI->APIC IRQ transform: 0000:00:1f.1[A] -> IRQ 18
[   21.587656] PCI->APIC IRQ transform: 0000:00:1f.3[B] -> IRQ 17
[   21.587660] PCI->APIC IRQ transform: 0000:00:1f.5[B] -> IRQ 17
[   21.587663] PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 16
[   21.587666] PCI->APIC IRQ transform: 0000:02:0a.0[A] -> IRQ 22
[   21.587670] PCI->APIC IRQ transform: 0000:02:0b.0[A] -> IRQ 23
[   21.587673] PCI->APIC IRQ transform: 0000:02:0c.0[A] -> IRQ 20
[   21.587677] PCI->APIC IRQ transform: 0000:02:0c.1[A] -> IRQ 20
[   21.590446] PCI: Bridge: 0000:00:01.0
[   21.590448]   IO window: disabled.
[   21.590454]   MEM window: fc900000-fe9fffff
[   21.590457]   PREFETCH window: dfe00000-efdfffff
[   21.590463] PCI: Bridge: 0000:00:1e.0
[   21.590466]   IO window: d000-dfff
[   21.590471]   MEM window: fea00000-feafffff
[   21.590475]   PREFETCH window: efe00000-efefffff
[   21.590492] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   21.590826] Machine check exception polling timer started.
[   21.591695] audit: initializing netlink socket (disabled)
[   21.591704] audit(1126964863.810:1): initialized
[   21.591858] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   21.591965] Initializing Cryptographic API
[   21.592095] vesafb: framebuffer at 0xe0000000, mapped to 0xf8800000, using 10240k, total 131072k
[   21.592099] vesafb: mode is 1280x1024x32, linelength=5120, pages=0
[   21.592102] vesafb: protected mode interface info at c000:e2b0
[   21.592104] vesafb: scrolling: redraw
[   21.592106] vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[   21.651647] Console: switching to colour frame buffer device 160x64
[   21.651653] fb0: VESA VGA frame buffer device
[   21.667376] PNP: No PS/2 controller found. Probing ports directly.
[   21.668907] serio: i8042 AUX port at 0x60,0x64 irq 12
[   21.669147] serio: i8042 KBD port at 0x60,0x64 irq 1
[   21.669152] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[   21.669321] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   21.669428] ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   21.669640] io scheduler noop registered
[   21.669658] io scheduler anticipatory registered
[   21.669665] io scheduler deadline registered
[   21.669676] io scheduler cfq registered
[   24.681816] floppy0: no floppy controllers found
[   24.682265] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[   24.682482] loop: loaded (max 8 devices)
[   24.682534] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   24.682538] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   24.682667] mice: PS/2 mouse device common for all mice
[   24.682692] Advanced Linux Sound Architecture Driver Version 1.0.9b (Thu Jul 28 12:20:13 2005 UTC).
[   24.683300] ALSA device list:
[   24.683303]   No soundcards found.
[   24.683305] oprofile: using NMI interrupt.
[   24.683328] NET: Registered protocol family 2
[   24.707628] input: AT Translated Set 2 keyboard on isa0060/serio0
[   24.781619] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[   24.781781] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[   24.782312] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[   24.782621] TCP: Hash tables configured (established 131072 bind 65536)
[   24.782625] TCP reno registered
[   24.782655] ip_conntrack version 2.1 (7168 buckets, 57344 max) - 212 bytes per conntrack
[   24.966983] input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
[   25.021020] ip_tables: (C) 2000-2002 Netfilter core team
[   25.439981] ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
[   25.440001] arp_tables: (C) 2002 David S. Miller
[   25.529771] TCP bic registered
[   25.529782] NET: Registered protocol family 1
[   25.529788] NET: Registered protocol family 17
[   25.529820] Using IPI Shortcut mode
[   25.529925] RAMDISK: Compressed image found at block 0
[   25.583902] VFS: Mounted root (ext2 filesystem).
[   25.586177] ICH5: IDE controller at PCI slot 0000:00:1f.1
[   25.586186] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
[   25.586198] ICH5: chipset revision 2
[   25.586200] ICH5: not 100% native mode: will probe irqs later
[   25.586210]     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
[   25.586223]     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
[   25.586232] Probing IDE interface ide0...
[   25.889028] hda: ST380011A, ATA DISK drive
[   26.607476] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   26.607530] hda: max request size: 1024KiB
[   26.607900] hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(33)
[   26.608047] hda: cache flushes supported
[   26.608095]  hda: hda1 hda2 < hda5 hda6 hda7 hda8 >
[   26.652935] Probing IDE interface ide1...
[   27.330220] kjournald starting.  Commit interval 5 seconds
[   27.330231] EXT3-fs: mounted filesystem with ordered data mode.
[   27.419816] Freeing unused kernel memory: 216k freed
[   31.594223] EXT3 FS on hda6, internal journal
[   31.675990] Adding 1004020k swap on /dev/hda5.  Priority:-1 extents:1
[   32.947466] kjournald starting.  Commit interval 5 seconds
[   32.947711] EXT3 FS on hda8, internal journal
[   32.947716] EXT3-fs: mounted filesystem with ordered data mode.
[   32.963236] kjournald starting.  Commit interval 5 seconds
[   32.963413] EXT3 FS on hda1, internal journal
[   32.963417] EXT3-fs: mounted filesystem with ordered data mode.
[   32.985402] kjournald starting.  Commit interval 5 seconds
[   32.985635] EXT3 FS on hda7, internal journal
[   32.985639] EXT3-fs: mounted filesystem with ordered data mode.
[   37.606831] 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
[   37.606838] 0000:02:0a.0: 3Com PCI 3c905C Tornado at 0xdc00. Vers LK1.1.19
[  201.166406] mantis_pci_probe: Got a device
[  201.166571] mantis_pci_probe: We got an IRQ
[  247.768601] Trying to free free IRQ23
[  292.418769] Unable to handle kernel paging request at virtual address f92bd3f2
[  292.419046]  printing eip:
[  292.419146] c02086fe
[  292.419227] *pde = 37ecf067
[  292.419331] *pte = 00000000
[  292.419434] Oops: 0000 [#1]
[  292.419537] SMP 
[  292.419614] Modules linked in: i2c_core mb86a15 dvb_core 3c59x piix sd_mod
[  292.419929] CPU:    0
[  292.419930] EIP:    0060:[<c02086fe>]    Not tainted VLI
[  292.419931] EFLAGS: 00010097   (2.6.13) 
[  292.420348] EIP is at vsnprintf+0x35e/0x4f0
[  292.420500] eax: f92bd3f2   ebx: 0000000a   ecx: f92bd3f2   edx: fffffffe
[  292.420743] esi: f6d32122   edi: 00000000   ebp: f6d32fff   esp: f4ddbec0
[  292.420986] ds: 007b   es: 007b   ss: 0068
[  292.421137] Process cat (pid: 2340, threadinfo=f4ddb000 task=f6d6d520)
[  292.421372] Stack: f4ddbf04 f6d32fff 00000000 00000000 0000000a 0000000a 00000000 00000000 
[  292.421752]        ffffffff ffffffff f759b500 f6a98580 00000017 f759b500 c01801d7 f6d32120 
[  292.422128]        00000ee0 c0369c81 f4ddbf20 00000008 c0105a4c f759b500 c0369c7e f92bd3f2 
[  292.422504] Call Trace:
[  292.422603]  [<c01801d7>] seq_printf+0x37/0x60
[  292.429982]  [<c0105a4c>] show_interrupts+0x2bc/0x3b0
[  292.437591]  [<c017fcd6>] seq_read+0x1d6/0x2d0
[  292.444976]  [<c015e186>] vfs_read+0xb6/0x180
[  292.452577]  [<c015e531>] sys_read+0x51/0x80
[  292.459958]  [<c0102f5f>] sysenter_past_esp+0x54/0x75
[  292.467638] Code: 00 83 cf 01 89 44 24 24 eb bb 8b 44 24 48 8b 54 24 20 83 44 24 48 04 8b 08 b8 3c 95 36 c0 81 f9 ff 0f 00 00 0f 46 c8 89 c8 eb 06 <80> 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83 e7 10 89 c3 75 20 
[  292.484921]  

--------------020706000500010000090805
Content-Type: text/plain;
 name="dmesg_module_load.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_module_load.txt"

[42949372.960000] Linux version 2.6.13 (root@deploy.auh.itecno.com) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #4 SMP Sun Sep 11 21:54:16 GST 2005
[42949372.960000] BIOS-provided physical RAM map:
[42949372.960000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[42949372.960000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[42949372.960000]  BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
[42949372.960000]  BIOS-e820: 0000000000100000 - 000000003ff30000 (usable)
[42949372.960000]  BIOS-e820: 000000003ff30000 - 000000003ff40000 (ACPI data)
[42949372.960000]  BIOS-e820: 000000003ff40000 - 000000003fff0000 (ACPI NVS)
[42949372.960000]  BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
[42949372.960000]  BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
[42949372.960000] Warning only 896MB will be used.
[42949372.960000] Use a HIGHMEM enabled kernel.
[42949372.960000] 896MB LOWMEM available.
[42949372.960000] found SMP MP-table at 000ff780
[42949372.960000] On node 0 totalpages: 229376
[42949372.960000]   DMA zone: 4096 pages, LIFO batch:1
[42949372.960000]   Normal zone: 225280 pages, LIFO batch:31
[42949372.960000]   HighMem zone: 0 pages, LIFO batch:1
[42949372.960000] DMI 2.3 present.
[42949372.960000] Intel MultiProcessor Specification v1.4
[42949372.960000]     Virtual Wire compatibility mode.
[42949372.960000] OEM ID: ASUSTek  Product ID:  APIC at: 0xFEE00000
[42949372.960000] Processor #0 15:2 APIC version 20
[42949372.960000] I/O APIC #2 Version 32 at 0xFEC00000.
[42949372.960000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[42949372.960000] Processors: 1
[42949372.960000] Allocating PCI resources starting at 40000000 (gap: 40000000:bfb80000)
[42949372.960000] Built 1 zonelists
[42949372.960000] Kernel command line: ro root=LABEL=/ rhgb quiet vga=795 
[42949372.960000] mapped APIC to ffffd000 (fee00000)
[42949372.960000] mapped IOAPIC to ffffc000 (fec00000)
[42949372.960000] Initializing CPU#0
[42949372.960000] CPU 0 irqstacks, hard=c046e000 soft=c0466000
[42949372.960000] PID hash table entries: 4096 (order: 12, 65536 bytes)
[    0.000000] Detected 2606.014 MHz processor.
[   21.122663] Using tsc for high-res timesource
[   21.122682] Console: colour dummy device 80x25
[   21.123068] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   21.123715] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   21.137497] Memory: 904792k/917504k available (2343k kernel code, 12132k reserved, 892k data, 216k init, 0k highmem)
[   21.137502] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   21.280029] Calibrating delay using timer specific routine.. 5217.61 BogoMIPS (lpj=26088070)
[   21.280068] Mount-cache hash table entries: 512
[   21.280147] CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
[   21.280156] CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
[   21.280166] CPU: Trace cache: 12K uops, L1 D cache: 8K
[   21.280169] CPU: L2 cache: 512K
[   21.280171] CPU: Physical Processor ID: 0
[   21.280173] CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
[   21.280181] Intel machine check architecture supported.
[   21.280186] Intel machine check reporting enabled on CPU#0.
[   21.280189] CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
[   21.280193] CPU0: Thermal monitoring enabled
[   21.280199] mtrr: v2.0 (20020519)
[   21.280205] Enabling fast FPU save and restore... done.
[   21.280208] Enabling unmasked SIMD FPU exception support... done.
[   21.280213] Checking 'hlt' instruction... OK.
[   21.320027] CPU0: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
[   21.320057] Total of 1 processors activated (5217.61 BogoMIPS).
[   21.320134] ENABLING IO-APIC IRQs
[   21.320304] ..TIMER: vector=0x31 pin1=2 pin2=0
[   21.539431] Brought up 1 CPUs
[   21.539530] checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
[   21.585558] Freeing initrd memory: 120k freed
[   21.585813] NET: Registered protocol family 16
[   21.585899] PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
[   21.585906] PCI: Using configuration type 1
[   21.586308] Linux Plug and Play Support v0.97 (c) Adam Belay
[   21.586457] SCSI subsystem initialized
[   21.586465] PCI: Probing PCI hardware
[   21.586468] PCI: Probing PCI hardware (bus 00)
[   21.586734] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[   21.586911] Boot video device is 0000:01:00.0
[   21.587205] PCI: Transparent bridge - 0000:00:1e.0
[   21.587637] PCI: Using IRQ router PIIX/ICH [8086/24d0] at 0000:00:1f.0
[   21.587652] PCI->APIC IRQ transform: 0000:00:1f.1[A] -> IRQ 18
[   21.587656] PCI->APIC IRQ transform: 0000:00:1f.3[B] -> IRQ 17
[   21.587660] PCI->APIC IRQ transform: 0000:00:1f.5[B] -> IRQ 17
[   21.587663] PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 16
[   21.587666] PCI->APIC IRQ transform: 0000:02:0a.0[A] -> IRQ 22
[   21.587670] PCI->APIC IRQ transform: 0000:02:0b.0[A] -> IRQ 23
[   21.587673] PCI->APIC IRQ transform: 0000:02:0c.0[A] -> IRQ 20
[   21.587677] PCI->APIC IRQ transform: 0000:02:0c.1[A] -> IRQ 20
[   21.590446] PCI: Bridge: 0000:00:01.0
[   21.590448]   IO window: disabled.
[   21.590454]   MEM window: fc900000-fe9fffff
[   21.590457]   PREFETCH window: dfe00000-efdfffff
[   21.590463] PCI: Bridge: 0000:00:1e.0
[   21.590466]   IO window: d000-dfff
[   21.590471]   MEM window: fea00000-feafffff
[   21.590475]   PREFETCH window: efe00000-efefffff
[   21.590492] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   21.590826] Machine check exception polling timer started.
[   21.591695] audit: initializing netlink socket (disabled)
[   21.591704] audit(1126964863.810:1): initialized
[   21.591858] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   21.591965] Initializing Cryptographic API
[   21.592095] vesafb: framebuffer at 0xe0000000, mapped to 0xf8800000, using 10240k, total 131072k
[   21.592099] vesafb: mode is 1280x1024x32, linelength=5120, pages=0
[   21.592102] vesafb: protected mode interface info at c000:e2b0
[   21.592104] vesafb: scrolling: redraw
[   21.592106] vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[   21.651647] Console: switching to colour frame buffer device 160x64
[   21.651653] fb0: VESA VGA frame buffer device
[   21.667376] PNP: No PS/2 controller found. Probing ports directly.
[   21.668907] serio: i8042 AUX port at 0x60,0x64 irq 12
[   21.669147] serio: i8042 KBD port at 0x60,0x64 irq 1
[   21.669152] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[   21.669321] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   21.669428] ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   21.669640] io scheduler noop registered
[   21.669658] io scheduler anticipatory registered
[   21.669665] io scheduler deadline registered
[   21.669676] io scheduler cfq registered
[   24.681816] floppy0: no floppy controllers found
[   24.682265] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[   24.682482] loop: loaded (max 8 devices)
[   24.682534] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   24.682538] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   24.682667] mice: PS/2 mouse device common for all mice
[   24.682692] Advanced Linux Sound Architecture Driver Version 1.0.9b (Thu Jul 28 12:20:13 2005 UTC).
[   24.683300] ALSA device list:
[   24.683303]   No soundcards found.
[   24.683305] oprofile: using NMI interrupt.
[   24.683328] NET: Registered protocol family 2
[   24.707628] input: AT Translated Set 2 keyboard on isa0060/serio0
[   24.781619] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[   24.781781] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[   24.782312] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[   24.782621] TCP: Hash tables configured (established 131072 bind 65536)
[   24.782625] TCP reno registered
[   24.782655] ip_conntrack version 2.1 (7168 buckets, 57344 max) - 212 bytes per conntrack
[   24.966983] input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
[   25.021020] ip_tables: (C) 2000-2002 Netfilter core team
[   25.439981] ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
[   25.440001] arp_tables: (C) 2002 David S. Miller
[   25.529771] TCP bic registered
[   25.529782] NET: Registered protocol family 1
[   25.529788] NET: Registered protocol family 17
[   25.529820] Using IPI Shortcut mode
[   25.529925] RAMDISK: Compressed image found at block 0
[   25.583902] VFS: Mounted root (ext2 filesystem).
[   25.586177] ICH5: IDE controller at PCI slot 0000:00:1f.1
[   25.586186] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
[   25.586198] ICH5: chipset revision 2
[   25.586200] ICH5: not 100% native mode: will probe irqs later
[   25.586210]     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
[   25.586223]     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
[   25.586232] Probing IDE interface ide0...
[   25.889028] hda: ST380011A, ATA DISK drive
[   26.607476] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   26.607530] hda: max request size: 1024KiB
[   26.607900] hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(33)
[   26.608047] hda: cache flushes supported
[   26.608095]  hda: hda1 hda2 < hda5 hda6 hda7 hda8 >
[   26.652935] Probing IDE interface ide1...
[   27.330220] kjournald starting.  Commit interval 5 seconds
[   27.330231] EXT3-fs: mounted filesystem with ordered data mode.
[   27.419816] Freeing unused kernel memory: 216k freed
[   31.594223] EXT3 FS on hda6, internal journal
[   31.675990] Adding 1004020k swap on /dev/hda5.  Priority:-1 extents:1
[   32.947466] kjournald starting.  Commit interval 5 seconds
[   32.947711] EXT3 FS on hda8, internal journal
[   32.947716] EXT3-fs: mounted filesystem with ordered data mode.
[   32.963236] kjournald starting.  Commit interval 5 seconds
[   32.963413] EXT3 FS on hda1, internal journal
[   32.963417] EXT3-fs: mounted filesystem with ordered data mode.
[   32.985402] kjournald starting.  Commit interval 5 seconds
[   32.985635] EXT3 FS on hda7, internal journal
[   32.985639] EXT3-fs: mounted filesystem with ordered data mode.
[   37.606831] 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
[   37.606838] 0000:02:0a.0: 3Com PCI 3c905C Tornado at 0xdc00. Vers LK1.1.19
[  201.166406] mantis_pci_probe: Got a device
[  201.166571] mantis_pci_probe: We got an IRQ

--------------020706000500010000090805
Content-Type: text/plain;
 name="dmesg_module_unload.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg_module_unload.txt"

[42949372.960000] Linux version 2.6.13 (root@deploy.auh.itecno.com) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #4 SMP Sun Sep 11 21:54:16 GST 2005
[42949372.960000] BIOS-provided physical RAM map:
[42949372.960000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[42949372.960000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[42949372.960000]  BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
[42949372.960000]  BIOS-e820: 0000000000100000 - 000000003ff30000 (usable)
[42949372.960000]  BIOS-e820: 000000003ff30000 - 000000003ff40000 (ACPI data)
[42949372.960000]  BIOS-e820: 000000003ff40000 - 000000003fff0000 (ACPI NVS)
[42949372.960000]  BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
[42949372.960000]  BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
[42949372.960000] Warning only 896MB will be used.
[42949372.960000] Use a HIGHMEM enabled kernel.
[42949372.960000] 896MB LOWMEM available.
[42949372.960000] found SMP MP-table at 000ff780
[42949372.960000] On node 0 totalpages: 229376
[42949372.960000]   DMA zone: 4096 pages, LIFO batch:1
[42949372.960000]   Normal zone: 225280 pages, LIFO batch:31
[42949372.960000]   HighMem zone: 0 pages, LIFO batch:1
[42949372.960000] DMI 2.3 present.
[42949372.960000] Intel MultiProcessor Specification v1.4
[42949372.960000]     Virtual Wire compatibility mode.
[42949372.960000] OEM ID: ASUSTek  Product ID:  APIC at: 0xFEE00000
[42949372.960000] Processor #0 15:2 APIC version 20
[42949372.960000] I/O APIC #2 Version 32 at 0xFEC00000.
[42949372.960000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[42949372.960000] Processors: 1
[42949372.960000] Allocating PCI resources starting at 40000000 (gap: 40000000:bfb80000)
[42949372.960000] Built 1 zonelists
[42949372.960000] Kernel command line: ro root=LABEL=/ rhgb quiet vga=795 
[42949372.960000] mapped APIC to ffffd000 (fee00000)
[42949372.960000] mapped IOAPIC to ffffc000 (fec00000)
[42949372.960000] Initializing CPU#0
[42949372.960000] CPU 0 irqstacks, hard=c046e000 soft=c0466000
[42949372.960000] PID hash table entries: 4096 (order: 12, 65536 bytes)
[    0.000000] Detected 2606.014 MHz processor.
[   21.122663] Using tsc for high-res timesource
[   21.122682] Console: colour dummy device 80x25
[   21.123068] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   21.123715] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   21.137497] Memory: 904792k/917504k available (2343k kernel code, 12132k reserved, 892k data, 216k init, 0k highmem)
[   21.137502] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   21.280029] Calibrating delay using timer specific routine.. 5217.61 BogoMIPS (lpj=26088070)
[   21.280068] Mount-cache hash table entries: 512
[   21.280147] CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
[   21.280156] CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
[   21.280166] CPU: Trace cache: 12K uops, L1 D cache: 8K
[   21.280169] CPU: L2 cache: 512K
[   21.280171] CPU: Physical Processor ID: 0
[   21.280173] CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
[   21.280181] Intel machine check architecture supported.
[   21.280186] Intel machine check reporting enabled on CPU#0.
[   21.280189] CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
[   21.280193] CPU0: Thermal monitoring enabled
[   21.280199] mtrr: v2.0 (20020519)
[   21.280205] Enabling fast FPU save and restore... done.
[   21.280208] Enabling unmasked SIMD FPU exception support... done.
[   21.280213] Checking 'hlt' instruction... OK.
[   21.320027] CPU0: Intel(R) Pentium(R) 4 CPU 2.60GHz stepping 09
[   21.320057] Total of 1 processors activated (5217.61 BogoMIPS).
[   21.320134] ENABLING IO-APIC IRQs
[   21.320304] ..TIMER: vector=0x31 pin1=2 pin2=0
[   21.539431] Brought up 1 CPUs
[   21.539530] checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
[   21.585558] Freeing initrd memory: 120k freed
[   21.585813] NET: Registered protocol family 16
[   21.585899] PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=2
[   21.585906] PCI: Using configuration type 1
[   21.586308] Linux Plug and Play Support v0.97 (c) Adam Belay
[   21.586457] SCSI subsystem initialized
[   21.586465] PCI: Probing PCI hardware
[   21.586468] PCI: Probing PCI hardware (bus 00)
[   21.586734] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[   21.586911] Boot video device is 0000:01:00.0
[   21.587205] PCI: Transparent bridge - 0000:00:1e.0
[   21.587637] PCI: Using IRQ router PIIX/ICH [8086/24d0] at 0000:00:1f.0
[   21.587652] PCI->APIC IRQ transform: 0000:00:1f.1[A] -> IRQ 18
[   21.587656] PCI->APIC IRQ transform: 0000:00:1f.3[B] -> IRQ 17
[   21.587660] PCI->APIC IRQ transform: 0000:00:1f.5[B] -> IRQ 17
[   21.587663] PCI->APIC IRQ transform: 0000:01:00.0[A] -> IRQ 16
[   21.587666] PCI->APIC IRQ transform: 0000:02:0a.0[A] -> IRQ 22
[   21.587670] PCI->APIC IRQ transform: 0000:02:0b.0[A] -> IRQ 23
[   21.587673] PCI->APIC IRQ transform: 0000:02:0c.0[A] -> IRQ 20
[   21.587677] PCI->APIC IRQ transform: 0000:02:0c.1[A] -> IRQ 20
[   21.590446] PCI: Bridge: 0000:00:01.0
[   21.590448]   IO window: disabled.
[   21.590454]   MEM window: fc900000-fe9fffff
[   21.590457]   PREFETCH window: dfe00000-efdfffff
[   21.590463] PCI: Bridge: 0000:00:1e.0
[   21.590466]   IO window: d000-dfff
[   21.590471]   MEM window: fea00000-feafffff
[   21.590475]   PREFETCH window: efe00000-efefffff
[   21.590492] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   21.590826] Machine check exception polling timer started.
[   21.591695] audit: initializing netlink socket (disabled)
[   21.591704] audit(1126964863.810:1): initialized
[   21.591858] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   21.591965] Initializing Cryptographic API
[   21.592095] vesafb: framebuffer at 0xe0000000, mapped to 0xf8800000, using 10240k, total 131072k
[   21.592099] vesafb: mode is 1280x1024x32, linelength=5120, pages=0
[   21.592102] vesafb: protected mode interface info at c000:e2b0
[   21.592104] vesafb: scrolling: redraw
[   21.592106] vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[   21.651647] Console: switching to colour frame buffer device 160x64
[   21.651653] fb0: VESA VGA frame buffer device
[   21.667376] PNP: No PS/2 controller found. Probing ports directly.
[   21.668907] serio: i8042 AUX port at 0x60,0x64 irq 12
[   21.669147] serio: i8042 KBD port at 0x60,0x64 irq 1
[   21.669152] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[   21.669321] ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   21.669428] ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   21.669640] io scheduler noop registered
[   21.669658] io scheduler anticipatory registered
[   21.669665] io scheduler deadline registered
[   21.669676] io scheduler cfq registered
[   24.681816] floppy0: no floppy controllers found
[   24.682265] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[   24.682482] loop: loaded (max 8 devices)
[   24.682534] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   24.682538] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   24.682667] mice: PS/2 mouse device common for all mice
[   24.682692] Advanced Linux Sound Architecture Driver Version 1.0.9b (Thu Jul 28 12:20:13 2005 UTC).
[   24.683300] ALSA device list:
[   24.683303]   No soundcards found.
[   24.683305] oprofile: using NMI interrupt.
[   24.683328] NET: Registered protocol family 2
[   24.707628] input: AT Translated Set 2 keyboard on isa0060/serio0
[   24.781619] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[   24.781781] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[   24.782312] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[   24.782621] TCP: Hash tables configured (established 131072 bind 65536)
[   24.782625] TCP reno registered
[   24.782655] ip_conntrack version 2.1 (7168 buckets, 57344 max) - 212 bytes per conntrack
[   24.966983] input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
[   25.021020] ip_tables: (C) 2000-2002 Netfilter core team
[   25.439981] ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
[   25.440001] arp_tables: (C) 2002 David S. Miller
[   25.529771] TCP bic registered
[   25.529782] NET: Registered protocol family 1
[   25.529788] NET: Registered protocol family 17
[   25.529820] Using IPI Shortcut mode
[   25.529925] RAMDISK: Compressed image found at block 0
[   25.583902] VFS: Mounted root (ext2 filesystem).
[   25.586177] ICH5: IDE controller at PCI slot 0000:00:1f.1
[   25.586186] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
[   25.586198] ICH5: chipset revision 2
[   25.586200] ICH5: not 100% native mode: will probe irqs later
[   25.586210]     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
[   25.586223]     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
[   25.586232] Probing IDE interface ide0...
[   25.889028] hda: ST380011A, ATA DISK drive
[   26.607476] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   26.607530] hda: max request size: 1024KiB
[   26.607900] hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(33)
[   26.608047] hda: cache flushes supported
[   26.608095]  hda: hda1 hda2 < hda5 hda6 hda7 hda8 >
[   26.652935] Probing IDE interface ide1...
[   27.330220] kjournald starting.  Commit interval 5 seconds
[   27.330231] EXT3-fs: mounted filesystem with ordered data mode.
[   27.419816] Freeing unused kernel memory: 216k freed
[   31.594223] EXT3 FS on hda6, internal journal
[   31.675990] Adding 1004020k swap on /dev/hda5.  Priority:-1 extents:1
[   32.947466] kjournald starting.  Commit interval 5 seconds
[   32.947711] EXT3 FS on hda8, internal journal
[   32.947716] EXT3-fs: mounted filesystem with ordered data mode.
[   32.963236] kjournald starting.  Commit interval 5 seconds
[   32.963413] EXT3 FS on hda1, internal journal
[   32.963417] EXT3-fs: mounted filesystem with ordered data mode.
[   32.985402] kjournald starting.  Commit interval 5 seconds
[   32.985635] EXT3 FS on hda7, internal journal
[   32.985639] EXT3-fs: mounted filesystem with ordered data mode.
[   37.606831] 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
[   37.606838] 0000:02:0a.0: 3Com PCI 3c905C Tornado at 0xdc00. Vers LK1.1.19
[  201.166406] mantis_pci_probe: Got a device
[  201.166571] mantis_pci_probe: We got an IRQ
[  247.768601] Trying to free free IRQ23

--------------020706000500010000090805
Content-Type: text/plain;
 name="interrupts_after_unloading.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="interrupts_after_unloading.txt"


--------------020706000500010000090805
Content-Type: text/plain;
 name="interrupts_before_loading.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="interrupts_before_loading.txt"

           CPU0       
  0:      10970    IO-APIC-edge  timer
  1:        195    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
 12:        110    IO-APIC-edge  i8042
 14:       2192    IO-APIC-edge  ide0
 22:        216   IO-APIC-level  eth0
NMI:          0 
LOC:      10938 
ERR:          0
MIS:          0

--------------020706000500010000090805
Content-Type: text/plain;
 name="mantis_common.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mantis_common.h"

#ifndef _MANTIS_COMMON_H_
#define _MANTIS_COMMON_H_

#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/kernel.h>
#include <linux/pci.h>

#include "dvbdev.h"
#include "dvb_demux.h"
#include "dmxdev.h"
#include "dvb_frontend.h"
#include <linux/i2c.h>
#include "mantis_reg.h"

#define MANTIS_ERROR		0
#define MANTIS_NOTICE		1
#define MANTIS_INFO		2
#define MANTIS_DEBUG		3

#define dprintk(x, y, z, format, arg...) do {						\
	if (z) {									\
		if	((x > MANTIS_ERROR) && (x > y))					\
			printk(KERN_ERR "%s: " format "\n" , __FUNCTION__ , ##arg);	\
		else if	((x > MANTIS_NOTICE) && (x > y))				\
			printk(KERN_NOTICE "%s: " format "\n" , __FUNCTION__ , ##arg);	\
		else if ((x > MANTIS_INFO) && (x > y))					\
			printk(KERN_INFO "%s: " format "\n" , __FUNCTION__ , ##arg);	\
		else if ((x > MANTIS_DEBUG) && (x > y))					\
			printk(KERN_DEBUG "%s: " format "\n" , __FUNCTION__ , ##arg);	\
	} else {									\
		if (x > y)								\
			printk(format , ##arg);						\
	}										\
} while(0)

#define mwrite(dat, addr)	writel((dat), addr)
#define mread(addr)		readl(addr)

#define mmwrite(dat, addr)	mwrite((dat), (mantis->mantis_mmio + (addr)))
#define mmread(addr)		mread(mantis->mantis_mmio + (addr))
#define mmand(dat, addr)	mmwrite((dat) & mmread(addr), addr)
#define mmor(dat, addr)		mmwrite((dat) | mmread(addr), addr)
#define mmaor(dat, addr)	mmwrite((dat) | ((mask) & mmread(addr)), addr)

struct mantis_config {
	__u8  eeprom_address;
	__u8  tuner_address;
};

struct mantis_pci {
	/*	PCI stuff	*/
	__u16 id;
	__u16 vendor_id;
	__u16 device_id;
	__u16 sub_vendor_id;
	__u16 sub_device_id;
	__u8  latency;
	
	/*	Linux PCI	*/	
	struct pci_dev *pdev;

	unsigned long mantis_addr;
	volatile __u8 __iomem *mantis_mmio;
//	__u8  bus;
	__u8  devfn;
	__u8  irq;
	__u8  revision;
	
	__u16 mantis_card_num;

	/*	RISC Core	*/
	__u32 block_count;
	__u32 block_bytes;
	__u32 line_bytes;
	__u32 line_count;
	
	__u32 risc_pos;
	 
	__u32 buf_size;
	__u8  *buf_cpu;
	dma_addr_t buf_dma;
	
	__u32 risc_size;
	__u32 *risc_cpu;
	dma_addr_t risc_dma;
	
	struct	i2c_adapter adapter;
	int	i2c_rc;

	struct  dvb_adapter dvb_adapter;
	struct  dvb_frontend *fe;
	struct  dvb_demux demux;
	struct  dmxdev dmxdev;

	struct  mantis_config *config;
};

extern unsigned int verbose;
extern int mantis_dvb_init(struct mantis_pci *mantis);
extern int mantis_frontend_init(struct mantis_pci *mantis);
extern int mantis_dvb_exit(struct mantis_pci *mantis);


#endif

--------------020706000500010000090805
Content-Type: text/plain;
 name="mantis_pci.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mantis_pci.c"

#include <asm/io.h>
#include <asm/pgtable.h>
#include <asm/page.h>
#include <linux/kmod.h>
#include <linux/vmalloc.h>
#include <linux/init.h>
#include <linux/device.h>
#include "mantis_common.h"
#include "mantis_dma.h"
#include "mantis_i2c.h"
#include "mantis_eeprom.h"

#include <asm/irq.h>
#include <linux/signal.h>
#include <linux/sched.h>
#include <linux/interrupt.h>

unsigned int verbose = 1;
module_param(verbose, int, 0644);
MODULE_PARM_DESC(verbose, "verbose startup messages, default is 1 (yes)");

#define PCI_VENDOR_ID_MANTIS			0x1822
#define PCI_DEVICE_ID_MANTIS_R11		0x4e35
#define DRIVER_NAME				"Mantis"

static struct pci_device_id mantis_pci_table[] = {
	{ PCI_DEVICE(PCI_VENDOR_ID_MANTIS, PCI_DEVICE_ID_MANTIS_R11) },
	{ 0 },
};

MODULE_DEVICE_TABLE(pci, mantis_pci_table);

static irqreturn_t mantis_pci_irq(int irq, void *dev_id, struct pt_regs *regs)
{
	struct mantis_pci *mantis;

	dprintk(verbose, MANTIS_DEBUG, 1, "Mantis PCI IRQ");
	mantis = (struct mantis_pci *) dev_id;
	if (mantis == NULL)
		dprintk(verbose, MANTIS_DEBUG, 1, "Aeio, mantis ISR");

	return IRQ_NONE;	// temporarily
}

static int mantis_i2c_setup(struct mantis_pci *mantis)
{
	u32 config;

//	mmwrite(0x80, MANTIS_DMA_CTL); // MCU i2c read
	config = mmread(MANTIS_DMA_CTL);
	dprintk(verbose, MANTIS_DEBUG, 1, "Mantis Ctl reg=0x%04x", config);

	return 0;
}

static int mantis_reg_dump(struct mantis_pci *mantis)
{
	u32 ctlreg, intstat, intmask, i2cdata;

	ctlreg = mmread(MANTIS_DMA_CTL);
	intstat = mmread(MANTIS_INT_STAT);
	intmask = mmread(MANTIS_INT_MASK);
	i2cdata = mmread(MANTIS_I2C_DATA);
	dprintk(verbose, MANTIS_DEBUG, 1, "CTL_REG=0x%04x, INT_STAT=0x%04x, \
		INT_MASK=0x%04x, I2C_DATA=0x%04x", ctlreg, intstat,		\
		intmask, i2cdata);

	return 0;
}

static int __devinit mantis_pci_probe(struct pci_dev *pdev,
				const struct pci_device_id *mantis_pci_table)
{
	u8 revision, latency;
	struct mantis_pci *mantis;

	mantis = (struct mantis_pci *)
				kmalloc(sizeof (struct mantis_pci), GFP_KERNEL);
	if (mantis == NULL) {
		dprintk(verbose, MANTIS_ERROR, 1, "Out of memory");
		return -ENOMEM;
	}
	dprintk(verbose, MANTIS_ERROR, 1, "Got a device");
	if (request_irq(pdev->irq, mantis_pci_irq, SA_SHIRQ | SA_INTERRUPT, 
						DRIVER_NAME, mantis) < 0) {
		dprintk(verbose, MANTIS_ERROR, 1, "Mantis IRQ reg failed");
		goto err;
	}
	dprintk(verbose, MANTIS_DEBUG, 1, "We got an IRQ");
	return 0;

err:
	dprintk(verbose, MANTIS_DEBUG, 1, "<freak out>");
	kfree(mantis);
	return -ENODEV;
}



static void __devexit mantis_pci_remove(struct pci_dev *pdev)
{
	free_irq(pdev->irq, pdev);
}

static struct pci_driver mantis_pci_driver = {
	.name = "Mantis PCI combo driver",
	.id_table = mantis_pci_table,
	.probe = mantis_pci_probe,
	.remove = mantis_pci_remove,
};

static int __devinit mantis_pci_init(void)
{
	return pci_register_driver(&mantis_pci_driver);
}

static void __devexit mantis_pci_exit(void)
{
	pci_unregister_driver(&mantis_pci_driver);
}

module_init(mantis_pci_init);
module_exit(mantis_pci_exit);

MODULE_DESCRIPTION("Mantis PCI DTV bridge driver");
MODULE_AUTHOR("Manu Abraham");
MODULE_LICENSE("GPL");

--------------020706000500010000090805
Content-Type: text/plain;
 name="stat_after_unloading.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stat_after_unloading.txt"

cpu  210 0 271 30642 1080 2 1 0
cpu0 210 0 271 30642 1080 2 1 0
intr 36484 32207 1363 0 0 0 0 0 0 0 0 0 0 110 0 2570 0 0 0 0 0 0 0 234 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
ctxt 21682
btime 1126950459
processes 2342
procs_running 1
procs_blocked 0

--------------020706000500010000090805
Content-Type: text/plain;
 name="stat_before_loading.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stat_before_loading.txt"

cpu  175 0 199 11504 968 1 1 0
cpu0 175 0 199 11504 968 1 1 0
intr 15790 12849 418 0 0 0 0 0 0 0 0 0 0 110 0 2196 0 0 0 0 0 0 0 217 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
ctxt 16743
btime 1126950459
processes 2274
procs_running 1
procs_blocked 0

--------------020706000500010000090805--
