Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131627AbRCSV76>; Mon, 19 Mar 2001 16:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131642AbRCSV7s>; Mon, 19 Mar 2001 16:59:48 -0500
Received: from 24.68.61.66.on.wave.home.com ([24.68.61.66]:36362 "HELO
	sh0n.net") by vger.kernel.org with SMTP id <S131627AbRCSV7k>;
	Mon, 19 Mar 2001 16:59:40 -0500
Message-ID: <3AB68123.18DC6305@sh0n.net>
Date: Mon, 19 Mar 2001 16:58:59 -0500
From: Shawn Starr <spstarr@sh0n.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre4 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.3-pre4: Unable to handle kernel NULL pointer dereference at virtual 
 address 000000fb
In-Reply-To: <200103190207.UAA13397@senechalle.net>
Content-Type: multipart/mixed;
 boundary="------------89C15C1D6156AE3FA4C7B66F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------89C15C1D6156AE3FA4C7B66F
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

I have included the ksymoops debug and dmesg (both small).. Any ideas?

Shawn.
--------------89C15C1D6156AE3FA4C7B66F
Content-Type: text/plain; charset=iso-8859-15;
 name="debug"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="debug"

ksymoops 2.3.7 on i586 2.4.3-pre4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.3-pre4/ (default)
     -m /boot/System.map (specified)

Intel Pentium with F0 0F bug - workaround enabled.
Unable to handle kernel NULL pointer dereference at virtual address 000000fb
c2016531
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c2016531>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: 00000000   ebx: c0709dc8   ecx: c10e3a60   edx: c1258800
esi: 00000000   edi: 00000082   ebp: c1258878   esp: c0709f54
ds: 0018   es: 0018   ss: 0018
Process scsi_eh_0 (pid: 297, stackpage=c0709000)
Stack: 00000282 c1258800 00000000 c1274a00 c20165cf c1258800 c1258878 00000282 
       c1274a00 c019dddf c1274a00 00002003 00000000 c019e427 c1274a00 c0708000 
       c0709fdc c0709fdc c1258800 c0709fe8 c0709fe8 c10e3a60 00000000 c019e8fb 
Call Trace: [<c20165cf>] [<c019dddf>] [<c019e427>] [<c019e8fb>] [<c010742c>] 
Code: f6 80 fb 00 00 00 10 75 70 8b 4d 00 31 d2 eb 0a 89 ca 8b 82 

>>EIP; c2016531 <[aha152x]free_hard_reset_SCs+21/ac>   <=====
Trace; c20165cf <[aha152x]aha152x_bus_reset+13/a0>
Trace; c019dddf <scsi_try_bus_reset+3f/90>
Trace; c019e427 <scsi_unjam_host+35b/75c>
Trace; c019e8fb <scsi_error_handler+d3/138>
Trace; c010742c <kernel_thread+28/38>
Code;  c2016531 <[aha152x]free_hard_reset_SCs+21/ac>
00000000 <_EIP>:
Code;  c2016531 <[aha152x]free_hard_reset_SCs+21/ac>   <=====
   0:   f6 80 fb 00 00 00 10      testb  $0x10,0xfb(%eax)   <=====
Code;  c2016538 <[aha152x]free_hard_reset_SCs+28/ac>
   7:   75 70                     jne    79 <_EIP+0x79> c20165aa <[aha152x]free_hard_reset_SCs+9a/ac>
Code;  c201653a <[aha152x]free_hard_reset_SCs+2a/ac>
   9:   8b 4d 00                  mov    0x0(%ebp),%ecx
Code;  c201653d <[aha152x]free_hard_reset_SCs+2d/ac>
   c:   31 d2                     xor    %edx,%edx
Code;  c201653f <[aha152x]free_hard_reset_SCs+2f/ac>
   e:   eb 0a                     jmp    1a <_EIP+0x1a> c201654b <[aha152x]free_hard_reset_SCs+3b/ac>
Code;  c2016541 <[aha152x]free_hard_reset_SCs+31/ac>
  10:   89 ca                     mov    %ecx,%edx
Code;  c2016543 <[aha152x]free_hard_reset_SCs+33/ac>
  12:   8b 82 00 00 00 00         mov    0x0(%edx),%eax



--------------89C15C1D6156AE3FA4C7B66F
Content-Type: text/plain; charset=iso-8859-15;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.4.3-pre4 (root@stucko) (gcc version 2.95.3 20010219 (prerelease)) #1 Sun Mar 18 01:29:02 EST 2001
BIOS-provided physical RAM map:
 BIOS-88: 000000000009f000 @ 0000000000000000 (usable)
 BIOS-88: 0000000001700000 @ 0000000000100000 (usable)
On node 0 totalpages: 6144
zone(0): 4096 pages.
zone(1): 2048 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=Linux ro root=302
Initializing CPU#0
Detected 83.524 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 166.29 BogoMIPS
Memory: 22124k/24576k available (996k kernel code, 2064k reserved, 382k data, 60k init, 0k highmem)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
CPU: Before vendor init, caps: 0000013f 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After vendor init, caps: 0000013f 00000000 00000000 00000000
CPU: After generic, caps: 0000013f 00000000 00000000 00000000
CPU: Common caps: 0000013f 00000000 00000000 00000000
CPU: Intel OverDrive PODP5V83 stepping 02
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
isapnp: Scanning for Pnp cards...
isapnp: Card 'Adaptec AVA-1505AI'
isapnp: Card '3Com 3C509B EtherLink III'
isapnp: 2 Plug & Play cards detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
parport0: PC-style at 0x378 [PCSPP(,...)]
pty: 256 Unix98 ptys configured
block: queued sectors max/low 14605kB/4868kB, 64 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
hda: ST3491A D, ATA DISK drive
hdb: QUANTUM PD210A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 836070 sectors (428 MB) w/120KiB Cache, CHS=899/15/62
hdb: 408564 sectors (209 MB) w/32KiB Cache, CHS=873/13/36
Partition check:
 hda: hda1 hda2
 hdb: hdb1 hdb2
paride: epat registered as protocol 0
pd: pd version 1.05, major 45, cluster 64, nice 0
pda: Sharing parport0 at 0x378
pda: epat 1.01, Shuttle EPAT chip c6 at 0x378, mode 1 (5/3), delay 1
pda: AVATAR  AR2250, master, 489472 blocks [239M], (956/16/32), removable media
 pda: pda1
Floppy drive(s): fd0 is 1.44M
FDC 0 is an 8272A
eth0: 3c509 at 0x220, 10baseT port, address  00 a0 24 46 41 c0, IRQ 5.
3c509.c:1.16 (2.2) 2/3/98 becker@cesdis.gsfc.nasa.gov.
loop: loaded (max 8 devices)
Serial driver version 5.05 (2000-12-13) with ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16450
ttyS01 at 0x02f8 (irq = 3) is a 16450
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
ip_conntrack (192 buckets, 1536 max)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 60k freed
Adding Swap: 20568k swap-space (priority -1)
eth0: Setting Rx mode to 1 addresses.
aha152x: BIOS test: passed, detected 1 controller(s)
aha152x: resetting bus...
aha152x0: vital data: rev=3, io=0x140 (0x140/0x140), irq=10, scsiid=7, reconnect=enabled, parity=enabled, synchronous=disabled, delay=1000, extended translation=disabled
aha152x0: trying software interrupt, ok.
scsi0 : Adaptec 152x SCSI driver; $Revision: 2.4 $
request_module[scsi_hostadapter]: waitpid(296,...) failed, errno 512
Detected scsi generic sg0 at scsi0, channel 0, id 0, lun 0, type -1
resize_dma_pool: unknown device type -1
aha152x: timer expired
Unable to handle kernel NULL pointer dereference at virtual address 000000fb
 printing eip:
c2016531
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c2016531>]
EFLAGS: 00010082
eax: 00000000   ebx: c0709dc8   ecx: c10e3a60   edx: c1258800
esi: 00000000   edi: 00000082   ebp: c1258878   esp: c0709f54
ds: 0018   es: 0018   ss: 0018
Process scsi_eh_0 (pid: 297, stackpage=c0709000)
Stack: 00000282 c1258800 00000000 c1274a00 c20165cf c1258800 c1258878 00000282 
       c1274a00 c019dddf c1274a00 00002003 00000000 c019e427 c1274a00 c0708000 
       c0709fdc c0709fdc c1258800 c0709fe8 c0709fe8 c10e3a60 00000000 c019e8fb 
Call Trace: [<c20165cf>] [<c019dddf>] [<c019e427>] [<c019e8fb>] [<c010742c>] 

Code: f6 80 fb 00 00 00 10 75 70 8b 4d 00 31 d2 eb 0a 89 ca 8b 82 


--------------89C15C1D6156AE3FA4C7B66F--

