Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137096AbREKKZl>; Fri, 11 May 2001 06:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137097AbREKKZc>; Fri, 11 May 2001 06:25:32 -0400
Received: from p03-46.brus.online.be ([194.88.125.238]:48644 "HELO
	mail.bsolutions.be") by vger.kernel.org with SMTP
	id <S137096AbREKKZX> convert rfc822-to-8bit; Fri, 11 May 2001 06:25:23 -0400
Date: Fri, 11 May 2001 12:27:15 +0200
From: r_letot@yahoo.com
To: linux-kernel@vger.kernel.org
Subject: Oops on 2.2 (somewhere in ext2 ?)
Message-ID: <20010511122715.A585@hal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I had an oops some days ago which I posted.
Here is a new one... well, actually 4 new ones :-(
I had to reboot before I could ksymoops my logs because the box was frozen
hard, so I don't know if the ksymoops output is valid (I can't judge, I
don't know what it should look like :-)

Here it comes : 

first a dmesg 
-----
Linux version 2.2.17 (root@hal) (gcc version 2.7.2.3) #1 Mon Nov 20 18:33:32 CET 2000
Detected 737031 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1471.28 BogoMIPS
Memory: 256816k/262016k available (1564k kernel code, 416k reserved, 3076k data, 144k init)
Dentry hash table entries: 32768 (order 6, 256k)
Buffer cache hash table entries: 262144 (order 8, 1024k)
Page cache hash table entries: 65536 (order 6, 256k)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: Intel Pentium III (Coppermine) stepping 03
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
PCI: PCI BIOS revision 2.10 entry at 0xf0d90
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 262144 bhash 65536)
Starting kswapd v 1.5 
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.13)
Real Time Clock Driver v1.09
RAM disk driver initialized:  16 RAM disks of 4096K size
PCI_IDE: unknown IDE controller on PCI bus 00 device f9, VID=8086, DID=244b
PCI_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:pio, hdd:pio
hda: ASUS CD-S500/A, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 50X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.11
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
sim710: No NCR53C710 adapter found.
scsi: <fdomain> Detection failed (no card)
NCR53c406a: no available ports found
sym53c416.c: Version 1.0.0
sym53c8xx: at PCI bus 2, device 11, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c860 detected with Symbios NVRAM
sym53c860-0: rev=0x02, base=0xeb800000, io_port=0xd800, irq=9
sym53c860-0: NCR clock is 80074KHz, 80074KHz
sym53c860-0: Symbios format NVRAM, ID 7, Fast-20, Parity Checking
sym53c860-0: initial SCNTL3/DMODE/DCNTL/CTEST3/4/5 = (hex) 00/00/00/00/00/00
sym53c860-0: final   SCNTL3/DMODE/DCNTL/CTEST3/4/5 = (hex) 05/ce/a0/00/08/00
sym53c860-0: resetting, command processing suspended for 2 seconds
sym53c860-0: restart (scsi reset).
ncr53c8xx: at PCI bus 2, device 11, function 0
ncr53c8xx: IO region 0xd800 to 0xd87f is in use
sym53c860-0: command processing resumed
Adaptec: Reading the hardware resource table.  This could take up to 5 minutes
Adaptec: Hardware resource table read.
Failed initialization of WD-7000 SCSI card!
megaraid: v107 (December 22, 1999)
aec671x_detect: 
3w-xxxx: tw_findcards(): No cards found.
scsi0 : sym53c8xx - version 1.3g
scsi1 : Vendor: Adaptec  Model: 2100S            Rev: 320R
scsi : 2 hosts.
  Vendor: HP        Model: HP35480A          Rev: M902
  Type:   Sequential-Access                  ANSI SCSI revision: 02
  Vendor: ADAPTEC   Model: MAIN              Rev: 320R
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi1, channel 0, id 0, lun 0
scsi : detected 1 SCSI disk total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 71716864 [35018 MB] [35.0 GB]
Partition check:
 sda: sda1 sda2 sda3
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 144k freed
NET4: Unix domain sockets 1.0 for Linux NET4.0.
Adding Swap: 248996k swap-space (priority -1)
3c59x.c:v0.99H 12Jun00 Donald Becker and others http://www.scyld.com/network/vortex.html
eth0: 3Com 3c905C Tornado at 0xd400,  00:01:02:db:e4:9c, IRQ 9
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 782d.
  Enabling bus-master transmits and whole-frame receives.
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
NET4: AppleTalk 0.18 for Linux NET4.0

