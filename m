Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277721AbRJROTc>; Thu, 18 Oct 2001 10:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277724AbRJROTX>; Thu, 18 Oct 2001 10:19:23 -0400
Received: from adsl-65-65-114-205.dsl.rcsntx.swbell.net ([65.65.114.205]:5381
	"EHLO router.localdomain") by vger.kernel.org with ESMTP
	id <S277721AbRJROTI>; Thu, 18 Oct 2001 10:19:08 -0400
Date: Thu, 18 Oct 2001 09:16:59 -0500 (CDT)
From: Michael Schout <mschout@gkg.net>
X-X-Sender: <mschout@mike.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: OOPS in 2.2.19 : Unable to handle kernel NULL pointer dereference
 (more crashes)
Message-ID: <20011018091613.Q39861-100000@mike.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

OOPS in 2.2.19 : Unable to handle kernel NULL pointer dereference (more crashes)

[2.] Full description of the problem/report:

kernel 2.2.19 produces this oops randomly on my machine, often locking up the
machine or portions of the machine entirely.

[3.] Keywords (i.e., modules, networking, kernel):

kernel, filesystem, raid, smp

[4.] Kernel version (from /proc/version):

Linux version 2.2.19 (root@deathstar.gkg-com.com) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 SMP Fri Apr 27 10:49:53 CDT 2001

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)


Options used: -V (default)
              -o /lib/modules/2.2.19 (specified)
              -k /proc/ksyms (specified)
              -l /proc/modules (specified)
              -m /boot/System.map-2.2.19 (specified)
              -c 1 (default)

