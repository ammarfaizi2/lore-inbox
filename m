Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262212AbSJFVyA>; Sun, 6 Oct 2002 17:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262214AbSJFVyA>; Sun, 6 Oct 2002 17:54:00 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:21129 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262212AbSJFVxy> convert rfc822-to-8bit; Sun, 6 Oct 2002 17:53:54 -0400
Date: Sun, 6 Oct 2002 23:59:10 +0200 (CEST)
From: eduard.epi@t-online.de (Peter Bornemann)
To: linux-kernel@vger.kernel.org
Subject: Bugs in 2.5.40-ac5
Message-ID: <Pine.LNX.4.44.0210062357440.848-100000@eduard.t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From peter@eduard.t-online.de Sun Oct  6 23:57:34 2002
Date: Sun, 6 Oct 2002 23:08:27 +0200 (CEST)
From: Peter Bornemann <peter@eduard.t-online.de>
To: linux-kernel@vger-kernel.org
Subject: Bugs in 2.5.40-ac5

These are the messages I get during bootinon my Athlon 700 debian box.
Gcc is 3.0.4:

      ksymoops makes the output from dmesg to:

ksymoops 2.4.5 on i686 2.5.40-ac5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.40-ac5/ (default)
     -m /boot/System.map-2.5.40-ac5 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Machine check exception polling timer started.
cpu: 0, clocks: 199983, slice: 99991
dffcfe98 c0114f02 c0241060 c02430c7 0000055e c0318298 c0130cf6 c02430c7
       0000055e 00000003 dffcfeec c0318288 42007530 0001ff0c 00010003 00030004
       00000046 c0318298 c03182d0 c03181dc c0318298 c01bca50 c1581134 000001d0
Call Trace: [<c0114f02>] [<c0130cf6>] [<c01bca50>] [<c01bcadd>] [<c01c22f8>] [<c01c8a60>] [<c01c2525>] [<c01c28e6>] [<c01c222d>] [<c01cf007>] [<c01c12c3>] [<c01050a7>] [<c0105070>] [<c01054f9>]
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c0114f02 <__might_sleep+52/60>
Trace; c0130cf6 <kmem_cache_alloc+26/1f0>
Trace; c01bca50 <blk_init_free_list+50/d0>
Trace; c01bcadd <blk_init_queue+d/e0>
Trace; c01c22f8 <ide_init_queue+28/70>
Trace; c01c8a60 <do_ide_request+0/20>
Trace; c01c2525 <init_irq+1e5/380>
Trace; c01c28e6 <hwif_init+76/270>
Trace; c01c222d <probe_hwif_init+1d/60>
Trace; c01cf007 <ide_setup_pci_device+57/60>
Trace; c01c12c3 <via_init_one+33/40>
Trace; c01050a7 <init+37/1c0>
Trace; c0105070 <init+0/1c0>
Trace; c01054f9 <kernel_thread_helper+5/c>

8139too Fast Ethernet driver 0.9.26
dfa17e30 c0114f02 c0241060 c0246da0 00000077 e08bd0bc c0168519 c0246da0
       00000077 e08bd028 e08bd020 e08bd020 e08bd000 c01a5d7d e08bd0bc dfdb99c8
       e08bd028 e08bd020 e08bd0b0 c01a4741 e08bd020 e08bd020 dfa16000 e08bd0ec
Call Trace: [<c0114f02>] [<c0168519>] [<c01a5d7d>] [<c01a4741>] [<e08a1785>] [<e08a4f7f>] [<e08a4f78>] [<c0163a5f>] [<c0163dbd>] [<e08a51c9>] [<e08a14d3>] [<e08a5840>] [<e0894f0a>] [<e08a1bb9>] [<e08a5840>] [<c01183a5>] [<e08a5800>] [<e089f060>] [<c0107253>]
dfa17d34 c0113baf c0240f20 00000001 c02760d8 dfa17d5c dfa16000 dfa17e24
       dfdd5ed1 dfa17da8 c0113e29 00000000 c16b8cc0 c0113c20 00000000 00000000
       dfa16000 dfdd5ed1 dfa17d9c 00000001 c16b8cc0 c0113c20 dfa17e28 dfa17e28