Then the log :
------
May 11 11:33:28 hal kernel: swap_free: Trying to free nonexistent swap-page
May 11 11:33:28 hal kernel: swap_free: Trying to free nonexistent swap-page
May 11 11:34:34 hal kernel: Oops: 0000
May 11 11:34:34 hal kernel: CPU:    0
May 11 11:34:34 hal kernel: EIP:    0010:[lookup_dentry+201/428]
May 11 11:34:34 hal kernel: EFLAGS: 00010202
May 11 11:34:34 hal kernel: eax: 00000008   ebx: cda5e220   ecx: 00000004   edx: 0000002f
May 11 11:34:34 hal kernel: esi: c2ff7b41   edi: 00000003   ebp: cf9265a0   esp: cb5dbf00
May 11 11:34:34 hal kernel: ds: 0018   es: 0018   ss: 0018
May 11 11:34:34 hal kernel: Process imapd (pid: 17357, process nr: 33, stackpage=cb5db000)
May 11 11:34:34 hal kernel: Stack: cfcbc060 c2ff7b2c caa18540 c2ff7b3c 00000004 0006e9b5 c0146c61 c2ff7b2c 
May 11 11:34:34 hal kernel:        cfcbc060 00000003 c2ff7a90 cb5da000 cb5b7760 cfcbc060 cfcbc060 c2eca001 
May 11 11:34:34 hal kernel:        c012ccf4 cb5b7760 cfcbc060 0000000b cb5b7760 c2eca006 0000000b c012ce68 
May 11 11:34:34 hal kernel: Call Trace: [ext2_follow_link+101/132] [do_follow_link+76/136] [lookup_dentry+312/428] [__namei+41/92] [sys_newstat+19/100] [system_call+52/56] 
May 11 11:34:34 hal kernel: Code: 8b 50 04 85 d2 74 13 8d 44 24 14 50 55 ff d2 83 c4 08 85 c0 
May 11 11:35:25 hal kernel: Oops: 0000
May 11 11:35:25 hal kernel: CPU:    0
May 11 11:35:25 hal kernel: EIP:    0010:[lookup_dentry+201/428]
May 11 11:35:25 hal kernel: EFLAGS: 00010202
May 11 11:35:25 hal kernel: eax: 00000008   ebx: cda5e220   ecx: 00000008   edx: 00000000
May 11 11:35:25 hal kernel: esi: c57f5018   edi: 00000001   ebp: cf9265a0   esp: cba63f78
May 11 11:35:25 hal kernel: ds: 0018   es: 0018   ss: 0018
May 11 11:35:25 hal kernel: Process smbd (pid: 16477, process nr: 60, stackpage=cba63000)
May 11 11:35:25 hal kernel: Stack: 00000001 bffffbfc c57f5000 c57f5010 00000008 2845f255 c012cf05 c57f5000 
May 11 11:35:25 hal kernel:        00000000 00000001 cba62000 0811c410 0811c370 c01252e2 08111c00 00000001 
May 11 11:35:25 hal kernel:        cba62000 0811c410 c010a0a8 08111c00 08111c18 0811c370 0811c410 0811c370 
May 11 11:35:25 hal kernel: Call Trace: [__namei+41/92] [sys_chdir+14/104] [system_call+52/56] [startup_32+43/285] 
May 11 11:35:25 hal kernel: Code: 8b 50 04 85 d2 74 13 8d 44 24 14 50 55 ff d2 83 c4 08 85 c0 
May 11 11:35:25 hal kernel: swap_free: Trying to free nonexistent swap-page
May 11 11:35:46 hal last message repeated 11 times
May 11 11:35:48 hal kernel: Oops: 0000
May 11 11:35:48 hal kernel: CPU:    0
May 11 11:35:48 hal kernel: EIP:    0010:[lookup_dentry+201/428]
May 11 11:35:48 hal kernel: EFLAGS: 00010202
May 11 11:35:48 hal kernel: eax: 00000008   ebx: cda5e220   ecx: 00000008   edx: 00000000
May 11 11:35:48 hal kernel: esi: c3333018   edi: 00000001   ebp: cf9265a0   esp: c4e25f78
May 11 11:35:48 hal kernel: ds: 0018   es: 0018   ss: 0018
May 11 11:35:48 hal kernel: Process smbd (pid: 16470, process nr: 25, stackpage=c4e25000)
May 11 11:35:48 hal kernel: Stack: 00000001 bffffbfc c3333000 c3333010 00000008 2845f255 c012cf05 c3333000 
May 11 11:35:48 hal kernel:        00000000 00000001 c4e24000 0811c410 0811c370 c01252e2 08111c00 00000001 
May 11 11:35:48 hal kernel:        c4e24000 0811c410 c010a0a8 08111c00 08111c18 0811c370 0811c410 0811c370 
May 11 11:35:48 hal kernel: Call Trace: [__namei+41/92] [sys_chdir+14/104] [system_call+52/56] [startup_32+43/285] 
May 11 11:35:48 hal kernel: Code: 8b 50 04 85 d2 74 13 8d 44 24 14 50 55 ff d2 83 c4 08 85 c0 
May 11 11:35:48 hal kernel: swap_free: Trying to free nonexistent swap-page
May 11 11:36:16 hal last message repeated 13 times
May 11 11:36:25 hal kernel: Oops: 0000
May 11 11:36:25 hal kernel: CPU:    0
May 11 11:36:25 hal kernel: EIP:    0010:[lookup_dentry+201/428]
May 11 11:36:25 hal kernel: EFLAGS: 00010202
May 11 11:36:25 hal kernel: eax: 00000008   ebx: cda5e220   ecx: 00000008   edx: 00000000
May 11 11:36:25 hal kernel: esi: ca050018   edi: 00000001   ebp: cf9265a0   esp: c51fdf78
May 11 11:36:25 hal kernel: ds: 0018   es: 0018   ss: 0018
May 11 11:36:25 hal kernel: Process smbd (pid: 16494, process nr: 84, stackpage=c51fd000)
May 11 11:36:25 hal kernel: Stack: 00000001 bffffbfc ca050000 ca050010 00000008 2845f255 c012cf05 ca050000 
May 11 11:36:25 hal kernel:        00000000 00000001 c51fc000 0811c410 0811c370 c01252e2 08111c00 00000001 
May 11 11:36:25 hal kernel:        c51fc000 0811c410 c010a0a8 08111c00 08111c18 0811c370 0811c410 0811c370 
May 11 11:36:25 hal kernel: Call Trace: [__namei+41/92] [sys_chdir+14/104] [system_call+52/56] [startup_32+43/285] 
May 11 11:36:25 hal kernel: Code: 8b 50 04 85 d2 74 13 8d 44 24 14 50 55 ff d2 83 c4 08 85 c0 
May 11 11:36:25 hal kernel: swap_free: Trying to free nonexistent swap-page
May 11 11:36:33 hal last message repeated 7 times
May 11 11:37:51 hal last message repeated 6 times
May 11 11:40:37 hal kernel: swap_free: Trying to free nonexistent swap-page
May 11 11:41:04 hal last message repeated 7 times
May 11 11:42:18 hal last message repeated 2 times

