Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271896AbRH2EHv>; Wed, 29 Aug 2001 00:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271899AbRH2EHd>; Wed, 29 Aug 2001 00:07:33 -0400
Received: from dvorak.nscl.msu.edu ([35.8.33.99]:39950 "EHLO dvorak")
	by vger.kernel.org with ESMTP id <S271896AbRH2EHX> convert rfc822-to-8bit;
	Wed, 29 Aug 2001 00:07:23 -0400
Date: Wed, 29 Aug 2001 00:21:45 -0400 (EDT)
From: Jens Hoefkens <hoefkens@msu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 boot failure
In-Reply-To: <E15bOqc-0004CB-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0108282340130.12708-100000@dvorak>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2001, Alan Cox wrote:

> 
> Can you boot it with a serial console ?
> 

Hi Alan.

I have the same problem with the serial console. The single CPU kernel
boots fine and dumps the log to the serial port, the SMP kernel
freezes right after 

	"Uncompressing Linux... OK, booting the kernel"

and there is no output to the serial console. However, I have done
some more tests with 2.4.9 kernels.

1) Single CPU 2.4.9 boots and reports tons of machine check exceptions
(output from the serial console in [1]). I also tried my best runnung
the OOPS trhough ksymoops ([3]).

2) Single CPU 2.4.9 with "nomce" parameter boots fine ([2]).

3) SMP 2.4.9 freezes the machine right after "OK, booting the kernel"
(with and without the "nomce" parameter).

Btw, I have swapped the CPUs around with no change. Moreover, I
remember that an earlier 2.2 kernel worked with both CPUs on this
board (if necessary, I can go back and try to find the last working
kernel - although it will take some time).


Thanks,
	
							Jens

-------------------------------------------------------------------------

[1]

Linux version 2.4.9-586tsc (herbert@gondolin) (gcc version 2.95.4 20010319 (Debian prerelease)) #1 Sun Aug 19 10:16:22 EST 2001
BIOS-provided physical RAM map:
 BIOS-e801: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e801: 0000000000100000 - 0000000009000000 (usable)
