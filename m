Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbTJMSVX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 14:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbTJMSVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 14:21:23 -0400
Received: from mail.tamiweb.com ([194.12.244.146]:31618 "EHLO mail.tamiweb.com")
	by vger.kernel.org with ESMTP id S261899AbTJMSVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 14:21:12 -0400
Subject: Re: Duron 1GB memory problem
From: Kostadin Karaivanov <larry@tamiweb.com>
Reply-To: larry@tamiweb.com
To: jhigdon <jhigdon@nni.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031013133239.482645d1.jhigdon@nni.com>
References: <1066059458.16230.22.camel@laptop.minfin.bg>
	 <20031013133239.482645d1.jhigdon@nni.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2sz3LEifJUH0VMirJpYg"
Organization: tamiweb
Message-Id: <1066069320.16233.51.camel@laptop.minfin.bg>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 13 Oct 2003 21:22:01 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2sz3LEifJUH0VMirJpYg
Content-Type: text/plain; charset=CP1251
Content-Transfer-Encoding: quoted-printable

On =EF=ED, 2003-10-13 at 20:32, jhigdon wrote:
> On Mon, 13 Oct 2003 18:37:38 +0300
> Kostadin Karaivanov <larry@tamiweb.com> wrote:
>=20
> > 	1. After upgrading my memory up to 1BG (2x512MB SDRAM) previosly 512MB
> > (2x256MB SDRAM) I try to boot 2.6.0-test5 compiled without highmem
> > support with boot-time option mem=3D512M and I got an Oops right before
> > the checks for memory (15th-16th row of dmesg).
> > It can't boot without mem=3D512M option even.
> >  =09
> > 	2. 2.4.20 (without highmem support) boots fine with same option, but
> > can't boot without it (?same? Oops).
> > =09
> > 	3. 2.6.0-test7 _WITH_ highmem enabled boots but I get 2 kernel Oops fo=
r
> > 24 hours.
> > =09
> > 	4. 2.6.0-test5 _with_ highmem reboots itself before getting to login
> > prompt,  I was told  about this by my hosting support.
> > =09
> > 	5. 2.4.22 with high mem works fine... for now
> >=20
> > =09
> > 	1, 2, 3 had happaned in my presence.
> > 	I can't provide traces. It is productional server.
>=20
> but you can run a 2.6.0-testX kernel on it? dmesg and .config would proba=
bly help too

Yes, 2.6.0-test7 with highmem and I got two Oops within 24 hours (as
stated before )
Grep from /var/log/messages of 2.6.0-test7 bootup, and 2.6.0-test7
.config follows

Oct 10 11:45:19 hosting kernel: klogd 1.4.1, log source =3D /proc/kmsg star=
ted.
Oct 10 11:45:19 hosting kernel: BIOS-provided physical RAM map:
Oct 10 11:45:19 hosting kernel: 119MB HIGHMEM available.
Oct 10 11:45:19 hosting kernel: 896MB LOWMEM available.
Oct 10 11:45:19 hosting kernel: DMI 2.3 present.
Oct 10 11:45:19 hosting kernel: Initializing CPU#0
Oct 10 11:45:19 hosting kernel: Memory: 1026340k/1040320k available (1829k =
kernel code, 13040k reserved, 307k data, 288k init, 122816k highmem)
Oct 10 11:45:19 hosting kernel: Dentry cache hash table entries: 131072 (or=
der: 7, 524288 bytes)
Oct 10 11:45:19 hosting kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cac=
he 64K (64 bytes/line)
Oct 10 11:45:19 hosting kernel: CPU: L2 Cache: 64K (64 bytes/line)
Oct 10 11:45:19 hosting kernel: Intel machine check architecture supported.
Oct 10 11:45:19 hosting kernel: Intel machine check reporting enabled on CP=
U#0.
Oct 10 11:45:19 hosting kernel: Enabling fast FPU save and restore... done.
Oct 10 11:45:19 hosting kernel: Checking 'hlt' instruction... OK.
Oct 10 11:45:19 hosting kernel: NET: Registered protocol family 16
Oct 10 11:45:19 hosting kernel: PCI: PCI BIOS revision 2.10 entry at 0xfdb0=
1, last bus=3D1
Oct 10 11:45:19 hosting kernel: PCI: Using configuration type 1
Oct 10 11:45:19 hosting kernel: mtrr: v2.0 (20020519)
Oct 10 11:45:19 hosting kernel: PCI: Using IRQ router SIS [1039/0008] at 00=
00:00:01.0
Oct 10 11:45:19 hosting kernel: SGI XFS for Linux with ACLs, large block nu=
mbers, no debug enabled
Oct 10 11:45:19 hosting kernel: SGI XFS Quota Management subsystem
Oct 10 11:45:19 hosting kernel: Initializing Cryptographic API
Oct 10 11:45:19 hosting kernel: Real Time Clock Driver v1.12
Oct 10 11:45:19 hosting kernel: Serial: 8250/16550 driver $Revision: 1.90 $=
 8 ports, IRQ sharing disabled