then ksymoops' output (the defaults are valid, but I had to reboot so maybe
the output is not valid):
------ 
ksymoops 2.3.4 on i686 2.2.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.17/ (default)
     -m /boot/System.map-2.2.17 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

May 11 11:34:34 hal kernel: Oops: 0000
May 11 11:34:34 hal kernel: CPU:    0
May 11 11:34:34 hal kernel: EIP:    0010:[lookup_dentry+201/428]
May 11 11:34:34 hal kernel: EFLAGS: 00010202
May 11 11:34:34 hal kernel: eax: 00000008   ebx: cda5e220   ecx: 00000004   edx: 0000002f
May 11 11:34:34 hal kernel: esi: c2ff7b41   edi: 00000003   ebp: cf9265a0   esp: cb5dbf00
May 11 11:34:34 hal kernel: ds: 0018   es: 0018   ss: 0018
May 11 11:34:34 hal kernel: Process imapd (pid: 17357, process nr: 33, stackpage=cb5db000)
May 11 11:34:34 hal kernel: Stack: cfcbc060 c2ff7b2c caa18540 c2ff7b3c 00000004 0006e9b5 c0146c61 c2ff7b2c 
May 11 11:34:34 hal kernel:        cfcbc060 00000003 c2ff7a90 cb5da000 cb5b7760 cfcbc060 cfcbc060 c2eca001 
May 11 11:34:34 hal kernel:        c012ccf4 cb5b7760 cfcbc060 0000000b cb5b7760 c2eca006 0000000b c012ce68 
May 11 11:34:34 hal kernel: Call Trace: [ext2_follow_link+101/132] [do_follow_link+76/136] [lookup_dentry+312/428] [__namei+41/92] [sys_newstat+19/100] [system_call+52/56] 
May 11 11:34:34 hal kernel: Code: 8b 50 04 85 d2 74 13 8d 44 24 14 50 55 ff d2 83 c4 08 85 c0 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 50 04                  mov    0x4(%eax),%edx
Code;  00000003 Before first symbol
   3:   85 d2                     test   %edx,%edx
