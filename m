Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTFQI3v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 04:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbTFQI3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 04:29:51 -0400
Received: from mx02.qsc.de ([213.148.130.14]:17593 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S261180AbTFQI3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 04:29:41 -0400
Date: Tue, 17 Jun 2003 10:46:23 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Still problems with PCMCIA in 2.5.72
Message-ID: <20030617084622.GA623@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.4.20-ww9 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

there are still issues with pcmcia in 2.5 series. Although the oopses on
insert/remove from 1 month ago disappeared, cards still don't get
detected all the time. I started too see this behaviou I think after
2.5.69-bk9.
I have a TI PCI1450 cardbus bridge in my Thinkpad and cards get detected
non-deterministically (at least for me).
One time the card is detected on initial insert, the other time on the
second one and if it's not detected by then I can reboot my machine,
since it wont find it anyway (I tried 10 inserts/removes). I never made
it work (even before) to get it detected and set up on boot, but I guess
that relates to my debian unstable system..I think there's something
wicked..

here are some syslog snipplets:

Jun 17 22:25:19 voyager kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Jun 17 22:25:19 voyager kernel: cs: IO port probe 0x0800-0x08ff: clean.
Jun 17 22:25:19 voyager kernel: cs: IO port probe 0x0100-0x04ff:
excluding 0x170-0x177 0x370-0x377 0x3c0-0x3df 0x4d0-0x4d7
Jun 17 22:25:19 voyager kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Jun 17 22:25:25 voyager kernel: spurious 8259A interrupt: IRQ7.
Jun 17 22:25:26 voyager cardmgr[186]: socket 1: D-Link DFE-670-TXD Fast
Ethernet
Jun 17 22:25:26 voyager kernel: cs: memory probe 0xa0000000-0xa0ffffff:
clean.
Jun 17 22:25:26 voyager cardmgr[186]: executing: 'modprobe pcnet_cs'
Jun 17 22:25:26 voyager cardmgr[186]: get dev info on socket 1 failed:
No such device
Jun 17 22:25:26 voyager kernel: pcnet_cs: RequestIO: No more items
Jun 17 22:25:30 voyager cardmgr[186]: executing: 'modprobe -r pcnet_cs'
Jun 17 22:25:35 voyager cardmgr[186]: socket 1: D-Link DFE-670-TXD Fast
Ethernet
Jun 17 22:25:35 voyager cardmgr[186]: executing: 'modprobe pcnet_cs'
Jun 17 22:25:35 voyager cardmgr[186]: get dev info on socket 1 failed:
No such device
Jun 17 22:25:35 voyager kernel: pcnet_cs: RequestIO: No more items
Jun 17 22:25:39 voyager cardmgr[186]: executing: 'modprobe -r pcnet_cs'
Jun 17 22:25:43 voyager cardmgr[186]: socket 1: D-Link DFE-670-TXD Fast
Ethernet
Jun 17 22:25:43 voyager cardmgr[186]: executing: 'modprobe pcnet_cs'
Jun 17 22:25:43 voyager cardmgr[186]: get dev info on socket 1 failed:
No such device
Jun 17 22:25:43 voyager kernel: pcnet_cs: RequestIO: No more items
Jun 17 22:25:46 voyager cardmgr[186]: executing: 'modprobe -r pcnet_cs'
Jun 17 22:25:49 voyager cardmgr[186]: socket 1: D-Link DFE-670-TXD Fast
Ethernet
Jun 17 22:25:49 voyager cardmgr[186]: executing: 'modprobe pcnet_cs'
Jun 17 22:25:49 voyager cardmgr[186]: get dev info on socket 1 failed:
No such device
Jun 17 22:25:49 voyager kernel: pcnet_cs: RequestIO: No more items
Jun 17 22:25:52 voyager cardmgr[186]: executing: 'modprobe -r pcnet_cs'
Jun 17 22:25:58 voyager cardmgr[186]: socket 0: D-Link DFE-670-TXD Fast
Ethernet
Jun 17 22:25:58 voyager cardmgr[186]: executing: 'modprobe pcnet_cs'
Jun 17 22:25:58 voyager kernel: pcnet_cs: RequestIO: No more items
Jun 17 22:25:59 voyager kernel: pcnet_cs: unable to read hardware net
address for io base 0x300
Jun 17 22:25:59 voyager cardmgr[186]: get dev info on socket 0 failed:
No such device
Jun 17 22:26:07 voyager cardmgr[186]: executing: 'modprobe -r pcnet_cs'
Jun 17 22:26:09 voyager cardmgr[186]: socket 0: D-Link DFE-670-TXD Fast
Ethernet
Jun 17 22:26:09 voyager cardmgr[186]: executing: 'modprobe pcnet_cs'
Jun 17 22:26:09 voyager cardmgr[186]: get dev info on socket 0 failed:
No such device

=2E..

rebooting

=2E..
Jun 17 22:30:32 voyager kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Jun 17 22:30:32 voyager kernel: cs: IO port probe 0x0800-0x08ff: clean.
Jun 17 22:30:32 voyager kernel: cs: IO port probe 0x0100-0x04ff:
excluding 0x170-0x177 0x370-0x377 0x3c0-0x3df 0x4d0-0x4d7
Jun 17 22:30:32 voyager kernel: cs: IO port probe 0x0a00-0x0aff: clean.
=2E..
Jun 17 22:30:42 voyager cardmgr[186]: socket 0: D-Link DFE-670-TXD Fast
Ethernet
Jun 17 22:30:42 voyager kernel: cs: memory probe 0xa0000000-0xa0ffffff:
clean.
Jun 17 22:30:42 voyager cardmgr[186]: executing: 'modprobe pcnet_cs'
Jun 17 22:30:43 voyager kernel: eth0: NE2000 (DL10022 rev 30): io 0x300,
irq 3, hw_addr 00:40:05:87:DA:69


It also seems that the chance of getting the disk into system is to
insert it after the system switched to init 2 but before the login
prompt appears. There are no strange services loaded at any time, so I
have no idea what might change later on.

The system:
Gnu C                  2.95.4
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
e2fsprogs              1.34-WIP
pcmcia-cs              3.2.2
PPP                    2.4.1
isdn4k-utils           3.2p3
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.9
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         pcnet_cs 8390 crc32 ehci_hcd

my .config:
CONFIG_X86=3Dy
CONFIG_MMU=3Dy
CONFIG_UID16=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_EXPERIMENTAL=3Dy
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_LOG_BUF_SHIFT=3D14
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_OBSOLETE_MODPARM=3Dy
CONFIG_MODVERSIONS=3Dy
CONFIG_KMOD=3Dy
CONFIG_X86_PC=3Dy
CONFIG_MPENTIUMIII=3Dy
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D5
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_INTEL_USERCOPY=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_PREEMPT=3Dy
CONFIG_X86_UP_APIC=3Dy
CONFIG_X86_UP_IOAPIC=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy
CONFIG_X86_TSC=3Dy
CONFIG_X86_MCE=3Dy
CONFIG_X86_MCE_NONFATAL=3Dy
CONFIG_MICROCODE=3Dy
CONFIG_X86_MSR=3Dy
CONFIG_X86_CPUID=3Dy
CONFIG_EDD=3Dy
CONFIG_NOHIGHMEM=3Dy
CONFIG_MTRR=3Dy
CONFIG_HAVE_DEC_LOCK=3Dy
CONFIG_PM=3Dy
CONFIG_SOFTWARE_SUSPEND=3Dy
CONFIG_ACPI=3Dy
CONFIG_ACPI_BOOT=3Dy
CONFIG_ACPI_SLEEP=3Dy
CONFIG_ACPI_SLEEP_PROC_FS=3Dy
CONFIG_ACPI_AC=3Dy
CONFIG_ACPI_BATTERY=3Dy
CONFIG_ACPI_BUTTON=3Dy
CONFIG_ACPI_FAN=3Dy
CONFIG_ACPI_PROCESSOR=3Dy
CONFIG_ACPI_THERMAL=3Dy
CONFIG_ACPI_BUS=3Dy
CONFIG_ACPI_INTERPRETER=3Dy
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_PCI=3Dy
CONFIG_ACPI_SYSTEM=3Dy
CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
CONFIG_CPU_FREQ_TABLE=3Dy
CONFIG_X86_ACPI_CPUFREQ=3Dy
CONFIG_X86_SPEEDSTEP_ICH=3Dy
CONFIG_X86_SPEEDSTEP_CENTRINO=3Dy
CONFIG_PCI=3Dy
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_NAMES=3Dy
CONFIG_ISA=3Dy
CONFIG_HOTPLUG=3Dy
CONFIG_PCMCIA=3Dy
CONFIG_YENTA=3Dy
CONFIG_CARDBUS=3Dy
CONFIG_I82092=3Dy
CONFIG_PCMCIA_PROBE=3Dy
CONFIG_KCORE_ELF=3Dy
CONFIG_BINFMT_AOUT=3Dm
CONFIG_BINFMT_ELF=3Dy
CONFIG_BINFMT_MISC=3Dy
CONFIG_PNP=3Dy
CONFIG_PNP_NAMES=3Dy
CONFIG_ISAPNP=3Dy
CONFIG_PNPBIOS=3Dy
CONFIG_BLK_DEV_FD=3Dm
CONFIG_BLK_DEV_LOOP=3Dm
CONFIG_IDE=3Dy
CONFIG_BLK_DEV_IDE=3Dy
CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
CONFIG_BLK_DEV_IDECS=3Dm
CONFIG_BLK_DEV_IDECD=3Dm
CONFIG_IDE_TASKFILE_IO=3Dy
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_BLK_DEV_GENERIC=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
CONFIG_IDEDMA_PCI_AUTO=3Dy
CONFIG_IDEDMA_ONLYDISK=3Dy
CONFIG_BLK_DEV_IDEDMA=3Dy
CONFIG_BLK_DEV_ADMA=3Dy
CONFIG_BLK_DEV_PIIX=3Dy
CONFIG_IDEDMA_AUTO=3Dy
CONFIG_BLK_DEV_IDE_MODES=3Dy
CONFIG_SCSI=3Dm
CONFIG_BLK_DEV_SD=3Dm
CONFIG_CHR_DEV_ST=3Dm
CONFIG_BLK_DEV_SR=3Dm
CONFIG_CHR_DEV_SG=3Dm
CONFIG_SCSI_MULTI_LUN=3Dy
CONFIG_SCSI_REPORT_LUNS=3Dy
CONFIG_NET=3Dy
CONFIG_PACKET=3Dy
CONFIG_PACKET_MMAP=3Dy
CONFIG_NETLINK_DEV=3Dm
CONFIG_NETFILTER=3Dy
CONFIG_UNIX=3Dy
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_INET_ECN=3Dy
CONFIG_SYN_COOKIES=3Dy
CONFIG_IP_NF_CONNTRACK=3Dy
CONFIG_IP_NF_FTP=3Dy
CONFIG_IP_NF_IRC=3Dy
CONFIG_IP_NF_QUEUE=3Dm
CONFIG_IP_NF_IPTABLES=3Dy
CONFIG_IP_NF_MATCH_LIMIT=3Dm
CONFIG_IP_NF_MATCH_MAC=3Dy
CONFIG_IP_NF_MATCH_PKTTYPE=3Dy
CONFIG_IP_NF_MATCH_MARK=3Dy
CONFIG_IP_NF_MATCH_MULTIPORT=3Dy
CONFIG_IP_NF_MATCH_STATE=3Dy
CONFIG_IP_NF_MATCH_CONNTRACK=3Dy
CONFIG_IP_NF_MATCH_UNCLEAN=3Dy
CONFIG_IP_NF_FILTER=3Dy
CONFIG_IP_NF_TARGET_REJECT=3Dy
CONFIG_IP_NF_TARGET_MIRROR=3Dm
CONFIG_IP_NF_NAT=3Dm
CONFIG_IP_NF_NAT_NEEDED=3Dy
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP_NF_TARGET_REDIRECT=3Dm
CONFIG_IP_NF_NAT_SNMP_BASIC=3Dm
CONFIG_IP_NF_NAT_IRC=3Dm
CONFIG_IP_NF_NAT_FTP=3Dm
CONFIG_IP_NF_MANGLE=3Dy
CONFIG_IP_NF_TARGET_TOS=3Dy
CONFIG_IP_NF_TARGET_ECN=3Dy
CONFIG_IP_NF_TARGET_DSCP=3Dm
CONFIG_IP_NF_TARGET_MARK=3Dy
CONFIG_IP_NF_TARGET_LOG=3Dy
CONFIG_IP_NF_TARGET_ULOG=3Dm
CONFIG_IP_NF_TARGET_TCPMSS=3Dm
CONFIG_IP_NF_ARPTABLES=3Dm
CONFIG_IP_NF_ARPFILTER=3Dm
CONFIG_IPV6_SCTP__=3Dy
CONFIG_NET_SCHED=3Dy
CONFIG_NET_SCH_CBQ=3Dy
CONFIG_NET_SCH_HTB=3Dy
CONFIG_NET_SCH_CSZ=3Dy
CONFIG_NET_SCH_PRIO=3Dy
CONFIG_NET_SCH_RED=3Dy
CONFIG_NET_SCH_SFQ=3Dy
CONFIG_NET_SCH_TEQL=3Dy
CONFIG_NET_SCH_TBF=3Dm
CONFIG_NET_SCH_GRED=3Dm
CONFIG_NET_SCH_DSMARK=3Dm
CONFIG_NET_QOS=3Dy
CONFIG_NET_ESTIMATOR=3Dy
CONFIG_NET_CLS=3Dy
CONFIG_NET_CLS_TCINDEX=3Dy
CONFIG_NET_CLS_ROUTE4=3Dy
CONFIG_NET_CLS_ROUTE=3Dy
CONFIG_NET_CLS_FW=3Dy
CONFIG_NET_CLS_U32=3Dy
CONFIG_NET_CLS_RSVP=3Dm
CONFIG_NET_CLS_RSVP6=3Dm
CONFIG_NET_CLS_POLICE=3Dy
CONFIG_NETDEVICES=3Dy
CONFIG_PPP=3Dm
CONFIG_PPP_MULTILINK=3Dy
CONFIG_PPP_FILTER=3Dy
CONFIG_PPP_ASYNC=3Dm
CONFIG_PPP_SYNC_TTY=3Dm
CONFIG_PPP_DEFLATE=3Dm
CONFIG_PPP_BSDCOMP=3Dm
CONFIG_PPPOE=3Dm
CONFIG_SLIP=3Dy
CONFIG_SLIP_COMPRESSED=3Dy
CONFIG_SLIP_SMART=3Dy
CONFIG_SLIP_MODE_SLIP6=3Dy
CONFIG_NET_PCMCIA=3Dy
CONFIG_PCMCIA_PCNET=3Dm
CONFIG_IRDA=3Dy
CONFIG_IRLAN=3Dm
CONFIG_IRNET=3Dm
CONFIG_IRCOMM=3Dy
CONFIG_IRTTY_SIR=3Dy
CONFIG_IRPORT_SIR=3Dy
CONFIG_INPUT=3Dy
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
CONFIG_SOUND_GAMEPORT=3Dy
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dy
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
CONFIG_SERIAL_8250=3Dy
CONFIG_SERIAL_8250_CONSOLE=3Dy
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
CONFIG_UNIX98_PTYS=3Dy
CONFIG_UNIX98_PTY_COUNT=3D256
CONFIG_BUSMOUSE=3Dy
CONFIG_RTC=3Dy
CONFIG_EXT2_FS=3Dy
CONFIG_EXT3_FS=3Dy
CONFIG_JBD=3Dy
CONFIG_AUTOFS4_FS=3Dy
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_ZISOFS_FS=3Dm
CONFIG_UDF_FS=3Dm
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
CONFIG_VFAT_FS=3Dm
CONFIG_NTFS_FS=3Dm
CONFIG_PROC_FS=3Dy
CONFIG_DEVPTS_FS=3Dy
CONFIG_TMPFS=3Dy
CONFIG_RAMFS=3Dy
CONFIG_NFS_FS=3Dm
CONFIG_NFS_V3=3Dy
CONFIG_NFS_V4=3Dy
CONFIG_NFSD=3Dm
CONFIG_NFSD_V3=3Dy
CONFIG_NFSD_V4=3Dy
CONFIG_NFSD_TCP=3Dy
CONFIG_LOCKD=3Dm
CONFIG_LOCKD_V4=3Dy
CONFIG_EXPORTFS=3Dm
CONFIG_SUNRPC=3Dm
CONFIG_SUNRPC_GSS=3Dm
CONFIG_SMB_FS=3Dm
CONFIG_SMB_NLS_DEFAULT=3Dy
CONFIG_SMB_NLS_REMOTE=3D"cp437"
CONFIG_CIFS=3Dm
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_SMB_NLS=3Dy
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"iso8859-15"
CONFIG_NLS_CODEPAGE_437=3Dy
CONFIG_NLS_CODEPAGE_850=3Dy
CONFIG_NLS_ISO8859_1=3Dy
CONFIG_NLS_ISO8859_15=3Dy
CONFIG_NLS_UTF8=3Dy
CONFIG_VIDEO_SELECT=3Dy
CONFIG_VGA_CONSOLE=3Dy
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_SOUND=3Dy
CONFIG_SND=3Dy
CONFIG_SND_SEQUENCER=3Dy
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dy
CONFIG_SND_PCM_OSS=3Dy
CONFIG_SND_SEQUENCER_OSS=3Dy
CONFIG_SND_RTCTIMER=3Dy
CONFIG_SND_CS46XX=3Dy
CONFIG_USB=3Dy
CONFIG_USB_DEVICEFS=3Dy
CONFIG_USB_BANDWIDTH=3Dy
CONFIG_USB_DYNAMIC_MINORS=3Dy
CONFIG_USB_EHCI_HCD=3Dm
CONFIG_USB_UHCI_HCD=3Dy
CONFIG_USB_ACM=3Dm
CONFIG_USB_PRINTER=3Dm
CONFIG_USB_STORAGE=3Dm
CONFIG_USB_STORAGE_HP8200e=3Dy
CONFIG_USB_HID=3Dm
CONFIG_USB_HIDINPUT=3Dy
CONFIG_HID_FF=3Dy
CONFIG_USB_HIDDEV=3Dy
CONFIG_DEBUG_KERNEL=3Dy
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_X86_EXTRA_IRQS=3Dy
CONFIG_X86_FIND_SMP_CONFIG=3Dy
CONFIG_X86_MPPARSE=3Dy
CONFIG_ZLIB_INFLATE=3Dm
CONFIG_ZLIB_DEFLATE=3Dm
CONFIG_X86_BIOS_REBOOT=3Dy





--=20
Regards,

Wiktor Wodecki

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+7tVe6SNaNRgsl4MRAhOwAJ4/TxCxUDWxpt7q7js9+WKIVvBaBQCgwDs+
lwCJRgFhRK71zm16qrAZANQ=
=dOIS
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
