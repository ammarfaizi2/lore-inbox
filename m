Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262184AbTCZUJ7>; Wed, 26 Mar 2003 15:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262311AbTCZUJ7>; Wed, 26 Mar 2003 15:09:59 -0500
Received: from lakemtao03.cox.net ([68.1.17.242]:1237 "EHLO lakemtao03.cox.net")
	by vger.kernel.org with ESMTP id <S262184AbTCZUJh>;
	Wed, 26 Mar 2003 15:09:37 -0500
Message-ID: <3E820C08.8070705@cox.net>
Date: Wed, 26 Mar 2003 14:22:32 -0600
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com
Subject: Kernel Panic
Content-Type: multipart/mixed;
 boundary="------------090000030905000904000607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090000030905000904000607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I booted my system with 2.5.66-bk1 and switched every 3 minutes between 
init 5 and init 3. This resulted in several faults from anything that 
was run at the time. Attached is the latest dmesg with the faults from 
uname and X at the end. Also attached is a panic that has an unknown 
process. It looked like a buffer overrun.  The ? characters are 
replacements for the high-ascii characters that I couldn't type.
I hope this can be fixed. I can reproduce the locking and crashing, but 
each time it is something different that dies. Sometimes I get a kernel 
panic, but it reboots itself before I can write anything down.

This problem started after I began using 2.5.66. I first noticed it when 
I would exit KDE before reboots. Things would lock up. Turned NMI 
watchdog on as I was instructed.


Regards,
David

PS. I have also included my config for 2.5.66

--------------090000030905000904000607
Content-Type: text/plain;
 name="config-2.5.66-bk1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config-2.5.66-bk1"

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MPENTIUM4=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_PREFETCH=y
CONFIG_X86_SSE2=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_EDD=m
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_HIGHPTE=y
CONFIG_MTRR=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_HT_ONLY=y
CONFIG_ACPI_BOOT=y
CONFIG_APM=y
CONFIG_APM_CPU_IDLE=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_SERIAL=y
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
CONFIG_PNPBIOS=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEFLOPPY=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_PCI_WIP=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_PDC202XX_FORCE=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC7XXX_OLD=m
CONFIG_SCSI_PPA=y
CONFIG_SCSI_IMM=m
CONFIG_IEEE1394=m
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_CMP=m
CONFIG_IEEE1394_AMDTP=m
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_XFRM_USER=y
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IRC=y
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_PHYSDEV=m
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
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
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IPV6=y
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=y
CONFIG_INET6_ESP=y
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_FILTER=y
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_IPV6_SCTP__=y
CONFIG_VLAN_8021Q=m
CONFIG_LLC=y
CONFIG_LLC_UI=y
CONFIG_IPX=y
CONFIG_ATALK=m
CONFIG_DEV_APPLETALK=y
CONFIG_IPDDP=m
CONFIG_IPDDP_ENCAP=y
CONFIG_IPDDP_DECAP=y
CONFIG_BRIDGE=m
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_BONDING=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_TULIP=y
CONFIG_TULIP=y
CONFIG_NET_PCI=y
CONFIG_SIS900=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
CONFIG_GAMEPORT=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_SERIAL=m
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_INPUT_UINPUT=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=2048
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
CONFIG_BUSMOUSE=y
CONFIG_HW_RANDOM=m
CONFIG_NVRAM=m
CONFIG_RTC=y
CONFIG_AGP=m
CONFIG_AGP3=y
CONFIG_AGP_INTEL=m
CONFIG_AGP_VIA=m
CONFIG_AGP_AMD=m
CONFIG_AGP_SIS=m
CONFIG_AGP_ALI=m
CONFIG_AGP_AMD_8151=m
CONFIG_AGP_I7505=m
CONFIG_RAW_DRIVER=m
CONFIG_HANGCHECK_TIMER=m
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_QUOTA=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=m
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_NTFS_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_HFS_FS=m
CONFIG_HPFS_FS=y
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_PARTITION_ADVANCED=y
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
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
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
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
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_SOUND=m
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_USB_AUDIO=m
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_AUDIO=m
CONFIG_USB_BLUETOOTH_TTY=m
CONFIG_USB_MIDI=m
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
CONFIG_USB_AIPTEK=m
CONFIG_USB_WACOM=m
CONFIG_USB_KBTAB=m
CONFIG_USB_POWERMATE=m
CONFIG_USB_XPAD=m
CONFIG_USB_MDC800=m
CONFIG_USB_SCANNER=m
CONFIG_USB_MICROTEK=m
CONFIG_USB_HPUSBSCSI=m
CONFIG_USB_DABUSB=m
CONFIG_USB_CATC=m
CONFIG_USB_CDCETHER=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_USBNET=m
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KEYSPAN_MPR=y
CONFIG_USB_SERIAL_KEYSPAN_USA28=y
CONFIG_USB_SERIAL_KEYSPAN_USA28X=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y
CONFIG_USB_SERIAL_KEYSPAN_USA19=y
CONFIG_USB_SERIAL_KEYSPAN_USA18X=y
CONFIG_USB_SERIAL_KEYSPAN_USA19W=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QW=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QI=y
CONFIG_USB_SERIAL_KEYSPAN_USA49W=y
CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_EZUSB=y
CONFIG_USB_EMI26=m
CONFIG_USB_TIGL=y
CONFIG_USB_AUERSWALD=m
CONFIG_USB_RIO500=m
CONFIG_USB_BRLVGER=m
CONFIG_USB_LCD=m
CONFIG_PROFILING=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_KALLSYMS=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_AES=y
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=y
CONFIG_X86_BIOS_REBOOT=y