Call Trace: [<c0113baf>] [<c0113e29>] [<c0113c20>] [<c0113c20>] [<c0124d81>] [<c0124c70>] [<e089d7b0>] [<c0124c70>] [<c01a6868>] [<e089b4d7>] [<c01a47cd>] [<e08a1785>] [<e08a4f7f>] [<e08a4f78>] [<c0163a5f>] [<c0163dbd>] [<e08a51c9>] [<e08a14d3>] [<e08a5840>] [<e0894f0a>] [<e08a1bb9>] [<e08a5840>] [<c01183a5>] [<e08a5800>] [<e089f060>] [<c0107253>]
dfa17d34 c0113baf c0240f20 00000001 c02760d8 dfa17d5c dfa16000 dfa17e24
       dfdd5ed1 dfa17da8 c0113e29 00000000 c16b8cc0 c0113c20 00000000 00000000
       dfa16000 dfdd5ed1 dfa17d9c 00000001 c16b8cc0 c0113c20 dfa17e28 dfa17e28
Call Trace: [<c0113baf>] [<c0113e29>] [<c0113c20>] [<c0113c20>] [<c0124d81>] [<c0124c70>] [<e089d7b0>] [<c0124c70>] [<c01a6868>] [<e089b4d7>] [<c01a4516>] [<c01a47cd>] [<e08a1785>] [<e08a4f7f>] [<e08a4f78>] [<e0893e4b>] [<e08a5840>] [<e0894f0a>] [<e08a1bb9>] [<e08a5840>] [<c01183a5>] [<e08a5800>] [<e089f060>] [<c0107253>]
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c0114f02 <__might_sleep+52/60>
Trace; c0168519 <driverfs_create_dir+39/d0>
Trace; c01a5d7d <device_make_dir+3d/90>
Trace; c01a4741 <device_register+c1/1a0>
Trace; e08a1785 <[sg]sg_attach+1d5/3d0>
Trace; e08a4f7f <[sg]__module_parm_desc_def_reserved_size+7f/625>
Trace; e08a4f78 <[sg]__module_parm_desc_def_reserved_size+78/625>
Trace; c0163a5f <proc_register+f/90>
Trace; c0163dbd <create_proc_entry+6d/a0>
Trace; e08a51c9 <[sg]__module_parm_desc_def_reserved_size+2c9/625>
Trace; e08a14d3 <[sg]sg_init+b3/130>
Trace; e08a5840 <[sg]sg_template+0/94>
Trace; e0894f0a <[scsi_mod]scsi_register_device+ba/150>
Trace; e08a1bb9 <[sg]init_sg+19/50>
Trace; e08a5840 <[sg]sg_template+0/94>
Trace; c01183a5 <sys_init_module+565/640>
Trace; e08a5800 <[sg].rodata.end+2db/2fb>
Trace; e089f060 <[sg]sg_open+0/2c0>
Trace; c0107253 <syscall_call+7/b>
Trace; c0113baf <schedule+36f/380>
Trace; c0113e29 <wait_for_completion+d9/110>
Trace; c0113c20 <default_wake_function+0/40>
Trace; c0113c20 <default_wake_function+0/40>
Trace; c0124d81 <call_usermodehelper+e1/f0>
Trace; c0124c70 <__call_usermodehelper+0/30>
Trace; e089d7b0 <[scsi_mod]scsi_driverfs_bus_type+30/5c>
Trace; c0124c70 <__call_usermodehelper+0/30>
Trace; c01a6868 <dev_hotplug+1e8/240>
Trace; e089b4d7 <[scsi_mod]__module_parm_max_scsi_luns+b/13>
Trace; c01a47cd <device_register+14d/1a0>
Trace; e08a1785 <[sg]sg_attach+1d5/3d0>
Trace; e08a4f7f <[sg]__module_parm_desc_def_reserved_size+7f/625>
Trace; e08a4f78 <[sg]__module_parm_desc_def_reserved_size+78/625>
Trace; c0163a5f <proc_register+f/90>
Trace; c0163dbd <create_proc_entry+6d/a0>
Trace; e08a51c9 <[sg]__module_parm_desc_def_reserved_size+2c9/625>
Trace; e08a14d3 <[sg]sg_init+b3/130>
Trace; e08a5840 <[sg]sg_template+0/94>
Trace; e0894f0a <[scsi_mod]scsi_register_device+ba/150>
Trace; e08a1bb9 <[sg]init_sg+19/50>
Trace; e08a5840 <[sg]sg_template+0/94>
Trace; c01183a5 <sys_init_module+565/640>
Trace; e08a5800 <[sg].rodata.end+2db/2fb>
Trace; e089f060 <[sg]sg_open+0/2c0>
Trace; c0107253 <syscall_call+7/b>
Trace; c0113baf <schedule+36f/380>
Trace; c0113e29 <wait_for_completion+d9/110>
Trace; c0113c20 <default_wake_function+0/40>
Trace; c0113c20 <default_wake_function+0/40>
Trace; c0124d81 <call_usermodehelper+e1/f0>
Trace; c0124c70 <__call_usermodehelper+0/30>
Trace; e089d7b0 <[scsi_mod]scsi_driverfs_bus_type+30/5c>
Trace; c0124c70 <__call_usermodehelper+0/30>
Trace; c01a6868 <dev_hotplug+1e8/240>
Trace; e089b4d7 <[scsi_mod]__module_parm_max_scsi_luns+b/13>
Trace; c01a4516 <device_attach+36/40>
Trace; c01a47cd <device_register+14d/1a0>
Trace; e08a1785 <[sg]sg_attach+1d5/3d0>
Trace; e08a4f7f <[sg]__module_parm_desc_def_reserved_size+7f/625>
Trace; e08a4f78 <[sg]__module_parm_desc_def_reserved_size+78/625>
Trace; e0893e4b <[scsi_mod]scsi_build_commandblocks+6b/1e0>
Trace; e08a5840 <[sg]sg_template+0/94>
Trace; e0894f0a <[scsi_mod]scsi_register_device+ba/150>
Trace; e08a1bb9 <[sg]init_sg+19/50>
Trace; e08a5840 <[sg]sg_template+0/94>
Trace; c01183a5 <sys_init_module+565/640>
Trace; e08a5800 <[sg].rodata.end+2db/2fb>
Trace; e089f060 <[sg]sg_open+0/2c0>
Trace; c0107253 <syscall_call+7/b>