Oct 10 11:45:19 hosting kernel: loop: loaded (max 8 devices)
Oct 10 11:45:19 hosting kernel: sis900.c: v1.08.06 9/24/2002
Oct 10 11:45:19 hosting kernel: PCI: Found IRQ 11 for device 0000:00:01.1
Oct 10 11:45:19 hosting kernel: eth0: VIA 6103 PHY transceiver found at add=
ress 1.
Oct 10 11:45:19 hosting kernel: eth0: Using transceiver found at address 1 =
as default
Oct 10 11:45:19 hosting kernel: eth0: SiS 900 PCI Fast Ethernet at 0xd400, =
IRQ 11, 00:0a:e6:4a:84:eb.
Oct 10 11:45:19 hosting kernel: Uniform Multi-Platform E-IDE driver Revisio=
n: 7.00alpha2
Oct 10 11:45:19 hosting kernel: ide: Assuming 33MHz system bus speed for PI=
O modes; override with idebus=3Dxx
Oct 10 11:45:19 hosting kernel: SIS5513: IDE controller at PCI slot 0000:00=
:00.1
Oct 10 11:45:19 hosting kernel: SIS5513: chipset revision 208
Oct 10 11:45:19 hosting kernel: SIS5513: not 100%% native mode: will probe =
irqs later
Oct 10 11:45:19 hosting kernel: SIS5513: SiS730 ATA 100 (1st gen) controlle=
r
Oct 10 11:45:19 hosting kernel:     ide0: BM-DMA at 0xff00-0xff07, BIOS set=
tings: hda:DMA, hdb:DMA
Oct 10 11:45:19 hosting kernel:     ide1: BM-DMA at 0xff08-0xff0f, BIOS set=
tings: hdc:DMA, hdd:DMA
Oct 10 11:45:19 hosting kernel: hda: 160086528 sectors (81964 MB) w/2048KiB=
 Cache, CHS=3D65535/16/63, UDMA(100)
Oct 10 11:45:19 hosting kernel:  hda: hda1 hda2 hda3 hda4
Oct 10 11:45:19 hosting kernel: mice: PS/2 mouse device common for all mice
Oct 10 11:45:19 hosting kernel: input: PC Speaker
Oct 10 11:45:19 hosting kernel: input: PS/2 Logitech Mouse on isa0060/serio=
1
Oct 10 11:45:19 hosting kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Oct 10 11:45:19 hosting kernel: input: AT Translated Set 2 keyboard on isa0=
060/serio0
Oct 10 11:45:19 hosting kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Oct 10 11:45:19 hosting kernel: device-mapper: 4.0.0-ioctl (2003-06-04) ini=
tialised: dm@uk.sistina.com
Oct 10 11:45:19 hosting kernel: NET: Registered protocol family 2
Oct 10 11:45:19 hosting kernel: IP: routing cache hash table of 8192 bucket=
s, 64Kbytes
Oct 10 11:45:19 hosting kernel: TCP: Hash tables configured (established 26=
2144 bind 65536)
Oct 10 11:45:19 hosting kernel: Initializing IPsec netlink socket
Oct 10 11:45:19 hosting kernel: NET: Registered protocol family 1
Oct 10 11:45:19 hosting kernel: NET: Registered protocol family 17
Oct 10 11:45:19 hosting kernel: NET: Registered protocol family 15
Oct 10 11:45:19 hosting kernel: BIOS EDD facility v0.09 2003-Jan-22, 1 devi=
ces found
Oct 10 11:45:19 hosting kernel: XFS mounting filesystem hda3
Oct 10 11:45:19 hosting kernel: Starting XFS recovery on filesystem: hda3 (=
dev: hda3)
Oct 10 11:45:19 hosting kernel: Ending XFS recovery on filesystem: hda3 (de=
v: hda3)
Oct 10 11:45:19 hosting kernel: Freeing unused kernel memory: 288k freed
Oct 10 11:45:19 hosting kernel: Adding 996020k swap on /dev/hda2.  Priority=
:-1 extents:1
Oct 10 11:45:19 hosting kernel: XFS mounting filesystem hda1
Oct 10 11:45:19 hosting kernel: Starting XFS recovery on filesystem: hda1 (=
dev: hda1)
Oct 10 11:45:19 hosting kernel: Ending XFS recovery on filesystem: hda1 (de=
v: hda1)
Oct 10 11:45:19 hosting kernel: XFS mounting filesystem hda4
Oct 10 11:45:19 hosting kernel: Starting XFS recovery on filesystem: hda4 (=
dev: hda4)
Oct 10 11:45:19 hosting kernel: Ending XFS recovery on filesystem: hda4 (de=
v: hda4)
Oct 10 11:45:19 hosting kernel: eth0: Media Link On 100mbps full-duplex


