Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262323AbSJKCdo>; Thu, 10 Oct 2002 22:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262326AbSJKCdo>; Thu, 10 Oct 2002 22:33:44 -0400
Received: from ip68-4-86-174.oc.oc.cox.net ([68.4.86.174]:19182 "EHLO
	ip68-4-86-174.oc.oc.cox.net") by vger.kernel.org with ESMTP
	id <S262323AbSJKCdl>; Thu, 10 Oct 2002 22:33:41 -0400
Date: Thu, 10 Oct 2002 19:39:26 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] pl2303 oops in 2.4.20-pre10 (and 2.5 too)
Message-ID: <20021011023925.GA9142@ip68-4-86-174.oc.oc.cox.net>
References: <20021009233624.GA17162@ip68-4-86-174.oc.oc.cox.net> <20021009235332.GA19351@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021009235332.GA19351@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 04:53:32PM -0700, Greg KH wrote:
> Can you enable debugging in the pl2303 driver (by loading it with
> "debug=1") and send the kernel debug log for when the oops happens.

Since it's a monolithic kernel, I recompiled with
CONFIG_USB_SERIAL_DEBUG enabled. Here's the dmesg output, followed by
the decoded oops.

-Barry K. Nathan <barryn@pobox.com>

---dmesg begins here---
Linux version 2.4.20-pre10 (barryn@ip68-4-86-174.oc.oc.cox.net) (gcc version 3.2 (Mandrake Linux 9.0 3.2-1mdk)) #1 Thu Oct 10 12:19:24 PDT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fe00000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
254MB LOWMEM available.
On node 0 totalpages: 65024
zone(0): 4096 pages.
zone(1): 60928 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=bzimage root=/dev/hda6 vga=0 
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 533.398 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1064.96 BogoMIPS
Memory: 254940k/260096k available (1223k kernel code, 4772k reserved, 418k data, 92k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
CPU:             Common caps: 0183fbff 00000000 00000000 00000000
CPU: Intel Celeron (Mendocino) stepping 05
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 533.4058 MHz.
..... host bus clock speed is 66.6756 MHz.
cpu: 0, clocks: 666756, slice: 333378
CPU0<T0:666752,T1:333360,D:14,S:333378,C:666756>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb640, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router SIS [1039/0008] at 00:01.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller on PCI bus 00 dev 01
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS620
    ide0: BM-DMA at 0x4000-0x4007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x4008-0x400f, BIOS settings: hdc:DMA, hdd:DMA
hda: SAMSUNG SV4084H, ATA DISK drive
hdd: CD-ROM Drive/F5E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c02ddfa4, I/O limit 4095Mb (mask 0xffffffff)
hda: setmax LBA 79730784, native  62500000
hda: 62500000 sectors (32000 MB) w/426KiB Cache, CHS=3890/255/63, UDMA(66)
hdd: ATAPI 52X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
pcnet32.c:v1.27a 10.02.2002 tsbogend@alpha.franken.de
PCI: Found IRQ 11 for device 00:0b.0
pcnet32: PCnet/FAST 79C971 at 0xe000, 00 60 b0 fc 62 bb
    tx_start_pt(0x0c00):~220 bytes, BCR18(9861):BurstWrEn BurstRdEn NoUFlow 
    SRAMSIZE=0x7f00, SRAM_BND=0x3f00, assigned IRQ 11.
eth0: registered as PCnet/FAST 79C971
PCI: Found IRQ 10 for device 00:0d.0
pcnet32: PCnet/FAST 79C971 at 0xe400, 00 60 b0 fc 62 40
    tx_start_pt(0x0c00):~220 bytes, BCR18(9861):BurstWrEn BurstRdEn NoUFlow 
    SRAMSIZE=0x7f00, SRAM_BND=0x3f00, assigned IRQ 10.
eth1: registered as PCnet/FAST 79C971
pcnet32: 2 cards_found.
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xd0800000, IRQ 12
usb-ohci.c: usb-00:01.2, Silicon Integrated Systems [SiS] 7001
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver serial
usbserial.c: USB Serial Driver core v1.4
usbserial.c: USB Serial support registered for PL-2303
pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.9
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
ip_conntrack version 2.1 (2032 buckets, 16256 max) - 288 bytes per conntrack
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 92k freed
hub.c: new USB device 00:01.2-2, assigned address 2
usbserial.c: descriptor matches
usbserial.c: found interrupt in
usbserial.c: PL-2303 converter detected
usbserial.c: get_free_serial 1
usbserial.c: get_free_serial - minor base = 0
usbserial.c: usb_serial_probe - setting up 1 port structures for this device
usbserial.c: PL-2303 converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
usbserial.c: descriptor matches
usbserial.c: found bulk out
usbserial.c: found bulk in
usbserial.c: found interrupt in for Prolific device on separate interface
usbserial.c: PL-2303 converter detected
usbserial.c: get_free_serial 1
usbserial.c: get_free_serial - minor base = 1
usbserial.c: usb_serial_probe - setting up 1 port structures for this device
usbserial.c: PL-2303 converter now attached to ttyUSB1 (or usb/tts/1 for devfs)
Sorry: masquerading timeouts set 5DAYS/2MINS/60SECS
microcode: CPU0 updated from revision 2 to 3, date=05051999
usbserial.c: serial_open
pl2303.c: pl2303_open -  port 0
pl2303.c: 0xc0:0x1:0x8484:0x0  1 - 0
pl2303.c: 0x40:0x1:0x404:0x0  0
pl2303.c: 0xc0:0x1:0x8484:0x0  1 - 0
pl2303.c: 0xc0:0x1:0x8383:0x0  1 - 7b
pl2303.c: 0xc0:0x1:0x8484:0x0  1 - 0
pl2303.c: 0x40:0x1:0x404:0x1  0
pl2303.c: 0xc0:0x1:0x8484:0x0  1 - 0
pl2303.c: 0xc0:0x1:0x8383:0x0  1 - 6
pl2303.c: 0x40:0x1:0x0:0x1  0
pl2303.c: 0x40:0x1:0x1:0xc0  0
pl2303.c: 0x40:0x1:0x2:0x4  0
pl2303.c: pl2303_set_termios -  port 0, initialized = 0
pl2303.c: 0xa1:0x21:0:0  7 - 0 0 0 0 0 0 0
pl2303.c: 0x40:1:0:1  0
pl2303.c: pl2303_set_termios - data bits = 8
pl2303.c: pl2303_set_termios - baud = 9600
pl2303.c: pl2303_set_termios - stop bits = 1
pl2303.c: pl2303_set_termios - parity = none
pl2303.c: 0x21:0x20:0:0  7
pl2303.c: set_control_lines - value = 3, retval = 0
pl2303.c: 0xa1:0x21:0:0  7 - 80 25 0 0 0 0 8
pl2303.c: pl2303_open - submitting read urb
Unable to handle kernel NULL pointer dereference at virtual address 00000010
 printing eip:
c01d8cd8
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01d8cd8>]    Not tainted
EFLAGS: 00010286
eax: 00000000   ebx: c1339400   ecx: 00000001   edx: c134b800
esi: c133941c   edi: 00000001   ebp: cd8f5e9c   esp: cd8f5e2c
ds: 0018   es: 0018   ss: 0018
Process minicom (pid: 117, stackpage=cd8f5000)
Stack: c02546a0 c02556d3 00000001 00000002 00000004 00000000 00000000 00000000 
       00000064 00000006 00000282 00000001 c02bd3bc 00000246 0000001c cd8f5e9c 
       c0119dd2 0000000a 00000400 c025539b cd8f5eac 00000024 00000000 00000000 
