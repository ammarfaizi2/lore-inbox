Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbUDLXZT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 19:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbUDLXZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 19:25:19 -0400
Received: from dsl-64-30-195-78.lcinet.net ([64.30.195.78]:14037 "EHLO
	jg555.com") by vger.kernel.org with ESMTP id S263163AbUDLXYV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 19:24:21 -0400
Message-ID: <26e601c420e5$4087ae90$d100a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Kernel" <linux-kernel@vger.kernel.org>
Subject: Problem with uhci_usb
Date: Mon, 12 Apr 2004 16:24:07 -0700
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_26E3_01C420AA.93DC6440"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_26E3_01C420AA.93DC6440
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I plug in usb devices and nothing shows up. I reboot the system with the
devices attached, nothing shows up. If I modeprobe ov511 nothing. If I
modrobe usb-storage nothing. I am using the standard kernel with -aa5
patchset and supermount-ng. I tried going back to 2.6.5, 2.6.4, and 2.6.3
without the patches, the same problem. USB worked under 2.4.25. Any ideas
and suggestions would be helpful, if more information is needed, please let
me know and I will provide it.

Here is the data.

cat /proc/interrrupts - output

           CPU0       CPU1
  0:  139683637         37    IO-APIC-edge  timer
  1:        510          1    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  3:      94944          1    IO-APIC-edge  serial
  4:        168          1    IO-APIC-edge  serial
  7:          0          0    IO-APIC-edge  parport0
  8:          0          1    IO-APIC-edge  rtc
  9:     466512          0   IO-APIC-level  megaraid
 11:    1163951          1   IO-APIC-level  eth0, eth1, eth2, eth3
 15:      24533          1   IO-APIC-level  aic7xxx, aic7xxx
NMI:  139683139  139683025
LOC:  139689481  139689629
ERR:          0
MIS:          0


lspci - output
00:13.0 USB Controller: OPTi Inc. 82C861 (rev 10)

00:13.0 USB Controller: OPTi Inc. 82C861 (rev 10) (prog-if 10 [OHCI])
        Subsystem: OPTi Inc. 82C861
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin A routed to IRQ 14
        Region 0: Memory at fdfff000 (32-bit, non-prefetchable) [size=4K]

ls /sys/bus/usb/devices - output
[blank]

ls /sys/bus/usb/drivers - output
hub  usb  usbfs

syslog - output
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
USB Universal Host Controller Interface driver v2.2

linux_ver - output
Linux server 2.6.5-lfs-3 #1 SMP Sat Apr 10 20:25:01 PDT 2004 i686 pentium2
i386 GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
binutils               2.15.90.0.1.1
util-linux             2.12a
mount                  2.12a
module-init-tools      3.0
e2fsprogs              1.35
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Linux C++ Library      5.0.5
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         uhci_hcd usbcore videodev hfs vfat fat isofs
zlib_inflate floppy ext2 nfsd exportfs lockd sunrpc parport_pc lp parport
ipt_TOS ipt_TCPMSS ipt_state ipt_REJECT ipt_LOG ipt_limit iptable_mangle
iptable_nat ip_conntrack_irc ip_conntrack_ftp ip_conntrack iptable_filter
ip_tables af_packet bonding 8250 serial_core tulip crc32 rtc supermount unix
aic7xxx megaraid sd_mod scsi_mod

Config file is attached
----
Jim Gifford
maillist@jg555.com

------=_NextPart_000_26E3_01C420AA.93DC6440
Content-Type: application/octet-stream;
	name="kernel.config"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="kernel.config"

#=0A=
# Automatically generated make config: don't edit=0A=
#=0A=
CONFIG_X86=3Dy=0A=
CONFIG_MMU=3Dy=0A=
CONFIG_UID16=3Dy=0A=
CONFIG_GENERIC_ISA_DMA=3Dy=0A=
=0A=
#=0A=
# Code maturity level options=0A=
#=0A=
CONFIG_EXPERIMENTAL=3Dy=0A=
CONFIG_CLEAN_COMPILE=3Dy=0A=
CONFIG_STANDALONE=3Dy=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
CONFIG_SWAP=3Dy=0A=
CONFIG_SYSVIPC=3Dy=0A=
# CONFIG_BSD_PROCESS_ACCT is not set=0A=
CONFIG_SYSCTL=3Dy=0A=
CONFIG_LOG_BUF_SHIFT=3D15=0A=
CONFIG_HOTPLUG=3Dy=0A=
CONFIG_IKCONFIG=3Dy=0A=
CONFIG_IKCONFIG_PROC=3Dy=0A=
# CONFIG_EMBEDDED is not set=0A=
CONFIG_KALLSYMS=3Dy=0A=
CONFIG_FUTEX=3Dy=0A=
CONFIG_EPOLL=3Dy=0A=
CONFIG_IOSCHED_NOOP=3Dy=0A=
CONFIG_IOSCHED_AS=3Dy=0A=
CONFIG_IOSCHED_DEADLINE=3Dy=0A=
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set=0A=
=0A=
#=0A=
# Loadable module support=0A=
#=0A=
CONFIG_MODULES=3Dy=0A=
CONFIG_MODULE_UNLOAD=3Dy=0A=
CONFIG_MODULE_FORCE_UNLOAD=3Dy=0A=
CONFIG_OBSOLETE_MODPARM=3Dy=0A=
CONFIG_MODVERSIONS=3Dy=0A=
CONFIG_KMOD=3Dy=0A=
CONFIG_STOP_MACHINE=3Dy=0A=
=0A=
#=0A=
# Processor type and features=0A=
#=0A=
CONFIG_X86_PC=3Dy=0A=
# CONFIG_X86_ELAN is not set=0A=
# CONFIG_X86_VOYAGER is not set=0A=
# CONFIG_X86_NUMAQ is not set=0A=
# CONFIG_X86_SUMMIT is not set=0A=
# CONFIG_X86_BIGSMP is not set=0A=
# CONFIG_X86_VISWS is not set=0A=
# CONFIG_X86_GENERICARCH is not set=0A=
# CONFIG_X86_ES7000 is not set=0A=
# CONFIG_M386 is not set=0A=
# CONFIG_M486 is not set=0A=
# CONFIG_M586 is not set=0A=
# CONFIG_M586TSC is not set=0A=
# CONFIG_M586MMX is not set=0A=
# CONFIG_M686 is not set=0A=
CONFIG_MPENTIUMII=3Dy=0A=
# CONFIG_MPENTIUMIII is not set=0A=
# CONFIG_MPENTIUMM is not set=0A=
# CONFIG_MPENTIUM4 is not set=0A=
# CONFIG_MK6 is not set=0A=
# CONFIG_MK7 is not set=0A=
# CONFIG_MK8 is not set=0A=
# CONFIG_MCRUSOE is not set=0A=
# CONFIG_MWINCHIPC6 is not set=0A=
# CONFIG_MWINCHIP2 is not set=0A=
# CONFIG_MWINCHIP3D is not set=0A=
# CONFIG_MCYRIXIII is not set=0A=
# CONFIG_MVIAC3_2 is not set=0A=
# CONFIG_X86_GENERIC is not set=0A=
CONFIG_X86_CMPXCHG=3Dy=0A=
CONFIG_X86_XADD=3Dy=0A=
CONFIG_X86_L1_CACHE_SHIFT=3D5=0A=
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy=0A=
CONFIG_X86_WP_WORKS_OK=3Dy=0A=
CONFIG_X86_INVLPG=3Dy=0A=
CONFIG_X86_BSWAP=3Dy=0A=
CONFIG_X86_POPAD_OK=3Dy=0A=
CONFIG_X86_GOOD_APIC=3Dy=0A=
CONFIG_X86_INTEL_USERCOPY=3Dy=0A=
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy=0A=
# CONFIG_HPET_TIMER is not set=0A=
# CONFIG_HPET_EMULATE_RTC is not set=0A=
CONFIG_SMP=3Dy=0A=
CONFIG_NR_CPUS=3D2=0A=
CONFIG_PREEMPT=3Dy=0A=
CONFIG_X86_LOCAL_APIC=3Dy=0A=
CONFIG_X86_IO_APIC=3Dy=0A=
CONFIG_X86_TSC=3Dy=0A=
CONFIG_X86_MCE=3Dy=0A=
# CONFIG_X86_MCE_NONFATAL is not set=0A=
# CONFIG_X86_MCE_P4THERMAL is not set=0A=
# CONFIG_TOSHIBA is not set=0A=
# CONFIG_I8K is not set=0A=
CONFIG_MICROCODE=3Dm=0A=
CONFIG_X86_MSR=3Dm=0A=
CONFIG_X86_CPUID=3Dm=0A=
=0A=
#=0A=
# Firmware Drivers=0A=
#=0A=
# CONFIG_EDD is not set=0A=
# CONFIG_NOHIGHMEM is not set=0A=
CONFIG_HIGHMEM4G=3Dy=0A=
# CONFIG_HIGHMEM64G is not set=0A=
CONFIG_HIGHMEM=3Dy=0A=
CONFIG_HIGHPTE=3Dy=0A=
# CONFIG_MATH_EMULATION is not set=0A=
CONFIG_MTRR=3Dy=0A=
CONFIG_IRQBALANCE=3Dy=0A=
CONFIG_HAVE_DEC_LOCK=3Dy=0A=
CONFIG_REGPARM=3Dy=0A=
=0A=
#=0A=
# Power management options (ACPI, APM)=0A=
#=0A=
# CONFIG_PM is not set=0A=
=0A=
#=0A=
# ACPI (Advanced Configuration and Power Interface) Support=0A=
#=0A=
# CONFIG_ACPI is not set=0A=
CONFIG_ACPI_BOOT=3Dy=0A=
=0A=
#=0A=
# CPU Frequency scaling=0A=
#=0A=
# CONFIG_CPU_FREQ is not set=0A=
=0A=
#=0A=
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)=0A=
#=0A=
CONFIG_PCI=3Dy=0A=
# CONFIG_PCI_GOBIOS is not set=0A=
# CONFIG_PCI_GOMMCONFIG is not set=0A=
# CONFIG_PCI_GODIRECT is not set=0A=
CONFIG_PCI_GOANY=3Dy=0A=
CONFIG_PCI_BIOS=3Dy=0A=
CONFIG_PCI_DIRECT=3Dy=0A=
CONFIG_PCI_MMCONFIG=3Dy=0A=
# CONFIG_PCI_USE_VECTOR is not set=0A=
# CONFIG_PCI_LEGACY_PROC is not set=0A=
CONFIG_PCI_NAMES=3Dy=0A=
CONFIG_ISA=3Dy=0A=
CONFIG_EISA=3Dy=0A=
# CONFIG_EISA_VLB_PRIMING is not set=0A=
CONFIG_EISA_PCI_EISA=3Dy=0A=
# CONFIG_EISA_VIRTUAL_ROOT is not set=0A=
CONFIG_EISA_NAMES=3Dy=0A=
# CONFIG_MCA is not set=0A=
# CONFIG_SCx200 is not set=0A=
=0A=
#=0A=
# PCMCIA/CardBus support=0A=
#=0A=
# CONFIG_PCMCIA is not set=0A=
CONFIG_PCMCIA_PROBE=3Dy=0A=
=0A=
#=0A=
# PCI Hotplug Support=0A=
#=0A=
# CONFIG_HOTPLUG_PCI is not set=0A=
=0A=
#=0A=
# Executable file formats=0A=
#=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
# CONFIG_BINFMT_AOUT is not set=0A=
CONFIG_BINFMT_MISC=3Dm=0A=
=0A=
#=0A=
# Device Drivers=0A=
#=0A=
=0A=
#=0A=
# Generic Driver Options=0A=
#=0A=
# CONFIG_FW_LOADER is not set=0A=
# CONFIG_DEBUG_DRIVER is not set=0A=
=0A=
#=0A=
# Memory Technology Devices (MTD)=0A=
#=0A=
# CONFIG_MTD is not set=0A=
=0A=
#=0A=
# Parallel port support=0A=
#=0A=
CONFIG_PARPORT=3Dm=0A=
CONFIG_PARPORT_PC=3Dm=0A=
CONFIG_PARPORT_PC_CML1=3Dm=0A=
# CONFIG_PARPORT_SERIAL is not set=0A=
CONFIG_PARPORT_PC_FIFO=3Dy=0A=
CONFIG_PARPORT_PC_SUPERIO=3Dy=0A=
# CONFIG_PARPORT_OTHER is not set=0A=
CONFIG_PARPORT_1284=3Dy=0A=
=0A=
#=0A=
# Plug and Play support=0A=
#=0A=
CONFIG_PNP=3Dy=0A=
# CONFIG_PNP_DEBUG is not set=0A=
=0A=
#=0A=
# Protocols=0A=
#=0A=
CONFIG_ISAPNP=3Dy=0A=
CONFIG_PNPBIOS=3Dy=0A=
CONFIG_PNPBIOS_PROC_FS=3Dy=0A=
=0A=
#=0A=
# Block devices=0A=
#=0A=
CONFIG_BLK_DEV_FD=3Dm=0A=
# CONFIG_BLK_DEV_XD is not set=0A=
# CONFIG_PARIDE is not set=0A=
# CONFIG_BLK_CPQ_DA is not set=0A=
# CONFIG_BLK_CPQ_CISS_DA is not set=0A=
# CONFIG_BLK_DEV_DAC960 is not set=0A=
# CONFIG_BLK_DEV_UMEM is not set=0A=
CONFIG_BLK_DEV_LOOP=3Dm=0A=
# CONFIG_BLK_DEV_CRYPTOLOOP is not set=0A=
# CONFIG_BLK_DEV_NBD is not set=0A=
# CONFIG_BLK_DEV_CARMEL is not set=0A=
CONFIG_BLK_DEV_RAM=3Dy=0A=
CONFIG_BLK_DEV_RAM_SIZE=3D4096=0A=
CONFIG_BLK_DEV_INITRD=3Dy=0A=
# CONFIG_LBD is not set=0A=
# CONFIG_CIPHER_TWOFISH is not set=0A=
=0A=
#=0A=
# ATA/ATAPI/MFM/RLL support=0A=
#=0A=
# CONFIG_IDE is not set=0A=
=0A=
#=0A=
# SCSI device support=0A=
#=0A=
CONFIG_SCSI=3Dm=0A=
# CONFIG_SCSI_PROC_FS is not set=0A=
=0A=
#=0A=
# SCSI support type (disk, tape, CD-ROM)=0A=
#=0A=
CONFIG_BLK_DEV_SD=3Dm=0A=
CONFIG_CHR_DEV_ST=3Dm=0A=
# CONFIG_CHR_DEV_OSST is not set=0A=
CONFIG_BLK_DEV_SR=3Dm=0A=
# CONFIG_BLK_DEV_SR_VENDOR is not set=0A=
CONFIG_CHR_DEV_SG=3Dm=0A=
=0A=
#=0A=
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs=0A=
#=0A=
CONFIG_SCSI_MULTI_LUN=3Dy=0A=
# CONFIG_SCSI_REPORT_LUNS is not set=0A=
# CONFIG_SCSI_CONSTANTS is not set=0A=
# CONFIG_SCSI_LOGGING is not set=0A=
=0A=
#=0A=
# SCSI Transport Attributes=0A=
#=0A=
# CONFIG_SCSI_SPI_ATTRS is not set=0A=
# CONFIG_SCSI_FC_ATTRS is not set=0A=
=0A=
#=0A=
# SCSI low-level drivers=0A=
#=0A=
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set=0A=
# CONFIG_SCSI_7000FASST is not set=0A=
# CONFIG_SCSI_ACARD is not set=0A=
# CONFIG_SCSI_AHA152X is not set=0A=
# CONFIG_SCSI_AHA1542 is not set=0A=
# CONFIG_SCSI_AHA1740 is not set=0A=
# CONFIG_SCSI_AACRAID is not set=0A=
CONFIG_SCSI_AIC7XXX=3Dm=0A=
CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D32=0A=
CONFIG_AIC7XXX_RESET_DELAY_MS=3D15000=0A=
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set=0A=
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set=0A=
CONFIG_AIC7XXX_DEBUG_ENABLE=3Dy=0A=
CONFIG_AIC7XXX_DEBUG_MASK=3D0=0A=
CONFIG_AIC7XXX_REG_PRETTY_PRINT=3Dy=0A=
# CONFIG_SCSI_AIC7XXX_OLD is not set=0A=
# CONFIG_SCSI_AIC79XX is not set=0A=
# CONFIG_SCSI_ADVANSYS is not set=0A=
# CONFIG_SCSI_IN2000 is not set=0A=
CONFIG_SCSI_MEGARAID=3Dm=0A=
# CONFIG_SCSI_SATA is not set=0A=
# CONFIG_SCSI_BUSLOGIC is not set=0A=
# CONFIG_SCSI_CPQFCTS is not set=0A=
# CONFIG_SCSI_DMX3191D is not set=0A=
# CONFIG_SCSI_DTC3280 is not set=0A=
# CONFIG_SCSI_EATA is not set=0A=
# CONFIG_SCSI_EATA_PIO is not set=0A=
# CONFIG_SCSI_FUTURE_DOMAIN is not set=0A=
# CONFIG_SCSI_GDTH is not set=0A=
# CONFIG_SCSI_GENERIC_NCR5380 is not set=0A=
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set=0A=
# CONFIG_SCSI_IPS is not set=0A=
# CONFIG_SCSI_INIA100 is not set=0A=
# CONFIG_SCSI_PPA is not set=0A=
# CONFIG_SCSI_IMM is not set=0A=
# CONFIG_SCSI_NCR53C406A is not set=0A=
# CONFIG_SCSI_SYM53C8XX_2 is not set=0A=
# CONFIG_SCSI_PAS16 is not set=0A=
# CONFIG_SCSI_PSI240I is not set=0A=
# CONFIG_SCSI_QLOGIC_FAS is not set=0A=
# CONFIG_SCSI_QLOGIC_ISP is not set=0A=
# CONFIG_SCSI_QLOGIC_FC is not set=0A=
# CONFIG_SCSI_QLOGIC_1280 is not set=0A=
CONFIG_SCSI_QLA2XXX=3Dm=0A=
# CONFIG_SCSI_QLA21XX is not set=0A=
# CONFIG_SCSI_QLA22XX is not set=0A=
# CONFIG_SCSI_QLA2300 is not set=0A=
# CONFIG_SCSI_QLA2322 is not set=0A=
# CONFIG_SCSI_QLA6312 is not set=0A=
# CONFIG_SCSI_QLA6322 is not set=0A=
# CONFIG_SCSI_SIM710 is not set=0A=
# CONFIG_SCSI_SYM53C416 is not set=0A=
# CONFIG_SCSI_DC395x is not set=0A=
# CONFIG_SCSI_DC390T is not set=0A=
# CONFIG_SCSI_T128 is not set=0A=
# CONFIG_SCSI_U14_34F is not set=0A=
# CONFIG_SCSI_ULTRASTOR is not set=0A=
# CONFIG_SCSI_NSP32 is not set=0A=
# CONFIG_SCSI_DEBUG is not set=0A=
=0A=
#=0A=
# Old CD-ROM drivers (not SCSI, not IDE)=0A=
#=0A=
# CONFIG_CD_NO_IDESCSI is not set=0A=
=0A=
#=0A=
# Multi-device support (RAID and LVM)=0A=
#=0A=
# CONFIG_MD is not set=0A=
=0A=
#=0A=
# Fusion MPT device support=0A=
#=0A=
# CONFIG_FUSION is not set=0A=
=0A=
#=0A=
# IEEE 1394 (FireWire) support=0A=
#=0A=
# CONFIG_IEEE1394 is not set=0A=
=0A=
#=0A=
# I2O device support=0A=
#=0A=
# CONFIG_I2O is not set=0A=
=0A=
#=0A=
# Networking support=0A=
#=0A=
CONFIG_NET=3Dy=0A=
=0A=
#=0A=
# Networking options=0A=
#=0A=
CONFIG_PACKET=3Dm=0A=
CONFIG_PACKET_MMAP=3Dy=0A=
# CONFIG_NETLINK_DEV is not set=0A=
CONFIG_UNIX=3Dm=0A=
# CONFIG_NET_KEY is not set=0A=
CONFIG_INET=3Dy=0A=
CONFIG_IP_MULTICAST=3Dy=0A=
# CONFIG_IP_ADVANCED_ROUTER is not set=0A=
# CONFIG_IP_PNP is not set=0A=
# CONFIG_NET_IPIP is not set=0A=
# CONFIG_NET_IPGRE is not set=0A=
# CONFIG_IP_MROUTE is not set=0A=
# CONFIG_ARPD is not set=0A=
CONFIG_SYN_COOKIES=3Dy=0A=
# CONFIG_INET_AH is not set=0A=
# CONFIG_INET_ESP is not set=0A=
# CONFIG_INET_IPCOMP is not set=0A=
=0A=
#=0A=
# IP: Virtual Server Configuration=0A=
#=0A=
# CONFIG_IP_VS is not set=0A=
# CONFIG_IPV6 is not set=0A=
# CONFIG_DECNET is not set=0A=
# CONFIG_BRIDGE is not set=0A=
CONFIG_NETFILTER=3Dy=0A=
# CONFIG_NETFILTER_DEBUG is not set=0A=
=0A=
#=0A=
# IP: Netfilter Configuration=0A=
#=0A=
CONFIG_IP_NF_CONNTRACK=3Dm=0A=
CONFIG_IP_NF_FTP=3Dm=0A=
CONFIG_IP_NF_IRC=3Dm=0A=
CONFIG_IP_NF_TFTP=3Dm=0A=
CONFIG_IP_NF_AMANDA=3Dm=0A=
CONFIG_IP_NF_QUEUE=3Dm=0A=
CONFIG_IP_NF_IPTABLES=3Dm=0A=
CONFIG_IP_NF_MATCH_LIMIT=3Dm=0A=
CONFIG_IP_NF_MATCH_IPRANGE=3Dm=0A=
CONFIG_IP_NF_MATCH_MAC=3Dm=0A=
CONFIG_IP_NF_MATCH_PKTTYPE=3Dm=0A=
CONFIG_IP_NF_MATCH_MARK=3Dm=0A=
CONFIG_IP_NF_MATCH_MULTIPORT=3Dm=0A=
CONFIG_IP_NF_MATCH_TOS=3Dm=0A=
CONFIG_IP_NF_MATCH_RECENT=3Dm=0A=
CONFIG_IP_NF_MATCH_ECN=3Dm=0A=
CONFIG_IP_NF_MATCH_DSCP=3Dm=0A=
CONFIG_IP_NF_MATCH_AH_ESP=3Dm=0A=
CONFIG_IP_NF_MATCH_LENGTH=3Dm=0A=
CONFIG_IP_NF_MATCH_TTL=3Dm=0A=
CONFIG_IP_NF_MATCH_TCPMSS=3Dm=0A=
CONFIG_IP_NF_MATCH_HELPER=3Dm=0A=
CONFIG_IP_NF_MATCH_STATE=3Dm=0A=
CONFIG_IP_NF_MATCH_CONNTRACK=3Dm=0A=
CONFIG_IP_NF_MATCH_OWNER=3Dm=0A=
CONFIG_IP_NF_FILTER=3Dm=0A=
CONFIG_IP_NF_TARGET_REJECT=3Dm=0A=
CONFIG_IP_NF_NAT=3Dm=0A=
CONFIG_IP_NF_NAT_NEEDED=3Dy=0A=
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm=0A=
CONFIG_IP_NF_TARGET_REDIRECT=3Dm=0A=
CONFIG_IP_NF_TARGET_NETMAP=3Dm=0A=
CONFIG_IP_NF_TARGET_SAME=3Dm=0A=
# CONFIG_IP_NF_NAT_LOCAL is not set=0A=
CONFIG_IP_NF_NAT_SNMP_BASIC=3Dm=0A=
CONFIG_IP_NF_NAT_IRC=3Dm=0A=
CONFIG_IP_NF_NAT_FTP=3Dm=0A=
CONFIG_IP_NF_NAT_TFTP=3Dm=0A=
CONFIG_IP_NF_NAT_AMANDA=3Dm=0A=
CONFIG_IP_NF_MANGLE=3Dm=0A=
CONFIG_IP_NF_TARGET_TOS=3Dm=0A=
CONFIG_IP_NF_TARGET_ECN=3Dm=0A=
CONFIG_IP_NF_TARGET_DSCP=3Dm=0A=
CONFIG_IP_NF_TARGET_MARK=3Dm=0A=
CONFIG_IP_NF_TARGET_CLASSIFY=3Dm=0A=
CONFIG_IP_NF_TARGET_LOG=3Dm=0A=
CONFIG_IP_NF_TARGET_ULOG=3Dm=0A=
CONFIG_IP_NF_TARGET_TCPMSS=3Dm=0A=
CONFIG_IP_NF_ARPTABLES=3Dm=0A=
CONFIG_IP_NF_ARPFILTER=3Dm=0A=
CONFIG_IP_NF_ARP_MANGLE=3Dm=0A=
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set=0A=
# CONFIG_IP_NF_COMPAT_IPFWADM is not set=0A=
# CONFIG_IP_NF_MATCH_CONNLIMIT is not set=0A=
# CONFIG_IP_NF_MATCH_FUZZY is not set=0A=
# CONFIG_IP_NF_MATCH_MPORT is not set=0A=
# CONFIG_IP_NF_MATCH_NTH is not set=0A=
# CONFIG_IP_NF_MATCH_SCTP is not set=0A=
=0A=
#=0A=
# SCTP Configuration (EXPERIMENTAL)=0A=
#=0A=
# CONFIG_IP_SCTP is not set=0A=
# CONFIG_ATM is not set=0A=
# CONFIG_VLAN_8021Q is not set=0A=
# CONFIG_LLC2 is not set=0A=
# CONFIG_IPX is not set=0A=
# CONFIG_ATALK is not set=0A=
# CONFIG_X25 is not set=0A=
# CONFIG_LAPB is not set=0A=
# CONFIG_NET_DIVERT is not set=0A=
# CONFIG_ECONET is not set=0A=
# CONFIG_WAN_ROUTER is not set=0A=
# CONFIG_NET_FASTROUTE is not set=0A=
# CONFIG_NET_HW_FLOWCONTROL is not set=0A=
=0A=
#=0A=
# QoS and/or fair queueing=0A=
#=0A=
# CONFIG_NET_SCHED is not set=0A=
=0A=
#=0A=
# Network testing=0A=
#=0A=
# CONFIG_NET_PKTGEN is not set=0A=
CONFIG_NETDEVICES=3Dy=0A=
=0A=
#=0A=
# ARCnet devices=0A=
#=0A=
# CONFIG_ARCNET is not set=0A=
CONFIG_DUMMY=3Dm=0A=
CONFIG_BONDING=3Dm=0A=
# CONFIG_EQUALIZER is not set=0A=
# CONFIG_TUN is not set=0A=
# CONFIG_NET_SB1000 is not set=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
CONFIG_NET_ETHERNET=3Dy=0A=
CONFIG_MII=3Dm=0A=
# CONFIG_HAPPYMEAL is not set=0A=
# CONFIG_SUNGEM is not set=0A=
# CONFIG_NET_VENDOR_3COM is not set=0A=
# CONFIG_LANCE is not set=0A=
# CONFIG_NET_VENDOR_SMC is not set=0A=
# CONFIG_NET_VENDOR_RACAL is not set=0A=
=0A=
#=0A=
# Tulip family network device support=0A=
#=0A=
CONFIG_NET_TULIP=3Dy=0A=
# CONFIG_DE2104X is not set=0A=
CONFIG_TULIP=3Dm=0A=
CONFIG_TULIP_MWI=3Dy=0A=
CONFIG_TULIP_MMIO=3Dy=0A=
CONFIG_TULIP_NAPI=3Dy=0A=
CONFIG_TULIP_NAPI_HW_MITIGATION=3Dy=0A=
# CONFIG_DE4X5 is not set=0A=
# CONFIG_WINBOND_840 is not set=0A=
# CONFIG_DM9102 is not set=0A=
# CONFIG_AT1700 is not set=0A=
# CONFIG_DEPCA is not set=0A=
# CONFIG_HP100 is not set=0A=
# CONFIG_NET_ISA is not set=0A=
# CONFIG_NET_PCI is not set=0A=
# CONFIG_NET_POCKET is not set=0A=
=0A=
#=0A=
# Ethernet (1000 Mbit)=0A=
#=0A=
# CONFIG_ACENIC is not set=0A=
# CONFIG_DL2K is not set=0A=
# CONFIG_E1000 is not set=0A=
# CONFIG_NS83820 is not set=0A=
# CONFIG_HAMACHI is not set=0A=
# CONFIG_YELLOWFIN is not set=0A=
# CONFIG_R8169 is not set=0A=
# CONFIG_SIS190 is not set=0A=
# CONFIG_SK98LIN is not set=0A=
# CONFIG_TIGON3 is not set=0A=
=0A=
#=0A=
# Ethernet (10000 Mbit)=0A=
#=0A=
# CONFIG_IXGB is not set=0A=
# CONFIG_FDDI is not set=0A=
# CONFIG_HIPPI is not set=0A=
# CONFIG_PLIP is not set=0A=
CONFIG_PPP=3Dm=0A=
# CONFIG_PPP_MULTILINK is not set=0A=
CONFIG_PPP_FILTER=3Dy=0A=
CONFIG_PPP_ASYNC=3Dm=0A=
# CONFIG_PPP_SYNC_TTY is not set=0A=
CONFIG_PPP_DEFLATE=3Dm=0A=
CONFIG_PPP_BSDCOMP=3Dm=0A=
# CONFIG_PPPOE is not set=0A=
# CONFIG_SLIP is not set=0A=
=0A=
#=0A=
# Wireless LAN (non-hamradio)=0A=
#=0A=
# CONFIG_NET_RADIO is not set=0A=
=0A=
#=0A=
# Token Ring devices=0A=
#=0A=
# CONFIG_TR is not set=0A=
# CONFIG_NET_FC is not set=0A=
# CONFIG_RCPCI is not set=0A=
# CONFIG_SHAPER is not set=0A=
# CONFIG_NETCONSOLE is not set=0A=
=0A=
#=0A=
# Wan interfaces=0A=
#=0A=
# CONFIG_WAN is not set=0A=
=0A=
#=0A=
# Amateur Radio support=0A=
#=0A=
# CONFIG_HAMRADIO is not set=0A=
=0A=
#=0A=
# IrDA (infrared) support=0A=
#=0A=
# CONFIG_IRDA is not set=0A=
=0A=
#=0A=
# Bluetooth support=0A=
#=0A=
# CONFIG_BT is not set=0A=
# CONFIG_NETPOLL is not set=0A=
# CONFIG_NET_POLL_CONTROLLER is not set=0A=
=0A=
#=0A=
# ISDN subsystem=0A=
#=0A=
# CONFIG_ISDN is not set=0A=
=0A=
#=0A=
# Telephony Support=0A=
#=0A=
# CONFIG_PHONE is not set=0A=
=0A=
#=0A=
# Input device support=0A=
#=0A=
CONFIG_INPUT=3Dy=0A=
=0A=
#=0A=
# Userland interfaces=0A=
#=0A=
CONFIG_INPUT_MOUSEDEV=3Dy=0A=
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D800=0A=
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D600=0A=
# CONFIG_INPUT_JOYDEV is not set=0A=
# CONFIG_INPUT_TSDEV is not set=0A=
# CONFIG_INPUT_EVDEV is not set=0A=
# CONFIG_INPUT_EVBUG is not set=0A=
=0A=
#=0A=
# Input I/O drivers=0A=
#=0A=
# CONFIG_GAMEPORT is not set=0A=
CONFIG_SOUND_GAMEPORT=3Dy=0A=
CONFIG_SERIO=3Dy=0A=
CONFIG_SERIO_I8042=3Dy=0A=
# CONFIG_SERIO_SERPORT is not set=0A=
# CONFIG_SERIO_CT82C710 is not set=0A=
# CONFIG_SERIO_PARKBD is not set=0A=
# CONFIG_SERIO_PCIPS2 is not set=0A=
=0A=
#=0A=
# Input Device Drivers=0A=
#=0A=
CONFIG_INPUT_KEYBOARD=3Dy=0A=
CONFIG_KEYBOARD_ATKBD=3Dy=0A=
# CONFIG_KEYBOARD_SUNKBD is not set=0A=
# CONFIG_KEYBOARD_LKKBD is not set=0A=
# CONFIG_KEYBOARD_XTKBD is not set=0A=
# CONFIG_KEYBOARD_NEWTON is not set=0A=
CONFIG_INPUT_MOUSE=3Dy=0A=
CONFIG_MOUSE_PS2=3Dm=0A=
# CONFIG_MOUSE_SERIAL is not set=0A=
# CONFIG_MOUSE_INPORT is not set=0A=
# CONFIG_MOUSE_LOGIBM is not set=0A=
# CONFIG_MOUSE_PC110PAD is not set=0A=
# CONFIG_MOUSE_VSXXXAA is not set=0A=
# CONFIG_INPUT_JOYSTICK is not set=0A=
# CONFIG_INPUT_TOUCHSCREEN is not set=0A=
CONFIG_INPUT_MISC=3Dy=0A=
CONFIG_INPUT_PCSPKR=3Dm=0A=
# CONFIG_INPUT_UINPUT is not set=0A=
=0A=
#=0A=
# Character devices=0A=
#=0A=
CONFIG_VT=3Dy=0A=
CONFIG_VT_CONSOLE=3Dy=0A=
CONFIG_HW_CONSOLE=3Dy=0A=
# CONFIG_SERIAL_NONSTANDARD is not set=0A=
=0A=
#=0A=
# Serial drivers=0A=
#=0A=
CONFIG_SERIAL_8250=3Dm=0A=
CONFIG_SERIAL_8250_NR_UARTS=3D2=0A=
# CONFIG_SERIAL_8250_EXTENDED is not set=0A=
=0A=
#=0A=
# Non-8250 serial port support=0A=
#=0A=
CONFIG_SERIAL_CORE=3Dm=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
CONFIG_LEGACY_PTYS=3Dy=0A=
CONFIG_LEGACY_PTY_COUNT=3D256=0A=
CONFIG_PRINTER=3Dm=0A=
# CONFIG_LP_CONSOLE is not set=0A=
# CONFIG_PPDEV is not set=0A=
# CONFIG_TIPAR is not set=0A=
# CONFIG_QIC02_TAPE is not set=0A=
=0A=
#=0A=
# IPMI=0A=
#=0A=
# CONFIG_IPMI_HANDLER is not set=0A=
=0A=
#=0A=
# Watchdog Cards=0A=
#=0A=
# CONFIG_WATCHDOG is not set=0A=
CONFIG_HW_RANDOM=3Dm=0A=
CONFIG_NVRAM=3Dm=0A=
CONFIG_RTC=3Dm=0A=
# CONFIG_GEN_RTC is not set=0A=
# CONFIG_DTLK is not set=0A=
# CONFIG_R3964 is not set=0A=
# CONFIG_APPLICOM is not set=0A=
# CONFIG_SONYPI is not set=0A=
=0A=
#=0A=
# Ftape, the floppy tape device driver=0A=
#=0A=
# CONFIG_AGP is not set=0A=
# CONFIG_DRM is not set=0A=
# CONFIG_MWAVE is not set=0A=
# CONFIG_RAW_DRIVER is not set=0A=
CONFIG_HANGCHECK_TIMER=3Dm=0A=
=0A=
#=0A=
# I2C support=0A=
#=0A=
# CONFIG_I2C is not set=0A=
=0A=
#=0A=
# Misc devices=0A=
#=0A=
# CONFIG_IBM_ASM is not set=0A=
=0A=
#=0A=
# Multimedia devices=0A=
#=0A=
CONFIG_VIDEO_DEV=3Dm=0A=
=0A=
#=0A=
# Video For Linux=0A=
#=0A=
=0A=
#=0A=
# Video Adapters=0A=
#=0A=
# CONFIG_VIDEO_PMS is not set=0A=
# CONFIG_VIDEO_BWQCAM is not set=0A=
# CONFIG_VIDEO_CQCAM is not set=0A=
# CONFIG_VIDEO_W9966 is not set=0A=
# CONFIG_VIDEO_CPIA is not set=0A=
# CONFIG_VIDEO_STRADIS is not set=0A=
# CONFIG_VIDEO_MXB is not set=0A=
# CONFIG_VIDEO_DPC is not set=0A=
# CONFIG_VIDEO_HEXIUM_ORION is not set=0A=
# CONFIG_VIDEO_HEXIUM_GEMINI is not set=0A=
=0A=
#=0A=
# Radio Adapters=0A=
#=0A=
# CONFIG_RADIO_CADET is not set=0A=
# CONFIG_RADIO_RTRACK is not set=0A=
# CONFIG_RADIO_RTRACK2 is not set=0A=
# CONFIG_RADIO_AZTECH is not set=0A=
# CONFIG_RADIO_GEMTEK is not set=0A=
# CONFIG_RADIO_GEMTEK_PCI is not set=0A=
# CONFIG_RADIO_MAXIRADIO is not set=0A=
# CONFIG_RADIO_MAESTRO is not set=0A=
# CONFIG_RADIO_SF16FMI is not set=0A=
# CONFIG_RADIO_SF16FMR2 is not set=0A=
# CONFIG_RADIO_TERRATEC is not set=0A=
# CONFIG_RADIO_TRUST is not set=0A=
# CONFIG_RADIO_TYPHOON is not set=0A=
# CONFIG_RADIO_ZOLTRIX is not set=0A=
=0A=
#=0A=
# Digital Video Broadcasting Devices=0A=
#=0A=
# CONFIG_DVB is not set=0A=
=0A=
#=0A=
# Graphics support=0A=
#=0A=
CONFIG_FB=3Dy=0A=
# CONFIG_FB_PM2 is not set=0A=
# CONFIG_FB_CYBER2000 is not set=0A=
# CONFIG_FB_IMSTT is not set=0A=
# CONFIG_FB_VGA16 is not set=0A=
# CONFIG_FB_VESA is not set=0A=
CONFIG_VIDEO_SELECT=3Dy=0A=
# CONFIG_FB_HGA is not set=0A=
# CONFIG_FB_RIVA is not set=0A=
# CONFIG_FB_MATROX is not set=0A=
# CONFIG_FB_RADEON_OLD is not set=0A=
# CONFIG_FB_RADEON is not set=0A=
# CONFIG_FB_ATY128 is not set=0A=
CONFIG_FB_ATY=3Dy=0A=
CONFIG_FB_ATY_CT=3Dy=0A=
# CONFIG_FB_ATY_GX is not set=0A=
# CONFIG_FB_ATY_XL_INIT is not set=0A=
# CONFIG_FB_SIS is not set=0A=
# CONFIG_FB_NEOMAGIC is not set=0A=
# CONFIG_FB_KYRO is not set=0A=
# CONFIG_FB_3DFX is not set=0A=
# CONFIG_FB_VOODOO1 is not set=0A=
# CONFIG_FB_TRIDENT is not set=0A=
# CONFIG_FB_VIRTUAL is not set=0A=
=0A=
#=0A=
# Console display driver support=0A=
#=0A=
CONFIG_VGA_CONSOLE=3Dy=0A=
# CONFIG_MDA_CONSOLE is not set=0A=
CONFIG_DUMMY_CONSOLE=3Dy=0A=
CONFIG_FRAMEBUFFER_CONSOLE=3Dy=0A=
CONFIG_PCI_CONSOLE=3Dy=0A=
# CONFIG_FONTS is not set=0A=
CONFIG_FONT_8x8=3Dy=0A=
CONFIG_FONT_8x16=3Dy=0A=
=0A=
#=0A=
# Logo configuration=0A=
#=0A=
CONFIG_LOGO=3Dy=0A=
# CONFIG_LOGO_LINUX_MONO is not set=0A=
CONFIG_LOGO_LINUX_VGA16=3Dy=0A=
# CONFIG_LOGO_LINUX_CLUT224 is not set=0A=
=0A=
#=0A=
# Sound=0A=
#=0A=
# CONFIG_SOUND is not set=0A=
=0A=
#=0A=
# USB support=0A=
#=0A=
CONFIG_USB=3Dm=0A=
CONFIG_USB_DEBUG=3Dy=0A=
=0A=
#=0A=
# Miscellaneous USB options=0A=
#=0A=
CONFIG_USB_DEVICEFS=3Dy=0A=
# CONFIG_USB_BANDWIDTH is not set=0A=
CONFIG_USB_DYNAMIC_MINORS=3Dy=0A=
=0A=
#=0A=
# USB Host Controller Drivers=0A=
#=0A=
# CONFIG_USB_EHCI_HCD is not set=0A=
# CONFIG_USB_OHCI_HCD is not set=0A=
CONFIG_USB_UHCI_HCD=3Dm=0A=
=0A=
#=0A=
# USB Device Class drivers=0A=
#=0A=
# CONFIG_USB_BLUETOOTH_TTY is not set=0A=
# CONFIG_USB_ACM is not set=0A=
# CONFIG_USB_PRINTER is not set=0A=
CONFIG_USB_STORAGE=3Dm=0A=
CONFIG_USB_STORAGE_DEBUG=3Dy=0A=
# CONFIG_USB_STORAGE_DATAFAB is not set=0A=
# CONFIG_USB_STORAGE_FREECOM is not set=0A=
# CONFIG_USB_STORAGE_DPCM is not set=0A=
# CONFIG_USB_STORAGE_HP8200e is not set=0A=
# CONFIG_USB_STORAGE_SDDR09 is not set=0A=
# CONFIG_USB_STORAGE_SDDR55 is not set=0A=
# CONFIG_USB_STORAGE_JUMPSHOT is not set=0A=
=0A=
#=0A=
# USB Human Interface Devices (HID)=0A=
#=0A=
# CONFIG_USB_HID is not set=0A=
=0A=
#=0A=
# USB HID Boot Protocol drivers=0A=
#=0A=
# CONFIG_USB_KBD is not set=0A=
# CONFIG_USB_MOUSE is not set=0A=
# CONFIG_USB_AIPTEK is not set=0A=
# CONFIG_USB_WACOM is not set=0A=
# CONFIG_USB_KBTAB is not set=0A=
# CONFIG_USB_POWERMATE is not set=0A=
# CONFIG_USB_MTOUCH is not set=0A=
# CONFIG_USB_XPAD is not set=0A=
# CONFIG_USB_ATI_REMOTE is not set=0A=
=0A=
#=0A=
# USB Imaging devices=0A=
#=0A=
# CONFIG_USB_MDC800 is not set=0A=
# CONFIG_USB_MICROTEK is not set=0A=
# CONFIG_USB_HPUSBSCSI is not set=0A=
=0A=
#=0A=
# USB Multimedia devices=0A=
#=0A=
# CONFIG_USB_DABUSB is not set=0A=
# CONFIG_USB_VICAM is not set=0A=
# CONFIG_USB_DSBR is not set=0A=
# CONFIG_USB_IBMCAM is not set=0A=
# CONFIG_USB_KONICAWC is not set=0A=
CONFIG_USB_OV511=3Dm=0A=
# CONFIG_USB_PWC is not set=0A=
# CONFIG_USB_SE401 is not set=0A=
# CONFIG_USB_STV680 is not set=0A=
=0A=
#=0A=
# USB Network adaptors=0A=
#=0A=
# CONFIG_USB_CATC is not set=0A=
# CONFIG_USB_KAWETH is not set=0A=
# CONFIG_USB_PEGASUS is not set=0A=
# CONFIG_USB_RTL8150 is not set=0A=
# CONFIG_USB_USBNET is not set=0A=
=0A=
#=0A=
# USB port drivers=0A=
#=0A=
# CONFIG_USB_USS720 is not set=0A=
=0A=
#=0A=
# USB Serial Converter support=0A=
#=0A=
# CONFIG_USB_SERIAL is not set=0A=
=0A=
#=0A=
# USB Miscellaneous drivers=0A=
#=0A=
# CONFIG_USB_EMI62 is not set=0A=
# CONFIG_USB_EMI26 is not set=0A=
# CONFIG_USB_TIGL is not set=0A=
# CONFIG_USB_AUERSWALD is not set=0A=
# CONFIG_USB_RIO500 is not set=0A=
# CONFIG_USB_LEGOTOWER is not set=0A=
# CONFIG_USB_LCD is not set=0A=
# CONFIG_USB_LED is not set=0A=
# CONFIG_USB_TEST is not set=0A=
=0A=
#=0A=
# USB Gadget Support=0A=
#=0A=
# CONFIG_USB_GADGET is not set=0A=
# CONFIG_USB_GADGET_NET2280 is not set=0A=
# CONFIG_USB_GADGET_PXA2XX is not set=0A=
# CONFIG_USB_GADGET_GOKU is not set=0A=
# CONFIG_USB_GADGET_SA1100 is not set=0A=
# CONFIG_USB_ZERO is not set=0A=
# CONFIG_USB_ETH is not set=0A=
# CONFIG_USB_GADGETFS is not set=0A=
# CONFIG_USB_FILE_STORAGE is not set=0A=
# CONFIG_USB_G_SERIAL is not set=0A=
=0A=
#=0A=
# File systems=0A=
#=0A=
CONFIG_EXT2_FS=3Dm=0A=
# CONFIG_EXT2_FS_XATTR is not set=0A=
CONFIG_EXT3_FS=3Dy=0A=
CONFIG_EXT3_FS_XATTR=3Dy=0A=
# CONFIG_EXT3_FS_POSIX_ACL is not set=0A=
# CONFIG_EXT3_FS_SECURITY is not set=0A=
CONFIG_JBD=3Dy=0A=
# CONFIG_JBD_DEBUG is not set=0A=
CONFIG_FS_MBCACHE=3Dy=0A=
# CONFIG_REISERFS_FS is not set=0A=
# CONFIG_JFS_FS is not set=0A=
# CONFIG_XFS_FS is not set=0A=
# CONFIG_MINIX_FS is not set=0A=
# CONFIG_ROMFS_FS is not set=0A=
# CONFIG_QUOTA is not set=0A=
# CONFIG_AUTOFS_FS is not set=0A=
CONFIG_AUTOFS4_FS=3Dm=0A=
=0A=
#=0A=
# CD-ROM/DVD Filesystems=0A=
#=0A=
CONFIG_ISO9660_FS=3Dm=0A=
CONFIG_JOLIET=3Dy=0A=
CONFIG_ZISOFS=3Dy=0A=
CONFIG_ZISOFS_FS=3Dm=0A=
CONFIG_UDF_FS=3Dm=0A=
=0A=
#=0A=
# DOS/FAT/NT Filesystems=0A=
#=0A=
CONFIG_FAT_FS=3Dm=0A=
CONFIG_MSDOS_FS=3Dm=0A=
CONFIG_VFAT_FS=3Dm=0A=
CONFIG_NTFS_FS=3Dm=0A=
# CONFIG_NTFS_DEBUG is not set=0A=
# CONFIG_NTFS_RW is not set=0A=
=0A=
#=0A=
# Pseudo filesystems=0A=
#=0A=
CONFIG_PROC_FS=3Dy=0A=
CONFIG_PROC_KCORE=3Dy=0A=
# CONFIG_DEVFS_FS is not set=0A=
# CONFIG_DEVPTS_FS_XATTR is not set=0A=
CONFIG_TMPFS=3Dy=0A=
# CONFIG_HUGETLBFS is not set=0A=
# CONFIG_HUGETLB_PAGE is not set=0A=
CONFIG_RAMFS=3Dy=0A=
CONFIG_SUPERMOUNT=3Dm=0A=
# CONFIG_SUPERMOUNT_DEBUG is not set=0A=
=0A=
#=0A=
# Miscellaneous filesystems=0A=
#=0A=
# CONFIG_ADFS_FS is not set=0A=
# CONFIG_AFFS_FS is not set=0A=
CONFIG_HFS_FS=3Dm=0A=
CONFIG_HFSPLUS_FS=3Dm=0A=
# CONFIG_BEFS_FS is not set=0A=
# CONFIG_BFS_FS is not set=0A=
# CONFIG_EFS_FS is not set=0A=
# CONFIG_CRAMFS is not set=0A=
# CONFIG_VXFS_FS is not set=0A=
# CONFIG_HPFS_FS is not set=0A=
# CONFIG_QNX4FS_FS is not set=0A=
# CONFIG_SYSV_FS is not set=0A=
# CONFIG_UFS_FS is not set=0A=
=0A=
#=0A=
# Network File Systems=0A=
#=0A=
CONFIG_NFS_FS=3Dm=0A=
# CONFIG_NFS_V3 is not set=0A=
CONFIG_NFS_V4=3Dy=0A=
# CONFIG_NFS_DIRECTIO is not set=0A=
CONFIG_NFSD=3Dm=0A=
# CONFIG_NFSD_V3 is not set=0A=
CONFIG_NFSD_TCP=3Dy=0A=
CONFIG_LOCKD=3Dm=0A=
CONFIG_EXPORTFS=3Dm=0A=
CONFIG_SUNRPC=3Dm=0A=
CONFIG_SUNRPC_GSS=3Dm=0A=
CONFIG_RPCSEC_GSS_KRB5=3Dm=0A=
CONFIG_SMB_FS=3Dm=0A=
CONFIG_SMB_NLS_DEFAULT=3Dy=0A=
CONFIG_SMB_NLS_REMOTE=3D"cp437"=0A=
CONFIG_CIFS=3Dm=0A=
# CONFIG_NCP_FS is not set=0A=
# CONFIG_CODA_FS is not set=0A=
# CONFIG_INTERMEZZO_FS is not set=0A=
# CONFIG_AFS_FS is not set=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
# CONFIG_PARTITION_ADVANCED is not set=0A=
CONFIG_MSDOS_PARTITION=3Dy=0A=
=0A=
#=0A=
# Native Language Support=0A=
#=0A=
CONFIG_NLS=3Dy=0A=
CONFIG_NLS_DEFAULT=3D"iso8859-1"=0A=
CONFIG_NLS_CODEPAGE_437=3Dm=0A=
# CONFIG_NLS_CODEPAGE_737 is not set=0A=
# CONFIG_NLS_CODEPAGE_775 is not set=0A=
# CONFIG_NLS_CODEPAGE_850 is not set=0A=
# CONFIG_NLS_CODEPAGE_852 is not set=0A=
# CONFIG_NLS_CODEPAGE_855 is not set=0A=
# CONFIG_NLS_CODEPAGE_857 is not set=0A=
# CONFIG_NLS_CODEPAGE_860 is not set=0A=
# CONFIG_NLS_CODEPAGE_861 is not set=0A=
# CONFIG_NLS_CODEPAGE_862 is not set=0A=
# CONFIG_NLS_CODEPAGE_863 is not set=0A=
# CONFIG_NLS_CODEPAGE_864 is not set=0A=
# CONFIG_NLS_CODEPAGE_865 is not set=0A=
# CONFIG_NLS_CODEPAGE_866 is not set=0A=
# CONFIG_NLS_CODEPAGE_869 is not set=0A=
# CONFIG_NLS_CODEPAGE_936 is not set=0A=
# CONFIG_NLS_CODEPAGE_950 is not set=0A=
# CONFIG_NLS_CODEPAGE_932 is not set=0A=
# CONFIG_NLS_CODEPAGE_949 is not set=0A=
# CONFIG_NLS_CODEPAGE_874 is not set=0A=
# CONFIG_NLS_ISO8859_8 is not set=0A=
# CONFIG_NLS_CODEPAGE_1250 is not set=0A=
# CONFIG_NLS_CODEPAGE_1251 is not set=0A=
CONFIG_NLS_ISO8859_1=3Dm=0A=
# CONFIG_NLS_ISO8859_2 is not set=0A=
# CONFIG_NLS_ISO8859_3 is not set=0A=
# CONFIG_NLS_ISO8859_4 is not set=0A=
# CONFIG_NLS_ISO8859_5 is not set=0A=
# CONFIG_NLS_ISO8859_6 is not set=0A=
# CONFIG_NLS_ISO8859_7 is not set=0A=
# CONFIG_NLS_ISO8859_9 is not set=0A=
# CONFIG_NLS_ISO8859_13 is not set=0A=
# CONFIG_NLS_ISO8859_14 is not set=0A=
# CONFIG_NLS_ISO8859_15 is not set=0A=
# CONFIG_NLS_KOI8_R is not set=0A=
# CONFIG_NLS_KOI8_U is not set=0A=
CONFIG_NLS_UTF8=3Dm=0A=
=0A=
#=0A=
# Profiling support=0A=
#=0A=
# CONFIG_PROFILING is not set=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
CONFIG_DEBUG_KERNEL=3Dy=0A=
CONFIG_EARLY_PRINTK=3Dy=0A=
# CONFIG_DEBUG_STACKOVERFLOW is not set=0A=
# CONFIG_DEBUG_STACK_USAGE is not set=0A=
# CONFIG_DEBUG_SLAB is not set=0A=
CONFIG_MAGIC_SYSRQ=3Dy=0A=
# CONFIG_DEBUG_SPINLOCK is not set=0A=
# CONFIG_DEBUG_PAGEALLOC is not set=0A=
# CONFIG_DEBUG_HIGHMEM is not set=0A=
# CONFIG_DEBUG_INFO is not set=0A=
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set=0A=
# CONFIG_KGDB is not set=0A=
# CONFIG_KGDB_9600BAUD is not set=0A=
# CONFIG_KGDB_19200BAUD is not set=0A=
# CONFIG_KGDB_38400BAUD is not set=0A=
# CONFIG_KGDB_57600BAUD is not set=0A=
# CONFIG_KGDB_115200BAUD is not set=0A=
# CONFIG_FRAME_POINTER is not set=0A=
CONFIG_X86_FIND_SMP_CONFIG=3Dy=0A=
CONFIG_X86_MPPARSE=3Dy=0A=
=0A=
#=0A=
# Security options=0A=
#=0A=
# CONFIG_SECURITY is not set=0A=
=0A=
#=0A=
# Cryptographic options=0A=
#=0A=
CONFIG_CRYPTO=3Dy=0A=
# CONFIG_CRYPTO_HMAC is not set=0A=
# CONFIG_CRYPTO_NULL is not set=0A=
# CONFIG_CRYPTO_MD4 is not set=0A=
CONFIG_CRYPTO_MD5=3Dm=0A=
# CONFIG_CRYPTO_SHA1 is not set=0A=
# CONFIG_CRYPTO_SHA256 is not set=0A=
# CONFIG_CRYPTO_SHA512 is not set=0A=
CONFIG_CRYPTO_DES=3Dm=0A=
# CONFIG_CRYPTO_BLOWFISH is not set=0A=
# CONFIG_CRYPTO_TWOFISH is not set=0A=
# CONFIG_CRYPTO_SERPENT is not set=0A=
# CONFIG_CRYPTO_AES is not set=0A=
# CONFIG_CRYPTO_CAST5 is not set=0A=
# CONFIG_CRYPTO_CAST6 is not set=0A=
# CONFIG_CRYPTO_ARC4 is not set=0A=
# CONFIG_CRYPTO_DEFLATE is not set=0A=
# CONFIG_CRYPTO_MICHAEL_MIC is not set=0A=
# CONFIG_CRYPTO_TEST is not set=0A=
=0A=
#=0A=
# Library routines=0A=
#=0A=
CONFIG_CRC32=3Dm=0A=
CONFIG_ZLIB_INFLATE=3Dm=0A=
CONFIG_ZLIB_DEFLATE=3Dm=0A=
CONFIG_X86_SMP=3Dy=0A=
CONFIG_X86_HT=3Dy=0A=
CONFIG_X86_BIOS_REBOOT=3Dy=0A=
CONFIG_X86_TRAMPOLINE=3Dy=0A=
CONFIG_PC=3Dy=0A=

------=_NextPart_000_26E3_01C420AA.93DC6440--