df02dd04 c0114f02 c0241060 e093f800 00000077 de862c04 e0936386 e093f800
       00000077 df103c00 df02c000 00000200 00000200 de862c04 e0938151 dfe2d6c4
       00004140 00000200 e0938371 dfe2d6c4 00004140 00000200 deedf558 c016c3b6
Call Trace: [<c0114f02>] [<e093f800>] [<e0936386>] [<e093f800>] [<e0938151>] [<e0938371>] [<c016c3b6>] [<c016bf10>] [<c013b0de>] [<c014a8bb>] [<c01b5326>] [<c01d2188>] [<c01b69ae>] [<c01b8a32>] [<c01b8e09>] [<c01d2188>] [<c01295c8>] [<c01b5ea7>] [<c012980e>] [<c0113c20>] [<c01125ac>] [<c01abde0>] [<c013eb26>] [<c01472fa>] [<c014e643>] [<c0107253>]
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c0114f02 <__might_sleep+52/60>
Trace; e093f800 <[snd-pcm]__kstrtab_snd_interval_muldivk+0/20>
Trace; e0936386 <[snd-pcm]snd_pcm_prepare+26/1f0>
Trace; e093f800 <[snd-pcm]__kstrtab_snd_interval_muldivk+0/20>
Trace; e0938151 <[snd-pcm]snd_pcm_common_ioctl1+91/260>
Trace; e0938371 <[snd-pcm]snd_pcm_playback_ioctl1+51/340>
Trace; c016c3b6 <ext2_readpages+16/20>
Trace; c016bf10 <ext2_get_block+0/450>
Trace; c013b0de <read_pages+2e/120>
Trace; c014a8bb <link_path_walk+50b/960>
Trace; c01b5326 <scrup+136/150>
Trace; c01d2188 <vgacon_cursor+148/1d0>
Trace; c01b69ae <lf+5e/70>
Trace; c01b8a32 <do_con_trol+da2/fa0>
Trace; c01b8e09 <do_con_write+1d9/6b0>
Trace; c01d2188 <vgacon_cursor+148/1d0>
Trace; c01295c8 <do_no_page+178/2d0>
Trace; c01b5ea7 <set_cursor+67/80>
Trace; c012980e <handle_mm_fault+ee/120>
Trace; c0113c20 <default_wake_function+0/40>
Trace; c01125ac <do_page_fault+28c/457>
Trace; c01abde0 <write_chan+0/210>
Trace; c013eb26 <vfs_write+96/160>
Trace; c01472fa <sys_fstat64+2a/30>
Trace; c014e643 <sys_ioctl+d3/2b0>
Trace; c0107253 <syscall_call+7/b>


