Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266645AbRGEHpN>; Thu, 5 Jul 2001 03:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264861AbRGEHpE>; Thu, 5 Jul 2001 03:45:04 -0400
Received: from linux.kappa.ro ([194.102.255.131]:18323 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S266645AbRGEHov>;
	Thu, 5 Jul 2001 03:44:51 -0400
X-RAV-AntiVirus: This e-mail has been scanned for viruses on host: linux.kappa.ro
Date: Thu, 5 Jul 2001 10:46:50 +0300
From: Mircea Damian <dmircea@kappa.ro>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
Message-ID: <20010705104650.A2820@linux.kappa.ro>
In-Reply-To: <20010704232816.B590@marvin.mahowi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010704232816.B590@marvin.mahowi.de>; from mahowi@gmx.net on Wed, Jul 04, 2001 at 11:28:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This bug hits me since 2.4.6-pre5 but nobody answered to my emails... The
code line is identical (and the softirq.c:206 ofc).

Anyone, any idea?

PS: My other posts:
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0107.0/0018.html
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0106.2/0790.html


On Wed, Jul 04, 2001 at 11:28:17PM +0200, Manfred H. Winter wrote:
> Hi!
> 
> I tried to install kernel 2.4.6 with same configuration as 2.4.5, but
> booting failed with:
> 
> kernel BUG at softirq.c:206!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0117f2e>]
> EFLAGS: 00010082
> eax: 0000001d  ebx: c025bf80  ecx: 00000001  edx: c0206628
> esi: c025bf80  edi: 00000001  ebp: 00000000  esp: c0213efc
> ds: 0018  es: 0018  ss: 0018
> Process swapper (pid: 0, stackpage=c0213000)
> Stack: c01d896c c01d8a08 000000ce 00000009 c02445c0 c02445c0 c0213f40 c0117d3f
>        c02445c0 00000000 c0242900 00000000 c010818d c020b5e0 c0213f9f 000003c7
>        c0205ba0 000003c7 c0106d80 c020b5e0 00000000 000003c7 c0213f9f 000003c7
> Call Trace: [<c0117d3f>] [<c010818d>] [<c0106d80>] [<c011493f>] [<c0105000>]
> Code: 0f 0b 83 c4 0c 8b 43 08 85 c0 75 18 fb 8b 43 10 50 8b 43 0c
> Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
> 
> +++
> 
> Output of ver_linux:
> 
> Linux marvin 2.4.5 #1 Tue May 29 03:56:38 CEST 2001 i686 unknown
>  
> Gnu C                  2.95.2
> Gnu make               3.79.1
> binutils               2.10.0.33
> util-linux             2.10s
> mount                  2.10s
> modutils               2.4.6
> e2fsprogs              1.19
> reiserfsprogs          3.x.0k-pre8
> PPP                    2.4.1
> Linux C Library        x    1 root     root      1382179 Jan 19 07:14 /lib/libc.so.6
> Dynamic linker (ldd)   2.2
> Procps                 2.0.7
> Net-tools              1.57
> Kbd                    1.02
> Sh-utils               2.0
> Modules Loaded         sd_mod af_packet khttpd autofs4 unix 8139too ide-scsi aic7xxx scsi_mod
> 
> +++
> 
> marvin:~ # cat /proc/cpuinfo
> processor       : 0
> vendor_id       : CyrixInstead
> cpu family      : 6
> model           : 2
> model name      : 6x86MX 2.5x Core/Bus Clock
> stepping        : 6
> cpu MHz         : 167.047
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : yes
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu de tsc msr cx8 pge cmov mmx cyrix_arr
> bogomips        : 333.41
> 
> +++
> 
> marvin:~ # cat /proc/ioports
> 0000-001f : dma1
> 0020-003f : pic1
> 0040-005f : timer
> 0060-006f : keyboard
> 0080-008f : dma page reg
> 00a0-00bf : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : ide1
> 01f0-01f7 : ide0
> 0376-0376 : ide1
> 03c0-03df : vga+
> 03f6-03f6 : ide0
> 0cf8-0cff : PCI conf1
> 6000-60ff : Adaptec AIC-7861
> 6500-65ff : Realtek Semiconductor Co., Ltd. RTL-8139
>   6500-65ff : 8139too
> f000-f00f : Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
>   f000-f007 : ide0
>   f008-f00f : ide1
> 
> +++
> 
> marvin:~ # cat /proc/iomem
> 00000000-0009fbff : System RAM
> 0009fc00-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000cc000-000cc7ff : Extension ROM
> 000f0000-000fffff : System ROM
> 00100000-07ffffff : System RAM
>   00100000-001ccc23 : Kernel code
>   001ccc24-0020b153 : Kernel data
> e0000000-e1ffffff : nVidia Corporation Vanta [NV6]
> e2000000-e2ffffff : nVidia Corporation Vanta [NV6]
> e3000000-e3000fff : Adaptec AIC-7861
>   e3000000-e3000fff : aic7xxx
> e3001000-e30010ff : Realtek Semiconductor Co., Ltd. RTL-8139
>   e3001000-e30010ff : 8139too
> ffff0000-ffffffff : reserved
> 
> +++
> 
> marvin:~ # lspci -vvv
> 00:00.0 Host bridge: Intel Corporation 430VX - 82437VX TVX [Triton VX] (rev 02)
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
> 	Latency: 32
> 
> 00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 
> 00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II] (prog-if 80 [Master])
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32
> 	Region 4: I/O ports at f000 [size=16]
> 
> 00:08.0 SCSI storage controller: Adaptec AIC-7861 (rev 01)
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (1000ns min, 1000ns max), cache line size 08
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: I/O ports at 6000 [disabled] [size=256]
> 	Region 1: Memory at e3000000 (32-bit, non-prefetchable) [size=4K]
> 	Expansion ROM at <unassigned> [disabled] [size=64K]
> 
> 00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
> 	Subsystem: Allied Telesyn International: Unknown device 2503
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (8000ns min, 16000ns max)
> 	Interrupt: pin A routed to IRQ 10
> 	Region 0: I/O ports at 6500 [size=256]
> 	Region 1: Memory at e3001000 (32-bit, non-prefetchable) [size=256]
> 	Capabilities: [50] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:0a.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15) (prog-if 00 [VGA])
> 	Subsystem: Creative Labs: Unknown device 1039
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (1250ns min, 250ns max)
> 	Interrupt: pin A routed to IRQ 9
> 	Region 0: Memory at e2000000 (32-bit, non-prefetchable) [size=16M]
> 	Region 1: Memory at e0000000 (32-bit, prefetchable) [size=32M]
> 	Expansion ROM at <unassigned> [disabled] [size=64K]
> 	Capabilities: [60] Power Management version 1
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> +++
> 
> marvin:~ # cat /proc/scsi/scsi
> Attached devices:
> Host: scsi0 Channel: 00 Id: 01 Lun: 00
>   Vendor: TANDBERG Model:  TDC 3600        Rev: =08:
>   Type:   Sequential-Access                ANSI SCSI revision: 02
> Host: scsi0 Channel: 00 Id: 05 Lun: 00
>   Vendor: IOMEGA   Model: ZIP 100          Rev: C.19
>   Type:   Direct-Access                    ANSI SCSI revision: 02
> Host: scsi0 Channel: 00 Id: 06 Lun: 00
>   Vendor: SCANNER  Model:                  Rev: 1.01
>   Type:   Scanner                          ANSI SCSI revision: 01 CCS
> Host: scsi1 Channel: 00 Id: 00 Lun: 00
>   Vendor: TEAC     Model: CD-W54E          Rev: 1.1Y
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> 
> +++
> 
> .config:
> 
> CONFIG_X86=y
> CONFIG_ISA=y
> CONFIG_UID16=y
> 
> CONFIG_EXPERIMENTAL=y
> 
> CONFIG_MODULES=y
> CONFIG_KMOD=y
> 
> CONFIG_M586=y
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_XADD=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_X86_L1_CACHE_SHIFT=5
> CONFIG_X86_USE_STRING_486=y
> CONFIG_X86_ALIGNMENT_16=y
> CONFIG_X86_MSR=m
> CONFIG_X86_CPUID=m
> CONFIG_NOHIGHMEM=y
> CONFIG_MTRR=y
> CONFIG_X86_UP_IOAPIC=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_LOCAL_APIC=y
> 
> CONFIG_NET=y
> CONFIG_PCI=y
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_NAMES=y
> CONFIG_SYSVIPC=y
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_SYSCTL=y
> CONFIG_KCORE_ELF=y
> CONFIG_BINFMT_AOUT=m
> CONFIG_BINFMT_ELF=y
> CONFIG_BINFMT_MISC=y
> CONFIG_PM=y
> CONFIG_APM=y
> CONFIG_APM_DO_ENABLE=y
> CONFIG_APM_CPU_IDLE=y
> CONFIG_APM_DISPLAY_BLANK=y
> CONFIG_APM_RTC_IS_GMT=y
> 
> CONFIG_PARPORT=m
> CONFIG_PARPORT_PC=m
> CONFIG_PARPORT_PC_FIFO=y
> CONFIG_PARPORT_1284=y
> 
> CONFIG_PNP=m
> CONFIG_ISAPNP=m
> 
> CONFIG_BLK_DEV_FD=m
> CONFIG_BLK_DEV_LOOP=m
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_SIZE=4096
> CONFIG_BLK_DEV_INITRD=y
> 
> CONFIG_PACKET=m
> CONFIG_PACKET_MMAP=y
> CONFIG_NETLINK=y
> CONFIG_RTNETLINK=y
> CONFIG_NETLINK_DEV=m
> CONFIG_NETFILTER=y
> CONFIG_UNIX=m
> CONFIG_INET=y
> CONFIG_SYN_COOKIES=y
> 
> CONFIG_IP_NF_CONNTRACK=m
> CONFIG_IP_NF_FTP=m
> CONFIG_IP_NF_QUEUE=m
> CONFIG_IP_NF_IPTABLES=m
> CONFIG_IP_NF_MATCH_LIMIT=m
> CONFIG_IP_NF_MATCH_MAC=m
> CONFIG_IP_NF_MATCH_MARK=m
> CONFIG_IP_NF_MATCH_MULTIPORT=m
> CONFIG_IP_NF_MATCH_TOS=m
> CONFIG_IP_NF_MATCH_TCPMSS=m
> CONFIG_IP_NF_MATCH_STATE=m
> CONFIG_IP_NF_MATCH_UNCLEAN=m
> CONFIG_IP_NF_MATCH_OWNER=m
> CONFIG_IP_NF_FILTER=m
> CONFIG_IP_NF_TARGET_REJECT=m
> CONFIG_IP_NF_TARGET_MIRROR=m
> CONFIG_IP_NF_NAT=m
> CONFIG_IP_NF_NAT_NEEDED=y
> CONFIG_IP_NF_TARGET_MASQUERADE=m
> CONFIG_IP_NF_TARGET_REDIRECT=m
> CONFIG_IP_NF_NAT_FTP=m
> CONFIG_IP_NF_MANGLE=m
> CONFIG_IP_NF_TARGET_TOS=m
> CONFIG_IP_NF_TARGET_MARK=m
> CONFIG_IP_NF_TARGET_LOG=m
> CONFIG_IP_NF_TARGET_TCPMSS=m
> CONFIG_KHTTPD=m
> 
> CONFIG_IDE=y
> 
> CONFIG_BLK_DEV_IDE=y
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_BLK_DEV_IDESCSI=m
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> CONFIG_IDEDMA_PCI_AUTO=y
> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_IDEDMA_AUTO=y
> CONFIG_IDEDMA_IVB=y
> 
> CONFIG_SCSI=m
> CONFIG_BLK_DEV_SD=m
> CONFIG_SD_EXTRA_DEVS=40
> CONFIG_CHR_DEV_ST=m
> CONFIG_BLK_DEV_SR=m
> CONFIG_SR_EXTRA_DEVS=2
> CONFIG_CHR_DEV_SG=m
> CONFIG_SCSI_CONSTANTS=y
> CONFIG_SCSI_LOGGING=y
> 
> CONFIG_SCSI_AIC7XXX=m
> CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
> CONFIG_AIC7XXX_RESET_DELAY_MS=5000
> CONFIG_AIC7XXX_BUILD_FIRMWARE=y
> 
> CONFIG_NETDEVICES=y
> 
> CONFIG_DUMMY=m
> 
> CONFIG_NET_ETHERNET=y
> CONFIG_NET_PCI=y
> CONFIG_8139TOO=m
> 
> CONFIG_PPP=m
> CONFIG_PPP_ASYNC=m
> CONFIG_PPP_DEFLATE=m
> CONFIG_PPP_BSDCOMP=m
> 
> CONFIG_INPUT=m
> CONFIG_INPUT_JOYDEV=m
> CONFIG_INPUT_EVDEV=m
> 
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_SERIAL=m
> CONFIG_UNIX98_PTYS=y
> CONFIG_UNIX98_PTY_COUNT=256
> CONFIG_PRINTER=m
> 
> CONFIG_MOUSE=m
> CONFIG_PSMOUSE=y
> 
> CONFIG_JOYSTICK=y
> CONFIG_INPUT_NS558=m
> CONFIG_INPUT_ANALOG=m
> 
> CONFIG_NVRAM=m
> CONFIG_RTC=m
> 
> CONFIG_AUTOFS4_FS=m
> CONFIG_REISERFS_FS=y
> CONFIG_FAT_FS=m
> CONFIG_MSDOS_FS=m
> CONFIG_VFAT_FS=m
> CONFIG_TMPFS=y
> CONFIG_ISO9660_FS=m
> CONFIG_JOLIET=y
> CONFIG_MINIX_FS=m
> CONFIG_PROC_FS=y
> CONFIG_DEVPTS_FS=y
> CONFIG_EXT2_FS=y
> CONFIG_UDF_FS=m
> CONFIG_UDF_RW=y
> 
> CONFIG_PARTITION_ADVANCED=y
> CONFIG_MSDOS_PARTITION=y
> CONFIG_NLS=y
> 
> CONFIG_NLS_DEFAULT="iso8859-15"
> CONFIG_NLS_CODEPAGE_437=m
> CONFIG_NLS_CODEPAGE_850=m
> CONFIG_NLS_ISO8859_1=m
> CONFIG_NLS_ISO8859_15=m
> CONFIG_NLS_UTF8=m
> 
> CONFIG_VGA_CONSOLE=y
> CONFIG_VIDEO_SELECT=y
> 
> CONFIG_SOUND=m
> CONFIG_SOUND_OSS=m
> CONFIG_SOUND_TRACEINIT=y
> CONFIG_SOUND_DMAP=y
> CONFIG_SOUND_SB=m
> CONFIG_SOUND_AWE32_SYNTH=m
> CONFIG_SOUND_YM3812=m
> 
> CONFIG_MAGIC_SYSRQ=y
> 
> +++
> 
> If you need more information, tell me.
> 
> Bye,
> 
> Manfred
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Mircea Damian
E-mails: dmircea@kappa.ro, dmircea@roedu.net
WebPage: http://taz.mania.k.ro/~dmircea/
