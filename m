Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbTIFMBY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 08:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbTIFMBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 08:01:24 -0400
Received: from tungsten.btinternet.com ([194.73.73.81]:57827 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id S261167AbTIFMBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 08:01:07 -0400
Message-ID: <3F59BE78.4080805@btopenworld.com>
Date: Sat, 06 Sep 2003 12:01:12 +0100
From: Subodh Shrivastava <subodh@btopenworld.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030901
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: [Bug 1190] New: oops on echo 4 > /proc/acpi/sleep]
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000501090200030809020004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000501090200030809020004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------000501090200030809020004
Content-Type: text/plain;
 name="ksymoops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksymoops.txt"

ksymoops 2.4.9 on i686 2.6.0-test4-mm6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test4-mm6/ (default)
     -m /usr/src/linux-2.6.0-test4-mm6/System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address fffffff4
c02b87e4
*pde = 00002067
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c02b87e4>]  Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010283
eax: 00000000   ebx: dfc32498     ecx: dfc32480       edx: ffffffe0
esi: 00000000   edi: c0360b26     ebp: 00000002       esp: dd297edc
ds: 007b        es: 007b       ss: 0068
Stack: 00000400 c0351409 c026c66c dfc32498 00000003 00000000 00000003 c026c6ca
       dfc32498 00000003 fffffff0 00000003 c013a005 00000003 00000000 c013a074
       00000001 00000000 c0139631 dceff810 00000000 dd297f56 c013af15 00000003
Call Trace:
 [<c026c66c>] subspend_device+0xfc/0x103
 [<c026c6ca>] device_suspend+0x57/0x79
 [<c013a005>] prepare+0x39/0x9c
 [<c013a074>] pm_suspend_disk+0xc/0xbc
 [<c0139631>] enter_state+0x9c/0xa0
 [<c013af15>] software_suspend+0x3b/0x42
 [<c0228621>] acpi_system_write_sleep+0xb4/0xcb
 [<c0158418>] vfs_write+0xbc/0x127
 [<c0158528>] sys_write+0x42/0x63
 [<c0336d33>] syscall_call+0x7/0xb
Code: 49 36 c0 eb ce c3 c3 83 ec 08 8b 54 24 0c 8b 42 70 3d a0 4e 3d c0 74 1a 81


>>EIP; c02b87e4 <usb_device_suspend+24/41>   <=====

>>ebx; dfc32498 <_end+1f7d71f8/3fba1d60>
>>ecx; dfc32480 <_end+1f7d71e0/3fba1d60>
>>edx; ffffffe0 <__kernel_rt_sigreturn+2ba0/????>
>>edi; c0360b26 <__func__.0+1cdb9/3db3f>
>>esp; dd297edc <_end+1ce3cc3c/3fba1d60>

Trace; c026c66c <suspend_device+fc/103>
Trace; c026c6ca <device_suspend+57/79>
Trace; c013a005 <prepare+39/9c>
Trace; c013a074 <pm_suspend_disk+c/bc>
Trace; c0139631 <enter_state+9c/a0>
Trace; c013af15 <software_suspend+3b/42>
Trace; c0228621 <acpi_system_write_sleep+b4/cb>
Trace; c0158418 <vfs_write+bc/127>
Trace; c0158528 <sys_write+42/63>
Trace; c0336d33 <syscall_call+7/b>

Code;  c02b87e4 <usb_device_suspend+24/41>
00000000 <_EIP>:
Code;  c02b87e4 <usb_device_suspend+24/41>   <=====
   0:   49                        dec    %ecx   <=====
Code;  c02b87e5 <usb_device_suspend+25/41>
   1:   36                        ss
Code;  c02b87e6 <usb_device_suspend+26/41>
   2:   c0 eb ce                  shr    $0xce,%bl
Code;  c02b87e9 <usb_device_suspend+29/41>
   5:   c3                        ret    
Code;  c02b87ea <usb_device_suspend+2a/41>
   6:   c3                        ret    
Code;  c02b87eb <usb_device_suspend+2b/41>
   7:   83 ec 08                  sub    $0x8,%esp