CONFIG_X86=3Dy
CONFIG_MMU=3Dy
CONFIG_UID16=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_EXPERIMENTAL=3Dy
CONFIG_CLEAN_COMPILE=3Dy
CONFIG_STANDALONE=3Dy
CONFIG_BROKEN_ON_SMP=3Dy
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_SYSCTL=3Dy
CONFIG_LOG_BUF_SHIFT=3D14
CONFIG_EMBEDDED=3Dy
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODULE_FORCE_UNLOAD=3Dy
CONFIG_OBSOLETE_MODPARM=3Dy
CONFIG_MODVERSIONS=3Dy
CONFIG_X86_PC=3Dy
CONFIG_MK7=3Dy
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D6
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_INTEL_USERCOPY=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
CONFIG_X86_USE_3DNOW=3Dy
CONFIG_X86_TSC=3Dy
CONFIG_X86_MCE=3Dy
CONFIG_X86_MCE_NONFATAL=3Dy
CONFIG_HIGHMEM4G=3Dy
CONFIG_HIGHMEM=3Dy
CONFIG_HIGHPTE=3Dy
CONFIG_MTRR=3Dy
CONFIG_PCI=3Dy
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_NAMES=3Dy
CONFIG_BINFMT_ELF=3Dy
CONFIG_BINFMT_AOUT=3Dy
CONFIG_BLK_DEV_LOOP=3Dy
CONFIG_BLK_DEV_CRYPTOLOOP=3Dy
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_SIZE=3D4096
CONFIG_BLK_DEV_INITRD=3Dy
CONFIG_IDE=3Dy
CONFIG_BLK_DEV_IDE=3Dy
CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
CONFIG_BLK_DEV_IDECD=3Dm
CONFIG_IDE_TASK_IOCTL=3Dy
CONFIG_IDE_TASKFILE_IO=3Dy
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_GENERIC=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
CONFIG_IDEDMA_PCI_AUTO=3Dy
CONFIG_BLK_DEV_ADMA=3Dy
CONFIG_BLK_DEV_SIS5513=3Dy
CONFIG_BLK_DEV_IDEDMA=3Dy
CONFIG_IDEDMA_AUTO=3Dy
CONFIG_NET=3Dy
CONFIG_PACKET=3Dy
CONFIG_PACKET_MMAP=3Dy
CONFIG_UNIX=3Dy
CONFIG_NET_KEY=3Dy
CONFIG_INET=3Dy
CONFIG_INET_ECN=3Dy
CONFIG_INET_AH=3Dy
CONFIG_INET_ESP=3Dy
CONFIG_INET_IPCOMP=3Dy
CONFIG_NETFILTER=3Dy
CONFIG_IP_NF_CONNTRACK=3Dy
CONFIG_IP_NF_FTP=3Dy
CONFIG_IP_NF_IPTABLES=3Dy
CONFIG_IP_NF_MATCH_LIMIT=3Dm
CONFIG_IP_NF_MATCH_MAC=3Dm
CONFIG_IP_NF_MATCH_PKTTYPE=3Dm
CONFIG_IP_NF_MATCH_MARK=3Dm
CONFIG_IP_NF_MATCH_MULTIPORT=3Dm
CONFIG_IP_NF_MATCH_TOS=3Dm
CONFIG_IP_NF_MATCH_ECN=3Dm
CONFIG_IP_NF_MATCH_DSCP=3Dm
CONFIG_IP_NF_MATCH_AH_ESP=3Dm
CONFIG_IP_NF_MATCH_LENGTH=3Dm
CONFIG_IP_NF_MATCH_TTL=3Dm
CONFIG_IP_NF_MATCH_TCPMSS=3Dm
CONFIG_IP_NF_MATCH_HELPER=3Dm
CONFIG_IP_NF_MATCH_STATE=3Dy
CONFIG_IP_NF_MATCH_CONNTRACK=3Dy
CONFIG_IP_NF_MATCH_OWNER=3Dm
CONFIG_IP_NF_FILTER=3Dy
CONFIG_IP_NF_TARGET_REJECT=3Dy
CONFIG_IP_NF_NAT=3Dm
CONFIG_IP_NF_NAT_NEEDED=3Dy
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP_NF_TARGET_REDIRECT=3Dm
CONFIG_IP_NF_NAT_LOCAL=3Dy
CONFIG_IP_NF_NAT_SNMP_BASIC=3Dm
CONFIG_IP_NF_NAT_FTP=3Dm
CONFIG_IP_NF_MANGLE=3Dm
CONFIG_IP_NF_TARGET_TOS=3Dm
CONFIG_IP_NF_TARGET_ECN=3Dm
CONFIG_IP_NF_TARGET_DSCP=3Dm
CONFIG_IP_NF_TARGET_MARK=3Dm
CONFIG_IP_NF_TARGET_LOG=3Dm
CONFIG_IP_NF_TARGET_ULOG=3Dm
CONFIG_IP_NF_TARGET_TCPMSS=3Dm
CONFIG_IP_NF_ARPTABLES=3Dm
CONFIG_XFRM=3Dy
CONFIG_XFRM_USER=3Dy
CONFIG_IPV6_SCTP__=3Dy
CONFIG_NETDEVICES=3Dy
CONFIG_NET_ETHERNET=3Dy
CONFIG_NET_PCI=3Dy
CONFIG_SIS900=3Dy
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
CONFIG_SERIAL_8250_NR_UARTS=3D4
CONFIG_SERIAL_CORE=3Dy
CONFIG_UNIX98_PTYS=3Dy
CONFIG_UNIX98_PTY_COUNT=3D256
CONFIG_RTC=3Dy
CONFIG_VIDEO_SELECT=3Dy
CONFIG_VGA_CONSOLE=3Dy
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_EXT2_FS=3Dm
CONFIG_EXT2_FS_XATTR=3Dy
CONFIG_EXT2_FS_POSIX_ACL=3Dy
CONFIG_EXT2_FS_SECURITY=3Dy
CONFIG_FS_MBCACHE=3Dm
CONFIG_FS_POSIX_ACL=3Dy
CONFIG_XFS_FS=3Dy
CONFIG_XFS_QUOTA=3Dy
CONFIG_XFS_POSIX_ACL=3Dy
CONFIG_QUOTACTL=3Dy
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_ZISOFS_FS=3Dm
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
CONFIG_VFAT_FS=3Dm
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
CONFIG_DEVPTS_FS=3Dy
CONFIG_RAMFS=3Dy
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"iso8859-1"
CONFIG_NLS_CODEPAGE_437=3Dy
CONFIG_NLS_CODEPAGE_1251=3Dy
CONFIG_NLS_ISO8859_1=3Dy
CONFIG_NLS_UTF8=3Dy
CONFIG_CRYPTO=3Dy
CONFIG_CRYPTO_HMAC=3Dy
CONFIG_CRYPTO_NULL=3Dm
CONFIG_CRYPTO_MD4=3Dm
CONFIG_CRYPTO_MD5=3Dy
CONFIG_CRYPTO_SHA1=3Dy
CONFIG_CRYPTO_SHA256=3Dm
CONFIG_CRYPTO_SHA512=3Dm
CONFIG_CRYPTO_DES=3Dy
CONFIG_CRYPTO_BLOWFISH=3Dm
CONFIG_CRYPTO_TWOFISH=3Dm
CONFIG_CRYPTO_SERPENT=3Dm
CONFIG_CRYPTO_AES=3Dy
CONFIG_CRYPTO_CAST5=3Dm
CONFIG_CRYPTO_CAST6=3Dm
CONFIG_CRYPTO_DEFLATE=3Dy
CONFIG_CRYPTO_TEST=3Dm
CONFIG_CRC32=3Dy
CONFIG_ZLIB_INFLATE=3Dy
CONFIG_ZLIB_DEFLATE=3Dy
CONFIG_X86_BIOS_REBOOT=3Dy


wwell Larry
=20




--=-2sz3LEifJUH0VMirJpYg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/iu1Iinq4IVRzHg8RAqq3AJ4tvcYHB+cc/ZWStZyQVgCsq8PGAQCfS1Bz
yuyFW7ixlXMx9epsFFgAVSU=
=Nh2q
-----END PGP SIGNATURE-----

--=-2sz3LEifJUH0VMirJpYg--

