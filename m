Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136017AbREBWXY>; Wed, 2 May 2001 18:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136020AbREBWXO>; Wed, 2 May 2001 18:23:14 -0400
Received: from vsat-148-75-225-142.ssa7.mcl.starband.net ([148.75.225.142]:28295
	"HELO SoftwareHackery.Com") by vger.kernel.org with SMTP
	id <S136017AbREBWWz>; Wed, 2 May 2001 18:22:55 -0400
Date: Wed, 2 May 2001 18:22:32 -0400 (EDT)
From: Marc Evans <Marc@SoftwareHackery.Com>
To: <linux-kernel@vger.kernel.org>
Subject: Build problems 2.4.4 on SPARC
Message-ID: <Pine.LNX.4.33.0105021810000.11768-100000@SoftwareHackery.Com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello -

While trying to compile the 2.4.4 kernel on a SPARC-20, I encounter the
following error.

[1.] One line summary of the problem:

kernel 2.4.4 won't compile

[2.] Full description of the problem/report:

See item 7.7 for details

[3.] Keywords (i.e., modules, networking, kernel):

kernel

[4.] Kernel version (from /proc/version):

2.4.1

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

[6.] A small shell script or example program which triggers the
     problem (if possible)

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)

Linux SoftwareHackery.Com 2.4.1 #8 SMP Thu Feb 8 09:57:19 EST 2001 sparc unknown

Gnu C                  2.95
Gnu make               3.78.1
binutils               2.9.5.0.22
util-linux             2.10f
mount                  2.10f
modutils               2.3.10-pre1
e2fsprogs              1.18
PPP                    2.3.11
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded

[7.2.] Processor information (from /proc/cpuinfo):

cpu		: Texas Instruments, Inc. - SuperSparc-(II)
fpu		: SuperSparc on-chip FPU
promlib		: Version 3 Revision 2
prom		: 2.25
type		: sun4m
ncpus probed	: 1
ncpus active	: 1
Cpu0Bogo	: 74.75
MMU type	: TI Viking/MXCC
contexts	: 65536
nocache total	: 1048576
nocache used	: 736512
CPU0		: online

[7.3.] Module information (from /proc/modules):

<none>

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

<none>

[7.5.] PCI information ('lspci -vvv' as root)

pcilib: Cannot open /proc/bus/pci
lspci: Cannot find any working access method.

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST15150N         Rev: AV01
  Type:   Direct-Access                    ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:

make[1]: Entering directory `/usr/src/linux-2.4.4/mm'
make all_targets
make[2]: Entering directory `/usr/src/linux-2.4.4/mm'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.4/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -m32 -pipe -mno-fpu
-fcall-used-g5 -fcall-used-g7    -c -o memory.o memory.c
memory.c:183: macro `pmd_alloc' used with too many (3) args
memory.c:204: macro `pte_alloc' used with too many (3) args
memory.c:725: macro `pte_alloc' used with too many (3) args
memory.c:750: macro `pmd_alloc' used with too many (3) args
memory.c:805: macro `pte_alloc' used with too many (3) args
memory.c:832: macro `pmd_alloc' used with too many (3) args
memory.c:1339: macro `pmd_alloc' used with too many (3) args
memory.c:1342: macro `pte_alloc' used with too many (3) args
memory.c:1392: macro `pte_alloc' used with too many (3) args
memory.c: In function `copy_page_range':
memory.c:183: warning: passing arg 1 of `___f_pmd_alloc' from incompatible pointer type
memory.c:183: warning: passing arg 2 of `___f_pmd_alloc' makes integer from pointer without a cast
memory.c:204: warning: passing arg 1 of `___f_pte_alloc' from incompatible pointer type
memory.c:204: warning: passing arg 2 of `___f_pte_alloc' makes integer from pointer without a cast
memory.c: In function `zeromap_pmd_range':
memory.c:725: warning: passing arg 1 of `___f_pte_alloc' from incompatible pointer type
memory.c:725: warning: passing arg 2 of `___f_pte_alloc' makes integer from pointer without a cast
memory.c: In function `zeromap_page_range':
memory.c:750: warning: passing arg 1 of `___f_pmd_alloc' from incompatible pointer type
memory.c:750: warning: passing arg 2 of `___f_pmd_alloc' makes integer from pointer without a cast
memory.c: In function `remap_pmd_range':
memory.c:805: warning: passing arg 1 of `___f_pte_alloc' from incompatible pointer type
memory.c:805: warning: passing arg 2 of `___f_pte_alloc' makes integer from pointer without a cast
memory.c: In function `remap_page_range':
memory.c:832: warning: passing arg 1 of `___f_pmd_alloc' from incompatible pointer type
memory.c:832: warning: passing arg 2 of `___f_pmd_alloc' makes integer from pointer without a cast
memory.c: In function `handle_mm_fault':
memory.c:1339: warning: passing arg 1 of `___f_pmd_alloc' from incompatible pointer type
memory.c:1339: warning: passing arg 2 of `___f_pmd_alloc' makes integer from pointer without a cast
memory.c:1342: warning: passing arg 1 of `___f_pte_alloc' from incompatible pointer type
memory.c:1342: warning: passing arg 2 of `___f_pte_alloc' makes integer from pointer without a cast
memory.c: In function `__pmd_alloc':
memory.c:1364: warning: implicit declaration of function `pmd_alloc_one_fast'
memory.c:1364: warning: assignment makes pointer from integer without a cast
memory.c:1367: warning: implicit declaration of function `pmd_alloc_one'
memory.c:1367: warning: assignment makes pointer from integer without a cast
memory.c:1381: warning: implicit declaration of function `pgd_populate'
memory.c: At top level:
memory.c:1393: conflicting types for `___f_pte_alloc' /usr/src/linux-2.4.4/include/asm/pgalloc.h:125: previous declaration of `___f_pte_alloc' memory.c: In function `___f_pte_alloc':
memory.c:1398: warning: implicit declaration of function `pte_alloc_one_fast'
memory.c:1398: `address' undeclared (first use in this function)
memory.c:1398: (Each undeclared identifier is reported only once
memory.c:1398: for each function it appears in.)
memory.c:1398: warning: assignment makes pointer from integer without a cast
memory.c:1401: warning: implicit declaration of function `pte_alloc_one'
memory.c:1401: warning: assignment makes pointer from integer without a cast
memory.c:1415: warning: implicit declaration of function `pmd_populate'