Code;  c02b87ee <usb_device_suspend+2e/41>
   a:   8b 54 24 0c               mov    0xc(%esp,1),%edx
Code;  c02b87f2 <usb_device_suspend+32/41>
   e:   8b 42 70                  mov    0x70(%edx),%eax
Code;  c02b87f5 <usb_device_suspend+35/41>
  11:   3d a0 4e 3d c0            cmp    $0xc03d4ea0,%eax
Code;  c02b87fa <usb_device_suspend+3a/41>
  16:   74 1a                     je     32 <_EIP+0x32>
Code;  c02b87fc <usb_device_suspend+3c/41>
  18:   81 00 00 00 00 00         addl   $0x0,(%eax)


1 error issued.  Results may not be reliable.

--------------000501090200030809020004
Content-Type: text/plain;
 name="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.txt"

Unable to handle kernel paging request at virtual address fffffff4
 Printing eip:
c02b87e4
*pde = 00002067
*pte = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:	0
EIP:	0060:[<c02b87e4>]	Not tainted VLI
EFLAGS:	00010283
EIP is at usb_device_suspend+0x24/0x41
eax: 00000000	ebx: dfc32498	ecx: dfc32480	edx: ffffffe0
esi: 00000000	edi: c0360b26	ebp: 00000002	esp: dd297edc
ds: 007b	es: 007b	ss: 0068
Process bash (pid: 3082, threadinfo=dd296000 task=df9af310)
Stack: 00000400 c0351409 c026c66c dfc32498 00000003 00000000 00000003 c026c6ca
       dfc32498 00000003 fffffff0 00000003 c013a005 00000003 00000000 c013a074
       00000001 00000000 c0139631 dceff810 00000000 dd297f56 c013af15 00000003
Call Trace:
 [<c026c66c>] subspend_device+0xfc/0x103
 [<c026c6ca>] device_suspend+0x57/0x79
 [<c013a005>] prepare+0x39/0x9c
 [<c013a074>] pm_suspend_disk+0xc/0xbc
 [<c0139631>] enter_state+0x9c/0xa0
 [<c013af15>] software_suspend+0x3b/0x42
 [<c0228621>] acpi_system_write_sleep+0xb4/0xcb
 [<c0158418>] vfs_write+0xbc/0x127
 [<c0158528>] sys_write+0x42/0x63
 [<c0336d33>] syscall_call+0x7/0xb

Code: 49 36 c0 eb ce c3 c3 83 ec 08 8b 54 24 0c 8b 42 70 3d a0 4e 3d c0 74 1a 81
 7a 74 84 8f 45 c0 74 11 8d 4a e8 89 c2 83 ea 20 74 07 <8b> 42 14 85 c0 75 06 31
 c0 83 c4 08 c3 8b 44 24 10 89 0c 24 89

--------------000501090200030809020004
Content-Type: text/plain;
 name="lspci.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.out"

00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 03)
00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 03)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 03)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 03)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 03)
00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 03)
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83)
00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
00:1f.1 IDE interface: Intel Corp. 82801DBM Ultra ATA Storage Controller (rev 03)
00:1f.3 SMBus: Intel Corp. 82801DB/DBM SMBus Controller (rev 03)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio Controller (rev 03)
00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem Controller (rev 03)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9] (rev 01)
02:02.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
02:04.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B Mini PCI Adapter (rev 04)
02:06.0 CardBus bridge: O2 Micro, Inc.: Unknown device 7114 (rev 20)
02:06.1 CardBus bridge: O2 Micro, Inc.: Unknown device 7114 (rev 20)
02:06.2 System peripheral: O2 Micro, Inc.: Unknown device 7110
02:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link)

