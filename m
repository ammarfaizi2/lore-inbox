Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130597AbRBWWSo>; Fri, 23 Feb 2001 17:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130610AbRBWWSb>; Fri, 23 Feb 2001 17:18:31 -0500
Received: from herald.cc.purdue.edu ([128.210.11.29]:13723 "EHLO
	herald.cc.purdue.edu") by vger.kernel.org with ESMTP
	id <S130597AbRBWWSQ>; Fri, 23 Feb 2001 17:18:16 -0500
Date: Fri, 23 Feb 2001 17:19:42 -0500
From: David Michael Norris <norrisd@purdue.edu>
To: linux-kernel@vger.kernel.org
Subject: oops with : loop-6 / patch-int-2.4.0.3 and 2.4.2
Message-Id: <20010223171942.A2322@purdue.edu>
Mail-Followup-To: David Michael Norris <norrisd>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	While running this script:

#/bin/bash
losetup -d /dev/loop0
losetup -e serpent /dev/loop0 /dev/sda1
mount -t ext2 /dev/loop0 ./idisc1

one of two things have happened:
1) It worked but I was unable to write to the disk, even though I had
   file permissions
3) It oopsed :

ksymoops 2.3.5 on i586 2.4.2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2/ (specified)
     -m /boot/System.map (specified)

Warning (compare_maps): mismatch on symbol __module_description  , sb says c1829080, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a240.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_acer  , sb says c1829106, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a2c6.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_acer  , sb says c18295a0, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a760.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_dma  , sb says c1829440, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a600.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_dma16  , sb says c1829480, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a640.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_esstype  , sb says c1829580, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a740.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_io  , sb says c18293c0, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a580.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_irq  , sb says c1829405, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a5c5.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_isapnp  , sb says c1829180, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a340.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_isapnpjump  , sb says c18291e0, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a3a0.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_mpu_io  , sb says c18294c0, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a680.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_multiple  , sb says c1829240, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a400.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_pnplegacy  , sb says c18292a0, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a460.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_reverse  , sb says c1829300, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a4c0.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_sm_games  , sb says c1829540, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a700.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_type  , sb says c1829500, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a6c0.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_uart401  , sb says c1829360, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a520.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_dma  , sb says c18290b5, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a275.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_dma16  , sb says c18290c0, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a280.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_esstype  , sb says c18290f7, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a2b7.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_io  , sb says c18290a0, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a260.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_irq  , sb says c18290aa, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a26a.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_isapnp  , sb says c1829112, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a2d2.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_isapnpjump  , sb says c1829120, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a2e0.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_mpu_io  , sb says c18290cd, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a28d.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_multiple  , sb says c1829132, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a2f2.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_pnplegacy  , sb says c1829142, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a302.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_reverse  , sb says c1829153, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a313.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_sm_games  , sb says c18290e7, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a2a7.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_type  , sb says c18290db, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a29b.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
Warning (compare_maps): mismatch on symbol __module_parm_uart401  , sb says c1829162, /lib/modules/2.4.2/kernel/drivers/sound/sb.o says c182a322.  Ignoring /lib/modules/2.4.2/kernel/drivers/sound/sb.o entry
CPU:    0
EIP:    0010:[<c014e512>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00017fee   ebx: 00000020   ecx: 00000000   edx: 00000000
esi: 00017fef   edi: c0965c00   ebp: c0653400   esp: c0b49ea4
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 2241, stackpage=c0b49000)
Stack: c0965c00 00000700 c0377a60 c0291e98 00000000 00000008 00000003 00000000 
       07000000 00000001 c0fadcc0 00000001 00000000 c01314fc c0965c00 00000000 
       00000000 00000000 00000700 c0377a60 c0b49f44 c013173a 00000700 c0377a60 
Call Trace: [<c01314fc>] [<c013173a>] [<c0108fb4>] [<c0132268>] [<c01320a4>] [<c0132424>] [<c0108e73>] 
Code: f7 f1 89 87 c0 00 00 00 8d 44 03 ff 31 d2 f7 f3 89 44 24 1c 