Code;  00000005 Before first symbol
   5:   74 13                     je     1a <_EIP+0x1a> 0000001a Before first symbol
Code;  00000007 Before first symbol
   7:   8d 44 24 14               lea    0x14(%esp,1),%eax
Code;  0000000b Before first symbol
   b:   50                        push   %eax
Code;  0000000c Before first symbol
   c:   55                        push   %ebp
Code;  0000000d Before first symbol
   d:   ff d2                     call   *%edx
Code;  0000000f Before first symbol
   f:   83 c4 08                  add    $0x8,%esp
Code;  00000012 Before first symbol
  12:   85 c0                     test   %eax,%eax

May 11 11:35:25 hal kernel: Oops: 0000
May 11 11:35:25 hal kernel: CPU:    0
May 11 11:35:25 hal kernel: EIP:    0010:[lookup_dentry+201/428]
May 11 11:35:25 hal kernel: EFLAGS: 00010202
May 11 11:35:25 hal kernel: eax: 00000008   ebx: cda5e220   ecx: 00000008   edx: 00000000
May 11 11:35:25 hal kernel: esi: c57f5018   edi: 00000001   ebp: cf9265a0   esp: cba63f78
May 11 11:35:25 hal kernel: ds: 0018   es: 0018   ss: 0018
May 11 11:35:25 hal kernel: Process smbd (pid: 16477, process nr: 60, stackpage=cba63000)
May 11 11:35:25 hal kernel: Stack: 00000001 bffffbfc c57f5000 c57f5010 00000008 2845f255 c012cf05 c57f5000 
May 11 11:35:25 hal kernel:        00000000 00000001 cba62000 0811c410 0811c370 c01252e2 08111c00 00000001 
May 11 11:35:25 hal kernel:        cba62000 0811c410 c010a0a8 08111c00 08111c18 0811c370 0811c410 0811c370 
May 11 11:35:25 hal kernel: Call Trace: [__namei+41/92] [sys_chdir+14/104] [system_call+52/56] [startup_32+43/285] 
May 11 11:35:25 hal kernel: Code: 8b 50 04 85 d2 74 13 8d 44 24 14 50 55 ff d2 83 c4 08 85 c0 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 50 04                  mov    0x4(%eax),%edx
Code;  00000003 Before first symbol
   3:   85 d2                     test   %edx,%edx
Code;  00000005 Before first symbol
   5:   74 13                     je     1a <_EIP+0x1a> 0000001a Before first symbol
Code;  00000007 Before first symbol
   7:   8d 44 24 14               lea    0x14(%esp,1),%eax
Code;  0000000b Before first symbol
   b:   50                        push   %eax
Code;  0000000c Before first symbol
   c:   55                        push   %ebp
Code;  0000000d Before first symbol
   d:   ff d2                     call   *%edx
Code;  0000000f Before first symbol
   f:   83 c4 08                  add    $0x8,%esp
Code;  00000012 Before first symbol
  12:   85 c0                     test   %eax,%eax

