Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271848AbRHUUMf>; Tue, 21 Aug 2001 16:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271846AbRHUUMV>; Tue, 21 Aug 2001 16:12:21 -0400
Received: from [145.254.145.253] ([145.254.145.253]:20463 "HELO
	schottelius.org") by vger.kernel.org with SMTP id <S271847AbRHUUME>;
	Tue, 21 Aug 2001 16:12:04 -0400
Message-ID: <3B82C02D.5AE30E4@pcsystems.de>
Date: Tue, 21 Aug 2001 22:10:21 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Carlos E Gorges <carlos@techlinux.com.br>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: aha152x problem (and NULL POINTER)
In-Reply-To: <3B1285CC.EB151D8A@pcsystems.de> <01053115394601.25723@shark.techlinux>
Content-Type: multipart/mixed;
 boundary="------------8AD2A0617D9C46C96CEED7AC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8AD2A0617D9C46C96CEED7AC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Sorry for the late reply!

I retried to load the card.
I recieved a NULL pointer.
The modprobe call

 317 pts/0    D      0:01 modprobe aha152x io=0x140 irq=9

does never return.

Nothing happens.

ksymoops output attached.

Nico


Carlos E Gorges wrote:

> On Mon 28 May 2001 13:07, Nico Schottelius wrote:
> > Hello!
> >
> > I tried to load thie aha152x modules:
>
> Hi, please add nmi_watchdog=1 to kernel parameter ( append in lilo ) and try again.
> send oops to lkml or to me.
>
> > modprobe aha152x io=0x140 irq=9 (which is correct)
> > entries in /proc/scsi are generated,
> > but the modprobe hangs and is unkillable.
> > aha152x reports scsi discs to the kernel messages,
> > although there are none connected to it.
> >
> > I tried to use a scanner, but it it impossible
> > to work with the controller.
> >
> > Did I miss any patches/ fixes ?
> >
> >
> > Nico
> >
> > using 2.4.4
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/



--------------8AD2A0617D9C46C96CEED7AC
Content-Type: text/plain; charset=us-ascii;
 name="dmesg2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg2"

Linux version 2.4.7 (root@eiche) (gcc version 2.95.2 19991024 (release)) #4 Tue Oct 2 16:55:42 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=new ro root=801 vga=0x0301 nmi_watchdog=1
Initializing CPU#0
Detected 399.321 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 796.26 BogoMIPS
Memory: 255276k/262144k available (1254k kernel code, 6484k reserved, 434k data, 192k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU:             Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Pentium II (Deschutes) stepping 03
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfacd0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
devfs: v0.107 (20010709) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
ACPI: APM is already active, exiting
rivafb: RIVA MTRR set to ON
Console: switching to colour frame buffer device 80x30
rivafb: PCI nVidia NV3 framebuffer ver 0.9.2a (RIVA-128, 8MB @ 0xE6000000)
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169493kB/56497kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: SAMSUNG SV3064D, ATA DISK drive
hdc: CD-532E-B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 59794560 sectors (30615 MB) w/434KiB Cache, CHS=3722/255/63
hdc: ATAPI 32X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 10 for device 00:0c.0
PCI: Sharing IRQ 10 with 00:08.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
        <Adaptec aic7880 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/255 SCBs

  Vendor: IBM       Model: DNES-309170W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
  Vendor: HP        Model: HP35480A          Rev: T503
  Type:   Sequential-Access                  ANSI SCSI revision: 02
(scsi0:A:4): 5.000MB/s transfers (5.000MHz, offset 8)
st: bufsize 32768, wrt 30720, max init. buffers 4, s/g segs 16.
Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 192k freed
Adding Swap: 205816k swap-space (priority -1)
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on sd(8,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on sd(8,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:03) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
PCI: Found IRQ 10 for device 00:08.0
PCI: Sharing IRQ 10 with 00:0c.0
3c59x.c:LK1.1.15 6 June 2001  Donald Becker and others. http://www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:08.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xa400,  00:60:08:50:b3:45, IRQ 10
  product code 4b4b rev 00.0 date 08-12-97
  8K word-wide RAM 3:5 Rx:Tx split, autoselect/MII interface.
  MII transceiver found at address 24, status 786f.
  Enabling bus-master transmits and whole-frame receives.
00:08.0: scatter/gather enabled. h/w checksums disabled
eth0: first available media type: MII
isapnp: Scanning for PnP cards...
isapnp: Card 'Adaptec AVA-1505AE'
isapnp: 1 Plug & Play card detected total
aha152x: BIOS test: passed, detected 1 controller(s)
aha152x: resetting bus...
aha152x1: vital data: rev=3, io=0x140 (0x140/0x140), irq=9, scsiid=7, reconnect=enabled, parity=enabled, synchronous=enabled, delay=1000, extended translation=disabled
aha152x1: trying software interrupt, ok.
scsi1 : Adaptec 152x SCSI driver; $Revision: 2.4 $
aha152x: timer expired
Unable to handle kernel NULL pointer dereference at virtual address 000000fb
 printing eip:
d2991571
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d2991571>]
EFLAGS: 00010082
eax: 00000000   ebx: c8149dc8   ecx: c8147000   edx: c864e800
esi: 00000000   edi: 00000086   ebp: c864e87c   esp: c8149f54
ds: 0018   es: 0018   ss: 0018
Process scsi_eh_1 (pid: 318, stackpage=c8149000)
Stack: 00000286 c864e800 00000000 c8147200 d299160f c864e800 c864e87c 00000286 
       c8147200 c01c6567 c8147200 00002003 00000000 c01c6b87 c8147200 c8148000 
       c8149fdc c8149fdc c864e800 c8149fe8 c8149fe8 c8147000 00000000 c01c702e 
Call Trace: [<c01c6567>] [<c01c6b87>] [<c01c702e>] [<c0105454>] 

Code: f6 80 fb 00 00 00 10 75 70 8b 4d 00 31 d2 eb 0a 89 ca 8b 82 


--------------8AD2A0617D9C46C96CEED7AC
Content-Type: text/plain; charset=us-ascii;
 name="ksymoutput"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksymoutput"

ksymoops 0.7c on i686 2.4.7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.7/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_cast_buffer) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_copy_to_buffer) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_evaluate_object) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_evaluate_reference_list) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_evaluate_simple_integer) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_extract_package_data) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_get_device_context) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_get_device_info) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_get_device_power_state) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_get_device_status) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_get_node) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_osl_generate_event) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_proc_root) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_register_driver) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_request) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_search) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_set_device_power_state) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_unregister_driver) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_fadt_R__ver_acpi_fadt not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol __module_author  , aha152x says d2995247, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997907.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_description  , aha152x says d2995260, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997920.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_aha152x  , aha152x says d29954cc, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997b8c.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_aha152x1  , aha152x says d2995512, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997bd2.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_delay  , aha152x says d2995449, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997b09.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_aha152x  , aha152x says d29954e0, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997ba0.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_aha152x1  , aha152x says d2995540, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997c00.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_delay  , aha152x says d2995460, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997b20.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_exttrans  , aha152x says d29954a0, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997b60.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_io  , aha152x says d29952c0, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997980.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_irq  , aha152x says d2995300, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d29979c0.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_parity  , aha152x says d29953e0, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997aa0.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_reconnect  , aha152x says d2995380, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997a40.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_scsiid  , aha152x says d2995340, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997a00.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_sync  , aha152x says d2995420, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997ae0.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_exttrans  , aha152x says d2995481, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997b41.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_io  , aha152x says d2995297, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997957.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_irq  , aha152x says d29952eb, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d29979ab.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_parity  , aha152x says d29953b0, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997a70.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_reconnect  , aha152x says d2995367, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997a27.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_scsiid  , aha152x says d2995327, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d29979e7.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_sync  , aha152x says d2995401, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997ac1.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_author  , 3c59x says d2984960, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985ac0.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_description  , 3c59x says d29849a0, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985b00.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_compaq_device_id  , 3c59x says d2984ab4, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985c14.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_compaq_ioaddr  , 3c59x says d2984a8d, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985bed.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_compaq_irq  , 3c59x says d2984aa2, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985c02.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_debug  , 3c59x says d29849ea, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985b4a.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_compaq_device_id  , 3c59x says d2984e60, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985fc0.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_compaq_ioaddr  , 3c59x says d2984da0, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985f00.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_compaq_irq  , 3c59x says d2984e00, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985f60.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_debug  , 3c59x says d2984ae0, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985c40.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_enable_wol  , 3c59x says d2984c80, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985de0.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_flow_ctrl  , 3c59x says d2984c20, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985d80.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_full_duplex  , 3c59x says d2984b80, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985ce0.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_hw_checksums  , 3c59x says d2984bc0, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985d20.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_max_interrupt_work  , 3c59x says d2984d40, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985ea0.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_options  , 3c59x says d2984b20, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985c80.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_rx_copybreak  , 3c59x says d2984ce0, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985e40.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_watchdog  , 3c59x says d2984ec0, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2986020.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_enable_wol  , 3c59x says d2984a4a, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985baa.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_flow_ctrl  , 3c59x says d2984a36, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985b96.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_full_duplex  , 3c59x says d2984a09, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985b69.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_hw_checksums  , 3c59x says d2984a1f, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985b7f.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_max_interrupt_work  , 3c59x says d2984a73, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985bd3.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_options  , 3c59x says d29849f7, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985b57.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_rx_copybreak  , 3c59x says d2984a5f, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985bbf.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_watchdog  , 3c59x says d2984acc, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985c2c.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Unable to handle kernel NULL pointer dereference at virtual address 000000fb
d2991571
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d2991571>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: 00000000   ebx: c8149dc8   ecx: c8147000   edx: c864e800
esi: 00000000   edi: 00000086   ebp: c864e87c   esp: c8149f54
ds: 0018   es: 0018   ss: 0018
Process scsi_eh_1 (pid: 318, stackpage=c8149000)
Stack: 00000286 c864e800 00000000 c8147200 d299160f c864e800 c864e87c 00000286 
       c8147200 c01c6567 c8147200 00002003 00000000 c01c6b87 c8147200 c8148000 
       c8149fdc c8149fdc c864e800 c8149fe8 c8149fe8 c8147000 00000000 c01c702e 
