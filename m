Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131377AbQKLWnI>; Sun, 12 Nov 2000 17:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131379AbQKLWm6>; Sun, 12 Nov 2000 17:42:58 -0500
Received: from stinky.trash.net ([195.141.182.42]:59600 "EHLO stinky.trash.net")
	by vger.kernel.org with ESMTP id <S131377AbQKLWmu>;
	Sun, 12 Nov 2000 17:42:50 -0500
Date: Sun, 12 Nov 2000 23:41:20 +0100 (MET)
From: "Peter H. Ruegg" <lkml+nospam@incense.org>
To: dhinds@zen.stanford.edu
cc: linux-kernel@vger.kernel.org
Subject: Compile error with 2.4.0-test11-pre3 PCMCIA
Message-ID: <Pine.GSO.4.21.0011122336350.18948-100000@stinky.trash.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello there,

I just tried to compile my first 2.4-Kernel. While dep, bzImage and
modules all seemed to work well, I've got the following errors while
trying to make modules_install:


depmod: *** Unresolved symbols in /lib/modules/2.4.0-test11-pre3/pcmcia/serial_cs.o
depmod: 	mod_timer_R1f13d309
depmod: 	kmalloc_R93d4cfe6
depmod: 	sprintf_R3c2c5af5
depmod: 	jiffies_R0da02d67
depmod: 	CardServices_Re4eef0a4
depmod: 	register_pccard_driver_R583d4ed2
depmod: 	del_timer_Rfc62f16d
depmod: 	unregister_pccard_driver_Rdb348cd2
depmod: 	unregister_serial_Rce8a3e65
depmod: 	kfree_R037a0cba
depmod: 	printk_R1b7d4074
depmod: 	register_serial_Ra18dc2b1
depmod: *** Unresolved symbols in /lib/modules/2.4.0-test11-pre3/pcmcia/serial_cb.o
depmod: 	register_driver_Ra8664c22
depmod: 	schedule_timeout_R17d59d01
depmod: 	unregister_driver_R9e54a5d8
depmod: 	kmalloc_R93d4cfe6
depmod: 	sprintf_R3c2c5af5
depmod: 	pci_enable_device_Re59f0d56
depmod: 	unregister_serial_Rce8a3e65
depmod: 	kfree_R037a0cba
depmod: 	printk_R1b7d4074
depmod: 	pci_find_slot_R0517f8e1
depmod: 	register_serial_Ra18dc2b1
depmod: *** Unresolved symbols in /lib/modules/2.4.0-test11-pre3/pcmcia/xirc2ps_cs.o
depmod: 	__ioremap_R9eac042a
depmod: 	schedule_timeout_R17d59d01
depmod: 	mod_timer_R1f13d309
depmod: 	__netdev_watchdog_up_R1a436c7f
depmod: 	__const_udelay_Reae3dfd6
depmod: 	skb_over_panic_R59ba9d11
depmod: 	kmalloc_R93d4cfe6
depmod: 	ether_setup_R734a43c2
depmod: 	__io_virt_debug_R2fd62b99
depmod: 	__kfree_skb_Recf10a12
depmod: 	softnet_data_R69e82b04
depmod: 	jiffies_R0da02d67
depmod: 	eth_type_trans_R553a1497
depmod: 	CardServices_Re4eef0a4
depmod: 	register_pccard_driver_R583d4ed2
depmod: 	del_timer_Rfc62f16d
depmod: 	register_netdev_R111267c0
depmod: 	unregister_netdev_Rad27d24b
depmod: 	netif_rx_R6efa67fa
depmod: 	unregister_pccard_driver_Rdb348cd2
depmod: 	kfree_R037a0cba
depmod: 	irq_stat_Rc0ba6f96
depmod: 	printk_R1b7d4074
depmod: 	iounmap_R5fb196d4
depmod: 	alloc_skb_R81bb25e5



Attached is my .config - hope that helps. If I'm doing anything wrong,
please tell me so. If any additional information is needed, please contact
me by removing the "+nospam" from my address.

Greets

Peter H. Ruegg



CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
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
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_APM=y
CONFIG_APM_IGNORE_USER_SUSPEND=y
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK=y
CONFIG_NET_IPIP=m
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
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
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_PIIX_TUNING=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y
CONFIG_SHAPER=m
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_XIRC2PS=m
CONFIG_PCMCIA_NETCARD=y
CONFIG_IRDA=m
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
CONFIG_IRDA_OPTIONS=y
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRTTY_SIR=m
CONFIG_IRPORT_SIR=m
CONFIG_NSC_FIR=m
CONFIG_WINBOND_FIR=m
CONFIG_TOSHIBA_FIR=m
CONFIG_SMC_IRCC_FIR=m
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_SHARE_IRQ=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_BUSMOUSE=m
CONFIG_LOGIBUSMOUSE=m
CONFIG_MS_BUSMOUSE=m
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_PCMCIA_SERIAL=y
CONFIG_PCMCIA_SERIAL_CS=m
CONFIG_PCMCIA_SERIAL_CB=m
CONFIG_QUOTA=y
CONFIG_AUTOFS4_FS=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_UMSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_RAMFS=m
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_MINIX_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_SYSV_FS=m
CONFIG_CODA_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_15=m
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_SOUND=y
CONFIG_SOUND_MAESTRO=m
CONFIG_SOUND_OSS=m
CONFIG_SOUND_TRACEINIT=y
CONFIG_USB=m
CONFIG_USB_DEBUG=y
CONFIG_USB_UHCI_ALT=m
CONFIG_USB_OHCI=m
CONFIG_USB_PRINTER=m
CONFIG_USB_SCANNER=m
CONFIG_USB_AUDIO=m
CONFIG_USB_ACM=m
CONFIG_USB_HID=m
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 5.0i for non-commercial use
Charset: noconv

iQA/AwUBOg8cmFcv4X0c4GKrEQLdQQCguPUq49Hq4Qy17o5G0nSYpzeDapYAoJxI
maK3BbC+ewQwtQIY/FSEPiks
=eGDg
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