4 warnings issued.  Results may not be reliable.

    original dmesg is:


Linux version 2.5.40-ac5 (root@eduard) (gcc version 3.0.4) #5 Son Okt 6 22:35:13 CEST 2002
Video mode to be used for restore is f03
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
 BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
 BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131052
  DMA zone: 4096 pages
  Normal zone: 126956 pages
  HighMem zone: 0 pages
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=debian.old ro root=1601 auto
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 700.190 MHz processor.
Console: colour VGA+ 80x28
Calibrating delay loop... 1376.25 BogoMIPS
Memory: 516468k/524208k available (1259k kernel code, 7352k reserved, 453k data, 100k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 0183fbff c1c3fbff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After vendor init, caps: 0183fbff c1c3fbff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Machine check exception polling timer started.
CPU:     After generic, caps: 0183fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0183fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 699.0942 MHz.
..... host bus clock speed is 199.0983 MHz.
cpu: 0, clocks: 199983, slice: 99991
CPU0<T0:199968,T1:99968,D:9,S:99991,C:199983>
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: PCI BIOS revision 2.10 entry at 0xf1010, last bus=1
PCI: Using configuration type 1
adding '' to cpu class interfaces
usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
aio_setup: sizeof(struct page) = 40
Capability LSM initialized
PCI: Disabling Via external APIC routing
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
pty: 256 Unix98 ptys configured
Software Watchdog Timer: 0.06, soft_margin: 60 sec, nowayout: 0
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 00:04.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 21) IDE UDMA66 controller on pci00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 52049U4, ATA DISK drive
hdb: FUJITSU MPG3409AT E, ATA DISK drive
hda: DMA disabled
hdb: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: WDC WD400EB-00CPF0, ATA DISK drive
hdd: IBM-DHEA-36481, ATA DISK drive
hdc: DMA disabled
hdd: DMA disabled
Debug: sleeping function called from illegal context at slab.c:1374
dffcfe98 c0114f02 c0241060 c02430c7 0000055e c0318298 c0130cf6 c02430c7
       0000055e 00000003 dffcfeec c0318288 42007530 0001ff0c 00010003 00030004
       00000046 c0318298 c03182d0 c03181dc c0318298 c01bca50 c1581134 000001d0
Call Trace: [<c0114f02>] [<c0130cf6>] [<c01bca50>] [<c01bcadd>] [<c01c22f8>] [<c01c8a60>] [<c01c2525>] [<c01c28e6>] [<c01c222d>] [<c01cf007>] [<c01c12c3>] [<c01050a7>] [<c0105070>] [<c01054f9>]
spurious 8259A interrupt: IRQ7.
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 40020624 sectors (20491 MB) w/2048KiB Cache, CHS=2491/255/63, UDMA(66)
 hda: hda1
