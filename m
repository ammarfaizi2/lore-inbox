Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271331AbTHMC0Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 22:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271335AbTHMC0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 22:26:25 -0400
Received: from elvas.procergs.com.br ([200.198.128.213]:10501 "EHLO
	elvas.procergs.com.br") by vger.kernel.org with ESMTP
	id S271331AbTHMC0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 22:26:19 -0400
To: linux-kernel@vger.kernel.org
Subject: Complete freeze with kernel 2.4.21-ac1
From: Otavio Salvador <otavio@debian.org>
Date: Tue, 12 Aug 2003 23:26:15 -0300
Message-ID: <87r83qfg3c.fsf@retteb.casa>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Folks,

I one of my servers, today I have a complete freeze. The messages
found in syslog is:

Aug 12 13:35:45 sp-server -- MARK --
Aug 12 13:39:17 sp-server kernel: kernel BUG at vmscan.c:358!
Aug 12 13:39:17 sp-server kernel: invalid operand: 0000
Aug 12 13:39:17 sp-server kernel: CPU:    0
Aug 12 13:39:17 sp-server kernel: EIP:    0010:[shrink_cache+721/752]    Not tainted
Aug 12 13:39:17 sp-server kernel: EFLAGS: 00010202
Aug 12 13:39:17 sp-server kernel: eax: fb1efdcc   ebx: 00000000   ecx: c1018004   edx: c02d2d50
Aug 12 13:39:17 sp-server kernel: esi: c1017fe8   edi: 00000b1b   ebp: c02d2d50   esp: cf771f3c
Aug 12 13:39:17 sp-server kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 13:39:17 sp-server kernel: Process kswapd (pid: 5, stackpage=cf771000)
Aug 12 13:39:17 sp-server kernel: Stack: c10c7b70 000001d0 cf770000 0000003b 000001d0 00000001 00000020 000001d0 
Aug 12 13:39:17 sp-server kernel:        00000020 00000006 c0130e81 00000006 c036c180 c02d2d50 000001d0 00000006 
Aug 12 13:39:17 sp-server kernel:        c02d2d50 00000000 c0130ef6 00000020 c02d2d50 cf770000 c02d2ca0 c0131014 
Aug 12 13:39:17 sp-server kernel: Call Trace:    [shrink_caches+97/160] [try_to_free_pages_zone+54/96] [kswapd_balance_pgdat+84/160] [kswapd_balance+25/48] [kswapd+141/176]
Aug 12 13:39:17 sp-server kernel:   [kswapd+0/176] [_stext+0/48] [arch_kernel_thread+43/64] [kswapd+0/176]
Aug 12 13:39:17 sp-server kernel: 
Aug 12 13:39:17 sp-server kernel: Code: 0f 0b 66 01 7e 3d 2a c0 e9 b3 fd ff ff c7 00 00 00 00 00 e8 
Aug 12 13:39:17 sp-server kernel:  kernel BUG at vmscan.c:358!
Aug 12 13:39:17 sp-server kernel: invalid operand: 0000
Aug 12 13:39:17 sp-server kernel: CPU:    0
Aug 12 13:39:17 sp-server kernel: EIP:    0010:[shrink_cache+721/752]    Not tainted
Aug 12 13:39:17 sp-server kernel: EFLAGS: 00010202
Aug 12 13:39:17 sp-server kernel: eax: fb1efdcc   ebx: 00000000   ecx: c1018004   edx: 00000142
Aug 12 13:39:17 sp-server kernel: esi: c1017fe8   edi: 00000c96   ebp: c02d2d50   esp: c85e5e2c
Aug 12 13:39:17 sp-server kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 13:39:17 sp-server kernel: Process eog-image-viewe (pid: 14987, stackpage=c85e5000)
Aug 12 13:39:17 sp-server kernel: Stack: 00000068 c7cdfc80 c85e4000 00000142 000001d2 00000020 00000020 000001d2 
Aug 12 13:39:17 sp-server kernel:        00000020 00000006 c0130e81 00000006 c4447104 c02d2d50 000001d2 00000006 
Aug 12 13:39:17 sp-server kernel:        c02d2d50 00000000 c0130ef6 00000020 c85e4000 00000120 c02d2d50 c0131cd2 
Aug 12 13:39:17 sp-server kernel: Call Trace:    [shrink_caches+97/160] [try_to_free_pages_zone+54/96] [balance_classzone+82/480] [__alloc_pages+222/368] [do_anonymous_page+108/2
40]
Aug 12 13:39:17 sp-server kernel:   [handle_mm_fault+119/256] [do_page_fault+287/1147] [sock_read+151/176] [sys_rt_sigprocmask+280/400] [do_page_fault+0/1147] [error_code+52/60]
Aug 12 13:39:17 sp-server kernel: 
Aug 12 13:39:17 sp-server kernel: Code: 0f 0b 66 01 7e 3d 2a c0 e9 b3 fd ff ff c7 00 00 00 00 00 e8 
Aug 12 13:39:48 sp-server kernel:  kernel BUG at vmscan.c:358!
Aug 12 13:39:48 sp-server kernel: invalid operand: 0000
Aug 12 13:39:48 sp-server kernel: CPU:    0
Aug 12 13:39:48 sp-server kernel: EIP:    0010:[shrink_cache+721/752]    Not tainted
Aug 12 13:39:48 sp-server kernel: EFLAGS: 00010202
Aug 12 13:39:48 sp-server kernel: eax: fb1efdcc   ebx: 00000000   ecx: c1018004   edx: 00000164
Aug 12 13:39:48 sp-server kernel: esi: c1017fe8   edi: 00000dec   ebp: c02d2d50   esp: c3993e2c
Aug 12 13:39:48 sp-server kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 13:39:48 sp-server kernel: Process eog-image-viewe (pid: 14992, stackpage=c3993000)
Aug 12 13:39:48 sp-server kernel: Stack: c033ebc0 0000000b c3992000 00000164 000001d2 00000020 00000020 000001d2 
Aug 12 13:39:48 sp-server kernel:        00000020 00000006 c0130e81 00000006 c0a11104 c02d2d50 000001d2 00000006 
Aug 12 13:39:48 sp-server kernel:        c02d2d50 00000000 c0130ef6 00000020 c3992000 00000120 c02d2d50 c0131cd2 
Aug 12 13:39:48 sp-server kernel: Call Trace:    [shrink_caches+97/160] [try_to_free_pages_zone+54/96] [balance_classzone+82/480] [__alloc_pages+222/368] [do_anonymous_page+108/2
40]
Aug 12 13:39:48 sp-server kernel:   [handle_mm_fault+119/256] [do_page_fault+287/1147] [update_process_times+63/80] [bh_action+34/64] [tasklet_hi_action+70/112] [do_IRQ+155/160]
Aug 12 13:39:48 sp-server kernel:   [do_page_fault+0/1147] [error_code+52/60]
Aug 12 13:39:48 sp-server kernel: 
Aug 12 13:39:48 sp-server kernel: Code: 0f 0b 66 01 7e 3d 2a c0 e9 b3 fd ff ff c7 00 00 00 00 00 e8 
Aug 12 13:40:00 sp-server kernel:  kernel BUG at vmscan.c:358!
Aug 12 13:40:00 sp-server kernel: invalid operand: 0000
Aug 12 13:40:00 sp-server kernel: CPU:    0
Aug 12 13:40:00 sp-server kernel: EIP:    0010:[shrink_cache+721/752]    Not tainted
Aug 12 13:40:00 sp-server kernel: EFLAGS: 00010202
Aug 12 13:40:00 sp-server kernel: eax: fb1efdcc   ebx: 00000000   ecx: c1018004   edx: 00000163
Aug 12 13:40:00 sp-server kernel: esi: c1017fe8   edi: 00000de0   ebp: c02d2d50   esp: c7f3be2c
Aug 12 13:40:00 sp-server kernel: ds: 0018   es: 0018   ss: 0018
Aug 12 13:40:00 sp-server kernel: Process eog-image-viewe (pid: 14998, stackpage=c7f3b000)
Aug 12 13:40:00 sp-server kernel: Stack: c12afdd4 caf5a000 c7f3a000 00000163 000001d2 00000020 0000001e 000001d2 
Aug 12 13:40:00 sp-server kernel:        00000020 00000006 c0130e81 00000006 c8672104 c02d2d50 000001d2 00000006 
Aug 12 13:40:00 sp-server kernel:        c02d2d50 00000000 c0130ef6 00000020 c7f3a000 00000120 c02d2d50 c0131cd2 
Aug 12 13:40:00 sp-server kernel: Call Trace:    [shrink_caches+97/160] [try_to_free_pages_zone+54/96] [balance_classzone+82/480] [__alloc_pages+222/368] [do_anonymous_page+108/2
40]
Aug 12 13:40:00 sp-server kernel:   [handle_mm_fault+119/256] [do_page_fault+287/1147] [sock_read+151/176] [sys_rt_sigprocmask+280/400] [do_page_fault+0/1147] [error_code+52/60]
Aug 12 13:40:00 sp-server kernel: 
Aug 12 13:40:00 sp-server kernel: Code: 0f 0b 66 01 7e 3d 2a c0 e9 b3 fd ff ff c7 00 00 00 00 00 e8 
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@

The .config are included bellow:

CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PM=y
CONFIG_APM=y
CONFIG_APM_RTC_IS_GMT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDESCSI=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_SIS5513=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_BLK_DEV_SR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_SIS900=y
CONFIG_VIA_RHINE=y
CONFIG_PPP=y
CONFIG_PPPOE=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_SIS=y
CONFIG_AGP_NVIDIA=y
CONFIG_REISERFS_FS=y
CONFIG_FAT_FS=y
CONFIG_VFAT_FS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_ISO8859_1=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SOUND=y
CONFIG_SOUND_TRIDENT=y

If someone need more information, please ask.

TIA,
Otavio

-- 
        O T A V I O    S A L V A D O R
---------------------------------------------
 E-mail: otavio@debian.org      UIN: 5906116
 GNU/Linux User: 239058     GPG ID: 49A5F855
 Home Page: http://www.freedom.ind.br/otavio
---------------------------------------------
