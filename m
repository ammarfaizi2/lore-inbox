Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278839AbRJVOmJ>; Mon, 22 Oct 2001 10:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278840AbRJVOmB>; Mon, 22 Oct 2001 10:42:01 -0400
Received: from adsl-65-69-143-29.dsl.rcsntx.swbell.net ([65.69.143.29]:6404
	"EHLO router.localdomain") by vger.kernel.org with ESMTP
	id <S278839AbRJVOlt>; Mon, 22 Oct 2001 10:41:49 -0400
Date: Mon, 22 Oct 2001 09:39:29 -0500 (CDT)
From: Michael Schout <mschout@gkg.net>
X-X-Sender: <mschout@mike.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: OOPS in 2.2.19 : Unable to handle kernel NULL pointer dereference
Message-ID: <20011022093853.E13351-100000@mike.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

OOPS in 2.2.19 : Unable to handle kernel NULL pointer dereference

[2.] Full description of the problem/report:

kernel 2.2.19 produces this oops randomly on my machine.

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

Oct 22 08:52:09 deathstar kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000100
Oct 22 08:52:09 deathstar kernel: current->tss.cr3 = 0bd8d000, %%cr3 = 0bd8d000
Oct 22 08:52:09 deathstar kernel: *pde = 00000000
Oct 22 08:52:09 deathstar kernel: Oops: 0000
Oct 22 08:52:09 deathstar kernel: CPU:    0
Oct 22 08:52:09 deathstar kernel: EIP:    0010:[find_buffer+104/144]
Oct 22 08:52:09 deathstar kernel: EFLAGS: 00010206
Oct 22 08:52:09 deathstar kernel: eax: 00000100   ebx: 00000007   ecx: 0007ce24   edx: 00000100
Oct 22 08:52:09 deathstar kernel: esi: 0000000d   edi: 00003006   ebp: 0004852c   esp: e17cbde0
Oct 22 08:52:09 deathstar kernel: ds: 0018   es: 0018   ss: 0018
Oct 22 08:52:09 deathstar kernel: Process postmaster (pid: 24405, process nr: 57, stackpage=e17cb000)
Oct 22 08:52:09 deathstar kernel: Stack: 0004852c 00003006 0007ce24 c012bd04 00003006 0004852c 00001000 0004852c
Oct 22 08:52:09 deathstar kernel:        c012c0a6 00003006 0004852c 00001000 0004852c 0004852c e2cd2498 e2cd2498
Oct 22 08:52:09 deathstar kernel:        00001000 c0143ecd 00003006 0004852c 00001000 00000000 0004852c e2cd2498
Oct 22 08:52:09 deathstar kernel: Call Trace: [get_hash_table+24/76] [getblk+30/324] [ext2_alloc_block+109/344] [block_getblk+305/616] [ext2_getblk+139/164] [__brelse+19/52] [ext2_file_write+1296/1572] [__brelse+19/52] [ext2_create+353/368] [permission+26/44] [open_namei+486/848] [filp_open+68/240] [filp_open+172/240] [sys_write+254/320] [ext2_file_write+0/1572] [system_call+52/56]
Oct 22 08:52:09 deathstar kernel: Code: 8b 00 39 6a 04 75 15 8b 4c 24 20 39 4a 08 75 0c 66 39 7a 0c

Code:  00000000 Before first symbol            00000000 <_IP>: <===
Code:  00000000 Before first symbol               0:	8b 00                	mov    (%eax),%eax <===
Code:  00000002 Before first symbol               2:	39 6a 04             	cmp    %ebp,0x4(%edx)
Code:  00000005 Before first symbol               5:	75 15                	jne     0000001c Before first symbol
Code:  00000007 Before first symbol               7:	8b 4c 24 20          	mov    0x20(%esp,1),%ecx
Code:  0000000b Before first symbol               b:	39 4a 08             	cmp    %ecx,0x8(%edx)
Code:  0000000e Before first symbol               e:	75 0c                	jne     0000001c Before first symbol
Code:  00000010 Before first symbol              10:	66 39 7a 0c          	cmp    %di,0xc(%edx)

Oct 22 09:13:54 deathstar kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000134
Oct 22 09:13:54 deathstar kernel: current->tss.cr3 = 12e61000, %%cr3 = 12e61000
Oct 22 09:13:54 deathstar kernel: *pde = 00000000
Oct 22 09:13:54 deathstar kernel: Oops: 0002
Oct 22 09:13:54 deathstar kernel: CPU:    0
Oct 22 09:13:54 deathstar kernel: EIP:    0010:[remove_from_queues+188/344]
Oct 22 09:13:54 deathstar kernel: EFLAGS: 00010206
Oct 22 09:13:54 deathstar kernel: eax: 00000100   ebx: de2a2e40   ecx: de2a2e40   edx: efdf3890
Oct 22 09:13:54 deathstar kernel: esi: 0000000c   edi: 00000000   ebp: 00000326   esp: d2fadeb8
Oct 22 09:13:54 deathstar kernel: ds: 0018   es: 0018   ss: 0018
Oct 22 09:13:54 deathstar kernel: Process postmaster (pid: 24996, process nr: 41, stackpage=d2fad000)
Oct 22 09:13:54 deathstar kernel: Stack: 0004952c c012baf2 de2a2e40 de2a2e40 c18fcec0 c012c372 de2a2e40 c01485cd
Oct 22 09:13:54 deathstar kernel:        de2a2e40 00000000 c6416000 00000000 c64160d4 00001000 c15ffc98 00000008
Oct 22 09:13:54 deathstar kernel:        00000400 00049206 00000000 00000326 c0148983 c6416000 0000000c c64160d0
Oct 22 09:13:54 deathstar kernel: Call Trace: [put_last_free+50/124] [__bforget+34/40] [trunc_indirect+493/668] [ext2_truncate+115/508] [ext2_delete_inode+102/140] [ext2_delete_inode+124/140] [iput+155/588] [d_delete+74/104] [ext2_unlink+371/404] [vfs_unlink+225/232] [sys_unlink+142/216] [system_call+52/56]
Oct 22 09:13:54 deathstar kernel: Code: 89 50 34 c7 01 00 00 00 00 89 02 c7 41 34 00 00 00 00 ff 0d

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
http://groups.google.com/groups?selm=linux.kernel.20011018091613.Q39861-100000%40mike.localdomain
http://groups.google.com/groups?selm=linux.kernel.20011018114227.O40415-100000%40mike.localdomain

Nobody seems to have any ideas on how to fix / whats causing it.

Mike

Hal 9000 - "Put down those Windows disks Dave....  Dave?  DAVE!!"