--------------000501090200030809020004
Content-Type: message/rfc822;
 name="[Bug 1190] New: oops on echo 4 > /proc/acpi/sleep"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[Bug 1190] New: oops on echo 4 > /proc/acpi/sleep"

Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by lanthanum with esmtp (Exim 3.22 #23)
	id 19vaJM-0000K8-00
	for subodh@btopenworld.com; Sat, 06 Sep 2003 11:28:56 +0100
Received: from fire-1.osdl.org (air1.pdx.osdl.net [172.20.0.5])
	by mail.osdl.org (8.11.6/8.11.6) with ESMTP id h86ASco12209
	for <subodh@btopenworld.com>; Sat, 6 Sep 2003 03:28:38 -0700
Received: from fire-1.osdl.org (localhost [127.0.0.1])
	by fire-1.osdl.org (8.12.8/8.12.8) with ESMTP id h86ASZlT006262
	for <subodh@btopenworld.com>; Sat, 6 Sep 2003 03:28:36 -0700
Received: (from www@localhost)
	by fire-1.osdl.org (8.12.8/8.12.5/Submit) id h86AHW1L005785;
	Sat, 6 Sep 2003 03:17:32 -0700
Date: Sat, 6 Sep 2003 03:17:32 -0700
Message-Id: <200309061017.h86AHW1L005785@fire-1.osdl.org>
From: bugme-daemon@osdl.org
To: subodh@btopenworld.com
Subject: [Bug 1190] New: oops on echo 4 > /proc/acpi/sleep
X-Bugzilla-Reason: Reporter
X-Spam-Status: No, hits=-0.3 required=5 tests=BUGZILLA_BUG,NO_REAL_NAME
X-Spam-Checker-Version: SpamAssassin 2.55-osdl_revision__1.1__
X-Scanned-By: MIMEDefang 2.36

http://bugme.osdl.org/show_bug.cgi?id=1190

           Summary: oops on echo 4 > /proc/acpi/sleep
    Kernel Version: linux-2.6.0-test4-mm6
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: subodh@btopenworld.com


Distribution:Gentoo
Dmesg:

Linux version 2.6.0-test4-mm6 (root@subbu-gentoo) (gcc version 3.2.3 20030422
(Gentoo Linux 1.4 3.2.3-r2, propolice)) #4 Sat Sep 6 09:53:36 BST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff70000 (usable)
 BIOS-e820: 000000001ff70000 - 000000001ff7b000 (ACPI data)
 BIOS-e820: 000000001ff7b000 - 000000001ff80000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 130928
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126832 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 ACER                                      ) @ 0x000f5dc0
ACPI: RSDT (v001 ACER   Cardinal 0x20020514  LTP 0x00000000) @ 0x1ff74c61
ACPI: FADT (v001 ACER   Cardinal 0x20020514 PTL  0x0000001e) @ 0x1ff7af64
ACPI: BOOT (v001 ACER   Cardinal 0x20020514  LTP 0x00000001) @ 0x1ff7afd8
ACPI: DSDT (v001 ACER   Cardinal 0x20020514 MSFT 0x0100000d) @ 0x00000000
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: root=/dev/hda8 devfs=mount elevator=as video=radeonfb:off
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
current: c038e9c0
current->thread_info: c0412000
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1299.155 MHz processor.
Console: colour VGA+ 80x25
Memory: 514272k/523712k available (2270k kernel code, 8688k reserved, 870k data,
160k init, 0k highmem)
zapping low mappings.
Calibrating delay loop... 2564.09 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: a7e9fbbf 00000000 00000000 00000000
CPU:     After vendor identify, caps: a7e9fbbf 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU:     After all inits, caps: a7e9fbbf 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1300MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1298.0710 MHz.
..... host bus clock speed is 99.0900 MHz.
PM: Adding info for No Bus:legacy
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd732, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20030813
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:1d.0
PM: Adding info for pci:0000:00:1d.1
PM: Adding info for pci:0000:00:1d.2
PM: Adding info for pci:0000:00:1d.7
PM: Adding info for pci:0000:00:1e.0
PM: Adding info for pci:0000:00:1f.0
PM: Adding info for pci:0000:00:1f.1
PM: Adding info for pci:0000:00:1f.3
PM: Adding info for pci:0000:00:1f.5
PM: Adding info for pci:0000:00:1f.6
PM: Adding info for pci:0000:01:00.0
PM: Adding info for pci:0000:02:02.0
PM: Adding info for pci:0000:02:04.0
PM: Adding info for pci:0000:02:06.0
PM: Adding info for pci:0000:02:06.1
PM: Adding info for pci:0000:02:06.2
PM: Adding info for pci:0000:02:07.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs *10)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 10)
ACPI: PCI Interrupt Link [LNKH] (IRQs *10)
ACPI: Embedded Controller [EC0] (gpe 29)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: Power Resource [PFN0] (off)
ACPI: Power Resource [PFN1] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
pty: 256 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
speedstep-centrino: found "Intel(R) Pentium(R) M processor 1300MHz": max
frequency: 1300000kHz
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
udf: registering filesystem
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Fan [FAN0] (off)
ACPI: Fan [FAN1] (off)
ACPI: Processor [CPU0] (supports C1 C2 C3)
ACPI: Thermal Zone [THRM] (49 C)
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 256M @ 0xe0000000
[drm] Initialized radeon 1.9.0 20020828 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ICH4: chipset revision 3
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATCS04-0, ATA DISK drive
PM: Adding info for No Bus:ide0
Using anticipatory scheduling io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PM: Adding info for ide:0.0
hdc: UJDA740 DVD/CDRW, ATAPI CD/DVD-ROM drive
PM: Adding info for No Bus:ide1
ide1 at 0x170-0x177,0x376 on irq 15
PM: Adding info for ide:1.0
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/1768KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 >
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 10, pci mem e0854000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: enabled 64bit PCI DMA
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
PM: Adding info for usb:usb1
PM: Adding info for usb:1-0:0
hub 1-0:0: USB hub found
hub 1-0:0: 6 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci-hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci-hcd 0000:00:1d.0: irq 10, io base 00001800
uhci-hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
PM: Adding info for usb:usb2
PM: Adding info for usb:2-0:0
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
uhci-hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci-hcd 0000:00:1d.1: irq 5, io base 00001820
uhci-hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
PM: Adding info for usb:usb3
PM: Adding info for usb:3-0:0
hub 3-0:0: USB hub found
hub 3-0:0: 2 ports detected
uhci-hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci-hcd 0000:00:1d.2: irq 10, io base 00001840
uhci-hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
PM: Adding info for usb:usb4
PM: Adding info for usb:4-0:0
hub 4-0:0: USB hub found
hub 4-0:0: 2 ports detected
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/core/usb.c: registered new driver speedtch
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
PM: Reading swsusp image.
PM: Resume from disk failed.
ACPI: (supports S0 S3 S4 S5)
found reiserfs format "3.6" with standard journal
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x501
hub 2-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 2-0:0: new USB device on port 2, assigned address 2
PM: Adding info for usb:2-2
PM: Adding info for usb:2-2:0
PM: Adding info for usb:2-2:1
PM: Adding info for usb:2-2:2
Reiserfs journal params: device hda8, size 8192, journal first block 18, max
trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda8) for (hda8)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 160k freed
Adding 1044184k swap on /dev/hda6.  Priority:-1 extents:1
Synaptics Touchpad, model: 1
 Firmware: 5.8
 180 degree mounted touchpad
 Sensor: 29
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: Synaptics Synaptics TouchPad on isa0060/serio1
b44.c:v0.9 (Jul 14, 2003)
eth0: Broadcom 4400 10/100BaseT Ethernet 00:c0:9f:24:b3:e9
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda9, size 8192, journal first block 18, max
trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda9) for (hda9)
Using r5 hash to sort names
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49324 usecs
intel8x0: clocking to 48000
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
usb 2-2: bulk timeout on ep5in
usbfs: USBDEVFS_BULK failed dev 2 ep 0x85 len 512 ret -110
usbfs: USBDEVFS_CONTROL failed cmd modem_run dev 2 rqt 192 rq 18 len 1 ret -32
usbfs: process 3348 (modem_run) did not claim interface 0 before use
blk: queue dfd01600, I/O limit 4095Mb (mask 0xffffffff)


Problem Description: When ever i try S3 or S4 sleep state my laptop generates
oops. NUM, CAP and Scroll keys work. I tried magic SysRq but couldn't get the
oops to be dumped on my disk.

Steps to reproduce: echo 4 > /proc/acpi/sleep or echo 3 > /proc/acpi/sleep

------- You are receiving this mail because: -------
You reported the bug, or are watching the reporter.


--------------000501090200030809020004--