Call Trace:    [<c0119dd2>] [<c01d57bb>] [<c0178e44>] [<c01413a3>] [<c015914a>]
  [<c01378aa>] [<c0136081>] [<c0135fa6>] [<c0140953>] [<c0136351>] [<c0107417>]

Code: 89 50 10 8b 46 20 89 04 24 e8 5a e9 fe ff 85 c0 75 76 a1 80 
---dmesg ends here---
---decoded oops begins here---
ksymoops 2.4.5 on i686 2.4.19-16mdksmp.  Options used
     -v vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map (specified)

cpu: 0, clocks: 666756, slice: 333378
Unable to handle kernel NULL pointer dereference at virtual address 00000010
c01d8cd8
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01d8cd8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000000   ebx: c1339400   ecx: 00000001   edx: c134b800
esi: c133941c   edi: 00000001   ebp: cd8f5e9c   esp: cd8f5e2c
ds: 0018   es: 0018   ss: 0018
Process minicom (pid: 117, stackpage=cd8f5000)
Stack: c02546a0 c02556d3 00000001 00000002 00000004 00000000 00000000 00000000 
       00000064 00000006 00000282 00000001 c02bd3bc 00000246 0000001c cd8f5e9c 
       c0119dd2 0000000a 00000400 c025539b cd8f5eac 00000024 00000000 00000000 