May 11 11:35:48 hal kernel: Oops: 0000
May 11 11:35:48 hal kernel: CPU:    0
May 11 11:35:48 hal kernel: EIP:    0010:[lookup_dentry+201/428]
May 11 11:35:48 hal kernel: EFLAGS: 00010202
May 11 11:35:48 hal kernel: eax: 00000008   ebx: cda5e220   ecx: 00000008   edx: 00000000
May 11 11:35:48 hal kernel: esi: c3333018   edi: 00000001   ebp: cf9265a0   esp: c4e25f78
May 11 11:35:48 hal kernel: ds: 0018   es: 0018   ss: 0018
May 11 11:35:48 hal kernel: Process smbd (pid: 16470, process nr: 25, stackpage=c4e25000)
May 11 11:35:48 hal kernel: Stack: 00000001 bffffbfc c3333000 c3333010 00000008 2845f255 c012cf05 c3333000 
May 11 11:35:48 hal kernel:        00000000 00000001 c4e24000 0811c410 0811c370 c01252e2 08111c00 00000001 
May 11 11:35:48 hal kernel:        c4e24000 0811c410 c010a0a8 08111c00 08111c18 0811c370 0811c410 0811c370 
May 11 11:35:48 hal kernel: Call Trace: [__namei+41/92] [sys_chdir+14/104] [system_call+52/56] [startup_32+43/285] 
May 11 11:35:48 hal kernel: Code: 8b 50 04 85 d2 74 13 8d 44 24 14 50 55 ff d2 83 c4 08 85 c0 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 50 04                  mov    0x4(%eax),%edx
Code;  00000003 Before first symbol
   3:   85 d2                     test   %edx,%edx
Code;  00000005 Before first symbol
   5:   74 13                     je     1a <_EIP+0x1a> 0000001a Before first symbol
Code;  00000007 Before first symbol
   7:   8d 44 24 14               lea    0x14(%esp,1),%eax
Code;  0000000b Before first symbol
   b:   50                        push   %eax
Code;  0000000c Before first symbol
   c:   55                        push   %ebp
Code;  0000000d Before first symbol
   d:   ff d2                     call   *%edx
Code;  0000000f Before first symbol
   f:   83 c4 08                  add    $0x8,%esp
Code;  00000012 Before first symbol
  12:   85 c0                     test   %eax,%eax

May 11 11:36:25 hal kernel: Oops: 0000
May 11 11:36:25 hal kernel: CPU:    0
May 11 11:36:25 hal kernel: EIP:    0010:[lookup_dentry+201/428]
May 11 11:36:25 hal kernel: EFLAGS: 00010202
May 11 11:36:25 hal kernel: eax: 00000008   ebx: cda5e220   ecx: 00000008   edx: 00000000
May 11 11:36:25 hal kernel: esi: ca050018   edi: 00000001   ebp: cf9265a0   esp: c51fdf78
May 11 11:36:25 hal kernel: ds: 0018   es: 0018   ss: 0018
May 11 11:36:25 hal kernel: Process smbd (pid: 16494, process nr: 84, stackpage=c51fd000)
May 11 11:36:25 hal kernel: Stack: 00000001 bffffbfc ca050000 ca050010 00000008 2845f255 c012cf05 ca050000 
May 11 11:36:25 hal kernel:        00000000 00000001 c51fc000 0811c410 0811c370 c01252e2 08111c00 00000001 
May 11 11:36:25 hal kernel:        c51fc000 0811c410 c010a0a8 08111c00 08111c18 0811c370 0811c410 0811c370 
May 11 11:36:25 hal kernel: Call Trace: [__namei+41/92] [sys_chdir+14/104] [system_call+52/56] [startup_32+43/285] 
May 11 11:36:25 hal kernel: Code: 8b 50 04 85 d2 74 13 8d 44 24 14 50 55 ff d2 83 c4 08 85 c0 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 50 04                  mov    0x4(%eax),%edx
Code;  00000003 Before first symbol
   3:   85 d2                     test   %edx,%edx
Code;  00000005 Before first symbol
   5:   74 13                     je     1a <_EIP+0x1a> 0000001a Before first symbol
Code;  00000007 Before first symbol
   7:   8d 44 24 14               lea    0x14(%esp,1),%eax
Code;  0000000b Before first symbol
   b:   50                        push   %eax
Code;  0000000c Before first symbol
   c:   55                        push   %ebp
Code;  0000000d Before first symbol
   d:   ff d2                     call   *%edx
Code;  0000000f Before first symbol
   f:   83 c4 08                  add    $0x8,%esp
Code;  00000012 Before first symbol
  12:   85 c0                     test   %eax,%eax


1 warning issued.  Results may not be reliable.

Do you need something else ?
--
Remi