On node 0 totalpages: 36864
zone(0): 4096 pages.
zone(1): 32768 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=2.4.9-586tsc ro root=302 console=ttyS0
Initializing CPU#0
Detected 99.720 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 198.65 BogoMIPS
Memory: 143036k/147456k available (774k kernel code, 4032k reserved, 310k data, 184k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Intel Pentium with F0 0F bug - workaround enabled.
Intel old style machine check architecture supported.
CPU#0: Machine Check Exception:  0x  10C200 (type 0x       9).
CPU#0: Machine Check Exception:  0x  114960 (type 0x       9).
CPU#0: Machine Check Exception:  0x  211D78 (type 0x       D).
CPU#0: Machine Check Exception:  0x  211CF0 (type 0x       D).
CPU#0: Machine Check Exception:  0x  211BF8 (type 0x       D).
CPU#0: Machine Check Exception:  0x  24B6A4 (type 0x       D).
CPU#0: Machine Check Exception:  0x  211B58 (type 0x       D).
CPU#0: Machine Check Exception:  0x  211AD0 (type 0x       D).
CPU#0: Machine Check Exception:  0x  2119D8 (type 0x       D).
CPU#0: Machine Check Exception:  0x  24B6C4 (type 0x       D).
CPU#0: Machine Check Exception:  0x  211938 (type 0x       D).
CPU#0: Machine Check Exception:  0x  2118B0 (type 0x       D).
CPU#0: Machine Check Exception:  0x  2117B8 (type 0x       D).
CPU#0: Machine Check Exception:  0x  24B6E4 (type 0x       D).
CPU#0: Machine Check Exception:  0x  211718 (type 0x       D).
CPU#0: Machine Check Exception:  0x  211690 (type 0x       D).
CPU#0: Machine Check Exception:  0x  211598 (type 0x       D).
CPU#0: Machine Check Exception:  0x  24B704 (type 0x       D).
CPU#0: Machine Check Exception:  0x  2114F8 (type 0x       D).
CPU#0: Machine Check Exception:  0x  211470 (type 0x       D).
CPU#0: Machine Check Exception:  0x  211378 (type 0x       D).
CPU#0: Machine Check Exception:  0x  24B724 (type 0x       D).
CPU#0: Machine Check Exception:  0x  2112D8 (type 0x       D).
CPU#0: Machine Check Exception:  0x  211250 (type 0x       D).
CPU#0: Machine Check Exception:  0x  1111E0 (type 0x       9).
CPU#0: Machine Check Exception:  0x  24B744 (type 0x       D).
CPU#0: Machine Check Exception:  0x  211108 (type 0x       D).
CPU#0: Machine Check Exception:  0x  211030 (type 0x       D).
CPU#0: Machine Check Exception:  0x  210F38 (type 0x       D).
CPU#0: Machine Check Exception:  0x  24B764 (type 0x       D).
CPU#0: Machine Check Exception:  0x  210E98 (type 0x       D).
CPU#0: Machine Check Exception:  0x  210E10 (type 0x       D).
CPU#0: Machine Check Exception:  0x  210D18 (type 0x       D).
CPU#0: Machine Check Exception:  0x  24B784 (type 0x       D).
CPU#0: Machine Check Exception:  0x  210C78 (type 0x       D).
CPU#0: Machine Check Exception:  0x  210BF0 (type 0x       D).
CPU#0: Machine Check Exception:  0x  210AF8 (type 0x       D).
CPU#0: Machine Check Exception:  0x  24B7A4 (type 0x       D).
CPU#0: Machine Check Exception:  0x  210A58 (type 0x       D).
CPU#0: Machine Check Exception:  0x  2109D0 (type 0x       D).
CPU#0: Machine Check Exception:  0x  2108D8 (type 0x       D).
CPU#0: Machine Check Exception:  0x  24B7C4 (type 0x       D).
CPU#0: Machine Check Exception:  0x  210838 (type 0x       D).
CPU#0: Machine Check Exception:  0x  2107B0 (type 0x       D).
CPU#0: Machine Check Exception:  0x  2106B8 (type 0x       D).
CPU#0: Machine Check Exception:  0x  24B7E4 (type 0x       D).
CPU#0: Machine Check Exception:  0x  210618 (type 0x       D).
CPU#0: Machine Check Exception:  0x  210590 (type 0x       D).
CPU#0: Machine Check Exception:  0x  210498 (type 0x       D).
CPU#0: Machine Check Exception:  0x  24B804 (type 0x       D).
CPU#0: Machine Check Exception:  0x  2103F8 (type 0x       D).
CPU#0: Machine Check Exception:  0x  210370 (type 0x       D).
CPU#0: Machine Check Exception:  0x  210278 (type 0x       D).
CPU#0: Machine Check Exception:  0x  24B824 (type 0x       D).
CPU#0: Machine Check Exception:  0x  2101A0 (type 0x       D).
Unable to handle kernel NULL pointer dereference at virtual address 00000046
 printing eip:
c01186c8
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01186c8>]
EFLAGS: 00010006
eax: ffffffff   ebx: c0210558   ecx: c0210000   edx: 00000042
esi: c0210558   edi: 00000013   ebp: 00000000   esp: c02100ec
ds: 0018   es: 0018   ss: 0018
Process  À (pid: -1071587976, stackpage=c020f000)
Stack: c0210000 00000006 00000009 c0118718 00000013 c0210558 c011886d 00000013 
       c0210000 c0210000 c0118a2d 00000009 c0210000 01ebd99f c0210000 00000000 
       c02101d8 c0118cc5 00000009 00000001 c0210000 c0117c33 00000009 c0210000 