hdb: host protected area => 1
hdb: 80063424 sectors (40992 MB) w/2048KiB Cache, CHS=4983/255/63, UDMA(66)
 hdb: hdb1 hdb2
hdc: host protected area => 1
hdc: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63, UDMA(66)
 hdc: hdc1 hdc2 < hdc5 hdc6 hdc7 >
hdd: 12692736 sectors (6499 MB) w/472KiB Cache, CHS=12592/16/63, UDMA(33)
 hdd: hdd1 hdd2
uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v2.0:USB HID core driver
register interface 'mouse' with class 'input
mice: PS/2 mouse device common for all mice
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT2-fs warning (device ide1(22,1)): ext2_fill_super: mounting ext3 filesystem as ext2

VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 100k freed
Adding 1052816k swap on /dev/hdb1.  Priority:-1 extents:1
Real Time Clock Driver v1.11
8139too Fast Ethernet driver 0.9.26
PCI: Found IRQ 3 for device 00:09.0
PCI: Sharing IRQ 3 with 00:0d.0
eth0: RealTek RTL8139 Fast Ethernet at 0xe088f000, 00:50:bf:08:85:96, IRQ 3
eth0:  Identified 8139 chip type 'RTL-8139B'
SCSI subsystem driver Revision: 1.00
sym53c8xx: setup=mpar:0,spar:0,tags:0,sync:50,burst:0,led:0,wide:1,diff:1,irqm:0, buschk:2
sym53c8xx: setup=hostid:7,offs:15,luns:1,pcifix:0,revprob:0,verb:2,debug:0x0,setlle_delay:10
PCI: Found IRQ 10 for device 00:0b.0
sym.0.11.0: setting PCI_COMMAND_PARITY...
sym.0.11.0: 53c810a detected with Symbios NVRAM
sym0: <810a> rev 0x23 on pci bus 0 device 11 function 0 irq 10
sym0: using memory mapped IO
sym0: Symbios NVRAM, ID 7, Fast-10, SE, NO parity
sym0: open drain IRQ line driver
sym0: using LOAD/STORE-based firmware.
sym0: initial SCNTL3/DMODE/DCNTL/CTEST3/4/5 = (hex) 00/00/00/00/00/00
sym0: final   SCNTL3/DMODE/DCNTL/CTEST3/4/5 = (hex) 03/0e/a0/01/80/00
sym0: SCSI BUS has been reset.
sym0: command processing suspended for 10 seconds
scsi0 : sym-2.1.16a
sym0: command processing resumed
  Vendor: TEAC      Model: CD-ROM CD-532S    Rev: 1.0A
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: HP        Model: CD-Writer+ 9200   Rev: 1.0e
  Type:   CD-ROM                             ANSI SCSI revision: 04
Debug: sleeping function called from illegal context at /linux2/usr/src/linux-2.5.x/include/asm/semaphore.h:119
dfa17e30 c0114f02 c0241060 c0246da0 00000077 e08bd0bc c0168519 c0246da0
       00000077 e08bd028 e08bd020 e08bd020 e08bd000 c01a5d7d e08bd0bc dfdb99c8
       e08bd028 e08bd020 e08bd0b0 c01a4741 e08bd020 e08bd020 dfa16000 e08bd0ec
Call Trace: [<c0114f02>] [<c0168519>] [<c01a5d7d>] [<c01a4741>] [<e08a1785>] [<e08a4f7f>] [<e08a4f78>] [<c0163a5f>] [<c0163dbd>] [<e08a51c9>] [<e08a14d3>] [<e08a5840>] [<e0894f0a>] [<e08a1bb9>] [<e08a5840>] [<c01183a5>] [<e08a5800>] [<e089f060>] [<c0107253>]
bad: scheduling while atomic!
dfa17d34 c0113baf c0240f20 00000001 c02760d8 dfa17d5c dfa16000 dfa17e24
       dfdd5ed1 dfa17da8 c0113e29 00000000 c16b8cc0 c0113c20 00000000 00000000
       dfa16000 dfdd5ed1 dfa17d9c 00000001 c16b8cc0 c0113c20 dfa17e28 dfa17e28