>>EIP; c014e512 <ext2_read_super+482/69c>   <=====
Trace; c01314fc <read_super+100/170>
Trace; c013173a <get_sb_bdev+16e/1c8>
Trace; c0108fb4 <error_code+34/40>
Trace; c0132268 <do_mount+174/2ac>
Trace; c01320a4 <copy_mount_options+4c/9c>
Trace; c0132424 <sys_mount+84/c4>
Trace; c0108e73 <system_call+33/40>
Code;  c014e512 <ext2_read_super+482/69c>
00000000 <_EIP>:
Code;  c014e512 <ext2_read_super+482/69c>   <=====
   0:   f7 f1                     div    %ecx,%eax   <=====
Code;  c014e514 <ext2_read_super+484/69c>
   2:   89 87 c0 00 00 00         mov    %eax,0xc0(%edi)
Code;  c014e51a <ext2_read_super+48a/69c>
   8:   8d 44 03 ff               lea    0xffffffff(%ebx,%eax,1),%eax
Code;  c014e51e <ext2_read_super+48e/69c>
   c:   31 d2                     xor    %edx,%edx
Code;  c014e520 <ext2_read_super+490/69c>
   e:   f7 f3                     div    %ebx,%eax
Code;  c014e522 <ext2_read_super+492/69c>
  10:   89 44 24 1c               mov    %eax,0x1c(%esp,1)


31 warnings issued.  Results may not be reliable.

I am running 2.4.2 with loop-6 and patch-int-2.4.0.3. And here is my system info and config file :

/proc/modules :
v_midi                  5240   0 (unused)
opl3                   11392   0 (unused)
mpu401                 18948   0 (unused)
sb                      9720   0 (unused)
sb_lib                 33788   0 [sb]
uart401                 6340   0 [sb_lib]

/proc/cpuinfo :
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 5
model		: 2
model name	: Pentium 75 - 200
stepping	: 5
cpu MHz		: 75.000
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: yes
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8
bogomips	: 149.50

/proc/ioports :
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0220-022f : soundblaster
0278-027a : parport0
027b-027f : parport0
02f8-02ff : serial(set)
0376-0376 : ide1
0388-038b : Yamaha OPL3
03c0-03df : vga+
03e8-03ef : serial(set)
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
fc80-fcff : 3Com Corporation 3c905C-TX [Fast Etherlink]
  fc80-fcff : eth0

/proc/iomem :
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c87ff : Extension ROM
000f0000-000fffff : System ROM
00100000-00ffffff : System RAM
  00100000-00233803 : Kernel code
  00233804-002a7e67 : Kernel data
fe000000-fe7fffff : S3 Inc. 86c764/765 [Trio32/64/64V+]
fedffc00-fedffc7f : 3Com Corporation 3c905C-TX [Fast Etherlink]
ffff53be-ffffffff : reserved

/proc/scsi/scsi :
Attached devices: 
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: IOMEGA   Model: ZIP 100          Rev: J.03
  Type:   Direct-Access                    ANSI SCSI revision: 02

.config :
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
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
CONFIG_M586TSC=y
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
# CONFIG_TOSHIBA is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
# CONFIG_SMP is not set
# CONFIG_X86_UP_IOAPIC is not set

#
# General setup
#
CONFIG_NET=y
# CONFIG_VISWS is not set
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_EISA=y
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
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
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Crypto options
#
CONFIG_CRYPTO=y
CONFIG_CIPHERS=y
CONFIG_CIPHER_AES=y
# CONFIG_CIPHER_RIJNDAEL is not set
# CONFIG_CIPHER_TWOFISH is not set
# CONFIG_CIPHER_MARS is not set
# CONFIG_CIPHER_RC6 is not set
CONFIG_CIPHER_SERPENT=y
# CONFIG_CIPHER_DFC is not set
# CONFIG_CIPHER_BLOWFISH is not set
# CONFIG_CIPHER_IDEA is not set
# CONFIG_CIPHER_RC5 is not set
# CONFIG_CIPHER_DES_EDE3 is not set
# CONFIG_CIPHER_DES is not set
# CONFIG_DIGEST is not set

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_LOOP_DEP=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_GEN=y
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK=y
# CONFIG_IP_MULTIPLE_TABLES is not set
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_ROUTE_LARGE_TABLES is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=y
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
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
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_COMPAT_IPCHAINS=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IPV6=y
# CONFIG_IPV6_EUI64 is not set

