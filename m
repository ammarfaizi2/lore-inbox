Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267323AbTGONW6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 09:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267274AbTGONW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 09:22:57 -0400
Received: from eta.fastwebnet.it ([213.140.2.50]:41660 "EHLO eta.fastwebnet.it")
	by vger.kernel.org with ESMTP id S267323AbTGONWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 09:22:48 -0400
Date: Tue, 15 Jul 2003 15:38:16 +0200
From: Mattia Dongili <dongili@supereva.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.6.0-test1] on a vaio GR laptop
Message-ID: <20030715133816.GA1074@inferi.kami.home>
Reply-To: dongili@supereva.it
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, here's some problems running the 1st 2.6 test kernel on this vaio
gr7k, a japanese model.

1. I've lost the '|' (pipe) keystroke in console, showkey reports the
   following:
     0   press
     1   release
    55   release
     0   relesase
     1   release
    55   release
  This laptop is equipped with a japanese keyboard so the | key is just
  above the Yen key. This problem was already here in 2.5.7X (haven't
  tested previous kernels).
  Using an xterm give me the | key back using this config option:
      Option          "XkbModel"      "jp106"
      Option          "XkbLayout"     "jp"

2. an Oops. In 2.4.21 happens the same. It's 100% reproducible, you
   just need to launch 'kon' (a kanji capable console) from an xterm.
   After the oops the computer is still usable, I can trigger more oops
   in the same manner :)

3. spurious 8259A interrupt: IRQ7
   this appeared also in 2.5.7X... never had one with the 2.4 series

below the kernel config, lspci and the oops.

Later I'll try suspending (S3/S4).

Thanks for the great job.
-- 
mattia
:wq!

*** kernel config
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
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_GENERIC=y
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
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_TABLE=y
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_X86_SPEEDSTEP_ICH=m
CONFIG_X86_SPEEDSTEP_LIB=m
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
CONFIG_HOTPLUG=y
CONFIG_PCMCIA=m
CONFIG_YENTA=m
CONFIG_CARDBUS=y
CONFIG_PCMCIA_PROBE=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PNP=y
CONFIG_ISAPNP=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=m
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_PPA=m
CONFIG_IEEE1394=m
CONFIG_IEEE1394_VERBOSEDEBUG=y
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_SBP2_PHYS_DMA=y
CONFIG_IEEE1394_ETH1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_IEEE1394_CMP=m
CONFIG_IEEE1394_AMDTP=m
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
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
CONFIG_IP_NF_ARP_MANGLE=m
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_E100=m
CONFIG_PPP=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_NET_PCMCIA=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_I801=m
CONFIG_I2C_ISA=m
CONFIG_RTC=m
CONFIG_SONYPI=m
CONFIG_AGP=m
CONFIG_AGP_INTEL=m
CONFIG_DRM=y
CONFIG_DRM_RADEON=m
CONFIG_EXT2_FS=m
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=m
CONFIG_FS_MBCACHE=m
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_PROC_INFO=y
CONFIG_JFS_FS=m
CONFIG_JFS_STATISTICS=y
CONFIG_AUTOFS4_FS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SMB_FS=m
CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-15"
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_UTF8=m
CONFIG_VIDEO_SELECT=y
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
CONFIG_SND_INTEL8X0=m
CONFIG_USB=m
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI_HCD=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y

*** lspci
00:00.0 Host bridge: Intel Corp. 82830 830 Chipset Host Bridge (rev 02)
00:01.0 PCI bridge: Intel Corp. 82830 830 Chipset AGP Bridge (rev 02)
00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 01)
00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 01)
00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 01)
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 41)
00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 01)
00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 01)
00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 01)
00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (rev 01)
00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY
02:02.0 FireWire (IEEE 1394): Texas Instruments TSB43AA22 IEEE-1394 Controller (PHY/Link Integrated) (rev 02)
02:05.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
02:05.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) PRO/100 VE (LOM) Ethernet Controller (rev 41)

*** dmesg | ksymoops
ksymoops 2.4.8 on i686 2.6.0-test1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test1/ (default)
     -m /boot/System.map-2.6.0-test1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
WARNING: USB Mass Storage data integrity not assured
e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x3c0-0x3df 0x3f8-0x3ff 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
Unable to handle kernel paging request at virtual address 00100100
c02016eb
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c02016eb>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: cb420000   ebx: 00000000   ecx: c9c70380   edx: 00100100
esi: cb024000   edi: cb024000   ebp: cb20ed00   esp: cb421f2c
ds: 007b   es: 007b   ss: 0068
Stack: c9c70380 cb51ce80 c9c70380 cb420000 cb51ce80 cb420000 cb51ce80 c0201f12 
       cb024000 c02cd6b3 caa80d80 00000000 00000000 cb024000 0000041d 00000001 
       cb20ed00 c020240d cb024000 00000000 cb420000 cff7ea80 00000000 00000001 
Call Trace:
 [<c0201f12>] do_tty_hangup+0x82/0x4f0
 [<c020240d>] disassociate_ctty+0x4d/0x1c0
 [<c0120ca0>] do_exit+0x2c0/0x430
 [<c0120efb>] do_group_exit+0x7b/0xc0
 [<c01093ab>] syscall_call+0x7/0xb
Code: 8b 02 0f 18 00 90 8d 8e 6c 09 00 00 39 ca 74 12 90 8d 74 26 


>>EIP; c02016eb <check_tty_count+1b/c0>   <=====

>>eax; cb420000 <_end+b08a650/3fc68650>
>>ecx; c9c70380 <_end+98da9d0/3fc68650>
>>esi; cb024000 <_end+ac8e650/3fc68650>
>>edi; cb024000 <_end+ac8e650/3fc68650>
>>ebp; cb20ed00 <_end+ae79350/3fc68650>
>>esp; cb421f2c <_end+b08c57c/3fc68650>

Trace; c0201f12 <do_tty_hangup+82/4f0>
Trace; c020240d <disassociate_ctty+4d/1c0>
Trace; c0120ca0 <do_exit+2c0/430>
Trace; c0120efb <do_group_exit+7b/c0>
Trace; c01093ab <syscall_call+7/b>

Code;  c02016eb <check_tty_count+1b/c0>
00000000 <_EIP>:
Code;  c02016eb <check_tty_count+1b/c0>   <=====
   0:   8b 02                     mov    (%edx),%eax   <=====
Code;  c02016ed <check_tty_count+1d/c0>
   2:   0f 18 00                  prefetchnta (%eax)
Code;  c02016f0 <check_tty_count+20/c0>
   5:   90                        nop    
Code;  c02016f1 <check_tty_count+21/c0>
   6:   8d 8e 6c 09 00 00         lea    0x96c(%esi),%ecx
Code;  c02016f7 <check_tty_count+27/c0>
   c:   39 ca                     cmp    %ecx,%edx
Code;  c02016f9 <check_tty_count+29/c0>
   e:   74 12                     je     22 <_EIP+0x22>
Code;  c02016fb <check_tty_count+2b/c0>
  10:   90                        nop    
Code;  c02016fc <check_tty_count+2c/c0>
  11:   8d 74 26 00               lea    0x0(%esi,1),%esi


1 warning and 1 error issued.  Results may not be reliable.

