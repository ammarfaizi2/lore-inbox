Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLPNMs>; Sat, 16 Dec 2000 08:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131380AbQLPNMj>; Sat, 16 Dec 2000 08:12:39 -0500
Received: from tellus.thn.htu.se ([193.10.192.40]:51213 "EHLO thn.htu.se")
	by vger.kernel.org with ESMTP id <S129345AbQLPNM2>;
	Sat, 16 Dec 2000 08:12:28 -0500
Date: Sat, 16 Dec 2000 13:41:52 +0100 (CET)
From: Richard Torkar <ds98rito@thn.htu.se>
To: <linux-kernel@vger.kernel.org>
Subject: Error compiling 2.4.0t13p1/p2
Message-ID: <Pine.LNX.4.30.0012161332001.19153-100000@studpc91.thndorm.htu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I use redHat 7.0 and the much discussed kgcc :)
I edited the Makefile and changed to kgcc as usual.
This didn't happen with 2.4.0-test12.

This is what I get during a make bzImage (make dep && make clean already
done). Last in this mail is my config.

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
- -fomit-frame-pointer -fno-strict-aliasing -pipe
- -mpreferred-stack-boundary=2 -march=i686    -c -o ip_nat_proto_icmp.o
ip_nat_proto_icmp.c
ld -m elf_i386 -r -o ip_nf_compat.o ipfwadm_core.o ip_fw_compat.o
ip_fw_compat_redir.o ip_fw_compat_masq.o ip_conntrack_standalone.o
ip_conntrack_core.o ip_conntrack_proto_generic.o ip_conntrack_proto_tcp.o
ip_conntrack_proto_udp.o ip_conntrack_proto_icmp.o ip_nat_standalone.o
ip_nat_rule.o ip_nat_core.o ip_nat_proto_unknown.o ip_nat_proto_tcp.o
ip_nat_proto_udp.o ip_nat_proto_icmp.o
rm -f netfilter.o
ld -m elf_i386  -r -o netfilter.o ipchains.o ip_nf_compat.o
ip_nf_compat.o: In function `ip_fw_ctl':
ip_nf_compat.o(.text+0xdf0): multiple definition of `ip_fw_ctl'
ipchains.o(.text+0x11c0): first defined here
ld: Warning: size of symbol `ip_fw_ctl' changed from 1151 to 474 in
ip_nf_compat.o
ip_nf_compat.o: In function `ipfw_input_check':
ip_nf_compat.o(.text+0x12d0): multiple definition of `ipfw_input_check'
ipchains.o(.text+0x1a10): first defined here
ld: Warning: size of symbol `ipfw_input_check' changed from 79 to 57 in
ip_nf_compat.o
ip_nf_compat.o: In function `ipfw_forward_check':
ip_nf_compat.o(.text+0x1350): multiple definition of `ipfw_forward_check'
ipchains.o(.text+0x1ae0): first defined here
ld: Warning: size of symbol `ipfw_forward_check' changed from 82 to 57 in
ip_nf_compat.o
ip_nf_compat.o(.data+0x2c): multiple definition of `ipfw_ops'
ipchains.o(.data+0x4): first defined here
ip_nf_compat.o: In function `ipfw_output_check':
ip_nf_compat.o(.text+0x1310): multiple definition of `ipfw_output_check'
ipchains.o(.text+0x1a60): first defined here
ld: Warning: size of symbol `ipfw_output_check' changed from 125 to 57 in
ip_nf_compat.o
ip_nf_compat.o: In function `ipfw_init_or_cleanup':
ip_nf_compat.o(.text+0x1540): multiple definition of
`ipfw_init_or_cleanup'
ipchains.o(.text+0x1b40): first defined here
ld: Warning: size of symbol `ipfw_init_or_cleanup' changed from 337 to 364
in ip_nf_compat.o
make[3]: *** [netfilter.o] Error 1
make[3]: Leaving directory
`/usr/src/linux-2.4.0-test12/net/ipv4/netfilter'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory
`/usr/src/linux-2.4.0-test12/net/ipv4/netfilter'
make[1]: *** [_subdir_ipv4/netfilter] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.0-test12/net'
make: *** [_dir_net] Error 2


Regards,

/Richard

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_M686=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_PACKET=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_SYN_COOKIES=y
CONFIG_IP_NF_COMPAT_IPCHAINS=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
CONFIG_AIC7XXX_RESET_DELAY=5
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_ISO8859_1=m
CONFIG_VGA_CONSOLE=y
CONFIG_SOUND=m
CONFIG_SOUND_OSS=m
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_DMAP=y
CONFIG_SOUND_VMIDI=m
CONFIG_SOUND_SB=m
CONFIG_SOUND_YM3812=m
CONFIG_MAGIC_SYSRQ=y

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6O2MTUSLExYo23RsRAu8JAJ9RF6nUSddOTpr9GE5h23jUA5YeVACg1I27
uxQvIEf7JE94zYydczpG3yc=
=NCuV
-----END PGP SIGNATURE-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