--------------090000030905000904000607
Content-Type: text/plain;
 name="dmesg-2.5.66-bk1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.5.66-bk1"

].
Initializing Cryptographic API
pty: 2048 Unix98 ptys configured
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Real Time Clock Driver v1.11
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,EPP,ECP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (interrupt-driven).
lp0: console ready
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
sis900.c: v1.08.06 9/24/2002
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0x9800, IRQ 9, 00:e0:18:9d:4f:d0.
Linux Tulip driver version 1.1.13 (May 11, 2002)
eth1: ADMtek Comet rev 17 at 0x9400, 00:20:78:04:68:6F, IRQ 9.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SiS648    ATA 133 controller
    ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb408-0xb40f, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 6Y080P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: ASUS CD-S500/A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=158816/16/63, UDMA(133)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 50X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdc, sector 0
ide-floppy driver 0.99.newide
ppa: Version 2.07 (for Linux 2.4.x)
ppa: Found device at ID 6, Attempting to use EPP 32 bit
ppa: Communication established with ID 6 using EPP 32 bit
scsi0 : Iomega VPI0 (ppa) interface
  Vendor: IOMEGA    Model: ZIP 100           Rev: D.09
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi0, channel 0, id 6, lun 0
ehci-hcd 00:03.3: Silicon Integrated S SiS7002 USB 2.0
ehci-hcd 00:03.3: irq 9, pci mem e0811000
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
ehci-hcd 00:03.3: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 00:03.3
ehci-hcd 00:03.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22
hub 1-0:0: USB hub found
hub 1-0:0: 6 ports detected
ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
ohci-hcd 00:03.0: Silicon Integrated S 7001
ohci-hcd 00:03.0: irq 9, pci mem e0813000
ohci-hcd 00:03.0: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
ohci-hcd 00:03.1: Silicon Integrated S 7001 (#2)
ohci-hcd 00:03.1: irq 9, pci mem e0815000
ohci-hcd 00:03.1: new USB bus registered, assigned bus number 3
hub 3-0:0: USB hub found
hub 3-0:0: 2 ports detected
ohci-hcd 00:03.2: Silicon Integrated S 7001 (#3)
ohci-hcd 00:03.2: irq 9, pci mem e0817000
ohci-hcd 00:03.2: new USB bus registered, assigned bus number 4
hub 4-0:0: USB hub found
hub 4-0:0: 2 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/core/usb.c: registered new driver tiglusb
drivers/usb/misc/tiglusb.c: TI-GRAPH LINK USB (aka SilverLink) driver, version 1.06
mice: PS/2 mouse device common for all mice
input: PC Speaker
gameport: NS558 PnP at pnp00:06 io 0x200 size 8 speed 784 kHz
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
LLC 2.0 by Procom, 1997, Arnaldo C. Melo, 2001, 2002
NET 4.0 IEEE 802.2 extended support
NET4.0 IEEE 802.2 BSD sockets, Jay Schulist, 2001, Arnaldo C. Melo, 2002
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 300 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
Initializing IPsec netlink socket
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
NET4: Linux IPX 0.50 for NET4.0
IPX Portions Copyright (c) 1995 Caldera, Inc.
IPX Portions Copyright (c) 2000-2002 Conectiva, Inc.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 201k freed
VFS: Mounted root (ext2 filesystem).
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x501
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
(fs/jbd/recovery.c, 253): journal_recover: JBD: recovery, exit status 0, recovered transactions 233998 to 234012
(fs/jbd/recovery.c, 255): journal_recover: JBD: Replayed 400 and revoked 0/1 blocks
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 136k freed
hub 2-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
hub 2-0:0: new USB device on port 1, assigned address 2
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-00:03.0-1
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,2), internal journal
Adding 1004020k swap on /dev/hda6.  Priority:-1 extents:1
intel8x0: clocking to 48000
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 801 $ Ben Collins <bcollins@debian.org>
ohci1394_0: Unexpected PCI resource length of 1000!
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[de800000-de8007ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[00:1023]  GUID[00e018000006d3df]  [Unknown] (Linux OHCI-1394)
Disabled Privacy Extensions on device c03ca500(lo)
eth0: Media Link On 100mbps full-duplex 
microcode: CPU0 no microcode found! (sig=f24, pflags=4)
eth0: no IPv6 routers present
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
microcode: CPU0 no microcode found! (sig=f24, pflags=4)
nvidia: no version magic, tainting kernel.
nvidia: module license 'unspecified' taints kernel.
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4191  Mon Dec  9 11:49:01 PST 2002
Linux agpgart interface v0.100 (c) Dave Jones
0: NVRM: AGPGART: unable to retrieve symbol table
Unable to handle kernel paging request at virtual address db608000
 printing eip:
c013bfb2
*pde = 1b4001e3
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c013bfb2>]    Tainted: PF 
EFLAGS: 00010206
EIP is at do_anonymous_page+0x9e/0x202
eax: 00000000   ebx: 00000000   ecx: 00000400   edx: db608000
esi: c1447140   edi: db608000   ebp: dc8ffed4   esp: dc8ffeb8
ds: 007b   es: 007b   ss: 0068
Process uname (pid: 1054, threadinfo=dc8fe000 task=dfcd2780)
Stack: c1447140 00000003 00000001 db2a5780 da3d1400 40015000 dcc80c80 dc8fff04 
       c013c5c0 dcc80c80 dcf19700 db248054 da3d1400 00000001 40015000 c013d282 
       dcc80c80 dcc80ca0 40015000 dc8fffb4 c0118dcd dcc80c80 dcf19700 40015000 
Call Trace:
 [<c013c5c0>] handle_mm_fault+0xe6/0x15e
 [<c013d282>] __vma_link+0x38/0x9e
 [<c0118dcd>] do_page_fault+0x131/0x430
 [<c013d9b6>] do_mmap_pgoff+0x3ca/0x670
 [<c0110577>] sys_mmap2+0x77/0xa8
 [<c0118c9c>] do_page_fault+0x0/0x430
 [<c010b5bd>] error_code+0x2d/0x38

Code: f3 ab 89 14 24 c7 44 24 04 03 00 00 00 e8 04 db fd ff 8b 55 
 <6>note: uname[1054] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
 [<c011a58d>] schedule+0x329/0x32e
 [<c013b02b>] unmap_vmas+0x1c5/0x222
 [<c013e752>] exit_mmap+0x76/0x172
 [<c011b8e4>] mmput+0x3e/0x80
 [<c011f0d9>] do_exit+0xf9/0x310
 [<c010bb52>] do_divide_error+0x0/0xde
 [<c0118edf>] do_page_fault+0x243/0x430
 [<c0135b81>] do_page_cache_readahead+0x77/0x136
 [<c0135cae>] page_cache_readahead+0x6e/0x17a
 [<c0133fcf>] buffered_rmqueue+0x93/0xfc
 [<c0118c9c>] do_page_fault+0x0/0x430
 [<c010b5bd>] error_code+0x2d/0x38
 [<c013bfb2>] do_anonymous_page+0x9e/0x202
 [<c013c5c0>] handle_mm_fault+0xe6/0x15e
 [<c013d282>] __vma_link+0x38/0x9e
 [<c0118dcd>] do_page_fault+0x131/0x430
 [<c013d9b6>] do_mmap_pgoff+0x3ca/0x670
 [<c0110577>] sys_mmap2+0x77/0xa8
 [<c0118c9c>] do_page_fault+0x0/0x430
 [<c010b5bd>] error_code+0x2d/0x38

microcode: CPU0 no microcode found! (sig=f24, pflags=4)
microcode: CPU0 no microcode found! (sig=f24, pflags=4)
0: NVRM: AGPGART: unable to retrieve symbol table
microcode: CPU0 no microcode found! (sig=f24, pflags=4)
microcode: CPU0 no microcode found! (sig=f24, pflags=4)
0: NVRM: AGPGART: unable to retrieve symbol table
general protection fault: 0000 [#2]
CPU:    0
EIP:    0060:[<c0140192>]    Tainted: PF 
EFLAGS: 00013286
EIP is at page_remove_rmap+0xbc/0x12e
eax: ffffffff   ebx: dba82300   ecx: ffffffff   edx: 0000001f
esi: c141ccb0   edi: 00000000   ebp: db591e94   esp: db591e78
ds: 007b   es: 007b   ss: 0068
Process X (pid: 1464, threadinfo=db590000 task=da5b1880)
Stack: dba8104c ffffffff dba82300 1ba8104c c14416c8 dba8104c c141ccb0 db591ed4 
       c013b93f c1452428 00000007 c14416f0 da51e000 0000004c db3c5000 dd2ad500 
       db591ed4 c14416c8 db6c8b00 c141ccb0 da9fa400 400130b0 dd2ad500 db591f04 
Call Trace:
 [<c013b93f>] do_wp_page+0x23d/0x342
 [<c013c629>] handle_mm_fault+0x14f/0x15e
 [<c0118dcd>] do_page_fault+0x131/0x430
 [<c0118c9c>] do_page_fault+0x0/0x430
 [<c010b5bd>] error_code+0x2d/0x38

Code: 8b 01 85 c0 89 45 e8 74 03 0f 18 00 31 d2 8b 44 91 04 85 c0 
 <6>note: X[1464] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
 [<c011a58d>] schedule+0x329/0x32e
 [<c013b02b>] unmap_vmas+0x1c5/0x222
 [<c013e752>] exit_mmap+0x76/0x172
 [<c011b8e4>] mmput+0x3e/0x80
 [<c011f0d9>] do_exit+0xf9/0x310
 [<c010c23c>] do_general_protection+0x0/0x94
 [<c010bb52>] do_divide_error+0x0/0xde
 [<c010c284>] do_general_protection+0x48/0x94
 [<c010b5bd>] error_code+0x2d/0x38
 [<c0140192>] page_remove_rmap+0xbc/0x12e
 [<c013b93f>] do_wp_page+0x23d/0x342
 [<c013c629>] handle_mm_fault+0x14f/0x15e
 [<c0118dcd>] do_page_fault+0x131/0x430
 [<c0118c9c>] do_page_fault+0x0/0x430
 [<c010b5bd>] error_code+0x2d/0x38

bad: scheduling while atomic!
Call Trace:
 [<c011a58d>] schedule+0x329/0x32e
 [<c013b02b>] unmap_vmas+0x1c5/0x222
 [<c013e752>] exit_mmap+0x76/0x172
 [<c011b8e4>] mmput+0x3e/0x80
 [<c011f0d9>] do_exit+0xf9/0x310
 [<c010c23c>] do_general_protection+0x0/0x94
 [<c010bb52>] do_divide_error+0x0/0xde
 [<c010c284>] do_general_protection+0x48/0x94
 [<c010b5bd>] error_code+0x2d/0x38
 [<c0140192>] page_remove_rmap+0xbc/0x12e
 [<c013b93f>] do_wp_page+0x23d/0x342
 [<c013c629>] handle_mm_fault+0x14f/0x15e
 [<c0118dcd>] do_page_fault+0x131/0x430
 [<c0118c9c>] do_page_fault+0x0/0x430
 [<c010b5bd>] error_code+0x2d/0x38

bad: scheduling while atomic!
Call Trace:
 [<c011a58d>] schedule+0x329/0x32e
 [<c013b02b>] unmap_vmas+0x1c5/0x222
 [<c013e752>] exit_mmap+0x76/0x172
 [<c011b8e4>] mmput+0x3e/0x80
 [<c011f0d9>] do_exit+0xf9/0x310
 [<c010c23c>] do_general_protection+0x0/0x94
 [<c010bb52>] do_divide_error+0x0/0xde
 [<c010c284>] do_general_protection+0x48/0x94
 [<c010b5bd>] error_code+0x2d/0x38
 [<c0140192>] page_remove_rmap+0xbc/0x12e
 [<c013b93f>] do_wp_page+0x23d/0x342
 [<c013c629>] handle_mm_fault+0x14f/0x15e
 [<c0118dcd>] do_page_fault+0x131/0x430
 [<c0118c9c>] do_page_fault+0x0/0x430
 [<c010b5bd>] error_code+0x2d/0x38

bad: scheduling while atomic!
Call Trace:
 [<c011a58d>] schedule+0x329/0x32e
 [<c013b02b>] unmap_vmas+0x1c5/0x222
 [<c013e752>] exit_mmap+0x76/0x172
 [<c011b8e4>] mmput+0x3e/0x80
 [<c011f0d9>] do_exit+0xf9/0x310
 [<c010c23c>] do_general_protection+0x0/0x94
 [<c010bb52>] do_divide_error+0x0/0xde
 [<c010c284>] do_general_protection+0x48/0x94
 [<c010b5bd>] error_code+0x2d/0x38
 [<c0140192>] page_remove_rmap+0xbc/0x12e
 [<c013b93f>] do_wp_page+0x23d/0x342
 [<c013c629>] handle_mm_fault+0x14f/0x15e
 [<c0118dcd>] do_page_fault+0x131/0x430
 [<c0118c9c>] do_page_fault+0x0/0x430
 [<c010b5bd>] error_code+0x2d/0x38

bad: scheduling while atomic!
Call Trace:
 [<c011a58d>] schedule+0x329/0x32e
 [<c013b02b>] unmap_vmas+0x1c5/0x222
 [<c013e752>] exit_mmap+0x76/0x172
 [<c011b8e4>] mmput+0x3e/0x80
 [<c011f0d9>] do_exit+0xf9/0x310
 [<c010c23c>] do_general_protection+0x0/0x94
 [<c010bb52>] do_divide_error+0x0/0xde
 [<c010c284>] do_general_protection+0x48/0x94
 [<c010b5bd>] error_code+0x2d/0x38
 [<c0140192>] page_remove_rmap+0xbc/0x12e
 [<c013b93f>] do_wp_page+0x23d/0x342
 [<c013c629>] handle_mm_fault+0x14f/0x15e
 [<c0118dcd>] do_page_fault+0x131/0x430
 [<c0118c9c>] do_page_fault+0x0/0x430
 [<c010b5bd>] error_code+0x2d/0x38

bad: scheduling while atomic!
Call Trace:
 [<c011a58d>] schedule+0x329/0x32e
 [<c013b02b>] unmap_vmas+0x1c5/0x222
 [<c013e752>] exit_mmap+0x76/0x172
 [<c011b8e4>] mmput+0x3e/0x80
 [<c011f0d9>] do_exit+0xf9/0x310
 [<c010c23c>] do_general_protection+0x0/0x94
 [<c010bb52>] do_divide_error+0x0/0xde
 [<c010c284>] do_general_protection+0x48/0x94
 [<c010b5bd>] error_code+0x2d/0x38
 [<c0140192>] page_remove_rmap+0xbc/0x12e
 [<c013b93f>] do_wp_page+0x23d/0x342
 [<c013c629>] handle_mm_fault+0x14f/0x15e
 [<c0118dcd>] do_page_fault+0x131/0x430
 [<c0118c9c>] do_page_fault+0x0/0x430
 [<c010b5bd>] error_code+0x2d/0x38

general protection fault: 0000 [#3]
CPU:    0
EIP:    0060:[<c0140192>]    Tainted: PF 
EFLAGS: 00013286
EIP is at page_remove_rmap+0xbc/0x12e
eax: ffffffff   ebx: dba82300   ecx: ffffffff   edx: 0000001f
esi: c146ffa0   edi: 00000000   ebp: da3bbb64   esp: da3bbb48
ds: 007b   es: 007b   ss: 0068
Process X (pid: 1465, threadinfo=da3ba000 task=da5b1880)
Stack: da6ae360 ffffffff dba82300 1a6ae360 da6ae360 00090000 00166000 da3bbb94 
       c013ad1b c146ee48 00000007 da3bbbc0 da3bbba4 c146ffa0 1c664005 c0434894 
       da9fa084 08448000 081ae000 da3bbbbc c013ade2 c0434894 da9fa080 08048000 
Call Trace:
 [<c013ad1b>] zap_pte_range+0x15b/0x1d6
 [<c013ade2>] zap_pmd_range+0x4c/0x68
 [<c013ae3f>] unmap_page_range+0x41/0x68
 [<c013af38>] unmap_vmas+0xd2/0x222
 [<c013e752>] exit_mmap+0x76/0x172
 [<c011b8e4>] mmput+0x3e/0x80
 [<c0150882>] exec_mmap+0x8e/0xf2
 [<c015094a>] flush_old_exec+0x1a/0x6e8
 [<c01507e6>] kernel_read+0x4a/0x58
 [<c016a5df>] load_elf_binary+0x2f7/0xc5a
 [<c01340bb>] __alloc_pages+0x83/0x2aa
 [<c01eaa2a>] __copy_from_user_ll+0x70/0x76
 [<c015138c>] search_binary_handler+0x104/0x1a8
 [<c01515b4>] do_execve+0x184/0x1c8
 [<c0109697>] sys_execve+0x4b/0x7a
 [<c010ab93>] syscall_call+0x7/0xb

Code: 8b 01 85 c0 89 45 e8 74 03 0f 18 00 31 d2 8b 44 91 04 85 c0 
 <6>note: X[1465] exited with preempt_count 1

--------------090000030905000904000607
Content-Type: text/plain;
 name="panic.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="panic.txt"

EFLAGS: 00010893
EIP is at scheduler_tick+0x96/0x2b8
eax: 74684769   ebx: 00000000   ecx: 00000000   edx: 00000003
esi: d0042444   edi: 00000001   ebp: c0429e8c   esp: c0429e74
ds: 007b   es: 007b   ss: 0068
Process: :???:?<`"^,?:d`9l?`9MF`8??`6?k?6???5?V`5JE?5H?`4M%?3?B`Tim Powers <timp@redhat.com> (pid: 543519605, threadinfo=c0428000 task=d0042444)
Stack: 00000000 00000000 c0461974 00000000 00000001 c0429f24 c0429eac c0123e9c
       00000000 00000001 00000001 00000000 c0429f24 20000001 c0429ebc c012401f
       00000000 c0429f24 c0429ed8 c0110202 c0429f24 c038b21c c038abc0 20000001
Call Trace:
 [<c0123e9c>] update_process_times+0x46/0x50
 [<c012401f>] do_timer+0x35/0xee
 [<c0110202>] timer_interrupt+0x62/0x106
 [<c010cb59>] handle_IRQ_event+0x37/0x5e
 [<c010ccd6>] do_IRQ+0x80/0xd6
 [<c010b500>] common_interrupt+0x18/0x20
 [<c011007b>] set_rtc_mmss+0x5f/0x184
 [<c010bb4d>] die+0x7d/0x82
 [<c0118edf>] do_page_fault+0x243/0x430

Code: 0f ab 50 08 83 c4 0c 5b 5e 5f 5d c3 8b 46 2c 85 c0 74 06 83
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

--------------090000030905000904000607--

