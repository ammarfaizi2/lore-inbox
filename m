Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135919AbREIJHE>; Wed, 9 May 2001 05:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135925AbREIJG5>; Wed, 9 May 2001 05:06:57 -0400
Received: from web13302.mail.yahoo.com ([216.136.175.38]:15111 "HELO
	web13302.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S135919AbREIJGs>; Wed, 9 May 2001 05:06:48 -0400
Message-ID: <20010509090647.94123.qmail@web13302.mail.yahoo.com>
Date: Wed, 9 May 2001 11:06:46 +0200 (CEST)
From: =?iso-8859-1?q?R=E9mi=20Letot?= <r_letot@yahoo.com>
Subject: Oops traced
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1957747793-989399206=:93442"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1957747793-989399206=:93442
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Hi all,

I had a double oops on a sever. The machine didn't
want to start anything after that, so I had to reboot
(no ctrl-ald-del because shutdown didn't start, only a
hard reboot worked :-(
It did damage my fs (ext2) but a manual fsck seems to
have revovered it.
The machine had a 150 days uptime, and is rock solid
since then (3 days)
I have good technical background, but I'm not a
developper by any means, and I don't understand
anything in the output of ksymoops. But if you need
some other info, I'm willing to help so don't hesitate
to ask (I can run other diagnosing tools, but I will
not accept to try to reproduce the oops though, it's
our main production server here)

Here it comes : 
<----- dmesg ----->
hal:/home/hobbes# dmesg
Linux version 2.2.17 (root@hal) (gcc version 2.7.2.3)
#1 Mon Nov 20 18:33:32 CET
 2000
Detected 737031 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1471.28 BogoMIPS
Memory: 256816k/262016k available (1564k kernel code,
416k reserved, 3076k data,
 144k init)
Dentry hash table entries: 32768 (order 6, 256k)
Buffer cache hash table entries: 262144 (order 8,
1024k)
Page cache hash table entries: 65536 (order 6, 256k)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: Intel Pentium III (Coppermine) stepping 03
Checking 386/387 coupling... OK, FPU using exception
16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch
(rgooch@atnf.csiro.au)
PCI: PCI BIOS revision 2.10 entry at 0xf0d90
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society
NET3.039
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 262144 bhash 65536)
Starting kswapd v 1.5
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.13)
Real Time Clock Driver v1.09
RAM disk driver initialized:  16 RAM disks of 4096K
size
PCI_IDE: unknown IDE controller on PCI bus 00 device
f9, VID=8086, DID=244b
PCI_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings:
hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings:
hdc:pio, hdd:pio
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
sym53c860-0: rev=0x02, base=0xeb800000,
io_port=0xd800, irq=9
sym53c860-0: NCR clock is 80074KHz, 80074KHz
sym53c860-0: Symbios format NVRAM, ID 7, Fast-20,
Parity Checking
sym53c860-0: initial SCNTL3/DMODE/DCNTL/CTEST3/4/5 =
(hex) 00/00/00/00/00/00
sym53c860-0: final   SCNTL3/DMODE/DCNTL/CTEST3/4/5 =
(hex) 05/ce/a0/00/08/00
sym53c860-0: resetting, command processing suspended
for 2 seconds
sym53c860-0: restart (scsi reset).
ncr53c8xx: at PCI bus 2, device 11, function 0
ncr53c8xx: IO region 0xd800 to 0xd87f is in use
sym53c860-0: command processing resumed
Adaptec: Reading the hardware resource table.  This
could take up to 5 minutes
Adaptec: Hardware resource table read.
Failed initialization of WD-7000 SCSI card!
megaraid: v107 (December 22, 1999)
aec671x_detect:
3w-xxxx: tw_findcards(): No cards found.
scsi0 : sym53c8xx - version 1.3g
scsi1 : Vendor: Adaptec  Model: 2100S            Rev:
320H
scsi : 2 hosts.
  Vendor: HP        Model: HP35480A          Rev: M902
  Type:   Sequential-Access                  ANSI SCSI
revision: 02
  Vendor: ADAPTEC   Model: MAIN              Rev: 320H
  Type:   Direct-Access                      ANSI SCSI
revision: 02
Detected scsi disk sda at scsi1, channel 0, id 0, lun
0
scsi : detected 1 SCSI disk total.
SCSI device sda: hdwr sector= 512 bytes. Sectors=
71716864 [35018 MB] [35.0 GB]
Partition check:
 sda: sda1 sda2 sda3
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 144k freed
NET4: Unix domain sockets 1.0 for Linux NET4.0.
Adding Swap: 248996k swap-space (priority -1)
3c59x.c:v0.99H 12Jun00 Donald Becker and others
http://www.scyld.com/network/vor
tex.html
eth0: 3Com 3c905C Tornado at 0xd400, 
00:01:02:db:e4:9c, IRQ 9
  8K byte-wide RAM 5:3 Rx:Tx split,
autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 782d.
  Enabling bus-master transmits and whole-frame
receives.
Serial driver version 4.27 with no serial options
enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
NET4: AppleTalk 0.18 for Linux NET4.0
st: bufsize 32768, wrt 30720, max buffers 5, s/g segs
16.
Detected scsi tape st0 at scsi0, channel 0, id 3, lun
0
sym53c860-0-<3,*>: FAST-10 SCSI 10.0 MB/s (100 ns,
offset 8)
VFS: Disk change detected on device ide0(3,0)
ISO 9660 Extensions: Microsoft Joliet Level 1
ISOFS: changing to secondary root
hal:/home/hobbes#
<----- end of dmesg ----->

<----- syslog ----->
hal:/home/hobbes# cat logoops
May  3 09:26:42 hal kernel: swap_free: Trying to free
nonexistent swap-page
May  3 09:26:42 hal kernel: swap_free: Trying to free
nonexistent swap-page
May  3 09:26:48 hal kernel: Oops: 0000
May  3 09:26:48 hal kernel: CPU:    0
May  3 09:26:48 hal kernel: EIP:    0010:[<d20e51f5>]
May  3 09:26:48 hal kernel: EFLAGS: 00210002
May  3 09:26:48 hal kernel: eax: 0a32424d   ebx:
c02fa9f4   ecx: c02f0700   edx:
 cf9d2f20
May  3 09:26:48 hal kernel: esi: 00000080   edi:
c030c728   ebp: 00000004   esp:
 c2a2ddc0
May  3 09:26:48 hal kernel: ds: 0018   es: 0018   ss:
0018
May  3 09:26:48 hal kernel: Process smbd (pid: 18037,
process nr: 46, stackpage=
c2a2d000)
May  3 09:26:48 hal kernel: Stack: c030c728 00000004
00000021 00000001 00000001
c4c15150 c2a2de34 00000001
May  3 09:26:48 hal kernel:        00000001 00000001
0a32424d 00788e05 00001000
00788e05 00000803 000002b2
May  3 09:26:48 hal kernel:        c01679eb c017f006
c02f9c2c 00000007 cf9d2f20
00000004 00788e05 00001000
May  3 09:26:48 hal kernel: Call Trace:
[ip_output+111/168] [add_request+1282/12
96] [getblk+31/332] [getblk+31/332]
[get_unused_buffer_head+27/164] [make_reques
t+2307/2344] [ll_rw_block+315/424]
May  3 09:26:48 hal kernel:        [bread+60/112]
[isofs_find_entry+158/1268] [e
xt2_readdir+1139/1152] [isofs_lookup+38/120]
[real_lookup+79/164] [lookup_dentry
+268/428] [__namei+41/92] [sys_newstat+19/100]
May  3 09:26:48 hal kernel:        [system_call+52/56]
[startup_32+43/285]
May  3 09:26:48 hal kernel: Code: 8b 48 30 89 0d 34 c7
30 c0 66 0f b6 50 04 66 8
3 fa 07 0f 87
May  3 09:26:48 hal kernel: free_one_pmd: bad
directory entry 00000004
May  3 09:27:41 hal kernel: swap_free: Trying to free
nonexistent swap-page
May  3 09:31:16 hal kernel: swap_free: Trying to free
nonexistent swap-page
May  3 09:31:56 hal kernel: Oops: 0000
May  3 09:31:56 hal kernel: CPU:    0
May  3 09:31:56 hal kernel: EIP:   
0010:[locks_remove_flock+14/144]
May  3 09:31:56 hal kernel: EFLAGS: 00210282
May  3 09:31:56 hal kernel: eax: 00000001   ebx:
c357f5c8   ecx: cdc75c40   edx:
 c357f5c8
May  3 09:31:56 hal kernel: esi: 40186000   edi:
cdc75c40   ebp: 00008000   esp:
 cb6a1e78
May  3 09:31:56 hal kernel: ds: 0018   es: 0018   ss:
0018
May  3 09:31:56 hal kernel: Process smbd (pid: 18027,
process nr: 10, stackpage=
cb6a1000)
May  3 09:31:56 hal kernel: Stack: cdc75c40 00008000
c041bd00 c01233fb 00000000
ce4ce638 c011b1dc c6120000
May  3 09:31:56 hal kernel:        cf85e5c0 40186000
cdc75c40 00008000 c6120000
00000001 0018e000 cecb8404
May  3 09:31:56 hal kernel:        00000001 4018e000
c0126c75 c357f5c8 cf85e5c0
c011ce62 c357f5c8 cdc75c40
May  3 09:31:56 hal kernel: Call Trace:
[free_page_and_swap_cache+95/100] [zap_p
age_range+324/452] [fput+17/72] [exit_mmap+190/268]
[mmput+30/56] [do_exit+215/6
40] [do_signal+664/752]
May  3 09:31:56 hal kernel:        [startup_32+0/285]
[force_sig_info+130/140] [
do_invalid_op+53/60] [error_table+2144/7104]
[error_code+45/52] [signal_return+2
0/24]
May  3 09:31:56 hal kernel: Code: 8b 40 08 89 44 24 10
8b 6c 24 10 83 c5 70 8b 5
4 24 10 8b 72
<----- end of syslog ----->

<----- ksymoops ----->
hal:/home/hobbes# ksymoops logoops
ksymoops 2.3.4 on i686 2.2.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.17/ (default)
     -m /boot/System.map-2.2.17 (default)

Warning: You did not tell me where to find symbol
information.  I will
assume that the log matches the kernel and modules
that are running
right now and I'll use the default options above for
symbol resolution.
If the current kernel and/or modules do not match the
log, you can get
more accurate output by telling me the kernel version
and where to find
map, modules, ksyms etc.  ksymoops -h explains the
options.

May  3 09:26:48 hal kernel: Oops: 0000
May  3 09:26:48 hal kernel: CPU:    0
May  3 09:26:48 hal kernel: EIP:    0010:[<d20e51f5>]
Using defaults from ksymoops -t elf32-i386 -a i386
May  3 09:26:48 hal kernel: EFLAGS: 00210002
May  3 09:26:48 hal kernel: eax: 0a32424d   ebx:
c02fa9f4   ecx: c02f0700   edx:
 cf9d2f20
May  3 09:26:48 hal kernel: esi: 00000080   edi:
c030c728   ebp: 00000004   esp:
 c2a2ddc0
May  3 09:26:48 hal kernel: ds: 0018   es: 0018   ss:
0018
May  3 09:26:48 hal kernel: Process smbd (pid: 18037,
process nr: 46, stackpage=
c2a2d000)
May  3 09:26:48 hal kernel: Stack: c030c728 00000004
00000021 00000001 00000001
c4c15150 c2a2de34 00000001
May  3 09:26:48 hal kernel:        00000001 00000001
0a32424d 00788e05 00001000
00788e05 00000803 000002b2
May  3 09:26:48 hal kernel:        c01679eb c017f006
c02f9c2c 00000007 cf9d2f20
00000004 00788e05 00001000
May  3 09:26:48 hal kernel: Call Trace:
[ip_output+111/168] [add_request+1282/12
96] [getblk+31/332] [getblk+31/332]
[get_unused_buffer_head+27/164] [make_reques
t+2307/2344] [ll_rw_block+315/424]
May  3 09:26:48 hal kernel: Code: 8b 48 30 89 0d 34 c7
30 c0 66 0f b6 50 04 66 8
3 fa 07 0f 87

>>EIP; d20e51f5 <END_OF_CODE+123be/????>   <=====
Code;  d20e51f5 <END_OF_CODE+123be/????>
00000000 <_EIP>:
Code;  d20e51f5 <END_OF_CODE+123be/????>   <=====
   0:   8b 48 30                  mov   
0x30(%eax),%ecx   <=====
Code;  d20e51f8 <END_OF_CODE+123c1/????>
   3:   89 0d 34 c7 30 c0         mov   
%ecx,0xc030c734
Code;  d20e51fe <END_OF_CODE+123c7/????>
   9:   66 0f b6 50 04            movzbw 0x4(%eax),%dx
Code;  d20e5203 <END_OF_CODE+123cc/????>
   e:   66 83 fa 07               cmp    $0x7,%dx
Code;  d20e5207 <END_OF_CODE+123d0/????>
  12:   0f 87 00 00 00 00         ja     18
<_EIP+0x18> d20e520d <END_OF_CODE+12
3d6/????>

May  3 09:31:56 hal kernel: Oops: 0000
May  3 09:31:56 hal kernel: CPU:    0
May  3 09:31:56 hal kernel: EIP:   
0010:[locks_remove_flock+14/144]
May  3 09:31:56 hal kernel: EFLAGS: 00210282
May  3 09:31:56 hal kernel: eax: 00000001   ebx:
c357f5c8   ecx: cdc75c40   edx:
 c357f5c8
May  3 09:31:56 hal kernel: esi: 40186000   edi:
cdc75c40   ebp: 00008000   esp:
 cb6a1e78
May  3 09:31:56 hal kernel: ds: 0018   es: 0018   ss:
0018
May  3 09:31:56 hal kernel: Process smbd (pid: 18027,
process nr: 10, stackpage=
cb6a1000)
May  3 09:31:56 hal kernel: Stack: cdc75c40 00008000
c041bd00 c01233fb 00000000
ce4ce638 c011b1dc c6120000
May  3 09:31:56 hal kernel:        cf85e5c0 40186000
cdc75c40 00008000 c6120000
00000001 0018e000 cecb8404
May  3 09:31:56 hal kernel:        00000001 4018e000
c0126c75 c357f5c8 cf85e5c0
c011ce62 c357f5c8 cdc75c40
May  3 09:31:56 hal kernel: Call Trace:
[free_page_and_swap_cache+95/100] [zap_p
age_range+324/452] [fput+17/72] [exit_mmap+190/268]
[mmput+30/56] [do_exit+215/6
40] [do_signal+664/752]
May  3 09:31:56 hal kernel: Code: 8b 40 08 89 44 24 10
8b 6c 24 10 83 c5 70 8b 5
4 24 10 8b 72

Code;  d20e51f5 <END_OF_CODE+123be/????>
00000000 <_EIP>:
Code;  d20e51f5 <END_OF_CODE+123be/????>
   0:   8b 40 08                  mov   
0x8(%eax),%eax
Code;  d20e51f8 <END_OF_CODE+123c1/????>
   3:   89 44 24 10               mov   
%eax,0x10(%esp,1)
Code;  d20e51fc <END_OF_CODE+123c5/????>
   7:   8b 6c 24 10               mov   
0x10(%esp,1),%ebp
Code;  d20e5200 <END_OF_CODE+123c9/????>
   b:   83 c5 70                  add    $0x70,%ebp
Code;  d20e5203 <END_OF_CODE+123cc/????>
   e:   8b 54 24 10               mov   
0x10(%esp,1),%edx
Code;  d20e5207 <END_OF_CODE+123d0/????>
  12:   8b 72 00                  mov   
0x0(%edx),%esi


1 warning issued.  Results may not be reliable.
hal:/home/hobbes#

<----- end of ksymoops ----->

My kernel configuration is attached.
Tell me if you need some more info.
-- 
Rémi

___________________________________________________________
Do You Yahoo!? -- Pour faire vos courses sur le Net, 
Yahoo! Shopping : http://fr.shopping.yahoo.com
--0-1957747793-989399206=:93442
Content-Type: text/plain; name="config-2.2.17"
Content-Description: config-2.2.17
Content-Disposition: inline; filename="config-2.2.17"

#
# Automatically generated make config: don't edit
#

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
CONFIG_M686=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_1GB=y
# CONFIG_2GB is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_OPTIMIZE is not set
CONFIG_PCI_OLD_PROC=y
# CONFIG_MCA is not set
# CONFIG_VISWS is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
# CONFIG_BINFMT_JAVA is not set
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_OTHER is not set
CONFIG_APM=y
CONFIG_APM_DISABLE_BY_DEFAULT=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_IGNORE_SUSPEND_BOUNCE is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# Plug and Play support
#
CONFIG_PNP=y
CONFIG_PNP_PARPORT=m

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_VIA82C586 is not set
# CONFIG_BLK_DEV_CMD646 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_IDE_CHIPSETS is not set

#
# Additional Block Devices
#
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_MD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_BLK_DEV_XD=m
CONFIG_BLK_DEV_DAC960=m
CONFIG_PARIDE_PARPORT=m
CONFIG_PARIDE=m

#
# Parallel IDE high-level drivers
#
CONFIG_PARIDE_PD=m
CONFIG_PARIDE_PCD=m
CONFIG_PARIDE_PF=m
CONFIG_PARIDE_PT=m
CONFIG_PARIDE_PG=m

#
# Parallel IDE protocol modules
#
CONFIG_PARIDE_ATEN=m
CONFIG_PARIDE_BPCK=m
CONFIG_PARIDE_COMM=m
CONFIG_PARIDE_DSTR=m
CONFIG_PARIDE_FIT2=m
CONFIG_PARIDE_FIT3=m
CONFIG_PARIDE_EPAT=m
CONFIG_PARIDE_EPIA=m
CONFIG_PARIDE_FRIQ=m
CONFIG_PARIDE_FRPW=m
CONFIG_PARIDE_KBIC=m
CONFIG_PARIDE_KTTI=m
CONFIG_PARIDE_ON20=m
CONFIG_PARIDE_ON26=m
CONFIG_BLK_CPQ_DA=m
# CONFIG_BLK_DEV_HD is not set

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_NETLINK=y
# CONFIG_RTNETLINK is not set
CONFIG_NETLINK_DEV=m
CONFIG_FIREWALL=y
CONFIG_FILTER=y
CONFIG_UNIX=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_IP_FIREWALL=y
# CONFIG_IP_FIREWALL_NETLINK is not set
# CONFIG_IP_TRANSPARENT_PROXY is not set
CONFIG_IP_MASQUERADE=y

#
# Protocol-specific masquerading support will be built as modules.
#
CONFIG_IP_MASQUERADE_ICMP=y

#
# Protocol-specific masquerading support will be built as modules.
#
CONFIG_IP_MASQUERADE_MOD=y
CONFIG_IP_MASQUERADE_IPAUTOFW=m
CONFIG_IP_MASQUERADE_IPPORTFW=m
CONFIG_IP_MASQUERADE_MFW=m
# CONFIG_IP_ROUTER is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
# CONFIG_NET_IPGRE_BROADCAST is not set
# CONFIG_IP_MROUTE is not set
CONFIG_IP_ALIAS=y
CONFIG_SYN_COOKIES=y

#
# (it is safe to leave these untouched)
#
CONFIG_INET_RARP=m
# CONFIG_SKB_LARGE is not set
CONFIG_IPV6=m
# CONFIG_IPV6_EUI64 is not set
# CONFIG_IPV6_NETLINK is not set

#
#  
#
CONFIG_IPX=m
# CONFIG_IPX_INTERN is not set
CONFIG_SPX=m
CONFIG_ATALK=m
CONFIG_X25=m
CONFIG_LAPB=m
# CONFIG_BRIDGE is not set
# CONFIG_LLC is not set
CONFIG_ECONET=m
# CONFIG_ECONET_AUNUDP is not set
# CONFIG_ECONET_NATIVE is not set
CONFIG_WAN_ROUTER=m
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set
# CONFIG_CPU_IS_SLOW is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
CONFIG_PHONE=m
CONFIG_PHONE_IXJ=m

#
# SCSI support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
CONFIG_BLK_DEV_3W_XXXX_RAID=y
CONFIG_SCSI_7000FASST=y
CONFIG_SCSI_ACARD=y
CONFIG_SCSI_AHA152X=y
CONFIG_SCSI_AHA1542=y
CONFIG_SCSI_AHA1740=y
CONFIG_SCSI_AIC7XXX=y
# CONFIG_AIC7XXX_TCQ_ON_BY_DEFAULT is not set
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
CONFIG_AIC7XXX_PROC_STATS=y
CONFIG_AIC7XXX_RESET_DELAY=15
CONFIG_SCSI_IPS=y
CONFIG_SCSI_ADVANSYS=y
CONFIG_SCSI_IN2000=y
CONFIG_SCSI_AM53C974=y
CONFIG_SCSI_MEGARAID=y
CONFIG_SCSI_BUSLOGIC=y
# CONFIG_SCSI_OMIT_FLASHPOINT is not set
CONFIG_SCSI_DTC3280=y
CONFIG_SCSI_DPT_I2O=y
CONFIG_SCSI_EATA=y
# CONFIG_SCSI_EATA_TAGGED_QUEUE is not set
# CONFIG_SCSI_EATA_LINKED_COMMANDS is not set
CONFIG_SCSI_EATA_MAX_TAGS=16
# CONFIG_SCSI_EATA_DMA is not set
CONFIG_SCSI_EATA_PIO=y
CONFIG_SCSI_FUTURE_DOMAIN=y
CONFIG_SCSI_GDTH=y
CONFIG_SCSI_GENERIC_NCR5380=y
# CONFIG_SCSI_GENERIC_NCR53C400 is not set
CONFIG_SCSI_G_NCR5380_PORT=y
# CONFIG_SCSI_G_NCR5380_MEM is not set
CONFIG_SCSI_INITIO=y
CONFIG_SCSI_INIA100=y
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
CONFIG_SCSI_NCR53C406A=y
CONFIG_SCSI_SYM53C416=y
CONFIG_SCSI_SIM710=y
# CONFIG_SCSI_NCR53C7xx is not set
CONFIG_SCSI_NCR53C8XX=y
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=8
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=4
CONFIG_SCSI_NCR53C8XX_SYNC=5
# CONFIG_SCSI_NCR53C8XX_PROFILE is not set
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
CONFIG_SCSI_NCR53C8XX_PQS_PDS=y
# CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set
CONFIG_SCSI_PAS16=y
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
CONFIG_SCSI_PSI240I=m
CONFIG_SCSI_QLOGIC_FAS=y
CONFIG_SCSI_QLOGIC_ISP=y
CONFIG_SCSI_QLOGIC_FC=y
CONFIG_SCSI_SEAGATE=y
CONFIG_SCSI_DC390T=m
# CONFIG_SCSI_DC390T_NOGENSUPP is not set
CONFIG_SCSI_T128=y
CONFIG_SCSI_U14_34F=y
# CONFIG_SCSI_U14_34F_LINKED_COMMANDS is not set
CONFIG_SCSI_U14_34F_MAX_TAGS=8
CONFIG_SCSI_ULTRASTOR=y
CONFIG_SCSI_DEBUG=m

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_SCSI=m

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
CONFIG_ARCNET=m
CONFIG_ARCNET_ETH=y
CONFIG_ARCNET_1051=y
CONFIG_ARCNET_COM90xx=m
CONFIG_ARCNET_COM90xxIO=m
CONFIG_ARCNET_RIM_I=m
CONFIG_ARCNET_COM20020=m
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_EQUALIZER=m
CONFIG_ETHERTAP=m
CONFIG_NET_SB1000=m

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL1=m
CONFIG_EL2=m
CONFIG_ELPLUS=m
CONFIG_EL16=m
CONFIG_EL3=m
CONFIG_3C515=m
CONFIG_VORTEX=m
CONFIG_LANCE=m
CONFIG_NET_VENDOR_SMC=y
CONFIG_WD80x3=m
CONFIG_ULTRA=m
CONFIG_ULTRA32=m
CONFIG_SMC9194=m
CONFIG_NET_VENDOR_RACAL=y
CONFIG_NI5010=m
CONFIG_NI52=m
CONFIG_NI65=m
CONFIG_RTL8139=m
CONFIG_NET_ISA=y
CONFIG_AT1700=m
CONFIG_E2100=m
CONFIG_DEPCA=m
CONFIG_EWRK3=m
CONFIG_EEXPRESS=m
CONFIG_EEXPRESS_PRO=m
CONFIG_FMV18X=m
CONFIG_HPLAN_PLUS=m
CONFIG_HPLAN=m
CONFIG_HP100=m
CONFIG_ETH16I=m
CONFIG_NE2000=m
# CONFIG_SEEQ8005 is not set
# CONFIG_SK_G16 is not set
CONFIG_NET_EISA=y
CONFIG_PCNET32=m
CONFIG_AC3200=m
CONFIG_APRICOT=m
CONFIG_CS89x0=m
CONFIG_DM9102=m
CONFIG_DE4X5=m
CONFIG_DEC_ELCP=m
CONFIG_DEC_ELCP_OLD=m
CONFIG_DGRS=m
CONFIG_EEXPRESS_PRO100=m
CONFIG_LNE390=m
CONFIG_NE3210=m
CONFIG_NE2K_PCI=m
CONFIG_TLAN=m
CONFIG_VIA_RHINE=m
CONFIG_SIS900=m
CONFIG_ES3210=m
CONFIG_EPIC100=m
# CONFIG_ZNET is not set
CONFIG_NET_POCKET=y
# CONFIG_ATP is not set
CONFIG_DE600=m
CONFIG_DE620=m

#
# Ethernet (1000 Mbit)
#
CONFIG_ACENIC=m
CONFIG_HAMACHI=m
CONFIG_YELLOWFIN=m
CONFIG_SK98LIN=m
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set

#
# Appletalk devices
#
CONFIG_LTPC=m
CONFIG_COPS=m
# CONFIG_COPS_DAYNA is not set
# CONFIG_COPS_TANGENT is not set
CONFIG_IPDDP=m
# CONFIG_IPDDP_ENCAP is not set
# CONFIG_IPDDP_DECAP is not set
CONFIG_PLIP=m
CONFIG_PPP=m

#
# CCP compressors for PPP are only built as modules.
#
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_NET_RADIO=y
CONFIG_STRIP=m
CONFIG_WAVELAN=m
CONFIG_ARLAN=m

#
# Token ring devices
#
CONFIG_TR=y
CONFIG_IBMTR=m
CONFIG_IBMLS=m
CONFIG_IBMOL=m
CONFIG_SKTR=m
CONFIG_NET_FC=y
CONFIG_IPHASE5526=m
CONFIG_RCPCI=m
CONFIG_SHAPER=m

#
# Wan interfaces
#
CONFIG_HOSTESS_SV11=m
CONFIG_COSA=m
CONFIG_SEALEVEL_4021=m
CONFIG_SYNCLINK_SYNCPPP=m
CONFIG_LANMEDIA=m
CONFIG_COMX=m
CONFIG_COMX_HW_COMX=m
CONFIG_COMX_HW_LOCOMX=m
CONFIG_COMX_HW_MIXCOM=m
CONFIG_COMX_PROTO_PPP=m
CONFIG_COMX_PROTO_LAPB=m
CONFIG_COMX_PROTO_FR=m
CONFIG_HDLC=m
CONFIG_N2=m
CONFIG_C101=m
CONFIG_WANXL=m
CONFIG_PC300=m
# CONFIG_PC300_X25 is not set
CONFIG_DLCI=m
CONFIG_DLCI_COUNT=24
CONFIG_DLCI_MAX=8
CONFIG_SDLA=m
CONFIG_WAN_DRIVERS=y
CONFIG_VENDOR_SANGOMA=m
CONFIG_WANPIPE_CARDS=1
# CONFIG_WANPIPE_FR is not set
# CONFIG_WANPIPE_PPP is not set
# CONFIG_WANPIPE_CHDLC is not set
# CONFIG_LAPBETHER is not set
CONFIG_X25_ASY=m
CONFIG_SBNI=m

#
# Amateur Radio support
#
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=m
# CONFIG_AX25_DAMA_SLAVE is not set
CONFIG_NETROM=m
CONFIG_ROSE=m

#
# AX.25 network device drivers
#
CONFIG_MKISS=m
CONFIG_6PACK=m
CONFIG_BPQETHER=m
CONFIG_DMASCC=m
CONFIG_SCC=m
# CONFIG_SCC_DELAY is not set
# CONFIG_SCC_TRXECHO is not set
CONFIG_BAYCOM_SER_FDX=m
CONFIG_BAYCOM_SER_HDX=m
CONFIG_BAYCOM_PAR=m
CONFIG_BAYCOM_EPP=m
CONFIG_SOUNDMODEM=m
# CONFIG_SOUNDMODEM_SBC is not set
# CONFIG_SOUNDMODEM_WSS is not set
# CONFIG_SOUNDMODEM_AFSK1200 is not set
# CONFIG_SOUNDMODEM_AFSK2400_7 is not set
# CONFIG_SOUNDMODEM_AFSK2400_8 is not set
# CONFIG_SOUNDMODEM_AFSK2666 is not set
# CONFIG_SOUNDMODEM_HAPN4800 is not set
# CONFIG_SOUNDMODEM_PSK4800 is not set
# CONFIG_SOUNDMODEM_FSK9600 is not set
CONFIG_YAM=m

#
# Misc. hamradio protocols
#
CONFIG_HFMODEM=m
# CONFIG_HFMODEM_SBC is not set
# CONFIG_HFMODEM_WSS is not set

#
# IrDA (infrared) support
#
CONFIG_IRDA=m

#
# IrDA protocols
#
CONFIG_IRLAN=m
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y
# CONFIG_IRDA_OPTIONS is not set
# CONFIG_IRDA_COMPRESSION is not set

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m
CONFIG_IRPORT_SIR=m

#
# FIR device drivers
#
CONFIG_NSC_FIR=m
CONFIG_WINBOND_FIR=m
CONFIG_TOSHIBA_FIR=m
CONFIG_SMC_IRCC_FIR=m

#
# Dongle support
#
# CONFIG_DONGLE is not set

#
# ISDN subsystem
#
CONFIG_ISDN=m
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_MPP=y
CONFIG_ISDN_AUDIO=y
CONFIG_ISDN_TTY_FAX=y
# CONFIG_ISDN_X25 is not set

#
# ISDN feature submodules
#
CONFIG_ISDN_DRV_LOOP=m
CONFIG_ISDN_DIVERSION=y

#
# low-level hardware drivers
#

#
# Passive ISDN cards
#
CONFIG_ISDN_DRV_HISAX=m

#
#   D-channel protocol features
#
CONFIG_HISAX_EURO=y
# CONFIG_DE_AOC is not set
# CONFIG_HISAX_NO_SENDCOMPLETE is not set
# CONFIG_HISAX_NO_LLC is not set
# CONFIG_HISAX_NO_KEYPAD is not set
# CONFIG_HISAX_1TR6 is not set

#
#   HiSax supported cards
#
CONFIG_HISAX_16_0=y
CONFIG_HISAX_16_3=y
CONFIG_HISAX_TELESPCI=y
CONFIG_HISAX_S0BOX=y
CONFIG_HISAX_AVM_A1=y
CONFIG_HISAX_FRITZPCI=y
CONFIG_HISAX_AVM_A1_PCMCIA=y
CONFIG_HISAX_ELSA=y
CONFIG_HISAX_IX1MICROR2=y
CONFIG_HISAX_DIEHLDIVA=y
CONFIG_HISAX_ASUSCOM=y
CONFIG_HISAX_TELEINT=y
CONFIG_HISAX_HFCS=y
CONFIG_HISAX_SEDLBAUER=y
CONFIG_HISAX_SPORTSTER=y
CONFIG_HISAX_MIC=y
CONFIG_HISAX_NETJET=y
CONFIG_HISAX_NICCY=y
CONFIG_HISAX_ISURF=y
CONFIG_HISAX_HSTSAPHIR=y
CONFIG_HISAX_BKM_A4T=y
CONFIG_HISAX_SCT_QUADRO=y
CONFIG_HISAX_GAZEL=y
CONFIG_HISAX_HFC_PCI=y
CONFIG_HISAX_W6692=y
CONFIG_HISAX_HFC_SX=y

#
# Active ISDN cards
#
CONFIG_ISDN_DRV_ICN=m
CONFIG_ISDN_DRV_PCBIT=m
# CONFIG_ISDN_DRV_SC is not set
CONFIG_ISDN_DRV_ACT2000=m
CONFIG_ISDN_DRV_EICON=m
CONFIG_ISDN_DRV_EICON_ISA=y
CONFIG_ISDN_DRV_AVMB1=m
CONFIG_ISDN_DRV_AVMB1_B1ISA=y
CONFIG_ISDN_DRV_AVMB1_B1PCI=y
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
CONFIG_ISDN_DRV_AVMB1_T1ISA=y
CONFIG_ISDN_DRV_AVMB1_B1PCMCIA=y
CONFIG_ISDN_DRV_AVMB1_T1PCI=y
CONFIG_ISDN_DRV_AVMB1_C4=y
CONFIG_ISDN_DRV_AVMB1_VERBOSE_REASON=y

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
CONFIG_CD_NO_IDESCSI=y
CONFIG_AZTCD=m
CONFIG_GSCD=m
CONFIG_SBPCD=m
CONFIG_MCD=m
CONFIG_MCD_IRQ=11
CONFIG_MCD_BASE=300
CONFIG_MCDX=m
CONFIG_OPTCD=m
CONFIG_CM206=m
CONFIG_SJCD=m
CONFIG_ISP16_CDI=m
CONFIG_CDU31A=m
CONFIG_CDU535=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
# CONFIG_SERIAL_EXTENDED is not set
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_COMPUTONE=m
CONFIG_ROCKETPORT=m
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
CONFIG_DIGIEPCA=m
CONFIG_ESPSERIAL=m
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=m
CONFIG_ISI=m
CONFIG_RISCOM8=m
CONFIG_SPECIALIX=m
# CONFIG_SPECIALIX_RTSCTS is not set
CONFIG_SX=m
CONFIG_RIO=m
# CONFIG_RIO_OLDPCI is not set
CONFIG_STALDRV=y
CONFIG_STALLION=m
CONFIG_ISTALLION=m
CONFIG_SYNCLINK=m
CONFIG_N_HDLC=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_PRINTER_READBACK is not set
CONFIG_MOUSE=y

#
# Mice
#
CONFIG_ATIXL_BUSMOUSE=m
CONFIG_BUSMOUSE=m
CONFIG_MS_BUSMOUSE=m
CONFIG_PSMOUSE=y
CONFIG_82C710_MOUSE=m
CONFIG_PC110_PAD=m

#
# Joysticks
#
CONFIG_JOYSTICK=m
CONFIG_JOY_ANALOG=m
CONFIG_JOY_ASSASSIN=m
CONFIG_JOY_GRAVIS=m
CONFIG_JOY_LOGITECH=m
CONFIG_JOY_SIDEWINDER=m
CONFIG_JOY_THRUSTMASTER=m
CONFIG_JOY_CREATIVE=m
CONFIG_JOY_LIGHTNING=m
CONFIG_JOY_PCI=m
CONFIG_JOY_MAGELLAN=m
CONFIG_JOY_SPACEORB=m
CONFIG_JOY_SPACEBALL=m
CONFIG_JOY_WARRIOR=m
CONFIG_JOY_CONSOLE=m
CONFIG_JOY_DB9=m
CONFIG_JOY_TURBOGRAFX=m
CONFIG_QIC02_TAPE=m
CONFIG_QIC02_DYNCONF=y

#
#    Setting runtime QIC-02 configuration is done with qic02conf
#

#
#    from the tpqic02-support package.  It is available at
#

#
#    metalab.unc.edu or ftp://titus.cfw.com/pub/Linux/util/
#
CONFIG_WATCHDOG=y

#
# Watchdog Cards
#
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WDT=m
CONFIG_WDT_501=y
# CONFIG_WDT_501_FAN is not set
CONFIG_SOFT_WATCHDOG=m
CONFIG_PCWATCHDOG=m
CONFIG_ACQUIRE_WDT=m
CONFIG_60XX_WDT=m
CONFIG_MIXCOMWD=m
CONFIG_NVRAM=m
CONFIG_RTC=y

#
# Video For Linux
#
# CONFIG_VIDEO_DEV is not set
CONFIG_DTLK=m

#
# Ftape, the floppy tape device driver
#
CONFIG_FTAPE=m
CONFIG_ZFTAPE=m
CONFIG_ZFT_DFLT_BLK_SZ=10240

#
# The compressor will be built as a module only!
#
CONFIG_ZFT_COMPRESSOR=m
CONFIG_FT_NR_BUFFERS=3
# CONFIG_FT_PROC_FS is not set
CONFIG_FT_NORMAL_DEBUG=y
# CONFIG_FT_FULL_DEBUG is not set
# CONFIG_FT_NO_TRACE is not set
# CONFIG_FT_NO_TRACE_AT_ALL is not set

#
# Hardware configuration
#
CONFIG_FT_STD_FDC=y
# CONFIG_FT_MACH2 is not set
# CONFIG_FT_PROBE_FC10 is not set
# CONFIG_FT_ALT_FDC is not set
CONFIG_FT_FDC_THR=8
CONFIG_FT_FDC_MAX_RATE=2000

#
# ONLY for DEC Alpha architectures
#
CONFIG_FT_ALPHA_CLOCK=0

#
# Filesystems
#
CONFIG_QUOTA=y
CONFIG_AUTOFS_FS=m
CONFIG_ADFS_FS=m
CONFIG_AFFS_FS=m
CONFIG_HFS_FS=m
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_UMSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_MINIX_FS=y
CONFIG_NTFS_FS=m
# CONFIG_NTFS_RW is not set
CONFIG_HPFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_QNX4FS_FS=m
# CONFIG_QNX4FS_RW is not set
CONFIG_ROMFS_FS=m
CONFIG_EXT2_FS=y
CONFIG_SYSV_FS=m
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set
CONFIG_EFS_FS=m
CONFIG_SGI_PARTITION=y

#
# Network File Systems
#
CONFIG_CODA_FS=m
CONFIG_NFS_FS=m
CONFIG_NFSD=m
# CONFIG_NFSD_SUN is not set
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_SMB_FS=m
CONFIG_NCP_FS=m
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
CONFIG_NCPFS_NFS_NS=y
CONFIG_NCPFS_OS2_NS=y
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_MOUNT_SUBDIR is not set
CONFIG_NCPFS_NLS=y
CONFIG_NCPFS_EXTRAS=y

#
# Partition Types
#
CONFIG_BSD_DISKLABEL=y
CONFIG_MAC_PARTITION=y
CONFIG_SMD_DISKLABEL=y
CONFIG_SOLARIS_X86_PARTITION=y
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_AMIGA_PARTITION=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
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
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_MDA_CONSOLE=m
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FB_PM2 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_VGA16 is not set
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_MULTIHEAD=y
# CONFIG_FB_ATY128 is not set
CONFIG_FB_VIRTUAL=m
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_MFB=m
CONFIG_FBCON_CFB2=m
CONFIG_FBCON_CFB4=m
CONFIG_FBCON_CFB8=m
CONFIG_FBCON_CFB16=m
CONFIG_FBCON_CFB24=m
CONFIG_FBCON_CFB32=m
# CONFIG_FBCON_AFB is not set
# CONFIG_FBCON_ILBM is not set
# CONFIG_FBCON_IPLAN2P2 is not set
# CONFIG_FBCON_IPLAN2P4 is not set
# CONFIG_FBCON_IPLAN2P8 is not set
# CONFIG_FBCON_MAC is not set
# CONFIG_FBCON_VGA_PLANES is not set
CONFIG_FBCON_VGA=m
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# Kernel hacking
#
# CONFIG_MAGIC_SYSRQ is not set

--0-1957747793-989399206=:93442--
