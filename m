Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130420AbRBEP6a>; Mon, 5 Feb 2001 10:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130622AbRBEP6T>; Mon, 5 Feb 2001 10:58:19 -0500
Received: from think.faceprint.com ([166.90.149.11]:21766 "EHLO
	think.faceprint.com") by vger.kernel.org with ESMTP
	id <S130420AbRBEP6F>; Mon, 5 Feb 2001 10:58:05 -0500
Message-ID: <3A7ECD8C.B847B770@faceprint.com>
Date: Mon, 05 Feb 2001 10:58:04 -0500
From: Nathan Walp <faceprint@faceprint.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OOPSes and BUGs everywhere (2.4.0)
Content-Type: multipart/mixed;
 boundary="------------E494D745863BF78A34D83759"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E494D745863BF78A34D83759
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I'm gonna type fast and send this as soon as possible, cuz I'm not sure
how long i'll be able to stay up.  I'm OOPSing and BUGging (is that a
word?) like crazy, and I can't figure it out.  I thought it was the BIOS
upgrade I did, but downgrading didn't do anything.  System is 1.1GHz
Tbird on Asus A7V, mixed SCSI and IDE.  I hope to post a follow-up w/
more info shortly, but here's the bulk of the info.


Nathan
--------------E494D745863BF78A34D83759
Content-Type: text/plain; charset=us-ascii;
 name="oops.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.log"

ksymoops 2.3.7 on i686 2.4.0.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0/ (default)
     -m /boot/System.map-2.4.0 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Feb  4 23:23:01 patience kernel: aec671x_detect: 
Feb  4 23:23:01 patience kernel: ds: no socket drivers loaded!
Feb  5 00:42:55 patience kernel: aec671x_detect: 
Feb  5 08:52:17 patience kernel: aec671x_detect: 
Feb  5 10:40:46 patience kernel: Unable to handle kernel paging request at virtual address 8f09897c
Feb  5 10:40:46 patience kernel: c0114a59
Feb  5 10:40:46 patience kernel: *pde = 00000000
Feb  5 10:40:46 patience kernel: Oops: 0002
Feb  5 10:40:46 patience kernel: CPU:    0
Feb  5 10:40:46 patience kernel: EIP:    0010:[remove_wait_queue+9/32]
Feb  5 10:40:46 patience kernel: EFLAGS: 00010097
Feb  5 10:40:46 patience kernel: eax: 00000297   ebx: c7a42050   ecx: cf098978   edx: 8f098978
Feb  5 10:40:46 patience kernel: esi: c7a42000   edi: c7a42008   ebp: cf463f70   esp: cf463f2c
Feb  5 10:40:46 patience kernel: ds: 0018   es: 0018   ss: 0018
Feb  5 10:40:46 patience kernel: Process X (pid: 223, stackpage=cf463000)
Feb  5 10:40:46 patience kernel: Stack: c013ece4 00000000 ce7df2c0 00000001 c013f018 cf463f68 00000008 00000020 
Feb  5 10:40:46 patience kernel:        c14ddd40 00000304 00800000 cf462000 00001876 00000018 00000000 00000000 
Feb  5 10:40:46 patience kernel:        c7a42000 00000000 c013f3a2 00000018 cf463fa8 cf463fa4 cf462000 00000000 
Feb  5 10:40:46 patience kernel: Call Trace: [poll_freewait+36/80] [do_select+456/480] [sys_select+834/1152] [system_call+51/56] 
Feb  5 10:40:46 patience kernel: Code: 89 4a 04 89 11 50 9d c3 eb 0d 90 90 90 90 90 90 90 90 90 90 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 4a 04                  mov    %ecx,0x4(%edx)
Code;  00000003 Before first symbol
   3:   89 11                     mov    %edx,(%ecx)
Code;  00000005 Before first symbol
   5:   50                        push   %eax
Code;  00000006 Before first symbol
   6:   9d                        popf   
Code;  00000007 Before first symbol
   7:   c3                        ret    
Code;  00000008 Before first symbol
   8:   eb 0d                     jmp    17 <_EIP+0x17> 00000017 Before first symbol
Code;  0000000a Before first symbol
   a:   90                        nop    
Code;  0000000b Before first symbol
   b:   90                        nop    
Code;  0000000c Before first symbol
   c:   90                        nop    
Code;  0000000d Before first symbol
   d:   90                        nop    
Code;  0000000e Before first symbol
   e:   90                        nop    
Code;  0000000f Before first symbol
   f:   90                        nop    
Code;  00000010 Before first symbol
  10:   90                        nop    
Code;  00000011 Before first symbol
  11:   90                        nop    
Code;  00000012 Before first symbol
  12:   90                        nop    
Code;  00000013 Before first symbol
  13:   90                        nop    

Feb  5 10:40:46 patience kernel: kernel BUG at page_alloc.c:72!
Feb  5 10:40:46 patience kernel: invalid operand: 0000
Feb  5 10:40:46 patience kernel: CPU:    0
Feb  5 10:40:46 patience kernel: EIP:    0010:[__free_pages_ok+34/784]
Feb  5 10:40:46 patience kernel: EFLAGS: 00010282
Feb  5 10:40:46 patience kernel: eax: 0000001f   ebx: c12628b0   ecx: c02cf988   edx: 00000000
Feb  5 10:40:46 patience kernel: esi: 00000005   edi: cdfc8404   ebp: 00000000   esp: cdfcbefc
Feb  5 10:40:46 patience kernel: ds: 0018   es: 0018   ss: 0018
Feb  5 10:40:46 patience kernel: Process enlightenment (pid: 259, stackpage=cdfcb000)
Feb  5 10:40:46 patience kernel: Stack: c0271805 c0271993 00000048 c12628b0 00000005 cdfc8404 ce1dc080 c1044010 
Feb  5 10:40:46 patience kernel:        c02d0d20 00000212 ffffffff 00006775 c012c80a c012ccfa c12628b0 00000005 
Feb  5 10:40:46 patience kernel:        c0121a39 c12628b0 ce311700 cdf7b0c0 4001d000 00008000 0041d000 4041d000 
Feb  5 10:40:46 patience kernel: Call Trace: [__free_pages+26/32] [free_page_and_swap_cache+170/176] [zap_page_range+425/576] [exit_mmap+181/272] [mmput+32/64] [do_exit+157/560] [sys_exit+14/16] 
Feb  5 10:40:46 patience kernel: Code: 0f 0b 83 c4 0c 83 7b 08 00 74 16 6a 4a 68 93 19 27 c0 68 05 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 0c                  add    $0xc,%esp
Code;  00000005 Before first symbol
   5:   83 7b 08 00               cmpl   $0x0,0x8(%ebx)
Code;  00000009 Before first symbol
   9:   74 16                     je     21 <_EIP+0x21> 00000021 Before first symbol
Code;  0000000b Before first symbol
   b:   6a 4a                     push   $0x4a
Code;  0000000d Before first symbol
   d:   68 93 19 27 c0            push   $0xc0271993
Code;  00000012 Before first symbol
  12:   68 05 00 00 00            push   $0x5

Feb  5 10:50:59 patience kernel: Unable to handle kernel paging request at virtual address 8ef9797c
Feb  5 10:50:59 patience kernel: c0114a59
Feb  5 10:50:59 patience kernel: *pde = 00000000
Feb  5 10:50:59 patience kernel: Oops: 0002
Feb  5 10:50:59 patience kernel: CPU:    0
Feb  5 10:50:59 patience kernel: EIP:    0010:[remove_wait_queue+9/32]
Feb  5 10:50:59 patience kernel: EFLAGS: 00010097
Feb  5 10:50:59 patience kernel: eax: 00000297   ebx: c7312050   ecx: cef97978   edx: 8ef97978
Feb  5 10:50:59 patience kernel: esi: c7312000   edi: c7312008   ebp: cf6c7f70   esp: cf6c7f2c
Feb  5 10:50:59 patience kernel: ds: 0018   es: 0018   ss: 0018
Feb  5 10:50:59 patience kernel: Process X (pid: 225, stackpage=cf6c7000)
Feb  5 10:50:59 patience kernel: Stack: c013ece4 00000000 cc730b40 00000001 c013f018 cf6c7f68 00000008 00000020 
Feb  5 10:50:59 patience kernel:        c14ddf40 00000304 00400000 cf6c6000 00002edd 00000017 00000000 00000000 
Feb  5 10:50:59 patience kernel:        c7312000 00000000 c013f3a2 00000017 cf6c7fa8 cf6c7fa4 cf6c6000 00000000 
Feb  5 10:50:59 patience kernel: Call Trace: [poll_freewait+36/80] [do_select+456/480] [sys_select+834/1152] [system_call+51/56] 
Feb  5 10:50:59 patience kernel: Code: 89 4a 04 89 11 50 9d c3 eb 0d 90 90 90 90 90 90 90 90 90 90 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 4a 04                  mov    %ecx,0x4(%edx)
Code;  00000003 Before first symbol
   3:   89 11                     mov    %edx,(%ecx)
Code;  00000005 Before first symbol
   5:   50                        push   %eax
Code;  00000006 Before first symbol
   6:   9d                        popf   
Code;  00000007 Before first symbol
   7:   c3                        ret    
Code;  00000008 Before first symbol
   8:   eb 0d                     jmp    17 <_EIP+0x17> 00000017 Before first symbol
Code;  0000000a Before first symbol
   a:   90                        nop    
Code;  0000000b Before first symbol
   b:   90                        nop    
Code;  0000000c Before first symbol
   c:   90                        nop    
Code;  0000000d Before first symbol
   d:   90                        nop    
Code;  0000000e Before first symbol
   e:   90                        nop    
Code;  0000000f Before first symbol
   f:   90                        nop    
Code;  00000010 Before first symbol
  10:   90                        nop    
Code;  00000011 Before first symbol
  11:   90                        nop    
Code;  00000012 Before first symbol
  12:   90                        nop    
Code;  00000013 Before first symbol
  13:   90                        nop    


1 warning issued.  Results may not be reliable.

--------------E494D745863BF78A34D83759
Content-Type: text/plain; charset=iso-8859-1;
 name="dmesg.log"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="dmesg.log"

Linux version 2.4.0 (root@patience) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #4 Mon Feb 5 08:57:32 EST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009e800 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000001800 @ 000000000009e800 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 000000000feec000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000003000 @ 000000000ffec000 (ACPI data)
 BIOS-e820: 0000000000010000 @ 000000000ffef000 (reserved)
 BIOS-e820: 0000000000001000 @ 000000000ffff000 (ACPI NVS)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009f800 for 4096 bytes.
On node 0 totalpages: 65516
zone(0): 4096 pages.
zone(1): 61420 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01444000)
Kernel command line: BOOT_IMAGE=linux ro root=801
Initializing CPU#0
Detected 1109.919 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2215.11 BogoMIPS
Memory: 254924k/262064k available (1427k kernel code, 6748k reserved, 524k data, 192k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf10f0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:04.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.3 present.
49 structures occupying 1371 bytes.
DMI table at 0x000F28B0.
BIOS Vendor: Award Software, Inc.
BIOS Version: ASUS A7V ACPI BIOS Revision 1004
BIOS Release: 08/21/2000
System Vendor: System Manufacturer.
Product Name: System Name.
Version System Version.
Serial Number SYS-1234567890.
Board Vendor: ASUSTeK Computer INC..
Board Name: <A7V>.
Board Version: REV 1.xx.
Asset Tag: Asset-1234567890.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 8
0x378: readIntrThreshold is 8
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: possible IRQ conflict!
0x378: ECP port cfgA=0x10 cfgB=0x00
0x378: ECP settings irq=<none or set by other means> dma=<none or set by other means>
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
parport0: cpp_daisy: aa5500ff(08)
parport0: assign_addrs: aa5500ff(08)
parport0: cpp_daisy: aa5500ff(08)
parport0: assign_addrs: aa5500ff(08)
parport0: Printer, HEWLETT-PACKARD DESKJET
parport_pc: Via 686A parallel port: io=0x378, irq=7, dma=3
pty: 256 Unix98 ptys configured
lp0: using parport0 (interrupt-driven).
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a IDE UDMA66 controller on pci0:4.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
PDC20265: IDE controller on PCI bus 00 dev 88
PCI: Found IRQ 10 for device 00:11.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x7800-0x7807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0x7808-0x780f, BIOS settings: hdg:pio, hdh:pio
hda: KENWOOD CD-ROM UCR-421 V221G, ATAPI CDROM drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hde: IBM-DTLA-307045, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0x9000-0x9007,0x8802 on irq 10
hde: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(100)
hda: ATAPI 68X CD-ROM drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host2/bus0/target0/lun0: [PTBL] [5606/255/63] p1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
udf: registering filesystem
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Linux Tulip driver version 0.9.13 (January 2, 2001)
PCI: Found IRQ 5 for device 00:0a.0
eth0: Lite-On 82c168 PNIC rev 32 at 0x9800, 00:A0:CC:61:CC:D2, IRQ 5.
eth0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 9 for device 00:0d.0
PCI: The same IRQ used for device 00:04.2
PCI: The same IRQ used for device 00:04.3
PCI: The same IRQ used for device 00:09.0
(scsi0) <Adaptec AIC-7892 Ultra 160/m SCSI host adapter> found at PCI 0/13/0
(scsi0) Wide Channel, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 392 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7892 Ultra 160/m SCSI host adapter>
(scsi0:0:0:0) Synchronous at 160.0 Mbyte/sec, offset 31.
  Vendor: SEAGATE   Model: ST318436LW        Rev: 0005
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:0:4:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: iomega    Model: jaz 1GB           Rev: G.55
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi0:0:6:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: HP        Model: CD-Writer+ 9200   Rev: 1.0c
  Type:   CD-ROM                             ANSI SCSI revision: 04
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
Detected scsi removable disk sdb at scsi0, channel 0, id 4, lun 0
SCSI device sda: 35885168 512-byte hdwr sectors (18373 MB)
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
sdb : READ CAPACITY failed.
sdb : status = 1, message = 00, host = 0, driver = 28 
sdb : extended sense code = 2 
sdb : block size assumed to be 512 bytes, disk size 1GB.  
 /dev/scsi/host0/bus0/target4/lun0: I/O error: dev 08:10, sector 0
 unable to read partition table
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 6, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Creative EMU10K1 PCI Audio Driver, version 0.7, 08:54:57 Feb  5 2001
PCI: Found IRQ 9 for device 00:09.0
PCI: The same IRQ used for device 00:04.2
PCI: The same IRQ used for device 00:04.3
PCI: The same IRQ used for device 00:0d.0
emu10k1: EMU10K1 rev 5 model 0x8040 found, IO at 0xa400-0xa41f, IRQ 9
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.251 $ time 08:55:04 Feb  5 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 9 for device 00:04.2
PCI: The same IRQ used for device 00:04.3
PCI: The same IRQ used for device 00:09.0
PCI: The same IRQ used for device 00:0d.0
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 9 for device 00:04.3
PCI: The same IRQ used for device 00:04.2
PCI: The same IRQ used for device 00:09.0
PCI: The same IRQ used for device 00:0d.0
usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 9
usb-uhci.c: Detected 2 ports
hub.c: USB new device connect on bus1/1, assigned device number 2
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hid
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 192k freed
usb-uhci.c: interrupt, status 3, frame# 187
event0: Event device for input0
mouse0: PS/2 mouse device for input0
input0: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Optical] on usb1:2.0
hub.c: USB new device connect on bus1/2, assigned device number 4
usb.c: USB device 4 (vend/prod 0x40a/0x2) is not claimed by any active driver.
hub.c: USB new device connect on bus2/2, assigned device number 5
hub.c: USB hub found
hub.c: 4 ports detected
Device not ready.  Make sure there is a disc in the drive.
VFS: Disk change detected on device 08:10
sdb : READ CAPACITY failed.
sdb : status = 1, message = 00, host = 0, driver = 28 
sdb : extended sense code = 2 
sdb : block size assumed to be 512 bytes, disk size 1GB.  
 /dev/scsi/host0/bus0/target4/lun0: I/O error: dev 08:10, sector 0
Adding Swap: 200804k swap-space (priority -1)
eth0: no IPv6 routers present
eth0: no IPv6 routers present

--------------E494D745863BF78A34D83759--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
