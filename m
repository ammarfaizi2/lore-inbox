Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264895AbTFQTVw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 15:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264896AbTFQTVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 15:21:52 -0400
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:42895 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id S264895AbTFQTUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 15:20:10 -0400
Date: Tue, 17 Jun 2003 15:33:21 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: BUG: Massive performance drop in conncetion time with 2.4.21 (62KB)
In-Reply-To: <Pine.LNX.4.56.0306161413360.3114@filesrv1.baby-dragons.com>
Message-ID: <Pine.LNX.4.56.0306171518080.6807@filesrv1.baby-dragons.com>
References: <20030616141806.6a92f839.skraw@ithnet.com>
 <Pine.LNX.4.51.0306161444090.18129@dns.toxicfilms.tv>
 <20030616145135.0ef5c436.skraw@ithnet.com> <20030616151035.735fcaf2.martin.zwickel@technotrend.de>
 <Pine.LNX.4.56.0306161413360.3114@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello All ,  Here goes .  I made 'me too'ism in another thread
	that may be related to what I am presenting here .  After my .sig
	is what I hope to be enough pertitanent information to get the bug
	stomped on .  This is driving me crazy .  Also if someone would
	like to point me at a URL:/Method(s)/... to be able to acquire
	further information that would make the effort for those that
	really can code in the kernel jobs easier please do .
	The slow down mentioned below happens with any network based
	connection .  JimL

On Mon, 16 Jun 2003, Mr. James W. Laferriere wrote:
> 	Hello Martin & Stephan ,  Since moving to 2.4.21 release from
> 	2.4.21-rc3 .  I have noticed that all network connections are slow
> 	to start .  But have normal responsiveness after the connection
> 	has been negotiated .  This all network activity .  I do have two
> 	nics in my system .  One eepro100 driven & one ns38320 driven .
> 	My MB is a Tyan thunder s2567 .  When I was running 2.4.21-rc3 the
> 	starting of the connections seemed avaerage but since there has
> 	been a Markedly slower response to connection establishment .
> 		Twyl ,  JimL
-- 
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

 # (time strace nslookup eisner.decus.org) 2>&1 | tee where-is-it-spend-allitstime.log