Oct 14 07:02:28 deathstar kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000100
Oct 14 07:02:28 deathstar kernel: current->tss.cr3 = 164f6000, %%cr3 = 164f6000
Oct 14 07:02:28 deathstar kernel: *pde = 00000000
Oct 14 07:02:28 deathstar kernel: Oops: 0000
Oct 14 07:02:28 deathstar kernel: CPU:    0
Oct 14 07:02:28 deathstar kernel: EIP:    0010:[find_buffer+104/144]
Oct 14 07:02:28 deathstar kernel: EFLAGS: 00010206
Oct 14 07:02:28 deathstar kernel: eax: 00000100   ebx: 00000007   ecx: 00012632   edx: 00000100
Oct 14 07:02:28 deathstar kernel: esi: 0000000d   edi: 00003006   ebp: 00065cfc   esp: d78b1e38
Oct 14 07:02:28 deathstar kernel: ds: 0018   es: 0018   ss: 0018
Oct 14 07:02:28 deathstar kernel: Process postmaster (pid: 28628, process nr: 35, stackpage=d78b1000)
Oct 14 07:02:28 deathstar kernel: Stack: 0000012c e6483540 00012632 c012bd04 00003006 00065cfc 00001000 00003006
Oct 14 07:02:28 deathstar kernel:        c012caec 00003006 00065cfc 00001000 00000000 d78b1ee8 0000012c ec169d18
Oct 14 07:02:28 deathstar kernel:        ec169d18 d78b1eb4 c80ef000 00003006 00000000 e6483540 c6a53720 00000000
Oct 14 07:02:28 deathstar kernel: Call Trace: [get_hash_table+24/76] [brw_page+336/904] [ext2_bmap+110/132] [generic_readpage+129/144] [try_to_read
Oct 14 07:02:28 deathstar kernel: Code: 8b 00 39 6a 04 75 15 8b 4c 24 20 39 4a 08 75 0c 66 39 7a 0c

Code:  00000000 Before first symbol            00000000 <_IP>: <===
Code:  00000000 Before first symbol               0:	8b 00                	mov    (%eax),%eax <===
Code:  00000002 Before first symbol               2:	39 6a 04             	cmp    %ebp,0x4(%edx)
Code:  00000005 Before first symbol               5:	75 15                	jne     0000001c Before first symbol
Code:  00000007 Before first symbol               7:	8b 4c 24 20          	mov    0x20(%esp,1),%ecx
Code:  0000000b Before first symbol               b:	39 4a 08             	cmp    %ecx,0x8(%edx)
Code:  0000000e Before first symbol               e:	75 0c                	jne     0000001c Before first symbol
Code:  00000010 Before first symbol              10:	66 39 7a 0c          	cmp    %di,0xc(%edx)

---------------------------------------------------------------

Options used: -V (default)
              -o /lib/modules/2.2.19 (specified)
              -k /proc/ksyms (specified)
              -l /proc/modules (specified)
              -m /boot/System.map-2.2.19 (specified)
              -c 1 (default)

Oct 14 07:58:13 deathstar kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000134
Oct 14 07:58:13 deathstar kernel: current->tss.cr3 = 28422000, %%cr3 = 28422000
Oct 14 07:58:13 deathstar kernel: *pde = 00000000
Oct 14 07:58:13 deathstar kernel: Oops: 0002
Oct 14 07:58:13 deathstar kernel: CPU:    0
Oct 14 07:58:13 deathstar kernel: EIP:    0010:[remove_from_queues+188/344]
Oct 14 07:58:13 deathstar kernel: EFLAGS: 00010206
Oct 14 07:58:13 deathstar kernel: eax: 00000100   ebx: de21ae40   ecx: de21ae40   edx: efc498c8
Oct 14 07:58:13 deathstar kernel: esi: 0000000c   edi: 00000000   ebp: 00000003   esp: e0651ebc
Oct 14 07:58:13 deathstar kernel: ds: 0018   es: 0018   ss: 0018
Oct 14 07:58:13 deathstar kernel: Process postmaster (pid: 28709, process nr: 65, stackpage=e0651000)
Oct 14 07:58:13 deathstar kernel: Stack: 00064cfc c012baf2 de21ae40 de21ae40 ee92e140 c012c372 de21ae40 c01485cd
Oct 14 07:58:13 deathstar kernel:        de21ae40 00000000 c0ce9260 00000000 c0ce9334 00001000 c3232738 00000008
Oct 14 07:58:13 deathstar kernel:        00000400 00064cf9 00000000 000001ce c0148983 c0ce9260 0000000c c0ce9330
Oct 14 07:58:13 deathstar kernel: Call Trace: [put_last_free+50/124] [__bforget+34/40] [trunc_indirect+493/668] [ext2_truncate+115/508] [ext2_delet
Oct 14 07:58:13 deathstar kernel: Code: 89 50 34 c7 01 00 00 00 00 89 02 c7 41 34 00 00 00 00 ff 0d

Code:  00000000 Before first symbol            00000000 <_IP>: <===
Code:  00000000 Before first symbol               0:	89 50 34             	mov    %edx,0x34(%eax) <===
Code:  00000003 Before first symbol               3:	c7 01 00 00 00 00    	movl   $0x0,(%ecx)
Code:  00000009 Before first symbol               9:	89 02                	mov    %eax,(%edx)
Code:  0000000b Before first symbol               b:	c7 41 34 00 00 00 00 	movl   $0x0,0x34(%ecx)
Code:  00000012 Before first symbol              12:	ff 0d 00 00 00 00    	decl   0x0

---------------------------------------------------------------

Options used: -V (default)
              -o /lib/modules/2.2.19 (specified)
              -k /proc/ksyms (specified)
              -l /proc/modules (specified)
              -m /boot/System.map-2.2.19 (specified)
              -c 1 (default)

Oct 17 09:01:18 deathstar kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000134
Oct 17 09:01:18 deathstar kernel: current->tss.cr3 = 00101000, %%cr3 = 00101000
Oct 17 09:01:18 deathstar kernel: *pde = 00000000
Oct 17 09:01:18 deathstar kernel: Oops: 0002
Oct 17 09:01:18 deathstar kernel: CPU:    1
Oct 17 09:01:19 deathstar kernel: EIP:    0010:[remove_from_queues+188/344]
Oct 17 09:01:19 deathstar kernel: EFLAGS: 00010206
Oct 17 09:01:19 deathstar kernel: eax: 00000100   ebx: df622e40   ecx: df622e40   edx: efd0ba10
Oct 17 09:01:19 deathstar kernel: esi: df622e40   edi: 00000000   ebp: c07ff820   esp: effdff88
Oct 17 09:01:19 deathstar kernel: ds: 0018   es: 0018   ss: 0018
Oct 17 09:01:19 deathstar kernel: Process kswapd (pid: 4, process nr: 5, stackpage=effdf000)
Oct 17 09:01:19 deathstar kernel: Stack: df622e40 c012cf91 df622e40 c07ff820 0000998e effde000 00000030 c0121397
Oct 17 09:01:19 deathstar kernel:        c07ff820 00000030 00000010 00000005 00000030 effde000 c0126746 00000005
Oct 17 09:01:19 deathstar kernel:        00000030 effde000 c01ea82e effde2c1 00001000 c0126817 00000030 00000f00
Oct 17 09:01:19 deathstar kernel: Call Trace: [try_to_free_buffers+53/164] [shrink_mmap+259/352] [try_to_free_pages+66/176] [tvecs+7374/14016] [ksw
Oct 17 09:01:19 deathstar kernel: Code: 89 50 34 c7 01 00 00 00 00 89 02 c7 41 34 00 00 00 00 ff 0d

Code:  00000000 Before first symbol            00000000 <_IP>: <===
Code:  00000000 Before first symbol               0:	89 50 34             	mov    %edx,0x34(%eax) <===
Code:  00000003 Before first symbol               3:	c7 01 00 00 00 00    	movl   $0x0,(%ecx)
Code:  00000009 Before first symbol               9:	89 02                	mov    %eax,(%edx)
Code:  0000000b Before first symbol               b:	c7 41 34 00 00 00 00 	movl   $0x0,0x34(%ecx)
Code:  00000012 Before first symbol              12:	ff 0d 00 00 00 00    	decl   0x0

[6.] A small shell script or example program which triggers the
     problem (if possible)

None available.  This happens randomly.  Sometimes within a few days, sometimes
it takes weeks.

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)

Linux deathstar.gkg-com.com 2.2.19 #1 SMP Fri Apr 27 10:49:53 CDT 2001 i686 unknown

Gnu C                  egcs-2.91.66
Gnu make               3.78.1
binutils               2.9.5.0.22
util-linux             2.10r
modutils               2.3.21
e2fsprogs              1.18
pcmcia-cs              3.1.8
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         3c59x DAC960

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 501.143
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr xmm
bogomips        : 999.42

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 501.143
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr xmm
bogomips        : 999.42

[7.3.] Module information (from /proc/modules):

3c59x                  22480   2 (autoclean)
DAC960                 60848   3

[7.4.] SCSI information (from /proc/scsi/scsi)

# cat /proc/rd/c0/current_status
***** DAC960 RAID Driver Version 2.2.10 of 1 February 2001 *****
Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>
Configuring Mylex DAC960PTL1 PCI RAID Controller
  Firmware Version: 4.08-0-37, Channels: 1, Memory Size: 8MB
  PCI Bus: 0, Device: 18, Function: 1, I/O Address: Unassigned
  PCI Address: 0xFC8FE000 mapped at 0xF0810000, IRQ Channel: 18
  Controller Queue Depth: 124, Maximum Blocks per Command: 128
  Driver Queue Depth: 123, Scatter/Gather Limit: 33 of 33 Segments
  Stripe Size: 64KB, Segment Size: 8KB, BIOS Geometry: 255/63
  Physical Devices:
    0:0  Vendor: SEAGATE   Model: ST39175LW         Revision: 0001
         Serial Number: 3AL0NXK100007008KQ52
         Disk Status: Online, 17782784 blocks
    0:1  Vendor: SEAGATE   Model: ST39175LW         Revision: 0001
         Serial Number: 3AL0P60T00007012R69K
         Disk Status: Online, 17782784 blocks
    0:2  Vendor: SEAGATE   Model: ST39175LW         Revision: 0001
         Serial Number: 3AL0P4VE00007012R7QV
         Disk Status: Online, 17782784 blocks
    0:3  Vendor: SEAGATE   Model: ST39175LW         Revision: 0001
         Serial Number: 3AL0P3V700001005HKUC
         Disk Status: Standby, 17782784 blocks
    0:4  Vendor: SEAGATE   Model: ST39175LW         Revision: 0001
         Serial Number: 3AL0P3SW000070113RRF
         Disk Status: Online, 17782784 blocks
    0:5  Vendor: SEAGATE   Model: ST39175LW         Revision: 0001
         Serial Number: 3AL0P1MV00007012RDGX
         Disk Status: Online, 17782784 blocks
  Logical Drives:
    /dev/rd/c0d0: RAID-5, Online, 71131136 blocks, Write Thru
  No Rebuild or Consistency Check in Progress

[7.5.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

This problem seems to occur when writing to the dac960 array usually.  I dont
know if that is coincidence or if the dac960 is the problem?

[X.] Other notes, patches, fixes, workarounds:

I've reported this (or a similar) oops several other times.  See:

http://groups.google.com/groups?selm=Pine.LNX.4.10.10106271124500.17066-100000%40galaxy.gkg-com.com
http://groups.google.com/groups?selm=linux.raid.Pine.LNX.4.10.10107161322570.12406-100000%40galaxy.gkg-com.com
http://groups.google.com/groups?selm=linux.raid.Pine.LNX.4.10.10108271318300.31572-100000%40galaxy.gkg-com.com

Nobody seems to have any ideas on how to fix / whats causing it.

Mike

Hal 9000 - "Put down those Windows disks Dave....  Dave?  DAVE!!"

