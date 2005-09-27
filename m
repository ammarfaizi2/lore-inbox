Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbVI0CfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbVI0CfM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 22:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbVI0CfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 22:35:12 -0400
Received: from barracuda.teksavvy.com ([206.248.154.34]:46247 "EHLO
	barracuda.teksavvy.com") by vger.kernel.org with ESMTP
	id S964801AbVI0CfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 22:35:09 -0400
From: David Ronis <ronis@ronispc.chem.mcgill.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17208.45007.13631.208641@montroll.lan>
Date: Mon, 26 Sep 2005 22:34:55 -0400
To: "Parag Warudkar" <kernel-stuff@comcast.net>
Cc: <david.ronis@mcgill.ca>, <linux-kernel@vger.kernel.org>
Subject: RE: problem with 2.6.13.[0-2]
In-Reply-To: <20050926005531.90DF42E0018@asmx1.McGill.CA>
References: <17206.60255.403692.773279@montroll.lan>
	<20050926005531.90DF42E0018@asmx1.McGill.CA>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: david.ronis@mcgill.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
Thanks for the reply.


DMA is on in both 2.6.12.6 and in 2.6.13.2.  Here's what hdparm
/dev/hda gives:

in 2.6.12.6:

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 65535/16/63, sectors = 195371568, start = 0

in 2.6.13.2 it's the same, except for

multcount    =  0 (off)

Could this be the problem, and if so, would setting multcount to on
fix it? (I take it hdparm -m 16 /dev/hda would do it)

David

>>>>> "Parag" == Parag Warudkar <kernel-stuff@comcast.net> writes:

    Parag> Is DMA enabled on the disk when you boot the kernel which
    Parag> has problems?  What does hdparm /dev/hdX say? Do things get
    Parag> better if you do hdparm -d1 /dev/hdX?

    Parag> Parag 

    Parag> -----Original Message-----
    Parag> From: linux-kernel-owner@vger.kernel.org
    Parag> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of David Ronis
    Parag> Sent: Sunday, September 25, 2005 2:25 PM
    Parag> To: linux-kernel@vger.kernel.org
    Parag> Subject: problem with 2.6.13.[0-2]


    Parag> I recently tried upgrading from 2.6.12.6 to 2.6.13.[0-2] on an HP
    Parag> pavilion zv5000 (a P4 with hyper-threading) running slackware-current.
    Parag> The configuration and build went fine and the new kernel boots; however,
    Parag> things run very very slowly.  As far as I can tell, what is slow are
    Parag> process involving any disk IO.  For example, the part of the boot where
    Parag> ldconfig is run seems to take 2-3 times as long as do things like
    Parag> remaking the X font caches, loading programs etc.

    Parag> This vaguely reminds me of my initial experience with this laptop, where
    Parag> I hadn't turned on CONFIG_BLK_DEV_ATIIXP, although it is now (see
    Parag> below).  If I reboot with the old kernel, things run as before.

    Parag> Finally, I don't subscribe to this list and would appreciate a CC of any
    Parag> reply.

    Parag> Thanks

    Parag> David

    Parag> Here is my .config file.


    Parag> #
    Parag> # Automatically generated make config: don't edit # Linux kernel
    Parag> version: 2.6.13.2 # Sat Sep 24 22:28:33 2005 # CONFIG_X86=y CONFIG_MMU=y
    Parag> CONFIG_UID16=y CONFIG_GENERIC_ISA_DMA=y CONFIG_GENERIC_IOMAP=y

    Parag> #
    Parag> # Code maturity level options
    Parag> #
    Parag> CONFIG_EXPERIMENTAL=y
    Parag> CONFIG_CLEAN_COMPILE=y
    Parag> CONFIG_LOCK_KERNEL=y
    Parag> CONFIG_INIT_ENV_ARG_LIMIT=32

    Parag> #
    Parag> # General setup
    Parag> #
    Parag> CONFIG_LOCALVERSION=""
    Parag> CONFIG_SWAP=y
    Parag> CONFIG_SYSVIPC=y
    Parag> # CONFIG_POSIX_MQUEUE is not set
    Parag> # CONFIG_BSD_PROCESS_ACCT is not set
    Parag> CONFIG_SYSCTL=y
    Parag> # CONFIG_AUDIT is not set
    Parag> CONFIG_HOTPLUG=y
    Parag> CONFIG_KOBJECT_UEVENT=y
    Parag> # CONFIG_IKCONFIG is not set
    Parag> # CONFIG_CPUSETS is not set
    Parag> # CONFIG_EMBEDDED is not set
    Parag> CONFIG_KALLSYMS=y
    Parag> # CONFIG_KALLSYMS_ALL is not set
    Parag> # CONFIG_KALLSYMS_EXTRA_PASS is not set
    Parag> CONFIG_PRINTK=y
    Parag> CONFIG_BUG=y
    Parag> CONFIG_BASE_FULL=y
    Parag> CONFIG_FUTEX=y
    Parag> CONFIG_EPOLL=y
    Parag> CONFIG_SHMEM=y
    Parag> CONFIG_CC_ALIGN_FUNCTIONS=0
    Parag> CONFIG_CC_ALIGN_LABELS=0
    Parag> CONFIG_CC_ALIGN_LOOPS=0
    Parag> CONFIG_CC_ALIGN_JUMPS=0
    Parag> # CONFIG_TINY_SHMEM is not set
    Parag> CONFIG_BASE_SMALL=0

    Parag> #
    Parag> # Loadable module support
    Parag> #
    Parag> CONFIG_MODULES=y
    Parag> CONFIG_MODULE_UNLOAD=y
    Parag> # CONFIG_MODULE_FORCE_UNLOAD is not set
    Parag> CONFIG_OBSOLETE_MODPARM=y
    Parag> CONFIG_MODVERSIONS=y
    Parag> # CONFIG_MODULE_SRCVERSION_ALL is not set CONFIG_KMOD=y
    Parag> CONFIG_STOP_MACHINE=y

    Parag> #
    Parag> # Processor type and features
    Parag> #
    Parag> CONFIG_X86_PC=y
    Parag> # CONFIG_X86_ELAN is not set
    Parag> # CONFIG_X86_VOYAGER is not set
    Parag> # CONFIG_X86_NUMAQ is not set
    Parag> # CONFIG_X86_SUMMIT is not set
    Parag> # CONFIG_X86_BIGSMP is not set
    Parag> # CONFIG_X86_VISWS is not set
    Parag> # CONFIG_X86_GENERICARCH is not set
    Parag> # CONFIG_X86_ES7000 is not set
    Parag> # CONFIG_M386 is not set
    Parag> # CONFIG_M486 is not set
    Parag> # CONFIG_M586 is not set
    Parag> # CONFIG_M586TSC is not set
    Parag> # CONFIG_M586MMX is not set
    Parag> # CONFIG_M686 is not set
    Parag> # CONFIG_MPENTIUMII is not set
    Parag> # CONFIG_MPENTIUMIII is not set
    Parag> # CONFIG_MPENTIUMM is not set
    Parag> CONFIG_MPENTIUM4=y
    Parag> # CONFIG_MK6 is not set
    Parag> # CONFIG_MK7 is not set
    Parag> # CONFIG_MK8 is not set
    Parag> # CONFIG_MCRUSOE is not set
    Parag> # CONFIG_MEFFICEON is not set
    Parag> # CONFIG_MWINCHIPC6 is not set
    Parag> # CONFIG_MWINCHIP2 is not set
    Parag> # CONFIG_MWINCHIP3D is not set
    Parag> # CONFIG_MGEODEGX1 is not set
    Parag> # CONFIG_MCYRIXIII is not set
    Parag> # CONFIG_MVIAC3_2 is not set
    Parag> # CONFIG_X86_GENERIC is not set
    Parag> CONFIG_X86_CMPXCHG=y
    Parag> CONFIG_X86_XADD=y
    Parag> CONFIG_X86_L1_CACHE_SHIFT=7
    Parag> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
    Parag> CONFIG_GENERIC_CALIBRATE_DELAY=y
    Parag> CONFIG_X86_WP_WORKS_OK=y
    Parag> CONFIG_X86_INVLPG=y
    Parag> CONFIG_X86_BSWAP=y
    Parag> CONFIG_X86_POPAD_OK=y
    Parag> CONFIG_X86_GOOD_APIC=y
    Parag> CONFIG_X86_INTEL_USERCOPY=y
    Parag> CONFIG_X86_USE_PPRO_CHECKSUM=y
    Parag> CONFIG_HPET_TIMER=y
    Parag> CONFIG_HPET_EMULATE_RTC=y
    Parag> CONFIG_SMP=y
    Parag> CONFIG_NR_CPUS=2
    Parag> CONFIG_SCHED_SMT=y
    Parag> # CONFIG_PREEMPT_NONE is not set
    Parag> # CONFIG_PREEMPT_VOLUNTARY is not set
    Parag> CONFIG_PREEMPT=y
    Parag> CONFIG_PREEMPT_BKL=y
    Parag> CONFIG_X86_LOCAL_APIC=y
    Parag> CONFIG_X86_IO_APIC=y
    Parag> CONFIG_X86_TSC=y
    Parag> CONFIG_X86_MCE=y
    Parag> CONFIG_X86_MCE_NONFATAL=y
    Parag> CONFIG_X86_MCE_P4THERMAL=y
    Parag> # CONFIG_TOSHIBA is not set
    Parag> # CONFIG_I8K is not set
    Parag> # CONFIG_X86_REBOOTFIXUPS is not set
    Parag> # CONFIG_MICROCODE is not set
    Parag> # CONFIG_X86_MSR is not set
    Parag> CONFIG_X86_CPUID=m

    Parag> #
    Parag> # Firmware Drivers
    Parag> #
    Parag> # CONFIG_EDD is not set
    Parag> CONFIG_NOHIGHMEM=y
    Parag> # CONFIG_HIGHMEM4G is not set
    Parag> # CONFIG_HIGHMEM64G is not set
    Parag> CONFIG_SELECT_MEMORY_MODEL=y
    Parag> CONFIG_FLATMEM_MANUAL=y
    Parag> # CONFIG_DISCONTIGMEM_MANUAL is not set
    Parag> # CONFIG_SPARSEMEM_MANUAL is not set
    Parag> CONFIG_FLATMEM=y
    Parag> CONFIG_FLAT_NODE_MEM_MAP=y
    Parag> # CONFIG_MATH_EMULATION is not set
    Parag> CONFIG_MTRR=y
    Parag> # CONFIG_EFI is not set
    Parag> # CONFIG_IRQBALANCE is not set
    Parag> CONFIG_HAVE_DEC_LOCK=y
    Parag> # CONFIG_REGPARM is not set
    Parag> CONFIG_SECCOMP=y
    Parag> # CONFIG_HZ_100 is not set
    Parag> # CONFIG_HZ_250 is not set
    Parag> CONFIG_HZ_1000=y
    Parag> CONFIG_HZ=1000
    Parag> CONFIG_PHYSICAL_START=0x100000
    Parag> # CONFIG_KEXEC is not set

    Parag> #
    Parag> # Power management options (ACPI, APM)
    Parag> #
    Parag> CONFIG_PM=y
    Parag> # CONFIG_PM_DEBUG is not set
    Parag> # CONFIG_SOFTWARE_SUSPEND is not set

    Parag> #
    Parag> # ACPI (Advanced Configuration and Power Interface) Support #
    Parag> CONFIG_ACPI=y CONFIG_ACPI_BOOT=y CONFIG_ACPI_INTERPRETER=y
    Parag> CONFIG_ACPI_AC=y CONFIG_ACPI_BATTERY=y CONFIG_ACPI_BUTTON=y
    Parag> CONFIG_ACPI_VIDEO=m # CONFIG_ACPI_HOTKEY is not set CONFIG_ACPI_FAN=y
    Parag> CONFIG_ACPI_PROCESSOR=y CONFIG_ACPI_THERMAL=y # CONFIG_ACPI_ASUS is not
    Parag> set # CONFIG_ACPI_IBM is not set # CONFIG_ACPI_TOSHIBA is not set
    Parag> CONFIG_ACPI_BLACKLIST_YEAR=0 # CONFIG_ACPI_DEBUG is not set
    Parag> CONFIG_ACPI_BUS=y CONFIG_ACPI_EC=y CONFIG_ACPI_POWER=y CONFIG_ACPI_PCI=y
    Parag> CONFIG_ACPI_SYSTEM=y CONFIG_X86_PM_TIMER=y # CONFIG_ACPI_CONTAINER is
    Parag> not set

    Parag> #
    Parag> # APM (Advanced Power Management) BIOS Support # # CONFIG_APM is not set

    Parag> #
    Parag> # CPU Frequency scaling
    Parag> #
    Parag> CONFIG_CPU_FREQ=y
    Parag> CONFIG_CPU_FREQ_TABLE=y
    Parag> # CONFIG_CPU_FREQ_DEBUG is not set
    Parag> CONFIG_CPU_FREQ_STAT=y
    Parag> CONFIG_CPU_FREQ_STAT_DETAILS=y
    Parag> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
    Parag> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
    Parag> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y # CONFIG_CPU_FREQ_GOV_POWERSAVE is not
    Parag> set CONFIG_CPU_FREQ_GOV_USERSPACE=m # CONFIG_CPU_FREQ_GOV_ONDEMAND is
    Parag> not set # CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set

    Parag> #
    Parag> # CPUFreq processor drivers
    Parag> #
    Parag> # CONFIG_X86_ACPI_CPUFREQ is not set
    Parag> # CONFIG_X86_POWERNOW_K6 is not set
    Parag> # CONFIG_X86_POWERNOW_K7 is not set
    Parag> # CONFIG_X86_POWERNOW_K8 is not set
    Parag> # CONFIG_X86_GX_SUSPMOD is not set
    Parag> # CONFIG_X86_SPEEDSTEP_CENTRINO is not set CONFIG_X86_SPEEDSTEP_ICH=m #
    Parag> CONFIG_X86_SPEEDSTEP_SMI is not set CONFIG_X86_P4_CLOCKMOD=m #
    Parag> CONFIG_X86_CPUFREQ_NFORCE2 is not set # CONFIG_X86_LONGRUN is not set #
    Parag> CONFIG_X86_LONGHAUL is not set

    Parag> #
    Parag> # shared options
    Parag> #
    Parag> CONFIG_X86_SPEEDSTEP_LIB=m
    Parag> # CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK is not set

    Parag> #
    Parag> # Bus options (PCI, PCMCIA, EISA, MCA, ISA) # CONFIG_PCI=y #
    Parag> CONFIG_PCI_GOBIOS is not set # CONFIG_PCI_GOMMCONFIG is not set #
    Parag> CONFIG_PCI_GODIRECT is not set CONFIG_PCI_GOANY=y CONFIG_PCI_BIOS=y
    Parag> CONFIG_PCI_DIRECT=y CONFIG_PCI_MMCONFIG=y # CONFIG_PCIEPORTBUS is not
    Parag> set # CONFIG_PCI_MSI is not set CONFIG_PCI_LEGACY_PROC=y
    Parag> CONFIG_PCI_NAMES=y # CONFIG_PCI_DEBUG is not set CONFIG_ISA_DMA_API=y #
    Parag> CONFIG_ISA is not set # CONFIG_MCA is not set # CONFIG_SCx200 is not set
    Parag> # CONFIG_HOTPLUG_CPU is not set

    Parag> #
    Parag> # PCCARD (PCMCIA/CardBus) support
    Parag> #
    Parag> CONFIG_PCCARD=m
    Parag> # CONFIG_PCMCIA_DEBUG is not set
    Parag> CONFIG_PCMCIA=m
    Parag> CONFIG_PCMCIA_LOAD_CIS=y
    Parag> CONFIG_PCMCIA_IOCTL=y
    Parag> CONFIG_CARDBUS=y

    Parag> #
    Parag> # PC-card bridges
    Parag> #
    Parag> CONFIG_YENTA=m
    Parag> # CONFIG_PD6729 is not set
    Parag> CONFIG_I82092=m
    Parag> # CONFIG_TCIC is not set
    Parag> CONFIG_PCCARD_NONSTATIC=m

    Parag> #
    Parag> # PCI Hotplug Support
    Parag> #
    Parag> # CONFIG_HOTPLUG_PCI is not set

    Parag> #
    Parag> # Executable file formats
    Parag> #
    Parag> CONFIG_BINFMT_ELF=y
    Parag> CONFIG_BINFMT_AOUT=m
    Parag> CONFIG_BINFMT_MISC=m

    Parag> #
    Parag> # Networking
    Parag> #
    Parag> CONFIG_NET=y

    Parag> #
    Parag> # Networking options
    Parag> #
    Parag> CONFIG_PACKET=m
    Parag> # CONFIG_PACKET_MMAP is not set
    Parag> CONFIG_UNIX=y
    Parag> CONFIG_XFRM=y
    Parag> CONFIG_XFRM_USER=m
    Parag> CONFIG_NET_KEY=y
    Parag> CONFIG_INET=y
    Parag> CONFIG_IP_MULTICAST=y
    Parag> CONFIG_IP_ADVANCED_ROUTER=y
    Parag> CONFIG_ASK_IP_FIB_HASH=y
    Parag> # CONFIG_IP_FIB_TRIE is not set
    Parag> CONFIG_IP_FIB_HASH=y
    Parag> # CONFIG_IP_MULTIPLE_TABLES is not set
    Parag> CONFIG_IP_ROUTE_MULTIPATH=y
    Parag> # CONFIG_IP_ROUTE_MULTIPATH_CACHED is not set CONFIG_IP_ROUTE_VERBOSE=y
    Parag> # CONFIG_IP_PNP is not set CONFIG_NET_IPIP=m CONFIG_NET_IPGRE=m #
    Parag> CONFIG_NET_IPGRE_BROADCAST is not set # CONFIG_IP_MROUTE is not set #
    Parag> CONFIG_ARPD is not set # CONFIG_SYN_COOKIES is not set CONFIG_INET_AH=m
    Parag> CONFIG_INET_ESP=m CONFIG_INET_IPCOMP=m CONFIG_INET_TUNNEL=m
    Parag> CONFIG_IP_TCPDIAG=y # CONFIG_IP_TCPDIAG_IPV6 is not set #
    Parag> CONFIG_TCP_CONG_ADVANCED is not set CONFIG_TCP_CONG_BIC=y

    Parag> #
    Parag> # IP: Virtual Server Configuration
    Parag> #
    Parag> # CONFIG_IP_VS is not set
    Parag> CONFIG_IPV6=m
    Parag> CONFIG_IPV6_PRIVACY=y
    Parag> CONFIG_INET6_AH=m
    Parag> CONFIG_INET6_ESP=m
    Parag> CONFIG_INET6_IPCOMP=m
    Parag> CONFIG_INET6_TUNNEL=m
    Parag> CONFIG_IPV6_TUNNEL=m
    Parag> CONFIG_NETFILTER=y
    Parag> # CONFIG_NETFILTER_DEBUG is not set

    Parag> #
    Parag> # IP: Netfilter Configuration
    Parag> #
    Parag> CONFIG_IP_NF_CONNTRACK=m
    Parag> CONFIG_IP_NF_CT_ACCT=y
    Parag> CONFIG_IP_NF_CONNTRACK_MARK=y
    Parag> CONFIG_IP_NF_CT_PROTO_SCTP=m
    Parag> CONFIG_IP_NF_FTP=m
    Parag> CONFIG_IP_NF_IRC=m
    Parag> CONFIG_IP_NF_TFTP=m
    Parag> # CONFIG_IP_NF_AMANDA is not set
    Parag> # CONFIG_IP_NF_QUEUE is not set
    Parag> CONFIG_IP_NF_IPTABLES=m
    Parag> CONFIG_IP_NF_MATCH_LIMIT=m
    Parag> CONFIG_IP_NF_MATCH_IPRANGE=m
    Parag> CONFIG_IP_NF_MATCH_MAC=m
    Parag> CONFIG_IP_NF_MATCH_PKTTYPE=m
    Parag> CONFIG_IP_NF_MATCH_MARK=m
    Parag> CONFIG_IP_NF_MATCH_MULTIPORT=m
    Parag> CONFIG_IP_NF_MATCH_TOS=m
    Parag> CONFIG_IP_NF_MATCH_RECENT=m
    Parag> CONFIG_IP_NF_MATCH_ECN=m
    Parag> CONFIG_IP_NF_MATCH_DSCP=m
    Parag> CONFIG_IP_NF_MATCH_AH_ESP=m
    Parag> CONFIG_IP_NF_MATCH_LENGTH=m
    Parag> CONFIG_IP_NF_MATCH_TTL=m
    Parag> CONFIG_IP_NF_MATCH_TCPMSS=m
    Parag> CONFIG_IP_NF_MATCH_HELPER=m
    Parag> CONFIG_IP_NF_MATCH_STATE=m
    Parag> CONFIG_IP_NF_MATCH_CONNTRACK=m
    Parag> CONFIG_IP_NF_MATCH_OWNER=m
    Parag> CONFIG_IP_NF_MATCH_ADDRTYPE=m
    Parag> CONFIG_IP_NF_MATCH_REALM=m
    Parag> CONFIG_IP_NF_MATCH_SCTP=m
    Parag> CONFIG_IP_NF_MATCH_COMMENT=m
    Parag> CONFIG_IP_NF_MATCH_CONNMARK=m
    Parag> CONFIG_IP_NF_MATCH_HASHLIMIT=m
    Parag> CONFIG_IP_NF_FILTER=m
    Parag> CONFIG_IP_NF_TARGET_REJECT=m
    Parag> CONFIG_IP_NF_TARGET_LOG=m
    Parag> CONFIG_IP_NF_TARGET_ULOG=m
    Parag> CONFIG_IP_NF_TARGET_TCPMSS=m
    Parag> CONFIG_IP_NF_NAT=m
    Parag> CONFIG_IP_NF_NAT_NEEDED=y
    Parag> CONFIG_IP_NF_TARGET_MASQUERADE=m
    Parag> CONFIG_IP_NF_TARGET_REDIRECT=m
    Parag> CONFIG_IP_NF_TARGET_NETMAP=m
    Parag> CONFIG_IP_NF_TARGET_SAME=m
    Parag> # CONFIG_IP_NF_NAT_SNMP_BASIC is not set CONFIG_IP_NF_NAT_IRC=m
    Parag> CONFIG_IP_NF_NAT_FTP=m CONFIG_IP_NF_NAT_TFTP=m CONFIG_IP_NF_MANGLE=m
    Parag> CONFIG_IP_NF_TARGET_TOS=m CONFIG_IP_NF_TARGET_ECN=m
    Parag> CONFIG_IP_NF_TARGET_DSCP=m CONFIG_IP_NF_TARGET_MARK=m
    Parag> CONFIG_IP_NF_TARGET_CLASSIFY=m CONFIG_IP_NF_TARGET_CONNMARK=m #
    Parag> CONFIG_IP_NF_TARGET_CLUSTERIP is not set # CONFIG_IP_NF_RAW is not set
    Parag> CONFIG_IP_NF_ARPTABLES=m CONFIG_IP_NF_ARPFILTER=m
    Parag> CONFIG_IP_NF_ARP_MANGLE=m

    Parag> #
    Parag> # IPv6: Netfilter Configuration (EXPERIMENTAL) # # CONFIG_IP6_NF_QUEUE
    Parag> is not set CONFIG_IP6_NF_IPTABLES=m CONFIG_IP6_NF_MATCH_LIMIT=m
    Parag> CONFIG_IP6_NF_MATCH_MAC=m CONFIG_IP6_NF_MATCH_RT=m
    Parag> CONFIG_IP6_NF_MATCH_OPTS=m CONFIG_IP6_NF_MATCH_FRAG=m
    Parag> CONFIG_IP6_NF_MATCH_HL=m CONFIG_IP6_NF_MATCH_MULTIPORT=m
    Parag> CONFIG_IP6_NF_MATCH_OWNER=m CONFIG_IP6_NF_MATCH_MARK=m
    Parag> CONFIG_IP6_NF_MATCH_IPV6HEADER=m CONFIG_IP6_NF_MATCH_AHESP=m
    Parag> CONFIG_IP6_NF_MATCH_LENGTH=m CONFIG_IP6_NF_MATCH_EUI64=m
    Parag> CONFIG_IP6_NF_FILTER=m CONFIG_IP6_NF_TARGET_LOG=m CONFIG_IP6_NF_MANGLE=m
    Parag> CONFIG_IP6_NF_TARGET_MARK=m CONFIG_IP6_NF_RAW=m

    Parag> #
    Parag> # SCTP Configuration (EXPERIMENTAL)
    Parag> #
    Parag> # CONFIG_IP_SCTP is not set
    Parag> # CONFIG_ATM is not set
    Parag> # CONFIG_BRIDGE is not set
    Parag> # CONFIG_VLAN_8021Q is not set
    Parag> # CONFIG_DECNET is not set
    Parag> CONFIG_LLC=m
    Parag> # CONFIG_LLC2 is not set
    Parag> CONFIG_IPX=m
    Parag> CONFIG_IPX_INTERN=y
    Parag> # CONFIG_ATALK is not set
    Parag> # CONFIG_X25 is not set
    Parag> # CONFIG_LAPB is not set
    Parag> # CONFIG_NET_DIVERT is not set
    Parag> # CONFIG_ECONET is not set
    Parag> # CONFIG_WAN_ROUTER is not set
    Parag> # CONFIG_NET_SCHED is not set
    Parag> CONFIG_NET_CLS_ROUTE=y

    Parag> #
    Parag> # Network testing
    Parag> #
    Parag> # CONFIG_NET_PKTGEN is not set
    Parag> # CONFIG_HAMRADIO is not set
    Parag> # CONFIG_IRDA is not set
    Parag> CONFIG_BT=m
    Parag> # CONFIG_BT_L2CAP is not set
    Parag> # CONFIG_BT_SCO is not set

    Parag> #
    Parag> # Bluetooth device drivers
    Parag> #
    Parag> # CONFIG_BT_HCIUSB is not set
    Parag> # CONFIG_BT_HCIUART is not set
    Parag> # CONFIG_BT_HCIBCM203X is not set
    Parag> # CONFIG_BT_HCIBPA10X is not set
    Parag> # CONFIG_BT_HCIBFUSB is not set
    Parag> # CONFIG_BT_HCIDTL1 is not set
    Parag> # CONFIG_BT_HCIBT3C is not set
    Parag> # CONFIG_BT_HCIBLUECARD is not set
    Parag> # CONFIG_BT_HCIBTUART is not set
    Parag> # CONFIG_BT_HCIVHCI is not set

    Parag> #
    Parag> # Device Drivers
    Parag> #

    Parag> #
    Parag> # Generic Driver Options
    Parag> #
    Parag> CONFIG_STANDALONE=y
    Parag> CONFIG_PREVENT_FIRMWARE_BUILD=y
    Parag> CONFIG_FW_LOADER=m
    Parag> # CONFIG_DEBUG_DRIVER is not set

    Parag> #
    Parag> # Memory Technology Devices (MTD)
    Parag> #
    Parag> # CONFIG_MTD is not set

    Parag> #
    Parag> # Parallel port support
    Parag> #
    Parag> CONFIG_PARPORT=m
    Parag> CONFIG_PARPORT_PC=m
    Parag> # CONFIG_PARPORT_SERIAL is not set
    Parag> # CONFIG_PARPORT_PC_FIFO is not set
    Parag> # CONFIG_PARPORT_PC_SUPERIO is not set
    Parag> # CONFIG_PARPORT_PC_PCMCIA is not set
    Parag> # CONFIG_PARPORT_GSC is not set
    Parag> # CONFIG_PARPORT_1284 is not set

    Parag> #
    Parag> # Plug and Play support
    Parag> #
    Parag> # CONFIG_PNP is not set

    Parag> #
    Parag> # Block devices
    Parag> #
    Parag> # CONFIG_BLK_DEV_FD is not set
    Parag> # CONFIG_PARIDE is not set
    Parag> # CONFIG_BLK_CPQ_DA is not set
    Parag> # CONFIG_BLK_CPQ_CISS_DA is not set
    Parag> # CONFIG_BLK_DEV_DAC960 is not set
    Parag> # CONFIG_BLK_DEV_UMEM is not set
    Parag> # CONFIG_BLK_DEV_COW_COMMON is not set
    Parag> CONFIG_BLK_DEV_LOOP=m
    Parag> # CONFIG_BLK_DEV_CRYPTOLOOP is not set
    Parag> CONFIG_BLK_DEV_NBD=m
    Parag> # CONFIG_BLK_DEV_SX8 is not set
    Parag> # CONFIG_BLK_DEV_UB is not set
    Parag> # CONFIG_BLK_DEV_RAM is not set
    Parag> CONFIG_BLK_DEV_RAM_COUNT=16
    Parag> CONFIG_INITRAMFS_SOURCE=""
    Parag> # CONFIG_LBD is not set
    Parag> # CONFIG_CDROM_PKTCDVD is not set

    Parag> #
    Parag> # IO Schedulers
    Parag> #
    Parag> CONFIG_IOSCHED_NOOP=y
    Parag> CONFIG_IOSCHED_AS=y
    Parag> CONFIG_IOSCHED_DEADLINE=y
    Parag> CONFIG_IOSCHED_CFQ=y
    Parag> # CONFIG_ATA_OVER_ETH is not set

    Parag> #
    Parag> # ATA/ATAPI/MFM/RLL support
    Parag> #
    Parag> CONFIG_IDE=y
    Parag> CONFIG_BLK_DEV_IDE=y

    Parag> #
    Parag> # Please see Documentation/ide.txt for help/info on IDE drives # #
    Parag> CONFIG_BLK_DEV_IDE_SATA is not set # CONFIG_BLK_DEV_HD_IDE is not set
    Parag> CONFIG_BLK_DEV_IDEDISK=y # CONFIG_IDEDISK_MULTI_MODE is not set #
    Parag> CONFIG_BLK_DEV_IDECS is not set CONFIG_BLK_DEV_IDECD=m #
    Parag> CONFIG_BLK_DEV_IDETAPE is not set # CONFIG_BLK_DEV_IDEFLOPPY is not set
    Parag> CONFIG_BLK_DEV_IDESCSI=m # CONFIG_IDE_TASK_IOCTL is not set

    Parag> #
    Parag> # IDE chipset support/bugfixes
    Parag> #
    Parag> CONFIG_IDE_GENERIC=y
    Parag> CONFIG_BLK_DEV_CMD640=y
    Parag> CONFIG_BLK_DEV_CMD640_ENHANCED=y
    Parag> CONFIG_BLK_DEV_IDEPCI=y
    Parag> CONFIG_IDEPCI_SHARE_IRQ=y
    Parag> # CONFIG_BLK_DEV_OFFBOARD is not set
    Parag> CONFIG_BLK_DEV_GENERIC=y
    Parag> # CONFIG_BLK_DEV_OPTI621 is not set
    Parag> CONFIG_BLK_DEV_RZ1000=y
    Parag> CONFIG_BLK_DEV_IDEDMA_PCI=y
    Parag> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set CONFIG_IDEDMA_PCI_AUTO=y #
    Parag> CONFIG_IDEDMA_ONLYDISK is not set CONFIG_BLK_DEV_AEC62XX=y #
    Parag> CONFIG_BLK_DEV_ALI15X3 is not set # CONFIG_BLK_DEV_AMD74XX is not set
    Parag> CONFIG_BLK_DEV_ATIIXP=y # CONFIG_BLK_DEV_CMD64X is not set #
    Parag> CONFIG_BLK_DEV_TRIFLEX is not set # CONFIG_BLK_DEV_CY82C693 is not set #
    Parag> CONFIG_BLK_DEV_CS5520 is not set # CONFIG_BLK_DEV_CS5530 is not set #
    Parag> CONFIG_BLK_DEV_HPT34X is not set # CONFIG_BLK_DEV_HPT366 is not set #
    Parag> CONFIG_BLK_DEV_SC1200 is not set CONFIG_BLK_DEV_PIIX=y #
    Parag> CONFIG_BLK_DEV_IT821X is not set # CONFIG_BLK_DEV_NS87415 is not set #
    Parag> CONFIG_BLK_DEV_PDC202XX_OLD is not set # CONFIG_BLK_DEV_PDC202XX_NEW is
    Parag> not set # CONFIG_BLK_DEV_SVWKS is not set # CONFIG_BLK_DEV_SIIMAGE is
    Parag> not set # CONFIG_BLK_DEV_SIS5513 is not set # CONFIG_BLK_DEV_SLC90E66 is
    Parag> not set # CONFIG_BLK_DEV_TRM290 is not set # CONFIG_BLK_DEV_VIA82CXXX is
    Parag> not set # CONFIG_IDE_ARM is not set CONFIG_BLK_DEV_IDEDMA=y #
    Parag> CONFIG_IDEDMA_IVB is not set CONFIG_IDEDMA_AUTO=y # CONFIG_BLK_DEV_HD is
    Parag> not set

    Parag> #
    Parag> # SCSI device support
    Parag> #
    Parag> CONFIG_SCSI=m
    Parag> CONFIG_SCSI_PROC_FS=y

    Parag> #
    Parag> # SCSI support type (disk, tape, CD-ROM) # CONFIG_BLK_DEV_SD=m
    Parag> CONFIG_CHR_DEV_ST=m CONFIG_CHR_DEV_OSST=m CONFIG_BLK_DEV_SR=m
    Parag> CONFIG_BLK_DEV_SR_VENDOR=y CONFIG_CHR_DEV_SG=m # CONFIG_CHR_DEV_SCH is
    Parag> not set

    Parag> #
    Parag> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs # #
    Parag> CONFIG_SCSI_MULTI_LUN is not set # CONFIG_SCSI_CONSTANTS is not set #
    Parag> CONFIG_SCSI_LOGGING is not set

    Parag> #
    Parag> # SCSI Transport Attributes
    Parag> #
    Parag> # CONFIG_SCSI_SPI_ATTRS is not set
    Parag> # CONFIG_SCSI_FC_ATTRS is not set
    Parag> # CONFIG_SCSI_ISCSI_ATTRS is not set

    Parag> #
    Parag> # SCSI low-level drivers
    Parag> #
    Parag> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set # CONFIG_SCSI_3W_9XXX is not
    Parag> set # CONFIG_SCSI_ACARD is not set # CONFIG_SCSI_AACRAID is not set #
    Parag> CONFIG_SCSI_AIC7XXX is not set # CONFIG_SCSI_AIC7XXX_OLD is not set #
    Parag> CONFIG_SCSI_AIC79XX is not set # CONFIG_SCSI_DPT_I2O is not set #
    Parag> CONFIG_MEGARAID_NEWGEN is not set # CONFIG_MEGARAID_LEGACY is not set #
    Parag> CONFIG_SCSI_SATA is not set # CONFIG_SCSI_BUSLOGIC is not set #
    Parag> CONFIG_SCSI_DMX3191D is not set # CONFIG_SCSI_EATA is not set #
    Parag> CONFIG_SCSI_FUTURE_DOMAIN is not set # CONFIG_SCSI_GDTH is not set #
    Parag> CONFIG_SCSI_IPS is not set # CONFIG_SCSI_INITIO is not set #
    Parag> CONFIG_SCSI_INIA100 is not set # CONFIG_SCSI_PPA is not set #
    Parag> CONFIG_SCSI_IMM is not set # CONFIG_SCSI_SYM53C8XX_2 is not set #
    Parag> CONFIG_SCSI_IPR is not set # CONFIG_SCSI_QLOGIC_FC is not set #
    Parag> CONFIG_SCSI_QLOGIC_1280 is not set CONFIG_SCSI_QLA2XXX=m #
    Parag> CONFIG_SCSI_QLA21XX is not set # CONFIG_SCSI_QLA22XX is not set #
    Parag> CONFIG_SCSI_QLA2300 is not set # CONFIG_SCSI_QLA2322 is not set #
    Parag> CONFIG_SCSI_QLA6312 is not set # CONFIG_SCSI_QLA24XX is not set #
    Parag> CONFIG_SCSI_LPFC is not set # CONFIG_SCSI_DC395x is not set #
    Parag> CONFIG_SCSI_DC390T is not set # CONFIG_SCSI_NSP32 is not set #
    Parag> CONFIG_SCSI_DEBUG is not set

    Parag> #
    Parag> # PCMCIA SCSI adapter support
    Parag> #
    Parag> # CONFIG_PCMCIA_AHA152X is not set
    Parag> # CONFIG_PCMCIA_FDOMAIN is not set
    Parag> # CONFIG_PCMCIA_NINJA_SCSI is not set
    Parag> # CONFIG_PCMCIA_QLOGIC is not set
    Parag> # CONFIG_PCMCIA_SYM53C500 is not set

    Parag> #
    Parag> # Multi-device support (RAID and LVM)
    Parag> #
    Parag> # CONFIG_MD is not set

    Parag> #
    Parag> # Fusion MPT device support
    Parag> #
    Parag> # CONFIG_FUSION is not set
    Parag> # CONFIG_FUSION_SPI is not set
    Parag> # CONFIG_FUSION_FC is not set

    Parag> #
    Parag> # IEEE 1394 (FireWire) support
    Parag> #
    Parag> CONFIG_IEEE1394=m

    Parag> #
    Parag> # Subsystem Options
    Parag> #
    Parag> # CONFIG_IEEE1394_VERBOSEDEBUG is not set # CONFIG_IEEE1394_OUI_DB is
    Parag> not set CONFIG_IEEE1394_EXTRA_CONFIG_ROMS=y
    Parag> CONFIG_IEEE1394_CONFIG_ROM_IP1394=y
    Parag> # CONFIG_IEEE1394_EXPORT_FULL_API is not set

    Parag> #
    Parag> # Device Drivers
    Parag> #
    Parag> CONFIG_IEEE1394_PCILYNX=m
    Parag> CONFIG_IEEE1394_OHCI1394=m

    Parag> #
    Parag> # Protocol Drivers
    Parag> #
    Parag> CONFIG_IEEE1394_VIDEO1394=m
    Parag> CONFIG_IEEE1394_SBP2=m
    Parag> # CONFIG_IEEE1394_SBP2_PHYS_DMA is not set CONFIG_IEEE1394_ETH1394=m
    Parag> CONFIG_IEEE1394_DV1394=m CONFIG_IEEE1394_RAWIO=m CONFIG_IEEE1394_CMP=m
    Parag> CONFIG_IEEE1394_AMDTP=m

    Parag> #
    Parag> # I2O device support
    Parag> #
    Parag> CONFIG_I2O=m
    Parag> CONFIG_I2O_EXT_ADAPTEC=y
    Parag> CONFIG_I2O_CONFIG=m
    Parag> CONFIG_I2O_CONFIG_OLD_IOCTL=y
    Parag> CONFIG_I2O_BUS=m
    Parag> CONFIG_I2O_BLOCK=m
    Parag> CONFIG_I2O_SCSI=m
    Parag> CONFIG_I2O_PROC=m

    Parag> #
    Parag> # Network device support
    Parag> #
    Parag> CONFIG_NETDEVICES=y
    Parag> CONFIG_DUMMY=m
    Parag> # CONFIG_BONDING is not set
    Parag> # CONFIG_EQUALIZER is not set
    Parag> CONFIG_TUN=m

    Parag> #
    Parag> # ARCnet devices
    Parag> #
    Parag> # CONFIG_ARCNET is not set

    Parag> #
    Parag> # Ethernet (10 or 100Mbit)
    Parag> #
    Parag> CONFIG_NET_ETHERNET=y
    Parag> CONFIG_MII=m
    Parag> # CONFIG_HAPPYMEAL is not set
    Parag> # CONFIG_SUNGEM is not set
    Parag> # CONFIG_NET_VENDOR_3COM is not set

    Parag> #
    Parag> # Tulip family network device support
    Parag> #
    Parag> # CONFIG_NET_TULIP is not set
    Parag> # CONFIG_HP100 is not set
    Parag> CONFIG_NET_PCI=y
    Parag> # CONFIG_PCNET32 is not set
    Parag> # CONFIG_AMD8111_ETH is not set
    Parag> # CONFIG_ADAPTEC_STARFIRE is not set
    Parag> # CONFIG_B44 is not set
    Parag> # CONFIG_FORCEDETH is not set
    Parag> # CONFIG_DGRS is not set
    Parag> # CONFIG_EEPRO100 is not set
    Parag> # CONFIG_E100 is not set
    Parag> # CONFIG_FEALNX is not set
    Parag> # CONFIG_NATSEMI is not set
    Parag> # CONFIG_NE2K_PCI is not set
    Parag> CONFIG_8139CP=m
    Parag> CONFIG_8139TOO=m
    Parag> CONFIG_8139TOO_PIO=y
    Parag> # CONFIG_8139TOO_TUNE_TWISTER is not set # CONFIG_8139TOO_8129 is not
    Parag> set # CONFIG_8139_OLD_RX_RESET is not set # CONFIG_SIS900 is not set #
    Parag> CONFIG_EPIC100 is not set # CONFIG_SUNDANCE is not set # CONFIG_TLAN is
    Parag> not set # CONFIG_VIA_RHINE is not set

    Parag> #
    Parag> # Ethernet (1000 Mbit)
    Parag> #
    Parag> # CONFIG_ACENIC is not set
    Parag> # CONFIG_DL2K is not set
    Parag> # CONFIG_E1000 is not set
    Parag> # CONFIG_NS83820 is not set
    Parag> # CONFIG_HAMACHI is not set
    Parag> # CONFIG_YELLOWFIN is not set
    Parag> # CONFIG_R8169 is not set
    Parag> # CONFIG_SKGE is not set
    Parag> # CONFIG_SK98LIN is not set
    Parag> # CONFIG_VIA_VELOCITY is not set
    Parag> # CONFIG_TIGON3 is not set
    Parag> # CONFIG_BNX2 is not set

    Parag> #
    Parag> # Ethernet (10000 Mbit)
    Parag> #
    Parag> # CONFIG_IXGB is not set
    Parag> # CONFIG_S2IO is not set

    Parag> #
    Parag> # Token Ring devices
    Parag> #
    Parag> # CONFIG_TR is not set

    Parag> #
    Parag> # Wireless LAN (non-hamradio)
    Parag> #
    Parag> CONFIG_NET_RADIO=y

    Parag> #
    Parag> # Obsolete Wireless cards support (pre-802.11) # # CONFIG_STRIP is not
    Parag> set # CONFIG_PCMCIA_WAVELAN is not set # CONFIG_PCMCIA_NETWAVE is not
    Parag> set

    Parag> #
    Parag> # Wireless 802.11 Frequency Hopping cards support # #
    Parag> CONFIG_PCMCIA_RAYCS is not set

    Parag> #
    Parag> # Wireless 802.11b ISA/PCI cards support # # CONFIG_HERMES is not set #
    Parag> CONFIG_ATMEL is not set

    Parag> #
    Parag> # Wireless 802.11b Pcmcia/Cardbus cards support # # CONFIG_AIRO_CS is
    Parag> not set # CONFIG_PCMCIA_WL3501 is not set

    Parag> #
    Parag> # Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support # # CONFIG_PRISM54
    Parag> is not set CONFIG_NET_WIRELESS=y

    Parag> #
    Parag> # PCMCIA network device support
    Parag> #
    Parag> # CONFIG_NET_PCMCIA is not set

    Parag> #
    Parag> # Wan interfaces
    Parag> #
    Parag> # CONFIG_WAN is not set
    Parag> # CONFIG_FDDI is not set
    Parag> # CONFIG_HIPPI is not set
    Parag> # CONFIG_PLIP is not set
    Parag> CONFIG_PPP=m
    Parag> # CONFIG_PPP_MULTILINK is not set
    Parag> CONFIG_PPP_FILTER=y
    Parag> CONFIG_PPP_ASYNC=m
    Parag> CONFIG_PPP_SYNC_TTY=m
    Parag> CONFIG_PPP_DEFLATE=m
    Parag> CONFIG_PPP_BSDCOMP=m
    Parag> CONFIG_PPPOE=m
    Parag> # CONFIG_SLIP is not set
    Parag> # CONFIG_NET_FC is not set
    Parag> # CONFIG_SHAPER is not set
    Parag> # CONFIG_NETCONSOLE is not set
    Parag> # CONFIG_NETPOLL is not set
    Parag> # CONFIG_NET_POLL_CONTROLLER is not set

    Parag> #
    Parag> # ISDN subsystem
    Parag> #
    Parag> # CONFIG_ISDN is not set

    Parag> #
    Parag> # Telephony Support
    Parag> #
    Parag> # CONFIG_PHONE is not set

    Parag> #
    Parag> # Input device support
    Parag> #
    Parag> CONFIG_INPUT=y

    Parag> #
    Parag> # Userland interfaces
    Parag> #
    Parag> CONFIG_INPUT_MOUSEDEV=y
    Parag> CONFIG_INPUT_MOUSEDEV_PSAUX=y
    Parag> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
    Parag> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
    Parag> # CONFIG_INPUT_JOYDEV is not set
    Parag> # CONFIG_INPUT_TSDEV is not set
    Parag> CONFIG_INPUT_EVDEV=m
    Parag> # CONFIG_INPUT_EVBUG is not set

    Parag> #
    Parag> # Input Device Drivers
    Parag> #
    Parag> CONFIG_INPUT_KEYBOARD=y
    Parag> CONFIG_KEYBOARD_ATKBD=y
    Parag> # CONFIG_KEYBOARD_SUNKBD is not set
    Parag> # CONFIG_KEYBOARD_LKKBD is not set
    Parag> # CONFIG_KEYBOARD_XTKBD is not set
    Parag> # CONFIG_KEYBOARD_NEWTON is not set
    Parag> CONFIG_INPUT_MOUSE=y
    Parag> CONFIG_MOUSE_PS2=y
    Parag> # CONFIG_MOUSE_SERIAL is not set
    Parag> # CONFIG_MOUSE_VSXXXAA is not set
    Parag> # CONFIG_INPUT_JOYSTICK is not set
    Parag> # CONFIG_INPUT_TOUCHSCREEN is not set
    Parag> CONFIG_INPUT_MISC=y
    Parag> CONFIG_INPUT_PCSPKR=y
    Parag> # CONFIG_INPUT_UINPUT is not set

    Parag> #
    Parag> # Hardware I/O ports
    Parag> #
    Parag> CONFIG_SERIO=y
    Parag> CONFIG_SERIO_I8042=y
    Parag> CONFIG_SERIO_SERPORT=m
    Parag> # CONFIG_SERIO_CT82C710 is not set
    Parag> # CONFIG_SERIO_PARKBD is not set
    Parag> # CONFIG_SERIO_PCIPS2 is not set
    Parag> CONFIG_SERIO_LIBPS2=y
    Parag> # CONFIG_SERIO_RAW is not set
    Parag> # CONFIG_GAMEPORT is not set

    Parag> #
    Parag> # Character devices
    Parag> #
    Parag> CONFIG_VT=y
    Parag> CONFIG_VT_CONSOLE=y
    Parag> CONFIG_HW_CONSOLE=y
    Parag> # CONFIG_SERIAL_NONSTANDARD is not set

    Parag> #
    Parag> # Serial drivers
    Parag> #
    Parag> CONFIG_SERIAL_8250=m
    Parag> CONFIG_SERIAL_8250_CS=m
    Parag> # CONFIG_SERIAL_8250_ACPI is not set
    Parag> CONFIG_SERIAL_8250_NR_UARTS=4
    Parag> # CONFIG_SERIAL_8250_EXTENDED is not set

    Parag> #
    Parag> # Non-8250 serial port support
    Parag> #
    Parag> CONFIG_SERIAL_CORE=m
    Parag> # CONFIG_SERIAL_JSM is not set
    Parag> CONFIG_UNIX98_PTYS=y
    Parag> CONFIG_LEGACY_PTYS=y
    Parag> CONFIG_LEGACY_PTY_COUNT=256
    Parag> CONFIG_PRINTER=m
    Parag> # CONFIG_LP_CONSOLE is not set
    Parag> # CONFIG_PPDEV is not set
    Parag> # CONFIG_TIPAR is not set

    Parag> #
    Parag> # IPMI
    Parag> #
    Parag> # CONFIG_IPMI_HANDLER is not set

    Parag> #
    Parag> # Watchdog Cards
    Parag> #
    Parag> # CONFIG_WATCHDOG is not set
    Parag> # CONFIG_HW_RANDOM is not set
    Parag> # CONFIG_NVRAM is not set
    Parag> CONFIG_RTC=y
    Parag> # CONFIG_DTLK is not set
    Parag> # CONFIG_R3964 is not set
    Parag> # CONFIG_APPLICOM is not set
    Parag> # CONFIG_SONYPI is not set

    Parag> #
    Parag> # Ftape, the floppy tape device driver
    Parag> #
    Parag> CONFIG_AGP=m
    Parag> # CONFIG_AGP_ALI is not set
    Parag> CONFIG_AGP_ATI=m
    Parag> # CONFIG_AGP_AMD is not set
    Parag> # CONFIG_AGP_AMD64 is not set
    Parag> # CONFIG_AGP_INTEL is not set
    Parag> # CONFIG_AGP_NVIDIA is not set
    Parag> # CONFIG_AGP_SIS is not set
    Parag> # CONFIG_AGP_SWORKS is not set
    Parag> # CONFIG_AGP_VIA is not set
    Parag> # CONFIG_AGP_EFFICEON is not set
    Parag> CONFIG_DRM=m
    Parag> # CONFIG_DRM_TDFX is not set
    Parag> # CONFIG_DRM_R128 is not set
    Parag> CONFIG_DRM_RADEON=m
    Parag> # CONFIG_DRM_MGA is not set
    Parag> # CONFIG_DRM_SIS is not set
    Parag> # CONFIG_DRM_VIA is not set

    Parag> #
    Parag> # PCMCIA character devices
    Parag> #
    Parag> # CONFIG_SYNCLINK_CS is not set
    Parag> # CONFIG_MWAVE is not set
    Parag> # CONFIG_RAW_DRIVER is not set
    Parag> # CONFIG_HPET is not set
    Parag> # CONFIG_HANGCHECK_TIMER is not set

    Parag> #
    Parag> # TPM devices
    Parag> #
    Parag> # CONFIG_TCG_TPM is not set

    Parag> #
    Parag> # I2C support
    Parag> #
    Parag> CONFIG_I2C=m
    Parag> CONFIG_I2C_CHARDEV=m

    Parag> #
    Parag> # I2C Algorithms
    Parag> #
    Parag> CONFIG_I2C_ALGOBIT=m
    Parag> CONFIG_I2C_ALGOPCF=m
    Parag> CONFIG_I2C_ALGOPCA=m

    Parag> #
    Parag> # I2C Hardware Bus support
    Parag> #
    Parag> CONFIG_I2C_ALI1535=m
    Parag> CONFIG_I2C_ALI1563=m
    Parag> CONFIG_I2C_ALI15X3=m
    Parag> CONFIG_I2C_AMD756=m
    Parag> # CONFIG_I2C_AMD756_S4882 is not set
    Parag> CONFIG_I2C_AMD8111=m
    Parag> CONFIG_I2C_I801=m
    Parag> CONFIG_I2C_I810=m
    Parag> CONFIG_I2C_PIIX4=m
    Parag> CONFIG_I2C_ISA=m
    Parag> CONFIG_I2C_NFORCE2=m
    Parag> CONFIG_I2C_PARPORT=m
    Parag> CONFIG_I2C_PARPORT_LIGHT=m
    Parag> CONFIG_I2C_PROSAVAGE=m
    Parag> CONFIG_I2C_SAVAGE4=m
    Parag> CONFIG_SCx200_ACB=m
    Parag> CONFIG_I2C_SIS5595=m
    Parag> CONFIG_I2C_SIS630=m
    Parag> CONFIG_I2C_SIS96X=m
    Parag> # CONFIG_I2C_STUB is not set
    Parag> CONFIG_I2C_VIA=m
    Parag> CONFIG_I2C_VIAPRO=m
    Parag> # CONFIG_I2C_VOODOO3 is not set
    Parag> # CONFIG_I2C_PCA_ISA is not set
    Parag> CONFIG_I2C_SENSOR=m

    Parag> #
    Parag> # Miscellaneous I2C Chip support
    Parag> #
    Parag> # CONFIG_SENSORS_DS1337 is not set
    Parag> # CONFIG_SENSORS_DS1374 is not set
    Parag> CONFIG_SENSORS_EEPROM=m
    Parag> # CONFIG_SENSORS_PCF8574 is not set
    Parag> # CONFIG_SENSORS_PCA9539 is not set
    Parag> # CONFIG_SENSORS_PCF8591 is not set
    Parag> # CONFIG_SENSORS_RTC8564 is not set
    Parag> # CONFIG_SENSORS_MAX6875 is not set
    Parag> # CONFIG_I2C_DEBUG_CORE is not set
    Parag> # CONFIG_I2C_DEBUG_ALGO is not set
    Parag> # CONFIG_I2C_DEBUG_BUS is not set
    Parag> # CONFIG_I2C_DEBUG_CHIP is not set

    Parag> #
    Parag> # Dallas's 1-wire bus
    Parag> #
    Parag> # CONFIG_W1 is not set

    Parag> #
    Parag> # Hardware Monitoring support
    Parag> #
    Parag> CONFIG_HWMON=y
    Parag> CONFIG_SENSORS_ADM1021=m
    Parag> CONFIG_SENSORS_ADM1025=m
    Parag> CONFIG_SENSORS_ADM1026=m
    Parag> CONFIG_SENSORS_ADM1031=m
    Parag> # CONFIG_SENSORS_ADM9240 is not set
    Parag> CONFIG_SENSORS_ASB100=m
    Parag> # CONFIG_SENSORS_ATXP1 is not set
    Parag> CONFIG_SENSORS_DS1621=m
    Parag> CONFIG_SENSORS_FSCHER=m
    Parag> CONFIG_SENSORS_FSCPOS=m
    Parag> CONFIG_SENSORS_GL518SM=m
    Parag> CONFIG_SENSORS_GL520SM=m
    Parag> CONFIG_SENSORS_IT87=m
    Parag> CONFIG_SENSORS_LM63=m
    Parag> CONFIG_SENSORS_LM75=m
    Parag> CONFIG_SENSORS_LM77=m
    Parag> CONFIG_SENSORS_LM78=m
    Parag> CONFIG_SENSORS_LM80=m
    Parag> CONFIG_SENSORS_LM83=m
    Parag> CONFIG_SENSORS_LM85=m
    Parag> CONFIG_SENSORS_LM87=m
    Parag> CONFIG_SENSORS_LM90=m
    Parag> CONFIG_SENSORS_LM92=m
    Parag> CONFIG_SENSORS_MAX1619=m
    Parag> CONFIG_SENSORS_PC87360=m
    Parag> CONFIG_SENSORS_SIS5595=m
    Parag> CONFIG_SENSORS_SMSC47M1=m
    Parag> CONFIG_SENSORS_SMSC47B397=m
    Parag> CONFIG_SENSORS_VIA686A=m
    Parag> CONFIG_SENSORS_W83781D=m
    Parag> CONFIG_SENSORS_W83L785TS=m
    Parag> CONFIG_SENSORS_W83627HF=m
    Parag> # CONFIG_SENSORS_W83627EHF is not set
    Parag> # CONFIG_HWMON_DEBUG_CHIP is not set

    Parag> #
    Parag> # Misc devices
    Parag> #
    Parag> # CONFIG_IBM_ASM is not set

    Parag> #
    Parag> # Multimedia devices
    Parag> #
    Parag> CONFIG_VIDEO_DEV=m

    Parag> #
    Parag> # Video For Linux
    Parag> #

    Parag> #
    Parag> # Video Adapters
    Parag> #
    Parag> CONFIG_VIDEO_BT848=m
    Parag> CONFIG_VIDEO_BWQCAM=m
    Parag> CONFIG_VIDEO_CQCAM=m
    Parag> CONFIG_VIDEO_CPIA=m
    Parag> CONFIG_VIDEO_CPIA_USB=m
    Parag> # CONFIG_VIDEO_SAA5246A is not set
    Parag> # CONFIG_VIDEO_SAA5249 is not set
    Parag> # CONFIG_TUNER_3036 is not set
    Parag> # CONFIG_VIDEO_STRADIS is not set
    Parag> # CONFIG_VIDEO_ZORAN is not set
    Parag> # CONFIG_VIDEO_SAA7134 is not set
    Parag> # CONFIG_VIDEO_MXB is not set
    Parag> # CONFIG_VIDEO_DPC is not set
    Parag> # CONFIG_VIDEO_HEXIUM_ORION is not set
    Parag> # CONFIG_VIDEO_HEXIUM_GEMINI is not set
    Parag> # CONFIG_VIDEO_CX88 is not set
    Parag> # CONFIG_VIDEO_OVCAMCHIP is not set

    Parag> #
    Parag> # Radio Adapters
    Parag> #
    Parag> # CONFIG_RADIO_GEMTEK_PCI is not set
    Parag> # CONFIG_RADIO_MAXIRADIO is not set
    Parag> # CONFIG_RADIO_MAESTRO is not set

    Parag> #
    Parag> # Digital Video Broadcasting Devices
    Parag> #
    Parag> # CONFIG_DVB is not set
    Parag> CONFIG_VIDEO_TUNER=m
    Parag> CONFIG_VIDEO_BUF=m
    Parag> CONFIG_VIDEO_BTCX=m
    Parag> CONFIG_VIDEO_IR=m
    Parag> CONFIG_VIDEO_TVEEPROM=m

    Parag> #
    Parag> # Graphics support
    Parag> #
    Parag> CONFIG_FB=y
    Parag> CONFIG_FB_CFB_FILLRECT=y
    Parag> CONFIG_FB_CFB_COPYAREA=y
    Parag> CONFIG_FB_CFB_IMAGEBLIT=y
    Parag> CONFIG_FB_SOFT_CURSOR=y
    Parag> # CONFIG_FB_MACMODES is not set
    Parag> CONFIG_FB_MODE_HELPERS=y
    Parag> CONFIG_FB_TILEBLITTING=y
    Parag> # CONFIG_FB_CIRRUS is not set
    Parag> # CONFIG_FB_PM2 is not set
    Parag> # CONFIG_FB_CYBER2000 is not set
    Parag> # CONFIG_FB_ARC is not set
    Parag> # CONFIG_FB_ASILIANT is not set
    Parag> # CONFIG_FB_IMSTT is not set
    Parag> CONFIG_FB_VGA16=m
    Parag> CONFIG_FB_VESA=y
    Parag> CONFIG_VIDEO_SELECT=y
    Parag> # CONFIG_FB_HGA is not set
    Parag> # CONFIG_FB_NVIDIA is not set
    Parag> # CONFIG_FB_RIVA is not set
    Parag> # CONFIG_FB_I810 is not set
    Parag> # CONFIG_FB_INTEL is not set
    Parag> # CONFIG_FB_MATROX is not set
    Parag> # CONFIG_FB_RADEON_OLD is not set
    Parag> CONFIG_FB_RADEON=m
    Parag> CONFIG_FB_RADEON_I2C=y
    Parag> # CONFIG_FB_RADEON_DEBUG is not set
    Parag> # CONFIG_FB_ATY128 is not set
    Parag> # CONFIG_FB_ATY is not set
    Parag> # CONFIG_FB_SAVAGE is not set
    Parag> # CONFIG_FB_SIS is not set
    Parag> # CONFIG_FB_NEOMAGIC is not set
    Parag> # CONFIG_FB_KYRO is not set
    Parag> # CONFIG_FB_3DFX is not set
    Parag> # CONFIG_FB_VOODOO1 is not set
    Parag> # CONFIG_FB_TRIDENT is not set
    Parag> # CONFIG_FB_GEODE is not set
    Parag> # CONFIG_FB_S1D13XXX is not set
    Parag> # CONFIG_FB_VIRTUAL is not set

    Parag> #
    Parag> # Console display driver support
    Parag> #
    Parag> CONFIG_VGA_CONSOLE=y
    Parag> CONFIG_DUMMY_CONSOLE=y
    Parag> CONFIG_FRAMEBUFFER_CONSOLE=m
    Parag> # CONFIG_FONTS is not set
    Parag> CONFIG_FONT_8x8=y
    Parag> CONFIG_FONT_8x16=y

    Parag> #
    Parag> # Logo configuration
    Parag> #
    Parag> CONFIG_LOGO=y
    Parag> CONFIG_LOGO_LINUX_MONO=y
    Parag> CONFIG_LOGO_LINUX_VGA16=y
    Parag> CONFIG_LOGO_LINUX_CLUT224=y
    Parag> CONFIG_BACKLIGHT_LCD_SUPPORT=y
    Parag> CONFIG_BACKLIGHT_CLASS_DEVICE=m
    Parag> CONFIG_BACKLIGHT_DEVICE=y
    Parag> CONFIG_LCD_CLASS_DEVICE=m
    Parag> CONFIG_LCD_DEVICE=y

    Parag> #
    Parag> # Sound
    Parag> #
    Parag> CONFIG_SOUND=y

    Parag> #
    Parag> # Advanced Linux Sound Architecture
    Parag> #
    Parag> CONFIG_SND=m
    Parag> CONFIG_SND_TIMER=m
    Parag> CONFIG_SND_PCM=m
    Parag> CONFIG_SND_RAWMIDI=m
    Parag> CONFIG_SND_SEQUENCER=m
    Parag> CONFIG_SND_SEQ_DUMMY=m
    Parag> CONFIG_SND_OSSEMUL=y
    Parag> CONFIG_SND_MIXER_OSS=m
    Parag> CONFIG_SND_PCM_OSS=m
    Parag> CONFIG_SND_SEQUENCER_OSS=y
    Parag> CONFIG_SND_RTCTIMER=m
    Parag> # CONFIG_SND_VERBOSE_PRINTK is not set
    Parag> # CONFIG_SND_DEBUG is not set

    Parag> #
    Parag> # Generic devices
    Parag> #
    Parag> CONFIG_SND_MPU401_UART=m
    Parag> CONFIG_SND_DUMMY=m
    Parag> CONFIG_SND_VIRMIDI=m
    Parag> CONFIG_SND_MTPAV=m
    Parag> CONFIG_SND_SERIAL_U16550=m
    Parag> CONFIG_SND_MPU401=m

    Parag> #
    Parag> # PCI devices
    Parag> #
    Parag> CONFIG_SND_AC97_CODEC=m
    Parag> # CONFIG_SND_ALI5451 is not set
    Parag> CONFIG_SND_ATIIXP=m
    Parag> CONFIG_SND_ATIIXP_MODEM=m
    Parag> # CONFIG_SND_AU8810 is not set
    Parag> # CONFIG_SND_AU8820 is not set
    Parag> # CONFIG_SND_AU8830 is not set
    Parag> # CONFIG_SND_AZT3328 is not set
    Parag> # CONFIG_SND_BT87X is not set
    Parag> # CONFIG_SND_CS46XX is not set
    Parag> # CONFIG_SND_CS4281 is not set
    Parag> # CONFIG_SND_EMU10K1 is not set
    Parag> # CONFIG_SND_EMU10K1X is not set
    Parag> # CONFIG_SND_CA0106 is not set
    Parag> # CONFIG_SND_KORG1212 is not set
    Parag> # CONFIG_SND_MIXART is not set
    Parag> # CONFIG_SND_NM256 is not set
    Parag> # CONFIG_SND_RME32 is not set
    Parag> # CONFIG_SND_RME96 is not set
    Parag> # CONFIG_SND_RME9652 is not set
    Parag> # CONFIG_SND_HDSP is not set
    Parag> # CONFIG_SND_HDSPM is not set
    Parag> # CONFIG_SND_TRIDENT is not set
    Parag> # CONFIG_SND_YMFPCI is not set
    Parag> # CONFIG_SND_ALS4000 is not set
    Parag> # CONFIG_SND_CMIPCI is not set
    Parag> # CONFIG_SND_ENS1370 is not set
    Parag> # CONFIG_SND_ENS1371 is not set
    Parag> # CONFIG_SND_ES1938 is not set
    Parag> # CONFIG_SND_ES1968 is not set
    Parag> # CONFIG_SND_MAESTRO3 is not set
    Parag> # CONFIG_SND_FM801 is not set
    Parag> # CONFIG_SND_ICE1712 is not set
    Parag> # CONFIG_SND_ICE1724 is not set
    Parag> # CONFIG_SND_INTEL8X0 is not set
    Parag> # CONFIG_SND_INTEL8X0M is not set
    Parag> # CONFIG_SND_SONICVIBES is not set
    Parag> # CONFIG_SND_VIA82XX is not set
    Parag> # CONFIG_SND_VIA82XX_MODEM is not set
    Parag> # CONFIG_SND_VX222 is not set
    Parag> # CONFIG_SND_HDA_INTEL is not set

    Parag> #
    Parag> # USB devices
    Parag> #
    Parag> # CONFIG_SND_USB_AUDIO is not set
    Parag> # CONFIG_SND_USB_USX2Y is not set

    Parag> #
    Parag> # PCMCIA devices
    Parag> #

    Parag> #
    Parag> # Open Sound System
    Parag> #
    Parag> # CONFIG_SOUND_PRIME is not set

    Parag> #
    Parag> # USB support
    Parag> #
    Parag> CONFIG_USB_ARCH_HAS_HCD=y
    Parag> CONFIG_USB_ARCH_HAS_OHCI=y
    Parag> CONFIG_USB=m
    Parag> # CONFIG_USB_DEBUG is not set

    Parag> #
    Parag> # Miscellaneous USB options
    Parag> #
    Parag> CONFIG_USB_DEVICEFS=y
    Parag> # CONFIG_USB_BANDWIDTH is not set
    Parag> # CONFIG_USB_DYNAMIC_MINORS is not set
    Parag> # CONFIG_USB_SUSPEND is not set
    Parag> # CONFIG_USB_OTG is not set

    Parag> #
    Parag> # USB Host Controller Drivers
    Parag> #
    Parag> CONFIG_USB_EHCI_HCD=m
    Parag> CONFIG_USB_EHCI_SPLIT_ISO=y
    Parag> CONFIG_USB_EHCI_ROOT_HUB_TT=y
    Parag> # CONFIG_USB_ISP116X_HCD is not set
    Parag> CONFIG_USB_OHCI_HCD=m
    Parag> # CONFIG_USB_OHCI_BIG_ENDIAN is not set
    Parag> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
    Parag> CONFIG_USB_UHCI_HCD=m
    Parag> # CONFIG_USB_SL811_HCD is not set

    Parag> #
    Parag> # USB Device Class drivers
    Parag> #
    Parag> # CONFIG_USB_AUDIO is not set

    Parag> #
    Parag> # USB Bluetooth TTY can only be used with disabled Bluetooth subsystem #
    Parag> # CONFIG_USB_MIDI is not set # CONFIG_USB_ACM is not set #
    Parag> CONFIG_USB_PRINTER is not set

    Parag> #
    Parag> # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be
    Parag> needed; see USB_STORAGE Help for more information # CONFIG_USB_STORAGE=m
    Parag> # CONFIG_USB_STORAGE_DEBUG is not set # CONFIG_USB_STORAGE_DATAFAB is
    Parag> not set # CONFIG_USB_STORAGE_FREECOM is not set #
    Parag> CONFIG_USB_STORAGE_ISD200 is not set # CONFIG_USB_STORAGE_DPCM is not
    Parag> set # CONFIG_USB_STORAGE_USBAT is not set # CONFIG_USB_STORAGE_SDDR09 is
    Parag> not set # CONFIG_USB_STORAGE_SDDR55 is not set #
    Parag> CONFIG_USB_STORAGE_JUMPSHOT is not set

    Parag> #
    Parag> # USB Input Devices
    Parag> #
    Parag> CONFIG_USB_HID=m
    Parag> CONFIG_USB_HIDINPUT=y
    Parag> # CONFIG_HID_FF is not set
    Parag> # CONFIG_USB_HIDDEV is not set

    Parag> #
    Parag> # USB HID Boot Protocol drivers
    Parag> #
    Parag> # CONFIG_USB_KBD is not set
    Parag> # CONFIG_USB_MOUSE is not set
    Parag> # CONFIG_USB_AIPTEK is not set
    Parag> # CONFIG_USB_WACOM is not set
    Parag> # CONFIG_USB_ACECAD is not set
    Parag> # CONFIG_USB_KBTAB is not set
    Parag> # CONFIG_USB_POWERMATE is not set
    Parag> # CONFIG_USB_MTOUCH is not set
    Parag> # CONFIG_USB_ITMTOUCH is not set
    Parag> # CONFIG_USB_EGALAX is not set
    Parag> # CONFIG_USB_XPAD is not set
    Parag> CONFIG_USB_ATI_REMOTE=m
    Parag> # CONFIG_USB_KEYSPAN_REMOTE is not set

    Parag> #
    Parag> # USB Imaging devices
    Parag> #
    Parag> # CONFIG_USB_MDC800 is not set
    Parag> # CONFIG_USB_MICROTEK is not set

    Parag> #
    Parag> # USB Multimedia devices
    Parag> #
    Parag> # CONFIG_USB_DABUSB is not set
    Parag> # CONFIG_USB_VICAM is not set
    Parag> # CONFIG_USB_DSBR is not set
    Parag> # CONFIG_USB_IBMCAM is not set
    Parag> # CONFIG_USB_KONICAWC is not set
    Parag> # CONFIG_USB_OV511 is not set
    Parag> # CONFIG_USB_SE401 is not set
    Parag> # CONFIG_USB_SN9C102 is not set
    Parag> # CONFIG_USB_STV680 is not set
    Parag> # CONFIG_USB_PWC is not set

    Parag> #
    Parag> # USB Network Adapters
    Parag> #
    Parag> # CONFIG_USB_CATC is not set
    Parag> # CONFIG_USB_KAWETH is not set
    Parag> # CONFIG_USB_PEGASUS is not set
    Parag> # CONFIG_USB_RTL8150 is not set
    Parag> # CONFIG_USB_USBNET is not set
    Parag> # CONFIG_USB_ZD1201 is not set
    Parag> CONFIG_USB_MON=y

    Parag> #
    Parag> # USB port drivers
    Parag> #
    Parag> # CONFIG_USB_USS720 is not set

    Parag> #
    Parag> # USB Serial Converter support
    Parag> #
    Parag> # CONFIG_USB_SERIAL is not set

    Parag> #
    Parag> # USB Miscellaneous drivers
    Parag> #
    Parag> # CONFIG_USB_EMI62 is not set
    Parag> # CONFIG_USB_EMI26 is not set
    Parag> # CONFIG_USB_AUERSWALD is not set
    Parag> # CONFIG_USB_RIO500 is not set
    Parag> # CONFIG_USB_LEGOTOWER is not set
    Parag> # CONFIG_USB_LCD is not set
    Parag> # CONFIG_USB_LED is not set
    Parag> # CONFIG_USB_CYTHERM is not set
    Parag> # CONFIG_USB_PHIDGETKIT is not set
    Parag> # CONFIG_USB_PHIDGETSERVO is not set
    Parag> # CONFIG_USB_IDMOUSE is not set
    Parag> # CONFIG_USB_SISUSBVGA is not set
    Parag> # CONFIG_USB_LD is not set
    Parag> # CONFIG_USB_TEST is not set

    Parag> #
    Parag> # USB DSL modem support
    Parag> #

    Parag> #
    Parag> # USB Gadget Support
    Parag> #
    Parag> # CONFIG_USB_GADGET is not set

    Parag> #
    Parag> # MMC/SD Card support
    Parag> #
    Parag> # CONFIG_MMC is not set

    Parag> #
    Parag> # InfiniBand support
    Parag> #
    Parag> # CONFIG_INFINIBAND is not set

    Parag> #
    Parag> # SN Devices
    Parag> #

    Parag> #
    Parag> # File systems
    Parag> #
    Parag> CONFIG_EXT2_FS=y
    Parag> # CONFIG_EXT2_FS_XATTR is not set
    Parag> # CONFIG_EXT2_FS_XIP is not set
    Parag> CONFIG_EXT3_FS=y
    Parag> CONFIG_EXT3_FS_XATTR=y
    Parag> # CONFIG_EXT3_FS_POSIX_ACL is not set
    Parag> # CONFIG_EXT3_FS_SECURITY is not set
    Parag> CONFIG_JBD=y
    Parag> # CONFIG_JBD_DEBUG is not set
    Parag> CONFIG_FS_MBCACHE=y
    Parag> CONFIG_REISERFS_FS=m
    Parag> # CONFIG_REISERFS_CHECK is not set
    Parag> # CONFIG_REISERFS_PROC_INFO is not set
    Parag> # CONFIG_REISERFS_FS_XATTR is not set
    Parag> # CONFIG_JFS_FS is not set
    Parag> CONFIG_FS_POSIX_ACL=y

    Parag> #
    Parag> # XFS support
    Parag> #
    Parag> # CONFIG_XFS_FS is not set
    Parag> # CONFIG_MINIX_FS is not set
    Parag> # CONFIG_ROMFS_FS is not set
    Parag> CONFIG_INOTIFY=y
    Parag> # CONFIG_QUOTA is not set
    Parag> CONFIG_DNOTIFY=y
    Parag> CONFIG_AUTOFS_FS=m
    Parag> CONFIG_AUTOFS4_FS=m

    Parag> #
    Parag> # CD-ROM/DVD Filesystems
    Parag> #
    Parag> CONFIG_ISO9660_FS=m
    Parag> CONFIG_JOLIET=y
    Parag> CONFIG_ZISOFS=y
    Parag> CONFIG_ZISOFS_FS=m
    Parag> CONFIG_UDF_FS=m
    Parag> CONFIG_UDF_NLS=y

    Parag> #
    Parag> # DOS/FAT/NT Filesystems
    Parag> #
    Parag> CONFIG_FAT_FS=m
    Parag> CONFIG_MSDOS_FS=m
    Parag> CONFIG_VFAT_FS=m
    Parag> CONFIG_FAT_DEFAULT_CODEPAGE=437
    Parag> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
    Parag> CONFIG_NTFS_FS=m
    Parag> # CONFIG_NTFS_DEBUG is not set
    Parag> CONFIG_NTFS_RW=y

    Parag> #
    Parag> # Pseudo filesystems
    Parag> #
    Parag> CONFIG_PROC_FS=y
    Parag> CONFIG_PROC_KCORE=y
    Parag> CONFIG_SYSFS=y
    Parag> # CONFIG_DEVPTS_FS_XATTR is not set
    Parag> CONFIG_TMPFS=y
    Parag> # CONFIG_TMPFS_XATTR is not set
    Parag> # CONFIG_HUGETLBFS is not set
    Parag> # CONFIG_HUGETLB_PAGE is not set
    Parag> CONFIG_RAMFS=y

    Parag> #
    Parag> # Miscellaneous filesystems
    Parag> #
    Parag> # CONFIG_ADFS_FS is not set
    Parag> # CONFIG_AFFS_FS is not set
    Parag> # CONFIG_HFS_FS is not set
    Parag> # CONFIG_HFSPLUS_FS is not set
    Parag> # CONFIG_BEFS_FS is not set
    Parag> # CONFIG_BFS_FS is not set
    Parag> # CONFIG_EFS_FS is not set
    Parag> # CONFIG_CRAMFS is not set
    Parag> # CONFIG_VXFS_FS is not set
    Parag> # CONFIG_HPFS_FS is not set
    Parag> # CONFIG_QNX4FS_FS is not set
    Parag> # CONFIG_SYSV_FS is not set
    Parag> # CONFIG_UFS_FS is not set

    Parag> #
    Parag> # Network File Systems
    Parag> #
    Parag> CONFIG_NFS_FS=m
    Parag> CONFIG_NFS_V3=y
    Parag> # CONFIG_NFS_V3_ACL is not set
    Parag> CONFIG_NFS_V4=y
    Parag> # CONFIG_NFS_DIRECTIO is not set
    Parag> CONFIG_NFSD=m
    Parag> CONFIG_NFSD_V3=y
    Parag> # CONFIG_NFSD_V3_ACL is not set
    Parag> CONFIG_NFSD_V4=y
    Parag> CONFIG_NFSD_TCP=y
    Parag> CONFIG_LOCKD=m
    Parag> CONFIG_LOCKD_V4=y
    Parag> CONFIG_EXPORTFS=m
    Parag> CONFIG_NFS_COMMON=y
    Parag> CONFIG_SUNRPC=m
    Parag> CONFIG_SUNRPC_GSS=m
    Parag> CONFIG_RPCSEC_GSS_KRB5=m
    Parag> CONFIG_RPCSEC_GSS_SPKM3=m
    Parag> # CONFIG_SMB_FS is not set
    Parag> # CONFIG_CIFS is not set
    Parag> CONFIG_NCP_FS=m
    Parag> CONFIG_NCPFS_PACKET_SIGNING=y
    Parag> CONFIG_NCPFS_IOCTL_LOCKING=y
    Parag> CONFIG_NCPFS_STRONG=y
    Parag> CONFIG_NCPFS_NFS_NS=y
    Parag> CONFIG_NCPFS_OS2_NS=y
    Parag> CONFIG_NCPFS_SMALLDOS=y
    Parag> CONFIG_NCPFS_NLS=y
    Parag> CONFIG_NCPFS_EXTRAS=y
    Parag> # CONFIG_CODA_FS is not set
    Parag> # CONFIG_AFS_FS is not set

    Parag> #
    Parag> # Partition Types
    Parag> #
    Parag> # CONFIG_PARTITION_ADVANCED is not set
    Parag> CONFIG_MSDOS_PARTITION=y

    Parag> #
    Parag> # Native Language Support
    Parag> #
    Parag> CONFIG_NLS=y
    Parag> CONFIG_NLS_DEFAULT="iso8859-1"
    Parag> CONFIG_NLS_CODEPAGE_437=m
    Parag> # CONFIG_NLS_CODEPAGE_737 is not set
    Parag> # CONFIG_NLS_CODEPAGE_775 is not set
    Parag> # CONFIG_NLS_CODEPAGE_850 is not set
    Parag> # CONFIG_NLS_CODEPAGE_852 is not set
    Parag> # CONFIG_NLS_CODEPAGE_855 is not set
    Parag> # CONFIG_NLS_CODEPAGE_857 is not set
    Parag> # CONFIG_NLS_CODEPAGE_860 is not set
    Parag> # CONFIG_NLS_CODEPAGE_861 is not set
    Parag> CONFIG_NLS_CODEPAGE_862=m
    Parag> # CONFIG_NLS_CODEPAGE_863 is not set
    Parag> # CONFIG_NLS_CODEPAGE_864 is not set
    Parag> # CONFIG_NLS_CODEPAGE_865 is not set
    Parag> # CONFIG_NLS_CODEPAGE_866 is not set
    Parag> # CONFIG_NLS_CODEPAGE_869 is not set
    Parag> # CONFIG_NLS_CODEPAGE_936 is not set
    Parag> # CONFIG_NLS_CODEPAGE_950 is not set
    Parag> # CONFIG_NLS_CODEPAGE_932 is not set
    Parag> # CONFIG_NLS_CODEPAGE_949 is not set
    Parag> # CONFIG_NLS_CODEPAGE_874 is not set
    Parag> CONFIG_NLS_ISO8859_8=m
    Parag> # CONFIG_NLS_CODEPAGE_1250 is not set
    Parag> # CONFIG_NLS_CODEPAGE_1251 is not set
    Parag> # CONFIG_NLS_ASCII is not set
    Parag> CONFIG_NLS_ISO8859_1=m
    Parag> # CONFIG_NLS_ISO8859_2 is not set
    Parag> # CONFIG_NLS_ISO8859_3 is not set
    Parag> # CONFIG_NLS_ISO8859_4 is not set
    Parag> # CONFIG_NLS_ISO8859_5 is not set
    Parag> # CONFIG_NLS_ISO8859_6 is not set
    Parag> # CONFIG_NLS_ISO8859_7 is not set
    Parag> # CONFIG_NLS_ISO8859_9 is not set
    Parag> # CONFIG_NLS_ISO8859_13 is not set
    Parag> # CONFIG_NLS_ISO8859_14 is not set
    Parag> # CONFIG_NLS_ISO8859_15 is not set
    Parag> # CONFIG_NLS_KOI8_R is not set
    Parag> # CONFIG_NLS_KOI8_U is not set
    Parag> # CONFIG_NLS_UTF8 is not set

    Parag> #
    Parag> # Profiling support
    Parag> #
    Parag> # CONFIG_PROFILING is not set

    Parag> #
    Parag> # Kernel hacking
    Parag> #
    Parag> # CONFIG_PRINTK_TIME is not set
    Parag> CONFIG_DEBUG_KERNEL=y
    Parag> CONFIG_MAGIC_SYSRQ=y
    Parag> CONFIG_LOG_BUF_SHIFT=15
    Parag> # CONFIG_SCHEDSTATS is not set
    Parag> # CONFIG_DEBUG_SLAB is not set
    Parag> # CONFIG_DEBUG_PREEMPT is not set
    Parag> # CONFIG_DEBUG_SPINLOCK is not set
    Parag> # CONFIG_DEBUG_SPINLOCK_SLEEP is not set # CONFIG_DEBUG_KOBJECT is not
    Parag> set CONFIG_DEBUG_BUGVERBOSE=y # CONFIG_DEBUG_INFO is not set #
    Parag> CONFIG_DEBUG_FS is not set # CONFIG_FRAME_POINTER is not set
    Parag> CONFIG_EARLY_PRINTK=y # CONFIG_DEBUG_STACKOVERFLOW is not set #
    Parag> CONFIG_KPROBES is not set # CONFIG_DEBUG_STACK_USAGE is not set #
    Parag> CONFIG_DEBUG_PAGEALLOC is not set # CONFIG_4KSTACKS is not set
    Parag> CONFIG_X86_FIND_SMP_CONFIG=y CONFIG_X86_MPPARSE=y

    Parag> #
    Parag> # Security options
    Parag> #
    Parag> # CONFIG_KEYS is not set
    Parag> # CONFIG_SECURITY is not set

    Parag> #
    Parag> # Cryptographic options
    Parag> #
    Parag> CONFIG_CRYPTO=y
    Parag> CONFIG_CRYPTO_HMAC=y
    Parag> CONFIG_CRYPTO_NULL=m
    Parag> CONFIG_CRYPTO_MD4=m
    Parag> CONFIG_CRYPTO_MD5=y
    Parag> CONFIG_CRYPTO_SHA1=m
    Parag> CONFIG_CRYPTO_SHA256=m
    Parag> CONFIG_CRYPTO_SHA512=m
    Parag> CONFIG_CRYPTO_WP512=m
    Parag> CONFIG_CRYPTO_TGR192=m
    Parag> CONFIG_CRYPTO_DES=m
    Parag> CONFIG_CRYPTO_BLOWFISH=m
    Parag> CONFIG_CRYPTO_TWOFISH=m
    Parag> CONFIG_CRYPTO_SERPENT=m
    Parag> CONFIG_CRYPTO_AES_586=m
    Parag> CONFIG_CRYPTO_CAST5=m
    Parag> CONFIG_CRYPTO_CAST6=m
    Parag> CONFIG_CRYPTO_TEA=m
    Parag> CONFIG_CRYPTO_ARC4=m
    Parag> CONFIG_CRYPTO_KHAZAD=m
    Parag> CONFIG_CRYPTO_ANUBIS=m
    Parag> CONFIG_CRYPTO_DEFLATE=m
    Parag> CONFIG_CRYPTO_MICHAEL_MIC=m
    Parag> CONFIG_CRYPTO_CRC32C=m
    Parag> # CONFIG_CRYPTO_TEST is not set

    Parag> #
    Parag> # Hardware crypto devices
    Parag> #
    Parag> # CONFIG_CRYPTO_DEV_PADLOCK is not set

    Parag> #
    Parag> # Library routines
    Parag> #
    Parag> CONFIG_CRC_CCITT=m
    Parag> CONFIG_CRC32=m
    Parag> CONFIG_LIBCRC32C=m
    Parag> CONFIG_ZLIB_INFLATE=m
    Parag> CONFIG_ZLIB_DEFLATE=m
    Parag> CONFIG_GENERIC_HARDIRQS=y
    Parag> CONFIG_GENERIC_IRQ_PROBE=y
    Parag> CONFIG_X86_SMP=y
    Parag> CONFIG_X86_HT=y
    Parag> CONFIG_X86_BIOS_REBOOT=y
    Parag> CONFIG_X86_TRAMPOLINE=y
    Parag> CONFIG_PC=y

    Parag> -
    Parag> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
    Parag> in the body of a message to majordomo@vger.kernel.org More majordomo
    Parag> info at  http://vger.kernel.org/majordomo-info.html
    Parag> Please read the FAQ at  http://www.tux.org/lkml/



