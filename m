Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWBFTAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWBFTAV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWBFTAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:00:21 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:56750 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932179AbWBFTAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:00:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:date:user-agent:cc:mime-version:content-disposition:subject:content-type:content-transfer-encoding:message-id;
        b=YVrjfGvQnfKIHvc07Dxr6IsDt1VvzdtxgeIn6kgJOiv8WTI1tLhuthKpgDqMWkG8PbvYQLeKQTBN1EfRlZkD7W2JSblo4j1bAz5KFyor6wDl6Ahy5r1X7T0Shx6+rzyrMEA1K+UNw/ckDwkzjKe5jhoOwYnJhoo2DF4Siu19p8o=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 6 Feb 2006 20:00:12 +0100
User-Agent: KMail/1.9
Cc: Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: Two Oopses at boot with 2.6.16-rc2-git1 - Unable to handle kernel paging request at virtual address ...
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200602062000.12388.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got two Oopses at boot with 2.6.16-rc2-git1 : 

Unable to handle kernel paging request at virtual address f49667f8
 printing eip:
c0233ccf
*pde = 00490067
Oops: 0000 [#1]

 <1>Unable to handle kernel paging request at virtual address f49668c0
 printing eip:
c0236ac7
*pde = 00490067
Oops: 0000 [#2]

The oopses are not fatal. The system continues to operate (seemingly) just
fine, in fact I'm still using the machine to compose this mail (I'll reboot
soon though to see if it ocours again on a second boot).

Complete dmesg output including the oopses, backtraces etc can be found
below along with some information about my system - let me know if more 
info is needed.


-----[ dmesg output including oopses ]-----

Linux version 2.6.16-rc2-git1 (juhl@dragon) (gcc version 3.4.5) #1 SMP PREEMPT Sat Feb 4 15:12:34 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ffb0000 (usable)
 BIOS-e820: 000000007ffb0000 - 000000007ffc0000 (ACPI data)
 BIOS-e820: 000000007ffc0000 - 000000007fff0000 (ACPI NVS)
 BIOS-e820: 000000007fff0000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 524208
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 294832 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000f9bb0
ACPI: RSDT (v001 A M I  OEMRSDT  0x12000506 MSFT 0x00000097) @ 0x7ffb0000
ACPI: FADT (v002 A M I  OEMFACP  0x12000506 MSFT 0x00000097) @ 0x7ffb0200
ACPI: MADT (v001 A M I  OEMAPIC  0x12000506 MSFT 0x00000097) @ 0x7ffb0390
ACPI: OEMB (v001 A M I  AMI_OEM  0x12000506 MSFT 0x00000097) @ 0x7ffc0040
ACPI: DSDT (v001  939M2 939M2150 0x00000150 INTL 0x02002026) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfec10000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 17, address 0xfec10000, GSI 24-39
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 2 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:7f7c0000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=2.6.16-rc2-git1 ro root=801
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec10000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c03ed000 soft=c03eb000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2200.644 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2074004k/2096832k available (2059k kernel code, 21700k reserved, 693k data, 208k init, 1179328k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4404.96 BogoMIPS (lpj=2202483)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 178bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000003
CPU: After vendor identify, caps: 178bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000003
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(2) -> Core 0
CPU: After all inits, caps: 178bfbf7 e3d3fbff 00000000 00000010 00000001 00000000 00000003
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 4400+ stepping 02
Booting processor 1/1 eip 2000
CPU 1 irqstacks, hard=c03ee000 soft=c03ec000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4399.57 BogoMIPS (lpj=2199788)
CPU: After generic identify, caps: 178bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000003
CPU: After vendor identify, caps: 178bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000003
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(2) -> Core 1
CPU: After all inits, caps: 178bfbf7 e3d3fbff 00000000 00000010 00000001 00000000 00000003
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: AMD Athlon(tm) 64 X2 Dual Core Processor 4400+ stepping 02
Total of 2 processors activated (8804.54 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: 
CPU#0 had 0 usecs TSC skew, fixed it up.
CPU#1 had 0 usecs TSC skew, fixed it up.
Brought up 2 CPUs
migration_cost=1000
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=4
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0800-083f claimed by ali7101 ACPI
Boot video device is 0000:03:00.0
PCI: Transparent bridge - 0000:00:06.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HTT_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEB1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEB2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15), disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15), disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
ACPI: PCI Interrupt Link [LNKP] (IRQs 3 4 *5 6 7 10 11 12 14 15)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: ff200000-ff2fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: disabled.
  MEM window: ff300000-ff3fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:05.0
  IO window: disabled.
  MEM window: ff400000-ff4fffff
  PREFETCH window: c7f00000-d7efffff
PCI: Bridge: 0000:00:06.0
  IO window: d000-dfff
  MEM window: ff500000-ff5fffff
  PREFETCH window: 88000000-880fffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 29 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 34 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:00:05.0 to 64
PCI: Setting latency timer of device 0000:00:06.0 to 64
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
io scheduler noop registered
io scheduler anticipatory registered (default)
vesafb: framebuffer at 0xc8000000, mapped to 0xf8880000, using 3072k, total 16384k
vesafb: mode is 1024x768x16, linelength=2048, pages=9
vesafb: protected mode interface info at c000:7880
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12ac
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
ACPI: PCI Interrupt 0000:04:07.0[A] -> GSI 22 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:04:07.0, from 11 to 2
eth0: VIA Rhine II at 0xff5fec00, 00:50:ba:f2:a3:1d, IRQ 18.
eth0: MII PHY found at address 8, status 0x782d advertising 01e1 Link 45e1.
ACPI: PCI Interrupt 0000:04:06.0[A] -> GSI 21 (level, low) -> IRQ 19
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec 29160N Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: PIONEER   Model: DVD-ROM DVD-305   Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target0:0:4: Beginning Domain Validation
 target0:0:4: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 16)
 target0:0:4: Domain Validation skipping write tests
 target0:0:4: Ending Domain Validation
  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.01
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target0:0:5: Beginning Domain Validation
 target0:0:5: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 16)
 target0:0:5: Domain Validation skipping write tests
 target0:0:5: Ending Domain Validation
  Vendor: IBM       Model: DDYS-T36950N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:6:0: Tagged Queuing enabled.  Depth 200
 target0:0:6: Beginning Domain Validation
 target0:0:6: wide asynchronous
 target0:0:6: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
 target0:0:6: Ending Domain Validation
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
sda: Write Protect is off
sda: Mode Sense: cb 00 00 08
SCSI device sda: drive cache: write back
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
sda: Write Protect is off
sda: Mode Sense: cb 00 00 08
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
sd 0:0:6:0: Attached scsi disk sda
sr0: scsi3-mmc drive: 16x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 0:0:4:0: Attached scsi CD-ROM sr0
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
sr 0:0:5:0: Attached scsi CD-ROM sr1
sr 0:0:4:0: Attached scsi generic sg0 type 5
sr 0:0:5:0: Attached scsi generic sg1 type 5
sd 0:0:6:0: Attached scsi generic sg2 type 0
mice: PS/2 mouse device common for all mice
MC: drivers/edac/edac_mc.c version edac_mc  Ver: 2.0.0 Feb  4 2006
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 131072 (order: 7, 524288 bytes)
TCP established hash table entries: 131072 (order: 9, 3145728 bytes)
TCP bind hash table entries: 65536 (order: 8, 1572864 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI Shortcut mode
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 208k freed
Write protecting the kernel read-only data: 329k
input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
Adding 763076k swap on /dev/sda3.  Priority:-1 extents:1 across:763076k
EXT3 FS on sda1, internal journal
Linux agpgart interface v0.101 (c) Dave Jones
ReiserFS: sda2: found reiserfs format "3.6" with standard journal
ReiserFS: sda2: using ordered data mode
ReiserFS: sda2: journal params: device sda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda2: checking transaction log (sda2)
ReiserFS: sda2: Using r5 hash to sort names
ReiserFS: sda4: found reiserfs format "3.6" with standard journal
ReiserFS: sda4: using ordered data mode
ReiserFS: sda4: journal params: device sda4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda4: checking transaction log (sda4)
ReiserFS: sda4: Using r5 hash to sort names
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
ACPI: PCI Interrupt 0000:04:05.0[A] -> GSI 20 (level, low) -> IRQ 20
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.3
Unable to handle kernel paging request at virtual address f49667f8
 printing eip:
c0233ccf
*pde = 00490067
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
Modules linked in: snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss uhci_hcd usbcore snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus snd_pcm snd_seq_device snd_timer snd_page_alloc snd_util_mem snd_hwdep snd agpgart
CPU:    1
EIP:    0060:[<c0233ccf>]    Not tainted VLI
EFLAGS: 00010246   (2.6.16-rc2-git1) 
EIP is at tty_paranoia_check+0xf/0x70
eax: f49667f8   ebx: f6900e18   ecx: c032c122   edx: 00000000
esi: f6900e18   edi: f6ece57c   ebp: c2231e90   esp: c2231e7c
ds: 007b   es: 007b   ss: 0068
Process agetty (pid: 2357, threadinfo=c2231000 task=f7fc3ab0)
Stack: <0>80042800 c20fc6c0 c2231eb4 c015e27c f49667f8 c2231f4c c023623a 00000046 
       0000000d c0171943 f7539000 c20fc6c0 c21a9f38 00000246 c2231ecc 00000282 
       f6ece57c c2231f60 bfa72690 c2231eec c2231ee0 c01f694b 00000406 bfa72690 
Call Trace:
 [<c0103db1>] show_stack_log_lvl+0xa1/0xe0
 [<c0103f76>] show_registers+0x156/0x1d0
 [<c010418a>] die+0x10a/0x1a0
 [<c0116b49>] do_page_fault+0x389/0x548
 [<c0103a3b>] error_code+0x4f/0x54
 [<c023623a>] release_dev+0x2a/0x7b0
 [<c0236e72>] tty_release+0x12/0x20
 [<c0162be7>] __fput+0x167/0x1b0
 [<c0162a79>] fput+0x19/0x20
 [<c01612ec>] filp_close+0x3c/0x80
 [<c016139c>] sys_close+0x6c/0x90
 [<c0102f39>] syscall_call+0x7/0xb
Code: 75 fa 8b 34 24 8b 7c 24 04 89 c8 c9 c3 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90 90 55 89 e5 53 89 d3 83 ec 10 85 c0 74 3d 31 d2 <81> 38 01 54 00 00 74 2b 8b 43 38 89 4c 24 0c c7 04 24 a4 41 33 
 <1>Unable to handle kernel paging request at virtual address f49668c0
 printing eip:
c0236ac7
*pde = 00490067
Oops: 0000 [#2]
PREEMPT SMP DEBUG_PAGEALLOC
Modules linked in: snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss uhci_hcd usbcore snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus snd_pcm snd_seq_device snd_timer snd_page_alloc snd_util_mem snd_hwdep snd agpgart
CPU:    0
EIP:    0060:[<c0236ac7>]    Not tainted VLI
EFLAGS: 00010246   (2.6.16-rc2-git1) 
EIP is at tty_open+0x107/0x2e0
eax: f49667f8   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: f49667f8   edi: f7910e1c   ebp: f6cd4ec0   esp: f6cd4ea0
ds: 007b   es: 007b   ss: 0068
Process agetty (pid: 2383, threadinfo=f6cd4000 task=f6e21ab0)
Stack: <0>88024eb0 00400006 00000000 f49667f8 00000005 f7a1fdfc c02369c0 f6a2ee18 
       f6cd4ee4 c016b627 00000001 00000000 f7910e1c 00000005 f7910e1c 00000000 
       f6a2ee18 f6cd4f08 c0160cde 00000213 00000001 c2149370 f6a23258 f7910e1c 
Call Trace:
 [<c0103db1>] show_stack_log_lvl+0xa1/0xe0
 [<c0103f76>] show_registers+0x156/0x1d0
 [<c010418a>] die+0x10a/0x1a0
 [<c0116b49>] do_page_fault+0x389/0x548
 [<c0103a3b>] error_code+0x4f/0x54
 [<c016b627>] chrdev_open+0xf7/0x1d0
 [<c0160cde>] __dentry_open+0x18e/0x290
 [<c0160f08>] nameidata_to_filp+0x28/0x40
 [<c0160e29>] do_filp_open+0x49/0x60
 [<c01611a0>] do_sys_open+0x50/0xe0
 [<c016124c>] sys_open+0x1c/0x20
 [<c0102f39>] syscall_call+0x7/0xb
Code: 00 00 8b 56 04 81 7a 74 04 00 01 00 0f 45 45 e8 89 45 e8 8b 8a bc 00 00 00 85 c9 75 7b 0f b7 45 e2 85 db 89 47 18 75 28 8b 45 ec <8b> 80 c8 00 00 00 a8 08 0f 84 dd 00 00 00 b8 15 00 00 00 e8 91 
 

-----[ scripts/ver_linux output ]-----

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux dragon 2.6.16-rc2-git1 #1 SMP PREEMPT Sat Feb 4 15:12:34 CET 2006 i686 unknown unknown GNU/Linux

Gnu C                  3.4.5
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12p
mount                  2.12p
module-init-tools      3.1
e2fsprogs              1.38
reiserfsprogs          3.6.19
reiser4progs           line
quota-tools            3.12.
PPP                    2.4.4b1
nfs-utils              1.0.7
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Linux C++ Library      6.0.3
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   064
Modules Loaded         snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss uhci_hcd usbcore snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus snd_pcm snd_seq_device snd_timer snd_page_alloc snd_util_mem snd_hwdep snd agpgart


-----[ cat /proc/cpuinfo output ]-----

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
stepping        : 2
cpu MHz         : 2200.644
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy ts fid vid ttp
bogomips        : 4404.96

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
stepping        : 2
cpu MHz         : 2200.644
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy ts fid vid ttp
bogomips        : 4399.57


-----[ cat /proc/meminfo output ]-----

MemTotal:      2074952 kB
MemFree:       1594292 kB
Buffers:         24756 kB
Cached:         255200 kB
SwapCached:          0 kB
Active:         233344 kB
Inactive:       150976 kB
HighTotal:     1179328 kB
HighFree:       814428 kB
LowTotal:       895624 kB
LowFree:        779864 kB
SwapTotal:      763076 kB
SwapFree:       763076 kB
Dirty:              48 kB
Writeback:           0 kB
Mapped:         155032 kB
Slab:            81684 kB
CommitLimit:   1800552 kB
Committed_AS:   441912 kB
PageTables:       1376 kB
VmallocTotal:   114680 kB
VmallocUsed:      6540 kB
VmallocChunk:   106992 kB


-----[ lspci -vvvx output ]-----

00:00.0 Host bridge: ALi Corporation M1695 K8 Northbridge [PCI Express and HyperTransport]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [40] #08 [0060]
        Capabilities: [5c] #08 [a800]
        Capabilities: [68] #08 [9000]
        Capabilities: [74] #08 [8000]
        Capabilities: [7c] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
                Address: 00000000fee00000  Data: 0000
00: b9 10 95 16 07 00 10 00 00 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: ALi Corporation: Unknown device 524b (prog-if 00 [Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 10
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: ff200000-ff2fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
                Address: 00000000fee00000  Data: 0000
        Capabilities: [58] #10 [0141]
        Capabilities: [7c] #08 [a800]
        Capabilities: [88] #08 [8825]
00: b9 10 4b 52 06 01 10 00 00 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 00 00
20: 20 ff 20 ff f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 03 00

00:02.0 PCI bridge: ALi Corporation: Unknown device 524c (prog-if 00 [Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 10
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: ff300000-ff3fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
                Address: 00000000fee00000  Data: 0000
        Capabilities: [58] #10 [0141]
        Capabilities: [7c] #08 [a800]
        Capabilities: [88] #08 [8825]
00: b9 10 4c 52 06 01 10 00 00 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 00 f0 00 00 00
20: 30 ff 30 ff f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 03 00

00:04.0 Host bridge: ALi Corporation M1689 K8 Northbridge [Super K8 Single Chip]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at dc000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [40] #08 [0024]
        Capabilities: [60] #08 [8038]
        Capabilities: [80] AGP version 3.0
                Status: RQ=28 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
00: b9 10 89 16 06 01 10 00 00 00 00 06 00 00 00 00
10: 08 00 00 dc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00

00:05.0 PCI bridge: ALi Corporation AGP8X Controller (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: ff400000-ff4fffff
        Prefetchable memory behind bridge: c7f00000-d7efffff
        BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
00: b9 10 46 52 07 01 20 00 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 03 03 40 f0 00 20 22
20: 40 ff 40 ff f0 c7 e0 d7 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0b 00

00:06.0 PCI bridge: ALi Corporation M5249 HTT to PCI Bridge (prog-if 01 [Subtractive decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: ff500000-ff5fffff
        Prefetchable memory behind bridge: 88000000-880fffff
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
00: b9 10 49 52 07 01 00 00 00 01 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 04 04 20 d0 d0 00 22
20: 50 ff 50 ff 00 88 00 88 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03 00

00:07.0 ISA bridge: ALi Corporation M1563 HyperTransport South Bridge (rev 70)
        Subsystem: ASRock Incorporation: Unknown device 1563
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 6000ns max)
00: b9 10 63 15 0f 00 00 02 70 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 63 15
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 18

00:07.1 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
        Subsystem: ASRock Incorporation: Unknown device 7101
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: b9 10 01 71 00 00 00 02 00 00 80 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 01 71
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:11.0 Ethernet controller: ALi Corporation M5263 Ethernet Controller (rev 40)
        Subsystem: ASRock Incorporation: Unknown device 5263
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (5000ns min, 10000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at ff6ffc00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 63 52 07 01 10 02 40 00 00 02 08 20 00 00
10: 01 e8 00 00 00 fc 6f ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 63 52
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 14 28

00:12.0 IDE interface: ALi Corporation M5229 IDE (rev c7) (prog-if 8a [Master SecP PriP])
        Subsystem: ASRock Incorporation: Unknown device 5229
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at ff00 [size=16]
00: b9 10 29 52 05 00 a0 02 c7 8a 01 01 00 20 00 00
10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
20: 01 ff 00 00 00 00 00 00 00 00 00 00 49 18 29 52
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00

00:13.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
        Subsystem: ASRock Incorporation: Unknown device 5237
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ff6fe000 (32-bit, non-prefetchable) [size=4K]
00: b9 10 37 52 17 01 a8 02 03 10 03 0c 10 20 80 00
10: 00 e0 6f ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 37 52
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 50

00:13.1 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
        Subsystem: ASRock Incorporation: Unknown device 5237
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 10
        Interrupt: pin B routed to IRQ 3
        Region 0: Memory at ff6fd000 (32-bit, non-prefetchable) [size=4K]
00: b9 10 37 52 17 01 a8 02 03 10 03 0c 10 20 80 00
10: 00 d0 6f ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 37 52
30: 00 00 00 00 00 00 00 00 00 00 00 00 03 02 00 50

00:13.2 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
        Subsystem: ASRock Incorporation: Unknown device 5237
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 10
        Interrupt: pin C routed to IRQ 11
        Region 0: Memory at ff6fc000 (32-bit, non-prefetchable) [size=4K]
00: b9 10 37 52 17 01 a8 02 03 10 03 0c 10 20 80 00
10: 00 c0 6f ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 37 52
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 03 00 50

00:13.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01) (prog-if 20 [EHCI])
        Subsystem: ASRock Incorporation: Unknown device 5239
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 8000ns max), cache line size 10
        Interrupt: pin D routed to IRQ 5
        Region 0: Memory at ff6ff800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #0a [2090]
00: b9 10 39 52 16 01 b0 02 01 20 03 0c 10 20 80 00
10: 00 f8 6f ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 39 52
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 04 10 20

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] #08 [2101]
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

03:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA Parhelia AGP (rev 03) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Parhelia 128Mb
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 8000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at c8000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at ff4fe000 (32-bit, non-prefetchable) [size=8K]
        Expansion ROM at ff4c0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
00: 2b 10 27 05 07 00 b0 02 03 00 00 03 10 20 00 00
10: 08 00 00 c8 00 e0 4f ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 40 08
30: 00 00 4c ff dc 00 00 00 00 00 00 00 05 01 10 20

04:05.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
        Subsystem: Creative Labs SBLive! 5.1 eMicro 28028
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 20
        Region 0: I/O ports at d880 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 11 02 00 05 01 90 02 0a 00 01 04 00 20 80 00
10: 81 d8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 67 80
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 02 14

04:05.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 0a)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at dc00 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 11 02 70 05 01 90 02 0a 00 80 09 00 20 80 00
10: 01 dc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 20 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 00 00

04:06.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
        Subsystem: Adaptec 29160N Ultra160 SCSI Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), cache line size 10
        Interrupt: pin A routed to IRQ 19
        BIST result: 00
        Region 0: I/O ports at d400 [disabled] [size=256]
        Region 1: Memory at ff5ff000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at 88000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 05 90 80 00 16 01 b0 02 02 00 00 01 10 20 00 80
10: 01 d4 00 00 04 f0 5f ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 05 90 a0 62
30: 00 00 5c ff dc 00 00 00 00 00 00 00 03 01 28 19

04:07.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 42)
        Subsystem: D-Link System Inc DFE-530TX rev B
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at d000 [size=256]
        Region 1: Memory at ff5fec00 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at 88020000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 65 30 17 01 10 02 42 00 00 02 10 20 00 00
10: 01 d0 00 00 00 ec 5f ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 11 01 14
30: 00 00 ff ff 40 00 00 00 00 00 00 00 02 01 03 08


-----[ cat /etc/slackware-version output ]-----

cat /etc/slackware-version


-----[ zcat /proc/config.gz | egrep -v "^#" | egrep -v "^$" output ]-----

CONFIG_X86_32=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y
CONFIG_EXPERIMENTAL=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_UID16=y
CONFIG_VM86=y
CONFIG_KALLSYMS=y
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_SLAB=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_DEFAULT_AS=y
CONFIG_DEFAULT_IOSCHED="anticipatory"
CONFIG_X86_PC=y
CONFIG_MK8=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_SMP=y
CONFIG_NR_CPUS=2
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_HIGHMEM4G=y
CONFIG_VMSPLIT_3G=y
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_NEED_NODE_MEMMAP_SIZE=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MIGRATION=y
CONFIG_HIGHPTE=y
CONFIG_MTRR=y
CONFIG_IRQBALANCE=y
CONFIG_REGPARM=y
CONFIG_SECCOMP=y
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_PHYSICAL_START=0x100000
CONFIG_DOUBLEFAULT=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_ISA_DMA_API=y
CONFIG_BINFMT_ELF=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_FIB_HASH=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_TCP_CONG_BIC=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_FC_ATTRS=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=200
CONFIG_AIC7XXX_RESET_DELAY_MS=15001
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
CONFIG_NET_PCI=y
CONFIG_VIA_RHINE=y
CONFIG_VIA_RHINE_MMIO=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1600
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1200
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_UINPUT=m
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_LIBPS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_NR_UARTS=2
CONFIG_SERIAL_8250_RUNTIME_UARTS=2
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_HW_RANDOM=y
CONFIG_RTC=y
CONFIG_AGP=m
CONFIG_HANGCHECK_TIMER=m
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
CONFIG_SND_EMU10K1=m
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB=m
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_UHCI_HCD=m
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_MON=y
CONFIG_EDAC=y
CONFIG_EDAC_MM_EDAC=y
CONFIG_EDAC_POLL=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_REISERFS_FS=y
CONFIG_INOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=865
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-15"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_UTF8=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=18
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_VM=y
CONFIG_FRAME_POINTER=y
CONFIG_FORCED_INLINING=y
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_RODATA=y
CONFIG_4KSTACKS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_KTIME_SCALAR=y