Call Trace: [<c01c6567>] [<c01c6b87>] [<c01c702e>] [<c0105454>] 
Code: f6 80 fb 00 00 00 10 75 70 8b 4d 00 31 d2 eb 0a 89 ca 8b 82 

>>EIP; d2991571 <[aha152x]free_hard_reset_SCs+21/ac>   <=====
Trace; c01c6567 <scsi_try_bus_reset+3b/88>
Trace; c01c6b87 <scsi_unjam_host+357/72c>
Trace; c01c702e <scsi_error_handler+d2/134>
Trace; c0105454 <kernel_thread+28/38>
Code;  d2991571 <[aha152x]free_hard_reset_SCs+21/ac>
00000000 <_EIP>:
Code;  d2991571 <[aha152x]free_hard_reset_SCs+21/ac>   <=====
   0:   f6 80 fb 00 00 00 10      testb  $0x10,0xfb(%eax)   <=====
Code;  d2991578 <[aha152x]free_hard_reset_SCs+28/ac>
   7:   75 70                     jne    79 <_EIP+0x79> d29915ea <[aha152x]free_hard_reset_SCs+9a/ac>
Code;  d299157a <[aha152x]free_hard_reset_SCs+2a/ac>
   9:   8b 4d 00                  mov    0x0(%ebp),%ecx
Code;  d299157d <[aha152x]free_hard_reset_SCs+2d/ac>
   c:   31 d2                     xor    %edx,%edx
Code;  d299157f <[aha152x]free_hard_reset_SCs+2f/ac>
   e:   eb 0a                     jmp    1a <_EIP+0x1a> d299158b <[aha152x]free_hard_reset_SCs+3b/ac>
Code;  d2991581 <[aha152x]free_hard_reset_SCs+31/ac>
  10:   89 ca                     mov    %ecx,%edx
Code;  d2991583 <[aha152x]free_hard_reset_SCs+33/ac>
  12:   8b 82 00 00 00 00         mov    0x0(%edx),%eax


68 warnings issued.  Results may not be reliable.


--------------8AD2A0617D9C46C96CEED7AC--