execve("/usr/bin/nslookup", ["nslookup", "eisner.decus.org"], [/* 31 vars */]) = 0
brk(0)                                  = 0x812bad4
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=72386, ...}) = 0
old_mmap(NULL, 72386, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40015000
close(3)                                = 0
open("/lib/libnsl.so.1", O_RDONLY)      = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260:\0"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=353351, ...}) = 0
old_mmap(NULL, 84956, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40027000
mprotect(0x40039000, 11228, PROT_NONE)  = 0
old_mmap(0x40039000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x11000) = 0x40039000
old_mmap(0x4003a000, 7132, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4003a000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0h\222\1"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=5029105, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4003c000
old_mmap(NULL, 1191168, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4003d000
mprotect(0x40156000, 40192, PROT_NONE)  = 0
old_mmap(0x40156000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x119000) = 0x40156000
old_mmap(0x4015c000, 15616, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4015c000
close(3)                                = 0
munmap(0x40015000, 72386)               = 0
rt_sigaction(SIGINT, {0x80f3b60, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGTERM, {0x80f3b60, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGPIPE, {SIG_IGN}, NULL, 8) = 0
rt_sigaction(SIGHUP, {SIG_DFL}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [HUP INT TERM], NULL, 8) = 0
getpid()                                = 7258
socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 3
close(3)                                = 0
socket(PF_INET6, SOCK_STREAM, 0)        = 3
getsockname(3, {sin_family=AF_INET6, sin6_port=htons(0), inet_pton(AF_INET6, "::", &sin6_addr), sin6_flowinfo=0, sin6_scope_id=0}, [28]) = 0
close(3)                                = 0
brk(0)                                  = 0x812bad4
brk(0x812bb4c)                          = 0x812bb4c
brk(0x812c000)                          = 0x812c000
brk(0x812f000)                          = 0x812f000
brk(0x8132000)                          = 0x8132000
open("/usr/share/locale/C/libdst.cat", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/C/LC_MESSAGES/libdst.cat", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/C/libdst.cat", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/C/LC_MESSAGES/libdst.cat", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/C/libisc.cat", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/C/LC_MESSAGES/libisc.cat", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/C/libisc.cat", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/C/LC_MESSAGES/libisc.cat", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/C/libdns.cat", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/C/LC_MESSAGES/libdns.cat", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/C/libdns.cat", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/C/LC_MESSAGES/libdns.cat", O_RDONLY) = -1 ENOENT (No such file or directory)
write(2, "Note:  nslookup is deprecated an"..., 206Note:  nslookup is deprecated and may be removed from future releases.
Consider using the `dig' or `host' programs instead.  Run nslookup with
the `-sil[ent]' option to prevent this message from appearing.
) = 206
open("/etc/resolv.conf", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=181, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40015000
read(3, "domain baby-dragons.com\nsearch b"..., 4096) = 181
brk(0x8133000)                          = 0x8133000
brk(0x8134000)                          = 0x8134000
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40015000, 4096)                = 0
rt_sigaction(SIGHUP, {0x80f3b70, ~[], 0x4000000}, NULL, 8) = 0
brk(0x8135000)                          = 0x8135000
brk(0x8146000)                          = 0x8146000
brk(0x8157000)                          = 0x8157000
brk(0x8168000)                          = 0x8168000
brk(0x8179000)                          = 0x8179000
brk(0x818a000)                          = 0x818a000
brk(0x819b000)                          = 0x819b000
gettimeofday({1055863921, 890694}, NULL) = 0
socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP) = 3
fcntl64(3, F_GETFL)                     = 0x2 (flags O_RDWR)
fcntl64(3, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
setsockopt(3, SOL_SOCKET, SO_BSDCOMPAT, [1], 4) = 0
setsockopt(3, SOL_SOCKET, 0x1d /* SO_??? */, [1], 4) = 0
setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
bind(3, {sin_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("0.0.0.0")}}, 16) = 0
recvmsg(3, 0xbffff590, 0)               = -1 EAGAIN (Resource temporarily unavailable)
gettimeofday({1055863921, 891731}, NULL) = 0
sendmsg(3, {msg_name(16)={sin_family=AF_INET, sin_port=htons(53), sin_addr=inet_addr("199.33.245.254")}}, msg_iov(1)=[{"\231O\1\0\0\1\0\0\0\0\0\0\6eisner\5decus\3org\0\0\1"..., 34}], msg_controllen=0, msg_flags=0}, 0) = 34
gettimeofday({1055863921, 892168}, NULL) = 0
select(4, [3], [], NULL, {0, 0})        = 0 (Timeout)
gettimeofday({1055863921, 892448}, NULL) = 0
gettimeofday({1055863921, 892516}, NULL) = 0
select(4, [3], [], NULL, {0, 998178})   = 0 (Timeout)
gettimeofday({1055863922, 887219}, NULL) = 0
gettimeofday({1055863922, 887407}, NULL) = 0
select(4, [3], [], NULL, {0, 3287})     = 0 (Timeout)
gettimeofday({1055863922, 897256}, NULL) = 0
gettimeofday({1055863922, 897362}, NULL) = 0
socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP) = 4
fcntl64(4, F_GETFL)                     = 0x2 (flags O_RDWR)
fcntl64(4, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
setsockopt(4, SOL_SOCKET, SO_BSDCOMPAT, [1], 4) = 0
setsockopt(4, SOL_SOCKET, 0x1d /* SO_??? */, [1], 4) = 0
setsockopt(4, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
bind(4, {sin_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("0.0.0.0")}}, 16) = 0
recvmsg(4, 0xbffff490, 0)               = -1 EAGAIN (Resource temporarily unavailable)
gettimeofday({1055863922, 898193}, NULL) = 0
sendmsg(4, {msg_name(16)={sin_family=AF_INET, sin_port=htons(53), sin_addr=inet_addr("192.103.194.6")}}, msg_iov(1)=[{"\231O\1\0\0\1\0\0\0\0\0\0\6eisner\5decus\3org\0\0\1"..., 34}], msg_controllen=0, msg_flags=0}, 0) = 34
gettimeofday({1055863922, 898540}, NULL) = 0
select(5, [3 4], [], NULL, {0, 0})      = 0 (Timeout)
gettimeofday({1055863922, 898803}, NULL) = 0
gettimeofday({1055863922, 898874}, NULL) = 0
select(5, [3 4], [], NULL, {0, 998488}) = 1 (in [4], left {0, 880000})
gettimeofday({1055863923, 22646}, NULL) = 0
recvmsg(4, {msg_name(16)={sin_family=AF_INET, sin_port=htons(53), sin_addr=inet_addr("192.103.194.6")}}, msg_iov(1)=[{"\231O\201\200\0\1\0\1\0\3\0\5\6eisner\5decus\3org\0\0\1"..., 65535}], msg_controllen=20, msg_control=0xbffff51c, , msg_flags=0}, 0) = 194
fstat64(1, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40015000
close(4)                                = 0
close(3)                                = 0
getpid()                                = 7258
kill(7258, SIGTERM)                     = 0
--- SIGTERM (Terminated) ---
sigreturn()                             = ? (mask now [RTMIN])
gettimeofday({1055863923, 25301}, NULL) = 0
brk(0x8131000)                          = 0x8131000
write(1, "Server:\t\t192.103.194.6\nAddress:\t"..., 123Server:		192.103.194.6
Address:	192.103.194.6#53

Non-authoritative answer:
Name:	eisner.decus.org
Address: 192.135.80.34

) = 123
munmap(0x40015000, 4096)                = 0
_exit(0)                                = ?

real	0m1.151s
user	0m0.020s
sys	0m0.010s


 # sh scripts/ver_linux >> where-is-it-spend-allitstime.log

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux filesrv1 2.4.21 #1 SMP Sun Jun 15 19:30:01 EDT 2003 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.25
e2fsprogs              1.32
jfsutils               1.0.18
reiserfsprogs          3.x.1b
pcmcia-cs              3.1.33
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.13
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded


 # cat .config >> where-is-it-spend-allitstime.log

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
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
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_HIGHIO=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
# CONFIG_X86_NUMA is not set
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=y
CONFIG_HAVE_DEC_LOCK=y

#
# General setup
#
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
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
# CONFIG_HOTPLUG_PCI_ACPI is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
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
# CONFIG_PARPORT is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
CONFIG_BLK_DEV_DAC960=y
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=8192
CONFIG_BLK_DEV_INITRD=y
CONFIG_BLK_STATS=y

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE=y
# CONFIG_NET_IPGRE_BROADCAST is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_TFTP is not set
CONFIG_IP_NF_IRC=y
CONFIG_IP_NF_QUEUE=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_DSCP=y
CONFIG_IP_NF_MATCH_AH_ESP=y
CONFIG_IP_NF_MATCH_LENGTH=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
CONFIG_IP_NF_MATCH_UNCLEAN=y
CONFIG_IP_NF_MATCH_OWNER=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_MIRROR=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=y
CONFIG_IP_NF_NAT_IRC=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_ECN=y
CONFIG_IP_NF_TARGET_DSCP=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=y
CONFIG_IP_NF_TARGET_TCPMSS=y
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y
CONFIG_IPV6=y

#
#   IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_QUEUE=y
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_MATCH_LIMIT=y
CONFIG_IP6_NF_MATCH_MAC=y
# CONFIG_IP6_NF_MATCH_RT is not set
# CONFIG_IP6_NF_MATCH_OPTS is not set
# CONFIG_IP6_NF_MATCH_FRAG is not set
# CONFIG_IP6_NF_MATCH_HL is not set
CONFIG_IP6_NF_MATCH_MULTIPORT=y
CONFIG_IP6_NF_MATCH_OWNER=y
CONFIG_IP6_NF_MATCH_MARK=y
# CONFIG_IP6_NF_MATCH_IPV6HEADER is not set
# CONFIG_IP6_NF_MATCH_AHESP is not set
CONFIG_IP6_NF_MATCH_LENGTH=y
CONFIG_IP6_NF_MATCH_EUI64=y
CONFIG_IP6_NF_FILTER=y
CONFIG_IP6_NF_TARGET_LOG=y
CONFIG_IP6_NF_MANGLE=y
CONFIG_IP6_NF_TARGET_MARK=y
# CONFIG_KHTTPD is not set
CONFIG_ATM=y
CONFIG_ATM_CLIP=y
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=y
CONFIG_ATM_MPOA=y
# CONFIG_ATM_BR2684 is not set
CONFIG_VLAN_8021Q=y
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
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
# Network testing
#
# CONFIG_NET_PKTGEN is not set

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
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_BLK_DEV_ADMA100 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
CONFIG_BLK_DEV_RZ1000=y
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_SVWKS=y
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set
# CONFIG_BLK_DEV_ATARAID_SII is not set

#
# SCSI support
#
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=y
CONFIG_CHR_DEV_OSST=y
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_SCSI_AIC79XX is not set
CONFIG_SCSI_DPT_I2O=y
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
CONFIG_SCSI_BUSLOGIC=y
# CONFIG_SCSI_OMIT_FLASHPOINT is not set
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
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
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
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

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
CONFIG_DUMMY=y
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=y
# CONFIG_ETHERTAP is not set

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
# CONFIG_EL16 is not set
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
CONFIG_VORTEX=y
# CONFIG_TYPHOON is not set
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
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
CONFIG_DE4X5=y
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
CONFIG_EEPRO100=y
# CONFIG_EEPRO100_PIO is not set
# CONFIG_E100 is not set
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
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_SUNDANCE_MMIO is not set
CONFIG_TLAN=y
# CONFIG_TC35815 is not set
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
CONFIG_NS83820=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=y
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_SYNC_TTY=y
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y
# CONFIG_PPPOE is not set
CONFIG_PPPOATM=y
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y
# CONFIG_STRIP is not set
# CONFIG_WAVELAN is not set
# CONFIG_ARLAN is not set
# CONFIG_AIRONET4500 is not set
# CONFIG_AIRONET4500_NONCS is not set
# CONFIG_AIRONET4500_PROC is not set
# CONFIG_AIRO is not set
# CONFIG_HERMES is not set
# CONFIG_PLX_HERMES is not set
# CONFIG_PCI_HERMES is not set
CONFIG_NET_WIRELESS=y

#
# Token Ring devices
#
# CONFIG_TR is not set
CONFIG_NET_FC=y
CONFIG_IPHASE5526=y
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# ATM drivers
#
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
CONFIG_ATM_NICSTAR=y
CONFIG_ATM_NICSTAR_USE_SUNI=y
# CONFIG_ATM_NICSTAR_USE_IDT77105 is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
CONFIG_ATM_FORE200E_MAYBE=y
CONFIG_ATM_FORE200E_PCA=y
CONFIG_ATM_FORE200E_PCA_DEFAULT_FW=y
CONFIG_ATM_FORE200E_TX_RETRY=16
CONFIG_ATM_FORE200E_DEBUG=1
CONFIG_ATM_FORE200E=y

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
CONFIG_INPUT=y
# CONFIG_INPUT_KEYBDEV is not set
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_MANY_PORTS=y
CONFIG_SERIAL_SHARE_IRQ=y
# CONFIG_SERIAL_DETECT_IRQ is not set
# CONFIG_SERIAL_MULTIPORT is not set
# CONFIG_HUB6 is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

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
# CONFIG_MK712_MOUSE is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set
# CONFIG_INPUT_NS558 is not set
# CONFIG_INPUT_LIGHTNING is not set
# CONFIG_INPUT_PCIGAME is not set
# CONFIG_INPUT_CS461X is not set
# CONFIG_INPUT_EMU10K1 is not set
# CONFIG_INPUT_SERIO is not set
# CONFIG_INPUT_SERPORT is not set
# CONFIG_INPUT_ANALOG is not set
# CONFIG_INPUT_A3D is not set
# CONFIG_INPUT_ADI is not set
# CONFIG_INPUT_COBRA is not set
# CONFIG_INPUT_GF2K is not set
# CONFIG_INPUT_GRIP is not set
# CONFIG_INPUT_INTERACT is not set
# CONFIG_INPUT_TMDC is not set
# CONFIG_INPUT_SIDEWINDER is not set
# CONFIG_INPUT_IFORCE_USB is not set
# CONFIG_INPUT_IFORCE_232 is not set
# CONFIG_INPUT_WARRIOR is not set
# CONFIG_INPUT_MAGELLAN is not set
# CONFIG_INPUT_SPACEORB is not set
# CONFIG_INPUT_SPACEBALL is not set
# CONFIG_INPUT_STINGER is not set
# CONFIG_INPUT_DB9 is not set
# CONFIG_INPUT_GAMECON is not set
# CONFIG_INPUT_TURBOGRAFX is not set
# CONFIG_QIC02_TAPE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
# CONFIG_IPMI_KCS is not set
# CONFIG_IPMI_WATCHDOG is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_SCx200_GPIO is not set
# CONFIG_AMD_RNG is not set
CONFIG_INTEL_RNG=y
# CONFIG_AMD_PM768 is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_8151 is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
CONFIG_AGP_SWORKS=y
CONFIG_DRM=y
# CONFIG_DRM_OLD is not set
CONFIG_DRM_NEW=y
CONFIG_DRM_TDFX=y
CONFIG_DRM_R128=y
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I810_XFREE_41 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
CONFIG_QUOTA=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_EFS_FS=y
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
CONFIG_CRAMFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_MINIX_FS=y
# CONFIG_VXFS_FS is not set
CONFIG_NTFS_FS=y
CONFIG_NTFS_RW=y
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
CONFIG_ROMFS_FS=y
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
CONFIG_UDF_FS=y
CONFIG_UDF_RW=y
CONFIG_UFS_FS=y
CONFIG_UFS_FS_WRITE=y

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
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
CONFIG_ZISOFS_FS=y

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
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
CONFIG_SOLARIS_X86_PARTITION=y
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_LDM_PARTITION=y
CONFIG_LDM_DEBUG=y
# CONFIG_SGI_PARTITION is not set
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
# CONFIG_EFI_PARTITION is not set
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
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
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

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
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_HGA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_MATROX is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_RADEON is not set
CONFIG_FB_ATY128=y
# CONFIG_FB_INTEL is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_FBCON_ADVANCED=y
# CONFIG_FBCON_MFB is not set
# CONFIG_FBCON_CFB2 is not set
# CONFIG_FBCON_CFB4 is not set
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
# CONFIG_FBCON_VGA_PLANES is not set
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
CONFIG_USB=y
CONFIG_USB_DEBUG=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_UHCI_ALT=y
CONFIG_USB_OHCI=y
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_MIDI is not set
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y
# CONFIG_USB_HID is not set
# CONFIG_USB_HIDINPUT is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
CONFIG_USB_SCANNER=y
# CONFIG_USB_MICROTEK is not set
CONFIG_USB_HPUSBSCSI=y
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set

#
# Bluetooth support
#
CONFIG_BLUEZ=y
CONFIG_BLUEZ_L2CAP=y
# CONFIG_BLUEZ_SCO is not set
# CONFIG_BLUEZ_RFCOMM is not set
# CONFIG_BLUEZ_BNEP is not set

#
# Bluetooth device drivers
#
CONFIG_BLUEZ_HCIUSB=y
# CONFIG_BLUEZ_USB_SCO is not set
# CONFIG_BLUEZ_USB_ZERO_PACKET is not set
# CONFIG_BLUEZ_HCIUART is not set
# CONFIG_BLUEZ_HCIDTL1 is not set
# CONFIG_BLUEZ_HCIBT3C is not set
# CONFIG_BLUEZ_HCIBLUECARD is not set
# CONFIG_BLUEZ_HCIBTUART is not set
# CONFIG_BLUEZ_HCIVHCI is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_FRAME_POINTER=y

#
# Library routines
#
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y

 # lspci -v >> /home/babydr/where-is-it-spend-allitstime.log

00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 23)
	Flags: fast devsel
	Memory at f0000000 (32-bit, prefetchable) [disabled] [size=32M]
	Memory at effff000 (32-bit, non-prefetchable) [disabled] [size=4K]

00:00.1 PCI bridge: ServerWorks CNB20LE Host Bridge (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: fe400000-fe4fffff
	Prefetchable memory behind bridge: f2000000-fa0fffff
	Capabilities: [80] AGP version 2.0

00:00.2 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
	Flags: medium devsel

00:00.3 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
	Flags: medium devsel

00:01.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c1010 66MHz  Ultra3 SCSI Adapter (rev 01)
	Subsystem: LSI Logic / Symbios Logic (formerly NCR): Unknown device 1000
	Flags: bus master, medium devsel, latency 72, IRQ 29
	I/O ports at c400 [size=256]
	Memory at fe9ff800 (64-bit, non-prefetchable) [size=1K]
	Memory at fe9f6000 (64-bit, non-prefetchable) [size=8K]
	Expansion ROM at fe9f0000 [disabled] [size=16K]
	Capabilities: [40] Power Management version 2

00:01.1 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 53c1010 66MHz  Ultra3 SCSI Adapter (rev 01)
	Subsystem: LSI Logic / Symbios Logic (formerly NCR): Unknown device 1000
	Flags: bus master, medium devsel, latency 72, IRQ 28
	I/O ports at c800 [size=256]
	Memory at fe9ffc00 (64-bit, non-prefetchable) [size=1K]
	Memory at fe9fc000 (64-bit, non-prefetchable) [size=8K]
	Expansion ROM at fe9f8000 [disabled] [size=16K]
	Capabilities: [40] Power Management version 2

00:02.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 09)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
	Flags: bus master, slow devsel, latency 64, IRQ 30
	I/O ports at cf00 [size=64]
	Capabilities: [dc] Power Management version 2

00:07.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corp. EtherExpress PRO/100+ Server Adapter (PILA8470B)
	Flags: bus master, medium devsel, latency 64, IRQ 23
	Memory at fe9fe000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at ce80 [size=64]
	Memory at fe800000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at fe700000 [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2

00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 51)
	Subsystem: ServerWorks OSB4 South Bridge
	Flags: bus master, medium devsel, latency 0

00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 64
	I/O ports at ffa0 [size=16]

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 USB Controller (rev 04) (prog-if 10 [OHCI])
	Subsystem: ServerWorks OSB4/CSB5 USB Controller
	Flags: bus master, medium devsel, latency 64, IRQ 10
	Memory at fe9f5000 (32-bit, non-prefetchable) [size=4K]

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF/PRO AGP 4x TMDS (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Rage Fury Pro/Xpert 2000 Pro
	Flags: bus master, stepping, 66Mhz, medium devsel, latency 64, IRQ 17
	Memory at f4000000 (32-bit, prefetchable) [size=64M]
	I/O ports at b800 [size=256]
	Memory at fe4fc000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at fe4c0000 [disabled] [size=128K]
	Capabilities: [50] AGP version 2.0
	Capabilities: [5c] Power Management version 2

02:01.0 Ethernet controller: National Semiconductor Corporation DP83820 10/100/1000 Ethernet Controller
	Subsystem: National Semiconductor Corporation: Unknown device f022
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 24
	I/O ports at e800 [size=256]
	Memory at febff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at febe0000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 2

02:02.0 I2O: Distributed Processing Technology SmartRAID V Controller (rev 01) (prog-if 01)
	Subsystem: Distributed Processing Technology 3010S Fibre Channel
	Flags: bus master, 66Mhz, slow devsel, latency 64, IRQ 26
	BIST result: 00
	Memory at fc000000 (32-bit, prefetchable) [size=32M]
	Expansion ROM at <unassigned> [disabled] [size=32K]
	Capabilities: [80] Power Management version 2

02:02.1 PCI bridge: Distributed Processing Technology PCI Bridge (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, slow devsel, latency 64
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Capabilities: [68] Power Management version 2

 ### dmesg output saved right after first boot into 2.4.21 . JimL
 # cat dmesg.20030615195422 >> where-is-it-spend-allitstime.log

Linux version 2.4.21 (root@(none)) (gcc version 2.95.3 20010315 (release)) #1 SMP Sun Jun 15 19:30:01 EDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000080000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec02000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
1152MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
hm, page 000ff000 reserved twice.
hm, page 00100000 reserved twice.
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
On node 0 totalpages: 524288
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 294912 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: AMI      Product ID: CNB20HE      APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
I/O APIC #4 Version 17 at 0xFEC00000.
I/O APIC #5 Version 17 at 0xFEC01000.
Enabling APIC mode: Flat.^IUsing 2 I/O APICs
Processors: 2
Kernel command line: BOOT_IMAGE=filesrv1 ro root=801 ramdisk=8192
Initializing CPU#0
Detected 849.158 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1690.82 BogoMIPS
Memory: 2067164k/2097152k available (3033k kernel code, 29600k reserved, 1093k data, 216k init, 1179648k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 0a
per-CPU timeslice cutoff: 731.33 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1697.38 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Coppermine) stepping 0a
Total of 2 processors activated (3388.21 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 4 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 4 ... ok.
Setting 5 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 5 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 4-0, 4-5, 4-9, 4-11, 4-14, 4-15, 5-0, 5-2, 5-3, 5-4, 5-5, 5-6, 5-9, 5-11, 5-15 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.
number of MP IRQ sources: 18.
number of IO-APIC #4 registers: 16.
number of IO-APIC #5 registers: 16.
testing the IO APIC.......................

IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 003 03  0    0    0   0   0    1    1    31
 01 003 03  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 003 03  0    0    0   0   0    1    1    51
 07 003 03  0    0    0   0   0    1    1    59
 08 003 03  0    0    0   0   0    1    1    61
 09 000 00  1    0    0   0   0    0    0    00
 0a 003 03  1    1    0   1   0    1    1    69
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    71
 0d 003 03  0    0    0   0   0    1    1    79
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00

IO APIC #5......
.... register #00: 05000000
.......    : physical APIC id: 05
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 01000000
.......     : arbitration: 01
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  1    1    0   1   0    1    1    81
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 003 03  1    1    0   1   0    1    1    89
 08 003 03  1    1    0   1   0    1    1    91
 09 000 00  1    0    0   0   0    0    0    00
 0a 003 03  1    1    0   1   0    1    1    99
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  1    1    0   1   0    1    1    A1
 0d 003 03  1    1    0   1   0    1    1    A9
 0e 003 03  1    1    0   1   0    1    1    B1
 0f 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ10 -> 0:10
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ17 -> 1:1
IRQ23 -> 1:7
IRQ24 -> 1:8
IRQ26 -> 1:10
IRQ28 -> 1:12
IRQ29 -> 1:13
IRQ30 -> 1:14
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 849.1599 MHz.
..... host bus clock speed is 99.9008 MHz.
cpu: 0, clocks: 999008, slice: 333002
CPU0<T0:999008,T1:666000,D:6,S:333002,C:999008>
cpu: 1, clocks: 999008, slice: 333002
CPU1<T0:999008,T1:332992,D:12,S:333002,C:999008>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfdbc1, last bus=3
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered primary peer bus 02 [IRQ]
PCI: Using IRQ router ServerWorks [1166/0200] at 00:0f.0
PCI->APIC IRQ transform: (B0,I1,P0) -> 29
PCI->APIC IRQ transform: (B0,I1,P1) -> 28
PCI->APIC IRQ transform: (B0,I2,P0) -> 30
PCI->APIC IRQ transform: (B0,I7,P0) -> 23
PCI->APIC IRQ transform: (B0,I15,P0) -> 10
PCI->APIC IRQ transform: (B1,I0,P0) -> 17
PCI->APIC IRQ transform: (B2,I1,P0) -> 24
PCI->APIC IRQ transform: (B2,I2,P0) -> 26
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
BlueZ Core ver 2.2 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver v1.1.22 [Flags: R/W]
EFS: 1.0a - http://aeschi.ch.eu.org/efs/
udf: registering filesystem
aty128fb: Rage128 BIOS located at segment C00C0000
aty128fb: Rage128 Pro PF (AGP) [chip rev 0x1] 32M 128-bit SDR SGRAM (1:1)
Console: switching to colour frame buffer device 80x30
fb0: ATY Rage128 frame buffer device on PCI
mtrr: type mismatch for f4000000,2000000 old: uncachable new: write-combining
aty128fb: Rage128 MTRR set to ON
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
fore200e: FORE Systems 200E-series driver - version 0.2d
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
ThunderLAN driver v1.15
TLAN: 0 devices installed, PCI: 0  EISA: 0
ns83820.c: National Semiconductor DP83820 10/100/1000 driver.
eth0: ns83820.c: 0x22c: f022100b, subsystem: 100b:f022
eth0: detected 64 bit PCI data bus.
eth0: enabling optical transceiver
eth0: ns83820 v0.20: DP83820 v1.3: 00:40:f4:66:df:ed io=0xfebff000 irq=24 f=sg
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth1: Intel Corp. 82557/8/9 [Ethernet Pro 100], 00:E0:81:04:D2:78, IRQ 23.
  Board assembly 567812-052, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 1920M
agpgart: AGP aperture is 32M @ 0xf0000000
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] AGP 0.99 on Serverworks HE @ 0xf0000000 32MB
mtrr: type mismatch for f0000000,2000000 old: uncachable new: write-combining
[drm] Initialized r128 2.2.0 20010917 on minor 1
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks OSB4: IDE controller at PCI slot 00:0f.1
PCI: Enabling device 00:0f.1 (0000 -> 0001)
SvrWks OSB4: chipset revision 0
SvrWks OSB4: not 100%% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
SCSI subsystem driver Revision: 1.00
sym.0.1.1: setting PCI_COMMAND_PARITY...
sym.0.1.0: setting PCI_COMMAND_PARITY...
sym0: <1010-66> rev 0x1 on pci bus 0 device 1 function 0 irq 29
sym0: using 64 bit DMA addressing
sym0: Symbios NVRAM, ID 7, Fast-80, SE, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: handling phase mismatch from SCRIPTS.
sym0: SCSI BUS has been reset.
sym1: <1010-66> rev 0x1 on pci bus 0 device 1 function 1 irq 28
sym1: using 64 bit DMA addressing
sym1: Symbios NVRAM, ID 7, Fast-80, SE, parity checking
sym1: open drain IRQ line driver, using on-chip SRAM
sym1: using LOAD/STORE-based firmware.
sym1: handling phase mismatch from SCRIPTS.
sym1: SCSI BUS has been reset.
scsi0 : sym-2.1.19-pre3
scsi1 : sym-2.1.19-pre3
  Vendor: SEAGATE   Model: ST118273LW        Rev: 6246
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 15)
  Vendor: IBM       Model: DDRS-34560D       Rev: DC1B
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym0:2: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 15)
  Vendor: COMPAQ    Model: ST34371W          Rev: 0940
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym0:0:0: tagged command queuing enabled, command queue depth 16.
sym0:1:0: tagged command queuing enabled, command queue depth 16.
sym0:2:0: tagged command queuing enabled, command queue depth 16.
  Vendor: COMPAQ    Model: TSL-9000          Rev: 2.06
  Type:   Sequential-Access                  ANSI SCSI revision: 02
  Vendor: COMPAQ    Model: TSL-9000          Rev: 2.06
  Type:   Medium Changer                     ANSI SCSI revision: 02
  Vendor: HP        Model: CD-Writer+ 9200   Rev: 1.0e
  Type:   CD-ROM                             ANSI SCSI revision: 04
  Vendor: HP        Model: CD-Writer+ 9200   Rev: 1.0c
  Type:   CD-ROM                             ANSI SCSI revision: 04
Loading Adaptec I2O RAID: Version 2.4 Build 5
Detecting Adaptec I2O RAID controllers...
Adaptec I2O RAID controller 0 at fa847000 size=100000 irq=26
dpti: If you have a lot of devices this could take a few minutes.
dpti0: Reading the hardware resource table.
TID 008  Vendor: ADAPTEC      Device: AIC-7899     Rev: 00000001
TID 525  Vendor: ADAPTEC      Device: RAID-5       Rev: 380E
scsi2 : Vendor: Adaptec  Model: 2110S            FW:380E
  Vendor: ADAPTEC   Model: RAID-5            Rev: 380E
  Type:   Direct-Access                      ANSI SCSI revision: 02
st: Version 20020805, bufsize 32768, wrt 30720, max init. bufs 4, s/g segs 16
Attached scsi tape st0 at scsi1, channel 0, id 4, lun 0
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
Attached scsi disk sdd at scsi2, channel 0, id 0, lun 0
sym0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 15)
SCSI device sda: 35566480 512-byte hdwr sectors (18210 MB)
Partition check:
 sda:<7>ldm_validate_partition_table(): Found an MS-DOS partition table, not a dynamic disk.
 sda1 sda2
SCSI device sdb: 8925000 512-byte hdwr sectors (4570 MB)
 sdb:<7>ldm_validate_partition_table(): Found an MS-DOS partition table, not a dynamic disk.
 sdb1 sdb2
SCSI device sdc: 8386000 512-byte hdwr sectors (4294 MB)
 sdc:<7>ldm_validate_partition_table(): Found an MS-DOS partition table, not a dynamic disk.
 sdc1 sdc2
SCSI device sdd: 177827840 512-byte hdwr sectors (91048 MB)
 sdd:<7>ldm_validate_partition_table(): Found an MS-DOS partition table, not a dynamic disk.
 sdd1 sdd2
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 5, lun 0
Attached scsi CD-ROM sr1 at scsi1, channel 0, id 6, lun 0
sym1:5: FAST-10 SCSI 10.0 MB/s ST (100.0 ns, offset 15)
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sym1:6: FAST-10 SCSI 10.0 MB/s ST (100.0 ns, offset 15)
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Attached scsi generic sg4 at scsi1, channel 0, id 4, lun 1,  type 8
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
host/uhci.c: USB Universal Host Controller Interface driver v1.1
host/usb-ohci.c: USB OHCI at membase 0xfa948000, IRQ 10
host/usb-ohci.c: usb-00:0f.2, ServerWorks OSB4/CSB5 OHCI USB Controller
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF c283b76c, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB OHCI Root Hub
SerialNumber: fa948000
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: Port indicators are not supported
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RRRR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c283b76c
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
usb.c: registered new driver usbscanner
scanner.c: 0.4.12:USB Scanner Driver
usb.c: registered new driver usblp
printer.c: v0.11: USB Printer Device Class driver
hpusbscsi.c: [hpusbscsi_init:250] driver loaded, DebugLvel=0
usb.c: registered new driver hpusbscsi
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  1482.000 MB/sec
   32regs    :   979.200 MB/sec
   pIII_sse  :  1690.000 MB/sec
   pII_mmx   :  1873.200 MB/sec
   p5_mmx    :  2003.600 MB/sec
raid5: using function: pIII_sse (1690.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
BlueZ HCI USB driver ver 2.4 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
usb.c: registered new driver hci_usb
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 128Kbytes
TCP: Hash tables configured (established 131072 bind 43690)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 292 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
registering ipv6 mark target
BlueZ L2CAP ver 2.1 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
lec.c: Jun 15 2003 19:36:52 initialized
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 216k freed
Adding Swap: 525288k swap-space (priority -1)
Adding Swap: 524480k swap-space (priority -2)
eth0: link now 1000F mbps, full duplex and up.
eth1: no IPv6 routers present
eth0: no IPv6 routers present
mtrr: type mismatch for f4000000,2000000 old: uncachable new: write-combining
mtrr: type mismatch for f4000000,2000000 old: uncachable new: write-combining