#
#   IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_KHTTPD=y
# CONFIG_ATM is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
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
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_IDEDMA_PCI is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_IDEDMA_PCI_AUTO is not set
# CONFIG_BLK_DEV_IDEDMA is not set
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD7409 is not set
# CONFIG_AMD7409_OVERRIDE is not set
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
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_OSB4 is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI support
#
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_PPA=y
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# IEEE 1394 (FireWire) support
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
CONFIG_DUMMY=y
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
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
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=y
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPP_ASYNC=y
# CONFIG_PPP_SYNC_TTY is not set
# CONFIG_PPP_DEFLATE is not set
# CONFIG_PPP_BSDCOMP is not set
# CONFIG_PPPOE is not set
# CONFIG_SLIP is not set

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
# CONFIG_SHAPER is not set

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
# Input core support
#
# CONFIG_INPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=y

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

#
# Joysticks
#
# CONFIG_JOYSTICK is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_INTEL_RNG=y
CONFIG_NVRAM=y
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
CONFIG_HFS_FS=m
# CONFIG_BFS_FS is not set
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=y
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_RAMFS=m
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
# CONFIG_MINIX_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
# CONFIG_DEVPTS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
CONFIG_ROMFS_FS=m
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_SYSV_FS_WRITE is not set
CONFIG_UDF_FS=m
# CONFIG_UDF_RW is not set
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_NFS_FS is not set
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
CONFIG_SMB_FS=y
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_UTF8=y

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
CONFIG_FB_VESA=y
CONFIG_FB_VGA16=y
# CONFIG_FB_HGA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_MATROX is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FBCON_ADVANCED is not set
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_VGA_PLANES=y
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
CONFIG_SOUND=y
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
CONFIG_SOUND_OSS=y
# CONFIG_SOUND_TRACEINIT is not set
# CONFIG_SOUND_DMAP is not set
# CONFIG_SOUND_AD1816 is not set
# CONFIG_SOUND_SGALAXY is not set
# CONFIG_SOUND_ADLIB is not set
# CONFIG_SOUND_ACI_MIXER is not set
# CONFIG_SOUND_CS4232 is not set
# CONFIG_SOUND_SSCAPE is not set
# CONFIG_SOUND_GUS is not set
CONFIG_SOUND_VMIDI=m
# CONFIG_SOUND_TRIX is not set
# CONFIG_SOUND_MSS is not set
CONFIG_SOUND_MPU401=m
# CONFIG_SOUND_NM256 is not set
# CONFIG_SOUND_MAD16 is not set
# CONFIG_SOUND_PAS is not set
# CONFIG_PAS_JOYSTICK is not set
# CONFIG_SOUND_PSS is not set
CONFIG_SOUND_SB=m
# CONFIG_SOUND_AWE32_SYNTH is not set
# CONFIG_SOUND_WAVEFRONT is not set
# CONFIG_SOUND_MAUI is not set
CONFIG_SOUND_YM3812=m
# CONFIG_SOUND_OPL3SA1 is not set
# CONFIG_SOUND_OPL3SA2 is not set
# CONFIG_SOUND_YMFPCI is not set
# CONFIG_SOUND_YMFPCI_LEGACY is not set
CONFIG_SOUND_UART6850=m
# CONFIG_SOUND_AEDSP16 is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Kernel hacking
#
CONFIG_MAGIC_SYSRQ=y

Thanks,
	David


-- 
David Michael Norris
norrisd@purdue.edu