Call Trace:    [<c0119dd2>] [<c01d57bb>] [<c0178e44>] [<c01413a3>] [<c015914a>]
  [<c01378aa>] [<c0136081>] [<c0135fa6>] [<c0140953>] [<c0136351>] [<c0107417>]
Code: 89 50 10 8b 46 20 89 04 24 e8 5a e9 fe ff 85 c0 75 76 a1 80 


>>EIP; c01d8cd8 <pl2303_open+508/890>   <=====

>>ebx; c1339400 <END_OF_CODE+10553a8/????>
>>edx; c134b800 <END_OF_CODE+10677a8/????>
>>esi; c133941c <END_OF_CODE+10553c4/????>
>>ebp; cd8f5e9c <END_OF_CODE+d611e44/????>
>>esp; cd8f5e2c <END_OF_CODE+d611dd4/????>

Trace; c0119dd2 <printk+112/150>
Trace; c01d57bb <serial_open+fb/140>
Trace; c0178e44 <tty_open+244/3d0>
Trace; c01413a3 <link_path_walk+593/710>
Trace; c015914a <ext2_free_blocks+21a/300>
Trace; c01378aa <chrdev_open+5a/60>
Trace; c0136081 <dentry_open+d1/1e0>
Trace; c0135fa6 <filp_open+66/70>
Trace; c0140953 <getname+93/d0>
Trace; c0136351 <sys_open+51/a0>
Trace; c0107417 <system_call+33/38>

Code;  c01d8cd8 <pl2303_open+508/890>
00000000 <_EIP>:
Code;  c01d8cd8 <pl2303_open+508/890>   <=====
   0:   89 50 10                  mov    %edx,0x10(%eax)   <=====
Code;  c01d8cdb <pl2303_open+50b/890>
   3:   8b 46 20                  mov    0x20(%esi),%eax
Code;  c01d8cde <pl2303_open+50e/890>
   6:   89 04 24                  mov    %eax,(%esp,1)
Code;  c01d8ce1 <pl2303_open+511/890>
   9:   e8 5a e9 fe ff            call   fffee968 <_EIP+0xfffee968> c01c7640 <usb_submit_urb+0/50>
Code;  c01d8ce6 <pl2303_open+516/890>
   e:   85 c0                     test   %eax,%eax
Code;  c01d8ce8 <pl2303_open+518/890>
  10:   75 76                     jne    88 <_EIP+0x88> c01d8d60 <pl2303_open+590/890>
Code;  c01d8cea <pl2303_open+51a/890>
  12:   a1 80 00 00 00            mov    0x80,%eax
---decoded oops ends here---