Call Trace: [<c0113baf>] [<c0113e29>] [<c0113c20>] [<c0113c20>] [<c0124d81>] [<c0124c70>] [<e089d7b0>] [<c0124c70>] [<c01a6868>] [<e089b4d7>] [<c01a47cd>] [<e08a1785>] [<e08a4f7f>] [<e08a4f78>] [<c0163a5f>] [<c0163dbd>] [<e08a51c9>] [<e08a14d3>] [<e08a5840>] [<e0894f0a>] [<e08a1bb9>] [<e08a5840>] [<c01183a5>] [<e08a5800>] [<e089f060>] [<c0107253>]
bad: scheduling while atomic!
dfa17d34 c0113baf c0240f20 00000001 c02760d8 dfa17d5c dfa16000 dfa17e24
       dfdd5ed1 dfa17da8 c0113e29 00000000 c16b8cc0 c0113c20 00000000 00000000
       dfa16000 dfdd5ed1 dfa17d9c 00000001 c16b8cc0 c0113c20 dfa17e28 dfa17e28
Call Trace: [<c0113baf>] [<c0113e29>] [<c0113c20>] [<c0113c20>] [<c0124d81>] [<c0124c70>] [<e089d7b0>] [<c0124c70>] [<c01a6868>] [<e089b4d7>] [<c01a4516>] [<c01a47cd>] [<e08a1785>] [<e08a4f7f>] [<e08a4f78>] [<e0893e4b>] [<e08a5840>] [<e0894f0a>] [<e08a1bb9>] [<e08a5840>] [<c01183a5>] [<e08a5800>] [<e089f060>] [<c0107253>]
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 64M @ 0xe4000000
agpgart: Oops, don't init more than one agpgart device.
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
parport0: cpp_daisy: aa5500ff(98)
parport0: assign_addrs: aa5500ff(98)
parport0: Printer, Hewlett-Packard HP LaserJet 5MP
parport1: PC-style at 0x9400, irq 9 [PCSPP,EPP]
parport1: cpp_daisy: aa5500ff(18)
parport1: assign_addrs: aa5500ff(18)
parport1: Printer, EPSON Stylus Photo 1290
lp0: using parport0 (interrupt-driven).
lp1: using parport1 (interrupt-driven).
FAT: Using codepage cp850
FAT: Using IO charset iso8859-15
FAT: Using codepage cp850
FAT: Using IO charset iso8859-15
FAT: Using codepage cp850
FAT: Using IO charset iso8859-15
FAT: Using codepage cp850
FAT: Using IO charset iso8859-15
FAT: Using codepage cp850
FAT: Using IO charset iso8859-15
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
PCI: Found IRQ 4 for device 00:0a.0
PPP BSD Compression module registered
PPP Deflate Compression module registered
Debug: sleeping function called from illegal context at /linux2/usr/src/linux-2.5.x/include/asm/semaphore.h:119
df02dd04 c0114f02 c0241060 e093f800 00000077 de862c04 e0936386 e093f800
       00000077 df103c00 df02c000 00000200 00000200 de862c04 e0938151 dfe2d6c4
       00004140 00000200 e0938371 dfe2d6c4 00004140 00000200 deedf558 c016c3b6
Call Trace: [<c0114f02>] [<e093f800>] [<e0936386>] [<e093f800>] [<e0938151>] [<e0938371>] [<c016c3b6>] [<c016bf10>] [<c013b0de>] [<c014a8bb>] [<c01b5326>] [<c01d2188>] [<c01b69ae>] [<c01b8a32>] [<c01b8e09>] [<c01d2188>] [<c01295c8>] [<c01b5ea7>] [<c012980e>] [<c0113c20>] [<c01125ac>] [<c01abde0>] [<c013eb26>] [<c01472fa>] [<c014e643>] [<c0107253>]

    I hope this helps a little

Peter B
          .         .
          |\_-^^^-_/|
          / (|)_(|) \
         ( === X === )
          \  ._|_.  /
           ^-_   _-^
              °°°