Call Trace: [<c0118718>] [<c011886d>] [<c0118a2d>] [<c0118cc5>] [<c0117c33>] 
   [<c0117ca5>] [<c0117ff3>] [<c010ac86>] [<c0107fef>] [<c010814e>] [<c0106e20>] 
   [<c011120c>] [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] 
   [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c258>] 
   [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c258>] [<c010c21b>] 
   [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c258>] [<c010c21b>] [<c010c269>] 
   [<c0106e94>] [<c011120c>] [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] 
   [<c011120c>] [<c010c258>] [<c010c21b>] [<c0185600>] [<c010c269>] [<c0106e94>] 
   [<c011120c>] [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] 
   [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c258>] 
   [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c258>] [<c010c21b>] 
   [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c258>] [<c010c21b>] [<c010c269>] 
   [<c0106e94>] [<c011120c>] [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] 
   [<c011120c>] [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] 
   [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c258>] 
   [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c258>] [<c010c21b>] 
   [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c258>] [<c010c21b>] [<c010c269>] 
   [<c0106e94>] [<c011120c>] [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] 
   [<c011120c>] [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] 
   [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c258>] 
   [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c258>] [<c010c21b>] 
   [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c258>] [<c010c21b>] [<c010c269>] 
   [<c0106e94>] [<c011120c>] [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] 
   [<c011120c>] [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] 
   [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c258>] 
   [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c2

-------------------------------------------------------------------------

[2] 

Linux version 2.4.9-586tsc (herbert@gondolin) (gcc version 2.95.4 20010319 (Debian prerelease)) #1 Sun Aug 19 10:16:22 EST 2001
BIOS-provided physical RAM map:
 BIOS-e801: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e801: 0000000000100000 - 0000000009000000 (usable)
On node 0 totalpages: 36864
zone(0): 4096 pages.
zone(1): 32768 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=2.4.9-586tsc ro root=302 console=ttyS0 nomce
Initializing CPU#0
Detected 99.721 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 198.65 BogoMIPS
Memory: 143036k/147456k available (774k kernel code, 4032k reserved, 310k data, 184k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Intel Pentium with F0 0F bug - workaround enabled.
CPU: Intel Pentium 75 - 200 stepping 05
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfd88a, last bus=0
PCI: Using configuration type 2
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.4.0 initialized
devfs: v0.107 (20010709) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 128 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Cronyx Ltd, Synchronous PPP and CISCO HDLC (c) 1994
Linux port (c) 1998 Building Number Three Ltd & Jan "Yenya" Kasprzak.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 16384)

-------------------------------------------------------------------------

[3]

ksymoops 2.4.1 on i686 2.4.7.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map-2.4.9-586tsc (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000046
c01186c8
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01186c8>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: ffffffff   ebx: c0210558   ecx: c0210000   edx: 00000042
esi: c0210558   edi: 00000013   ebp: 00000000   esp: c02100ec
ds: 0018   es: 0018   ss: 0018
Process  À (pid: -1071587976, stackpage=c020f000)
Stack: c0210000 00000006 00000009 c0118718 00000013 c0210558 c011886d 00000013 
       c0210000 c0210000 c0118a2d 00000009 c0210000 01ebd99f c0210000 00000000 
       c02101d8 c0118cc5 00000009 00000001 c0210000 c0117c33 00000009 c0210000 
Call Trace: [<c0118718>] [<c011886d>] [<c0118a2d>] [<c0118cc5>] [<c0117c33>] 
   [<c0117ca5>] [<c0117ff3>] [<c010ac86>] [<c0107fef>] [<c010814e>] [<c0106e20>] 
   [<c011120c>] [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] 
   [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c258>] 
   [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c258>] [<c010c21b>] 
   [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c258>] [<c010c21b>] [<c010c269>] 
   [<c0106e94>] [<c011120c>] [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] 
   [<c011120c>] [<c010c258>] [<c010c21b>] [<c0185600>] [<c010c269>] [<c0106e94>] 
   [<c011120c>] [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] 
   [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c258>] 
   [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c258>] [<c010c21b>] 
   [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c258>] [<c010c21b>] [<c010c269>] 
   [<c0106e94>] [<c011120c>] [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] 
   [<c011120c>] [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] 
   [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c258>] 
   [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c258>] [<c010c21b>] 
   [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c258>] [<c010c21b>] [<c010c269>] 
   [<c0106e94>] [<c011120c>] [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] 
   [<c011120c>] [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] 
   [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c258>] 
   [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c258>] [<c010c21b>] 
   [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c258>] [<c010c21b>] [<c010c269>] 
   [<c0106e94>] [<c011120c>] [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] 
   [<c011120c>] [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] 
   [<c010c258>] [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c258>] 
   [<c010c21b>] [<c010c269>] [<c0106e94>] [<c011120c>] [<c010c2
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; c01186c8 <rm_from_queue+24/60>   <=====
Trace; c0118718 <rm_sig_from_queue+14/18>
Trace; c011886d <handle_stop_signal+41/74>
Trace; c0118a2d <send_sig_info+49/a4>
Trace; c0118cc5 <send_sig+1d/24>
Trace; c0117c33 <update_one_process+83/d8>
Trace; c0117ca5 <update_process_times+1d/94>
Trace; c0117ff3 <do_timer+23/70>
Trace; c010ac86 <timer_interrupt+62/120>
Trace; c0107fef <handle_IRQ_event+2f/58>
Trace; c010814e <do_IRQ+6e/b0>
Trace; c0106e20 <ret_from_intr+0/7>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c0185600 <sk_run_filter+3cc/400>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>
Trace; c010c258 <do_machine_check+0/18>
Trace; c010c21b <pentium_machine_check+1f/3c>
Trace; c010c269 <do_machine_check+11/18>
Trace; c0106e94 <error_code+34/40>
Trace; c011120c <printk+140/160>


1 warning issued.  Results may not be reliable.


-------------------------------------------------------------------------
   Jens Hoefkens                                   Phone:  517-333-6441
   NSCL / MSU                                      Mobile: 517-402-6251
   East Lansing, MI 48824                          Fax:    517-353-5967
   USA   
   
   http://bt.nscl.msu.edu/~hoefkens
-------------------------------------------------------------------------



