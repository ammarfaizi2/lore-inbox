Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293745AbSCAGxS>; Fri, 1 Mar 2002 01:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310371AbSCAGvo>; Fri, 1 Mar 2002 01:51:44 -0500
Received: from web14203.mail.yahoo.com ([216.136.172.145]:22444 "HELO
	web14203.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S310194AbSCAGti>; Fri, 1 Mar 2002 01:49:38 -0500
Message-ID: <20020301064937.97402.qmail@web14203.mail.yahoo.com>
Date: Thu, 28 Feb 2002 22:49:37 -0800 (PST)
From: Erik McKee <camhanaich99@yahoo.com>
Subject: 2.5.x compile problem
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-171122657-1014965377=:96999"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-171122657-1014965377=:96999
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

I just installed BK and did a clone of bk://linux.bkbits.com/linux-2.5 

I managed to get all files checked out and then attempted to build the kernel
with 'make dep modules modules-install bzImage.'  This flies by fine untill I
hit the md directory.  raid5.c fails to compile because of a header problem in
raid5.h.  I looked at the header file and it looks fine to me, but obviously
gcc doesn't like it.  The complete error messages are attatched below in case
more then one error is at work here.  GCC is 2.95.3.  On an unrelated note with
another question, I occasionally get a segfault in the middle of building a
kernel, no matter what version.  It can happen anywhere from make dep onwards. 
I am wondering what causes that as well.

.config attatched as well.

TIA
Erik McKee

p.s. Please cc me as I am not on the list.

make -C md
make[2]: Entering directory `/dosc/linux/drivers/md'
make all_targets
make[3]: Entering directory `/dosc/linux/drivers/md'
gcc -D__KERNEL__ -I/dosc/linux/include -Wall -Wstrict-prototypes -Wnotrigraphs
-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=k6   -DKBUILD_BASENAME=raid5  -c -o raid5.o
raid5.c
In file included from raid5.c:23:
/dosc/linux/include/linux/raid/raid5.h:218: parse error before
`md_wait_queue_head_t'
/dosc/linux/include/linux/raid/raid5.h:218: warning: no semicolon at end of
struct or union
/dosc/linux/include/linux/raid/raid5.h:222: parse error before `device_lock'
/dosc/linux/include/linux/raid/raid5.h:222: warning: type defaults to `int' in
declaration of `device_lock'
/dosc/linux/include/linux/raid/raid5.h:222: warning: data definition has no
type or storage class
/dosc/linux/include/linux/raid/raid5.h:226: parse error before `}'
raid5.c: In function `__release_stripe':
raid5.c:67: dereferencing pointer to incomplete type
raid5.c:71: dereferencing pointer to incomplete type
raid5.c:73: dereferencing pointer to incomplete type
raid5.c:74: dereferencing pointer to incomplete type
raid5.c:77: dereferencing pointer to incomplete type
raid5.c:78: dereferencing pointer to incomplete type
raid5.c:79: dereferencing pointer to incomplete type
raid5.c:81: dereferencing pointer to incomplete type
raid5.c:82: dereferencing pointer to incomplete type
raid5.c:83: dereferencing pointer to incomplete type
raid5.c:84: dereferencing pointer to incomplete type
raid5.c:85: dereferencing pointer to incomplete type
raid5.c: In function `release_stripe':
raid5.c:94: dereferencing pointer to incomplete type
raid5.c: In function `insert_hash':
raid5.c:113: dereferencing pointer to incomplete type
raid5.c:113: dereferencing pointer to incomplete type
raid5.c: In function `get_free_stripe':
raid5.c:132: dereferencing pointer to incomplete type
raid5.c:134: dereferencing pointer to incomplete type
raid5.c:138: dereferencing pointer to incomplete type
raid5.c:129: warning: `first' might be used uninitialized in this function
raid5.c: In function `init_stripe':
raid5.c:189: dereferencing pointer to incomplete type
raid5.c:202: dereferencing pointer to incomplete type
raid5.c: In function `shrink_stripe_cache':
raid5.c:227: dereferencing pointer to incomplete type
raid5.c:231: dereferencing pointer to incomplete type
raid5.c: In function `__find_stripe':
raid5.c:242: dereferencing pointer to incomplete type
raid5.c:242: dereferencing pointer to incomplete type
raid5.c:238: warning: `sh' might be used uninitialized in this function
raid5.c: In function `get_active_stripe':
raid5.c:255: warning: implicit declaration of function `md_spin_lock_irq'
raid5.c:255: dereferencing pointer to incomplete type
raid5.c:258: dereferencing pointer to incomplete type
raid5.c:259: dereferencing pointer to incomplete type
raid5.c:268: dereferencing pointer to incomplete type
raid5.c:272: dereferencing pointer to incomplete type
raid5.c:272: dereferencing pointer to incomplete type
raid5.c:272: dereferencing pointer to incomplete type
raid5.c:272: dereferencing pointer to incomplete type
raid5.c:272: dereferencing pointer to incomplete type
raid5.c:275: dereferencing pointer to incomplete type
raid5.c:275: dereferencing pointer to incomplete type
raid5.c:276: dereferencing pointer to incomplete type
raid5.c:278: dereferencing pointer to incomplete type
raid5.c:278: dereferencing pointer to incomplete type
raid5.c:278: dereferencing pointer to incomplete type
raid5.c:278: dereferencing pointer to incomplete type
raid5.c:278: dereferencing pointer to incomplete type
raid5.c:278: dereferencing pointer to incomplete type
raid5.c:278: dereferencing pointer to incomplete type
raid5.c:284: dereferencing pointer to incomplete type
raid5.c:288: dereferencing pointer to incomplete type
raid5.c:294: dereferencing pointer to incomplete type
raid5.c:298: dereferencing pointer to incomplete type
raid5.c:303: dereferencing pointer to incomplete type
raid5.c:305: dereferencing pointer to incomplete type
raid5.c:306: dereferencing pointer to incomplete type
raid5.c:307: dereferencing pointer to incomplete type
raid5.c:307: dereferencing pointer to incomplete type
raid5.c:307: dereferencing pointer to incomplete type
raid5.c:307: dereferencing pointer to incomplete type
raid5.c:307: dereferencing pointer to incomplete type
raid5.c:307: dereferencing pointer to incomplete type
raid5.c:307: dereferencing pointer to incomplete type
raid5.c:309: dereferencing pointer to incomplete type
raid5.c:318: dereferencing pointer to incomplete type
raid5.c:329: warning: implicit declaration of function `md_spin_unlock_irq'
raid5.c:329: dereferencing pointer to incomplete type
raid5.c: In function `grow_stripes':
raid5.c:345: dereferencing pointer to incomplete type
raid5.c:346: dereferencing pointer to incomplete type
raid5.c:352: dereferencing pointer to incomplete type
raid5.c: In function `shrink_stripes':
raid5.c:364: dereferencing pointer to incomplete type
raid5.c:371: dereferencing pointer to incomplete type
raid5.c:373: dereferencing pointer to incomplete type
raid5.c: In function `raid5_end_read_request':
raid5.c:382: dereferencing pointer to incomplete type
raid5.c:397: dereferencing pointer to incomplete type
raid5.c:408: structure has no member named `b_reqnext'
raid5.c:409: structure has no member named `b_reqnext'
raid5.c:421: dereferencing pointer to incomplete type
raid5.c: In function `raid5_end_write_request':
raid5.c:440: dereferencing pointer to incomplete type
raid5.c:453: warning: implicit declaration of function `md_spin_lock_irqsave'
raid5.c:453: dereferencing pointer to incomplete type
raid5.c:455: dereferencing pointer to incomplete type
raid5.c:459: warning: implicit declaration of function
`md_spin_unlock_irqrestore'
raid5.c:459: dereferencing pointer to incomplete type
raid5.c: In function `raid5_build_block':
raid5.c:471: dereferencing pointer to incomplete type
raid5.c: In function `raid5_error':
raid5.c:490: dereferencing pointer to incomplete type
raid5.c:490: warning: value computed is not used
raid5.c:490: dereferencing pointer to incomplete type
raid5.c:501: dereferencing pointer to incomplete type
raid5.c:502: dereferencing pointer to incomplete type
raid5.c:503: dereferencing pointer to incomplete type
raid5.c:507: dereferencing pointer to incomplete type
raid5.c:515: dereferencing pointer to incomplete type
raid5.c:516: dereferencing pointer to incomplete type
raid5.c:521: dereferencing pointer to incomplete type
raid5.c:527: dereferencing pointer to incomplete type
raid5.c:536: dereferencing pointer to incomplete type
raid5.c:485: warning: `disk' might be used uninitialized in this function
raid5.c: In function `raid5_compute_sector':
raid5.c:557: dereferencing pointer to incomplete type
raid5.c:580: dereferencing pointer to incomplete type
raid5.c:582: dereferencing pointer to incomplete type
raid5.c:602: dereferencing pointer to incomplete type
raid5.c:584: warning: unreachable code at beginning of switch statement
raid5.c: In function `compute_block':
raid5.c:664: dereferencing pointer to incomplete type
raid5.c: In function `compute_parity':
raid5.c:692: dereferencing pointer to incomplete type
raid5.c:712: structure has no member named `b_reqnext'
raid5.c:713: structure has no member named `b_reqnext'
raid5.c:724: structure has no member named `b_reqnext'
raid5.c:725: structure has no member named `b_reqnext'
raid5.c: In function `add_stripe_bh':
raid5.c:784: dereferencing pointer to incomplete type
raid5.c:785: structure has no member named `b_reqnext'
raid5.c:792: structure has no member named `b_reqnext'
raid5.c: In function `handle_stripe':
raid5.c:826: dereferencing pointer to incomplete type
raid5.c:852: dereferencing pointer to incomplete type
raid5.c:861: structure has no member named `b_reqnext'
raid5.c:862: structure has no member named `b_reqnext'
raid5.c:876: dereferencing pointer to incomplete type
raid5.c:891: structure has no member named `b_reqnext'
raid5.c:892: structure has no member named `b_reqnext'
raid5.c:896: dereferencing pointer to incomplete type
raid5.c:897: dereferencing pointer to incomplete type
raid5.c:900: structure has no member named `b_reqnext'
raid5.c:901: structure has no member named `b_reqnext'
raid5.c:909: dereferencing pointer to incomplete type
raid5.c:919: dereferencing pointer to incomplete type
raid5.c:926: dereferencing pointer to incomplete type
raid5.c:934: structure has no member named `b_reqnext'
raid5.c:935: structure has no member named `b_reqnext'
raid5.c:958: dereferencing pointer to incomplete type
raid5.c:964: structure has no member named `b_reqnext'
raid5.c:973: dereferencing pointer to incomplete type
raid5.c:989: dereferencing pointer to incomplete type
raid5.c:999: dereferencing pointer to incomplete type
raid5.c:1011: dereferencing pointer to incomplete type
raid5.c:1030: dereferencing pointer to incomplete type
raid5.c:1053: dereferencing pointer to incomplete type
raid5.c:1058: dereferencing pointer to incomplete type
raid5.c:1059: dereferencing pointer to incomplete type
raid5.c:1060: dereferencing pointer to incomplete type
raid5.c:1102: dereferencing pointer to incomplete type
raid5.c:1103: dereferencing pointer to incomplete type
raid5.c:1104: dereferencing pointer to incomplete type
raid5.c:1110: dereferencing pointer to incomplete type
raid5.c:1118: structure has no member named `b_reqnext'
raid5.c:1119: structure has no member named `b_reqnext'
raid5.c:1123: structure has no member named `b_reqnext'
raid5.c:1124: structure has no member named `b_reqnext'
raid5.c:1130: dereferencing pointer to incomplete type
raid5.c:1136: dereferencing pointer to incomplete type
raid5.c:1137: dereferencing pointer to incomplete type
raid5.c:1145: structure has no member named `b_rdev'
raid5.c:1146: structure has no member named `b_rsector'
raid5.c:1147: warning: passing arg 1 of `generic_make_request' makes pointer
frominteger without a cast
raid5.c:1147: too many arguments to function `generic_make_request'
raid5.c: In function `raid5_activate_delayed':
raid5.c:1158: dereferencing pointer to incomplete type
raid5.c:1159: dereferencing pointer to incomplete type
raid5.c:1160: dereferencing pointer to incomplete type
raid5.c:1166: dereferencing pointer to incomplete type
raid5.c:1167: dereferencing pointer to incomplete type
raid5.c: In function `raid5_unplug_device':
raid5.c:1176: dereferencing pointer to incomplete type
raid5.c:1180: dereferencing pointer to incomplete type
raid5.c:1181: dereferencing pointer to incomplete type
raid5.c: In function `raid5_plug_device':
raid5.c:1188: dereferencing pointer to incomplete type
raid5.c:1189: dereferencing pointer to incomplete type
raid5.c:1190: dereferencing pointer to incomplete type
raid5.c:1191: dereferencing pointer to incomplete type
raid5.c:1192: dereferencing pointer to incomplete type
raid5.c: In function `raid5_make_request':
raid5.c:1200: dereferencing pointer to incomplete type
raid5.c:1213: structure has no member named `b_rsector'
raid5.c: In function `raid5_sync_request':
raid5.c:1235: dereferencing pointer to incomplete type
raid5.c:1240: dereferencing pointer to incomplete type
raid5.c: In function `raid5d':
raid5.c:1274: dereferencing pointer to incomplete type
raid5.c:1285: dereferencing pointer to incomplete type
raid5.c:1289: dereferencing pointer to incomplete type
raid5.c:1290: dereferencing pointer to incomplete type
raid5.c:1291: dereferencing pointer to incomplete type
raid5.c:1292: dereferencing pointer to incomplete type
raid5.c:1295: dereferencing pointer to incomplete type
raid5.c:1298: dereferencing pointer to incomplete type
raid5.c:1305: dereferencing pointer to incomplete type
raid5.c:1311: dereferencing pointer to incomplete type
raid5.c:1315: dereferencing pointer to incomplete type
raid5.c:1287: warning: `first' might be used uninitialized in this function
raid5.c: In function `raid5syncd':
raid5.c:1328: dereferencing pointer to incomplete type
raid5.c:1330: dereferencing pointer to incomplete type
raid5.c:1332: dereferencing pointer to incomplete type
raid5.c:1340: dereferencing pointer to incomplete type
raid5.c: In function `raid5_run':
raid5.c:1364: sizeof applied to an incomplete type
raid5.c:1367: dereferencing pointer to incomplete type
raid5.c:1367: dereferencing pointer to incomplete type
raid5.c:1367: dereferencing pointer to incomplete type
raid5.c:1367: dereferencing pointer to incomplete type
raid5.c:1367: dereferencing pointer to incomplete type
raid5.c:1367: dereferencing pointer to incomplete type
raid5.c:1368: dereferencing pointer to incomplete type
raid5.c:1370: dereferencing pointer to incomplete type
raid5.c:1370: warning: implicit declaration of function `md__get_free_pages'
raid5.c:1372: dereferencing pointer to incomplete type
raid5.c:1372: dereferencing pointer to incomplete type
raid5.c:1372: dereferencing pointer to incomplete type
raid5.c:1372: dereferencing pointer to incomplete type
raid5.c:1374: dereferencing pointer to incomplete type
raid5.c:1374: `MD_SPIN_LOCK_UNLOCKED' undeclared (first use in this function)
raid5.c:1374: (Each undeclared identifier is reported only once
raid5.c:1374: for each function it appears in.)
raid5.c:1375: warning: implicit declaration of function
`md_init_waitqueue_head'
raid5.c:1375: dereferencing pointer to incomplete type
raid5.c:1376: dereferencing pointer to incomplete type
raid5.c:1376: dereferencing pointer to incomplete type
raid5.c:1376: dereferencing pointer to incomplete type
raid5.c:1376: dereferencing pointer to incomplete type
raid5.c:1377: dereferencing pointer to incomplete type
raid5.c:1377: dereferencing pointer to incomplete type
raid5.c:1377: dereferencing pointer to incomplete type
raid5.c:1377: dereferencing pointer to incomplete type
raid5.c:1378: dereferencing pointer to incomplete type
raid5.c:1378: dereferencing pointer to incomplete type
raid5.c:1378: dereferencing pointer to incomplete type
raid5.c:1378: dereferencing pointer to incomplete type
raid5.c:1379: dereferencing pointer to incomplete type
raid5.c:1380: dereferencing pointer to incomplete type
raid5.c:1381: dereferencing pointer to incomplete type
raid5.c:1383: dereferencing pointer to incomplete type
raid5.c:1384: dereferencing pointer to incomplete type
raid5.c:1385: dereferencing pointer to incomplete type
raid5.c:1386: dereferencing pointer to incomplete type
raid5.c:1390: warning: assignment from incompatible pointer type
raid5.c:1390: dereferencing pointer to incomplete type
raid5.c:1390: dereferencing pointer to incomplete type
raid5.c:1390: warning: left-hand operand of comma expression has no effect
raid5.c:1398: dereferencing pointer to incomplete type
raid5.c:1438: dereferencing pointer to incomplete type
raid5.c:1458: dereferencing pointer to incomplete type
raid5.c:1461: dereferencing pointer to incomplete type
raid5.c:1474: dereferencing pointer to incomplete type
raid5.c:1478: dereferencing pointer to incomplete type
raid5.c:1478: dereferencing pointer to incomplete type
raid5.c:1478: dereferencing pointer to incomplete type
raid5.c:1479: dereferencing pointer to incomplete type
raid5.c:1480: dereferencing pointer to incomplete type
raid5.c:1481: dereferencing pointer to incomplete type
raid5.c:1482: dereferencing pointer to incomplete type
raid5.c:1483: dereferencing pointer to incomplete type
raid5.c:1493: dereferencing pointer to incomplete type
raid5.c:1493: dereferencing pointer to incomplete type
raid5.c:1494: dereferencing pointer to incomplete type
raid5.c:1497: dereferencing pointer to incomplete type
raid5.c:1498: dereferencing pointer to incomplete type
raid5.c:1501: dereferencing pointer to incomplete type
raid5.c:1502: dereferencing pointer to incomplete type
raid5.c:1502: dereferencing pointer to incomplete type
raid5.c:1506: dereferencing pointer to incomplete type
raid5.c:1514: dereferencing pointer to incomplete type
raid5.c:1515: dereferencing pointer to incomplete type
raid5.c:1521: dereferencing pointer to incomplete type
raid5.c:1522: dereferencing pointer to incomplete type
raid5.c:1523: dereferencing pointer to incomplete type
raid5.c:1525: dereferencing pointer to incomplete type
raid5.c:1537: dereferencing pointer to incomplete type
raid5.c:1539: dereferencing pointer to incomplete type
raid5.c:1543: dereferencing pointer to incomplete type
raid5.c:1546: dereferencing pointer to incomplete type
raid5.c:1546: dereferencing pointer to incomplete type
raid5.c:1548: dereferencing pointer to incomplete type
raid5.c:1548: dereferencing pointer to incomplete type
raid5.c:1553: dereferencing pointer to incomplete type
raid5.c:1554: dereferencing pointer to incomplete type
raid5.c:1560: dereferencing pointer to incomplete type
raid5.c:1561: dereferencing pointer to incomplete type
raid5.c:1574: dereferencing pointer to incomplete type
raid5.c:1575: dereferencing pointer to incomplete type
raid5.c: In function `raid5_stop_resync':
raid5.c:1588: dereferencing pointer to incomplete type
raid5.c:1591: dereferencing pointer to incomplete type
raid5.c:1592: dereferencing pointer to incomplete type
raid5.c: In function `raid5_restart_resync':
raid5.c:1606: dereferencing pointer to incomplete type
raid5.c:1607: dereferencing pointer to incomplete type
raid5.c:1612: dereferencing pointer to incomplete type
raid5.c:1613: dereferencing pointer to incomplete type
raid5.c: In function `raid5_stop':
raid5.c:1625: dereferencing pointer to incomplete type
raid5.c:1626: dereferencing pointer to incomplete type
raid5.c:1627: dereferencing pointer to incomplete type
raid5.c:1628: dereferencing pointer to incomplete type
raid5.c:1629: dereferencing pointer to incomplete type
raid5.c: In function `raid5_status':
raid5.c:1678: dereferencing pointer to incomplete type
raid5.c:1678: dereferencing pointer to incomplete type
raid5.c:1679: dereferencing pointer to incomplete type
raid5.c:1680: dereferencing pointer to incomplete type
raid5.c: In function `print_raid5_conf':
raid5.c:1700: dereferencing pointer to incomplete type
raid5.c:1701: dereferencing pointer to incomplete type
raid5.c:1701: dereferencing pointer to incomplete type
raid5.c:1706: dereferencing pointer to incomplete type
raid5.c:1706: dereferencing pointer to incomplete type
raid5.c:1708: dereferencing pointer to incomplete type
raid5.c: In function `raid5_diskop':
raid5.c:1727: dereferencing pointer to incomplete type
raid5.c:1739: dereferencing pointer to incomplete type
raid5.c:1740: dereferencing pointer to incomplete type
raid5.c:1751: dereferencing pointer to incomplete type
raid5.c:1765: dereferencing pointer to incomplete type
raid5.c:1766: dereferencing pointer to incomplete type
raid5.c:1782: dereferencing pointer to incomplete type
raid5.c:1801: dereferencing pointer to incomplete type
raid5.c:1802: dereferencing pointer to incomplete type
raid5.c:1821: dereferencing pointer to incomplete type
raid5.c:1826: dereferencing pointer to incomplete type
raid5.c:1829: dereferencing pointer to incomplete type
raid5.c:1835: dereferencing pointer to incomplete type
raid5.c:1841: dereferencing pointer to incomplete type
raid5.c:1842: dereferencing pointer to incomplete type
raid5.c:1852: dereferencing pointer to incomplete type
raid5.c:1857: dereferencing pointer to incomplete type
raid5.c:1858: dereferencing pointer to incomplete type
raid5.c:1938: dereferencing pointer to incomplete type
raid5.c:1939: dereferencing pointer to incomplete type
raid5.c:1940: dereferencing pointer to incomplete type
raid5.c:1945: dereferencing pointer to incomplete type
raid5.c:1947: dereferencing pointer to incomplete type
raid5.c:1958: dereferencing pointer to incomplete type
raid5.c:1985: dereferencing pointer to incomplete type
raid5.c:1719: warning: `i' might be used uninitialized in this function
raid5.c:1721: warning: `tmp' might be used uninitialized in this function
raid5.c:1721: warning: `sdisk' might be used uninitialized in this function
raid5.c:1721: warning: `adisk' might be used uninitialized in this function
raid5.c: At top level:
raid5.c:1993: warning: initialization from incompatible pointer type
raid5.c:2002: warning: initialization from incompatible pointer type
raid5.c:2004: parse error before `raid5_init'
raid5.c:2005: warning: return-type defaults to `int'
make[3]: *** [raid5.o] Error 1
make[3]: Leaving directory `/dosc/linux/drivers/md'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/dosc/linux/drivers/md'
make[1]: *** [_subdir_md] Error 2
make[1]: Leaving directory `/dosc/linux/drivers'
make: *** [_dir_drivers] Error 2

__________________________________________________
Do You Yahoo!?
Yahoo! Greetings - Send FREE e-cards for every occasion!
http://greetings.yahoo.com
--0-171122657-1014965377=:96999
Content-Type: text/plain; name="dot.config.txt"
Content-Description: dot.config.txt
Content-Disposition: inline; filename="dot.config.txt"

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
CONFIG_MK6=y
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM4G_HIGHPTE is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_HIGHMEM64G_HIGHPTE is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set
CONFIG_HAVE_DEC_LOCK=y

#
# General options
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
# CONFIG_HOTPLUG_PCI_IBM is not set
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
# CONFIG_PM is not set
# CONFIG_ACPI is not set
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=y
CONFIG_MD_MULTIPATH=y
CONFIG_BLK_DEV_LVM=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
# CONFIG_IP_ROUTE_MULTIPATH is not set
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_ROUTE_LARGE_TABLES is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_NAT_NEEDED=y
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
CONFIG_IPV6=m

#
#   IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_KHTTPD=m
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
CONFIG_IPX=m
# CONFIG_IPX_INTERN is not set
CONFIG_ATALK=m
# CONFIG_DECNET is not set
CONFIG_BRIDGE=m
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
CONFIG_IDE_TASK_IOCTL=y
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_PCI_WIP=y
# CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
CONFIG_IDEDMA_NEW_DRIVE_LISTINGS=y
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC_ADMA is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
CONFIG_IDEDMA_IVB=y
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Appletalk devices
#
# CONFIG_APPLETALK is not set
# CONFIG_LTPC is not set
# CONFIG_COPS is not set
# CONFIG_IPDDP is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
CONFIG_EL16=m
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
CONFIG_VORTEX=y
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
CONFIG_NET_ISA=y
# CONFIG_E2100 is not set
# CONFIG_EWRK3 is not set
# CONFIG_EEXPRESS is not set
# CONFIG_EEXPRESS_PRO is not set
# CONFIG_HPLAN_PLUS is not set
# CONFIG_HPLAN is not set
# CONFIG_LP486E is not set
# CONFIG_ETH16I is not set
CONFIG_NE2000=y
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_DE2104X is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
# CONFIG_EEPRO100 is not set
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
CONFIG_NE2K_PCI=y
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_NEW_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
# CONFIG_SLIP_SMART is not set
# CONFIG_SLIP_MODE_SLIP6 is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
CONFIG_SHAPER=m

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input device support
#
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m
CONFIG_GAMEPORT=m
CONFIG_SOUND_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
# CONFIG_GAMEPORT_L4 is not set
CONFIG_INPUT_EMU10K1=m
# CONFIG_GAMEPORT_PCIGAME is not set
# CONFIG_GAMEPORT_FM801 is not set
# CONFIG_GAMEPORT_CS461x is not set
CONFIG_SERIO=m
CONFIG_SERIO_SERPORT=m
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE_USB is not set
# CONFIG_JOYSTICK_IFORCE_232 is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_DB9 is not set
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_SOFT_WATCHDOG=y
# CONFIG_WDT is not set
# CONFIG_WDTPCI is not set
# CONFIG_PCWATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_I810_TCO is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_60XX_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_INTEL_RNG is not set
CONFIG_NVRAM=m
CONFIG_RTC=m
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
CONFIG_AGP_ALI=y
# CONFIG_AGP_SWORKS is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_QUOTA=y
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
CONFIG_HFS_FS=m
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=m
CONFIG_JBD=m
CONFIG_JBD_DEBUG=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
CONFIG_CRAMFS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_MINIX_FS=m
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
CONFIG_ROMFS_FS=m
CONFIG_EXT2_FS=m
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_NFS_FS is not set
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
CONFIG_ZISOFS_FS=m

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FB_RIVA is not set
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_VESA is not set
CONFIG_FB_VGA16=y
# CONFIG_FB_HGA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_MATROX is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_MFB=y
CONFIG_FBCON_CFB2=y
CONFIG_FBCON_CFB4=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
# CONFIG_FBCON_AFB is not set
# CONFIG_FBCON_ILBM is not set
# CONFIG_FBCON_IPLAN2P2 is not set
# CONFIG_FBCON_IPLAN2P4 is not set
# CONFIG_FBCON_IPLAN2P8 is not set
# CONFIG_FBCON_MAC is not set
CONFIG_FBCON_VGA_PLANES=y
CONFIG_FBCON_VGA=y
# CONFIG_FBCON_HGA is not set
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
CONFIG_FBCON_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set
# CONFIG_USB_DEVICEFS is not set
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_LONG_TIMEOUT is not set
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OHCI_HCD=m
# CONFIG_USB_UHCI is not set
# CONFIG_USB_UHCI_ALT is not set
CONFIG_USB_OHCI=m
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_HID=m
# CONFIG_USB_HIDDEV is not set
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
# CONFIG_USB_WACOM is not set
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_AUERSWALD is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y

#
# Library routines
#
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m

--0-171122657-1014965377=:96999--
