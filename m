Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWEXVYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWEXVYj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 17:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWEXVYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 17:24:38 -0400
Received: from elasmtp-mealy.atl.sa.earthlink.net ([209.86.89.69]:24286 "EHLO
	elasmtp-mealy.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S932473AbWEXVYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 17:24:36 -0400
Message-ID: <4474CF11.4090007@netwolves.com>
Date: Wed, 24 May 2006 17:24:33 -0400
From: Steve Clark <sclark@netwolves.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.7.12) Gecko/20051110
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Steve Clark <sclark@dev.netwolves.com>, linux-kernel@vger.kernel.org,
       uClinux development list <uclinux-dev@uclinux.org>
Subject: Re: uclinux 2.4.32 panic
References: <44746064.30607@netwolves.com> <20060524201030.GU11191@w.ods.org>
In-Reply-To: <20060524201030.GU11191@w.ods.org>
Content-Type: multipart/mixed;
 boundary="------------050809020906010407000106"
X-ELNK-Trace: a437fbc6971e80f61aa676d7e74259b7b3291a7d08dfec79459e0556ca53606b31470575c67a7806350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 63.122.229.22
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050809020906010407000106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Willy Tarreau wrote:
> On Wed, May 24, 2006 at 09:32:20AM -0400, Steve Clark wrote:
> 
>>Hello,
>>
>>I realize this is uClinux - but I received no response from the 
>>uclinux-devel list so I am
>>posting here in the hope that someone will be kind enough to at least 
>>give me a
>>direction in which to proceed in trying to track down this panic. It 
>>only seems to
>>happen under heavy traffic - especially outbound, in other words 
>>ethernet to modem to internet.
>>
>>I am having trouble with cnxtserial.c causing a panic on an actiontec 
>>dualpc
>>modem. I've looked at the code but can't figure out how I can be 
>>getting a null pointer. I have very
>>limited experience working in the kernel so if anyone can give 
>>somethings to try I would appreciate
>>it. Below is the output from ksymoops of the panic.
> 
> 
> Could you please inform us about :
>   - the architecture (not obvious from the dump)
>   - the *exact* kernel version. uclinux and 2.4.32 are not enough. I
>     would guess 2.4.32-uc0, but I'm not sure that it's the only one.
>     Also, if you have other patches applied, please point to them.
>   - a list of the loaded modules and the .config
>   - how often it happens (every minutes, hours, days, weeks, ...) and
>     if you know an easy way to reproduce it (you only mentionned that
>     it *only* seems to happen in the circumstances above, but not if
>     it's guaranteed).
> 
> Of course, this will not guarantee that anybody will reply nor find
> the bug, but right now, it might discourage many people from searching.
> 
> 
>>Thanks,
>>Steve
> 
> 
> Regards,
> Willy
> 
> 
> 
>>ksymoops 2.4.11 on i686 2.6.16-1.2122_FC5.  Options used
>>      -v /home/sclark/actiontec/linux-2.4.32/vmlinux (specified)
>>      -K (specified)
>>      -L (specified)
>>      -O (specified)
>>      -m ../System.map (specified)
>>      -t elf32-littlearm -a armnommu
>>
>># Unable to handle kernel NULL pointer dereference at virtual address 
>>0000003f
>>Internal error: Oops: ffffffff
>>CPU: 0
>>pc : [<0090e5fc>]    lr : [<008727cc>]    Not tainted
>>sp : 0098bc14  ip : 7e17685d  fp : 0098bc38
>>r10: 00a10000  r9 : 173706d5  r8 : 800e000a
>>r7 : 08010100  r6 : 00dc08d0  r5 : 24108090  r4 : c914d625
>>r3 : 6c9c0a91  r2 : 00000018  r1 : 009922b8  r0 : c3400038
>>Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  Segment user
>>Control: C000107D
>>Process ksoftirqd_CPU0 (pid: 3, stackpage=0098b000)
>>0098bc00:          008727cc 0090e5fc 20000093  ffffffff 00000038 
>>00000000 00992
>>0098bc20: 00000038 00956228 20000013 0098bc6c  0098bc3c 008727cc 
>>0090e3b0 00000
>>0098bc40: 00000000 00992200 00000038 0099221c  0094ce68 00000000 
>>00000001 00a10
>>0098bc60: 0098bc98 0098bc70 008820e0 00872694  00992200 00a29760 
>>00a29760 00994
>>0098bc80: 00000034 00000000 009ea9e2 0098bcb0  0098bc9c 00882004 
>>00882024 00994
>>0098bca0: 00000000 0098bcc8 0098bcb4 008794f4  00881fd4 0000002f 
>>00a29760 0098b
>>0098bcc0: 0098bccc 008793c0 00879434 0098bcd4  00000001 009ea9e2 
>>00994d64 00994
>>0098bce0: 00000000 0094ce68 00994d60 00000000  0098bd1c 0098bd00 
>>00878e04 00878
>>0098bd00: 00a24080 009edec0 009edec0 00992400  0098bd44 0098bd20 
>>00878b60 00878
>>0098bd20: 00a24080 00992400 009edec0 00000000  008b7744 00000002 
>>0098bd60 0098b
>>0098bd40: 008a9c74 0087891c 0094ce68 0094ce60  00992400 0098bd80 
>>0098bd64 0089e
>>0098bd60: 008a9c1c 00000001 009edec0 00000000  00000000 0098bd9c 
>>0098bd84 008b7
>>0098bd80: 0089ea64 00000001 00000004 00992400  0098bde0 0098bda0 
>>008a8fec 008b7
>>0098bda0: 00992400 0098bdb0 008b7744 80000000  00964ac0 009edec0 
>>009edec0 009ed
>>0098bdc0: 00992400 0093ded4 008b4204 00000000  00000002 0098be08 
>>0098bde4 008b5
>>0098bde0: 008a8ea4 00992400 008b7744 80000000  009edec0 00000002 
>>00992400 0098b
>>0098be00: 0098be0c 008b4258 008b5730 00000001  0098be60 0098be20 
>>008a8fec 008b4
>>0098be20: 00992400 0098be30 008b4204 80000000  00964ab0 009edec0 
>>009edef0 009ed
>>0098be40: 000005f4 00992400 008b29e0 00000000  00000002 0098be8c 
>>0098be64 008b4
>>0098be60: 008a8ea4 00992400 008b4204 80000000  00a243a0 0093ded4 
>>009edec0 0093d
>>0098be80: 0098bebc 0098be90 008b2c08 008b3f38  0093ded4 00000005 
>>00000000 00000
>>0098bea0: 0093ded4 00000001 00000000 00000000  0098bf00 0098bec0 
>>008a8fec 008b2
>>0098bec0: 00000000 0098bed0 008b29e0 80000000  00964aa0 009edec0 
>>00000005 009ed
>>0098bee0: 009edec0 00965500 0093ded4 00036356  009381a0 0098bf38 
>>0098bf04 008b2
>>0098bf00: 008a8ea4 00000000 008b29e0 80000000  009edec0 0093fc1c 
>>009edec0 00000
>>0098bf20: 00000008 00000001 0098bf88 0098bf54  0098bf3c 0089f54c 
>>008b2284 0093d
>>0098bf40: 009381cc 009381ac 0098bf84 0098bf58  0089f65c 0089f2ec 
>>00000040 00938
>>0098bf60: 009381cc 009381a0 009381bc 00036356  60000013 0094d224 
>>0098bfb0 0098b
>>0098bf80: 0089f7dc 0089f5c4 0000012c 00938090  00000003 fffffff2 
>>0094ce60 00000
>>0098bfa0: 00938080 0098bfdc 0098bfb4 0081e090  0089f754 0098a000 
>>0098a000 0098a
>>0098bfc0: 0094ce60 00938d48 41029402 0080ae58  0098bffc 0098bfe0 
>>0081e70c 0081d
>>0098bfe0: 00000000 0097e000 0081e674 00945730  00000000 0098c000 
>>00810f28 0081e
>>Backtrace:
>>Function entered at [<0090e3a0>] from [<008727cc>]
>>  r9 = 20000013  r8 = 00956228  r7 = 00000038  r6 = 009922A0
>>  r5 = 00000000  r4 = 00000038
>>Function entered at [<00872684>] from [<008820e0>]
>>Function entered at [<00882014>] from [<00882004>]
>>Function entered at [<00881fc4>] from [<008794f4>]
>>  r5 = 00000000  r4 = 00994D60
>>Function entered at [<00879424>] from [<008793c0>]
>>  r5 = 00A29760  r4 = 0000002F
>>Function entered at [<00878ebc>] from [<00878e04>]
>>Function entered at [<00878d60>] from [<00878b60>]
>>  r7 = 00992400  r6 = 009EDEC0  r5 = 009EDEC0  r4 = 00A24080
>>Function entered at [<0087890c>] from [<008a9c74>]
>>Function entered at [<008a9c0c>] from [<0089ebf0>]
>>  r6 = 00992400  r5 = 0094CE60  r4 = 0094CE68
>>Function entered at [<0089ea54>] from [<008b781c>]
>>  r7 = 00000000  r6 = 00000000  r5 = 009EDEC0  r4 = 00000001
>>Function entered at [<008b7744>] from [<008a8fec>]
>>  r6 = 00992400  r5 = 00000004  r4 = 00000001
>>Function entered at [<008a8e94>] from [<008b58cc>]
>>Function entered at [<008b5720>] from [<008b4258>]
>>  r6 = 00992400  r5 = 00000002  r4 = 009EDEC0
>>Function entered at [<008b4204>] from [<008a8fec>]
>>  r4 = 00000001
>>Function entered at [<008a8e94>] from [<008b413c>]
>>Function entered at [<008b3f28>] from [<008b2c08>]
>>  r7 = 0093DED4  r6 = 009EDEC0  r5 = 0093DED4  r4 = 00A243A0
>>Function entered at [<008b29e0>] from [<008a8fec>]
>>  r6 = 00000000  r5 = 00000000  r4 = 00000001
>>Function entered at [<008a8e94>] from [<008b2768>]
>>Function entered at [<008b2274>] from [<0089f54c>]
>>  r8 = 0098BF88  r7 = 00000001  r6 = 00000008  r5 = 00000000
>>  r4 = 009EDEC0
>>Function entered at [<0089f2dc>] from [<0089f65c>]
>>  r6 = 009381AC  r5 = 009381CC  r4 = 0093DED4
>>Function entered at [<0089f5b4>] from [<0089f7dc>]
>>Function entered at [<0089f744>] from [<0081e090>]
>>Function entered at [<0081dfd8>] from [<0081e70c>]
>>Function entered at [<0081e674>] from [<00810f28>]
>>  r7 = 00945730  r6 = 0081E674  r5 = 0097E000  r4 = 00000000
>>Code: ba000003 e93113f8 (e92013f8) e2522020 aafffffb
>>Error (Oops_bfd_perror): /tmp/ksymoops.BYmaYB Invalid bfd target
>>
>>
>> >>LR;  008727cc <rs_write+148/294>
>>
>> >>PC;  0090e5fc <memmove+25c/460>   <=====
>>
>>Trace; 0090e3a0 <memcpy+0/0>
>>Trace; 008727cc <rs_write+148/294>
>>
>> >>r8; 00956228 <tmp_buf+0/1000>
>>
>>Trace; 00872684 <rs_write+0/294>
>>Trace; 008820e0 <ppp_async_push+cc/230>
>>Trace; 00882014 <ppp_async_push+0/230>
>>Trace; 00882004 <ppp_async_send+40/50>
>>Trace; 00881fc4 <ppp_async_send+0/50>
>>Trace; 008794f4 <ppp_push+d0/1b8>
>>Trace; 00879424 <ppp_push+0/1b8>
>>Trace; 008793c0 <ppp_send_frame+504/568>
>>Trace; 00878ebc <ppp_send_frame+0/568>
>>Trace; 00878e04 <ppp_xmit_process+a4/15c>
>>Trace; 00878d60 <ppp_xmit_process+0/15c>
>>Trace; 00878b60 <ppp_start_xmit+254/2c8>
>>Trace; 0087890c <ppp_start_xmit+0/2c8>
>>Trace; 008a9c74 <.gcc2_compiled.+68/100>
>>Trace; 008a9c0c <qdisc_restart+0/0>
>>Trace; 0089ebf0 <dev_queue_xmit+19c/3b0>
>>
>> >>r5; 0094ce60 <irq_stat+0/20>
>> >>r4; 0094ce68 <irq_stat+8/20>
>>
>>Trace; 0089ea54 <dev_queue_xmit+0/3b0>
>>Trace; 008b781c <ip_finish_output2+d8/150>
>>Trace; 008b7744 <ip_finish_output2+0/150>
>>Trace; 008a8fec <nf_hook_slow+158/1f0>
>>Trace; 008a8e94 <nf_hook_slow+0/1f0>
>>Trace; 008b58cc <ip_finish_output+1ac/1b8>
>>Trace; 008b5720 <ip_finish_output+0/1b8>
>>Trace; 008b4258 <ip_forward_finish+54/98>
>>Trace; 008b4204 <ip_forward_finish+0/98>
>>Trace; 008a8fec <nf_hook_slow+158/1f0>
>>Trace; 008a8e94 <nf_hook_slow+0/1f0>
>>Trace; 008b413c <.gcc2_compiled.+214/2dc>
>>Trace; 008b3f28 <ip_forward+0/0>
>>Trace; 008b2c08 <ip_rcv_finish+228/29c>
>>
>> >>r7; 0093ded4 <eth0_dev+0/164>
>> >>r5; 0093ded4 <eth0_dev+0/164>
>>
>>Trace; 008b29e0 <ip_rcv_finish+0/29c>
>>Trace; 008a8fec <nf_hook_slow+158/1f0>
>>Trace; 008a8e94 <nf_hook_slow+0/1f0>
>>Trace; 008b2768 <ip_rcv+4f4/568>
>>Trace; 008b2274 <ip_rcv+0/568>
>>Trace; 0089f54c <netif_receive_skb+270/2d8>
>>Trace; 0089f2dc <netif_receive_skb+0/2d8>
>>Trace; 0089f65c <process_backlog+a8/190>
>>
>> >>r6; 009381ac <softnet_data+c/1a0>
>> >>r5; 009381cc <softnet_data+2c/1a0>
>> >>r4; 0093ded4 <eth0_dev+0/164>
>>
>>Trace; 0089f5b4 <process_backlog+0/190>
>>Trace; 0089f7dc <net_rx_action+98/1bc>
>>Trace; 0089f744 <net_rx_action+0/1bc>
>>Trace; 0081e090 <__do_softirq+b8/15c>
>>Trace; 0081dfd8 <.gcc2_compiled.+0/0>
>>Trace; 0081e70c <ksoftirqd+98/cc>
>>Trace; 0081e674 <ksoftirqd+0/cc>
>>Trace; 00810f28 <arch_kernel_thread+38/44>
>>
>> >>r7; 00945730 <__machine_arch_type+0/4>
>> >>r6; 0081e674 <ksoftirqd+0/cc>
>>
>>Kernel panic: Aiee, killing interrupt handler
>>
>>1 error issued.  Results may not be reliable.
>>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 
Thanks for the tip Willy,

The hardware is the ActionTec DualPC Modem it has a conexant cx82100 
arm processor.
I can reproduce it at will by connecting to the internet and running 
nttcp thru it at the same time
I am scping file both ways from and to, and then finally starting a 
getty on /dev/ttyS0, the modem is
at ttyS1 and also ttyS0 is where all the kernel printk messages come out.

When I start the getty if I have all the other traffic going it 
usually will panic in under a minute. IF I don't
have the getty running it will run for hours and not panic.



2.4.32-uc0 with patches from
http://www.bettina-attack.de/jonny/view.php/projects/uclinux_on_cx82100/



--------------050809020906010407000106
Content-Type: text/plain;
 name="config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config"

#
# Automatically generated make config: don't edit
#
CONFIG_ARM=y
# CONFIG_SBUS is not set
CONFIG_UID16=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_UCLINUX=y
MAGIC_ROM_PTR=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
# CONFIG_OBSOLETE is not set

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# System Type
#
# CONFIG_ARCH_DSC21 is not set
# CONFIG_ARCH_VC547X is not set
# CONFIG_ARCH_DM270 is not set
CONFIG_ARCH_CNXT=y
# CONFIG_ARCH_NETARM is not set
# CONFIG_ARCH_TA7S is not set
# CONFIG_ARCH_TA7V is not set
# CONFIG_ARCH_SWARM is not set
# CONFIG_ARCH_INL is not set
# CONFIG_ARCH_SAMSUNG is not set
# CONFIG_ARCH_LPC is not set
# CONFIG_MACH_EB67XDIP is not set
# CONFIG_ARCH_ATMEL is not set
# CONFIG_MACH_UC5471DSP is not set
# CONFIG_MACH_SJ5471ENG is not set
# CONFIG_ARCH_IPOD is not set
# CONFIG_ARCH_WINBOND is not set
# CONFIG_CPU_BIG_ENDIAN is not set
# CONFIG_ARCH_P52 is not set
# CONFIG_ARCH_SPIPE is not set
CONFIG_ARCH_CX821XX=y
# CONFIG_BD_HASBANI is not set
# CONFIG_BD_HUMBER is not set
# CONFIG_BD_GOLDENGATE is not set
# CONFIG_BD_MACKINAC is not set
# CONFIG_BD_RUSHMORE is not set
CONFIG_BD_TIBURON=y
CONFIG_CHIP_CX82100=y
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE="root=/dev/mtdblock2 init=/linuxrc"
# CONFIG_SET_MEM_PARAM is not set
CONFIG_RAMKERNEL=y
# CONFIG_ROMKERNEL is not set
CONFIG_CPU_32=y
# CONFIG_CPU_26 is not set
CONFIG_CPU_ARM940T=y
CONFIG_NO_PGT_CACHE=y
CONFIG_CPU_WITH_CACHE=y
CONFIG_CPU_WITH_MCR_INSTRUCTION=y
DRAM_BASE=0x00800000
DRAM_SIZE=0x00780000
FLASH_MEM_BASE=0x00400000
FLASH_SIZE=0x00200000
CONFIG_CPU_ARM940_CPU_IDLE=y
CONFIG_CPU_ARM940_I_CACHE_ON=y
CONFIG_CPU_ARM940_D_CACHE_ON=y
CONFIG_CPU_ARM940_WRITETHROUGH=y

#
# General setup
#
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
CONFIG_NET=y
# CONFIG_SYSVIPC is not set
CONFIG_REDUCED_MEMORY=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_NWFPE is not set
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_FLAT=y
CONFIG_BINFMT_ZFLAT=y
CONFIG_KERNEL_ELF=y
# CONFIG_PM is not set
# CONFIG_ARTHUR is not set
# CONFIG_ALIGNMENT_TRAP is not set
# CONFIG_PCI is not set
# CONFIG_RAM_ATTACHED_ROMFS is not set

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
# CONFIG_FILTER is not set
# CONFIG_NET_NEIGH_DEBUG is not set
# CONFIG_NET_RESTRICTED_REUSE is not set
# CONFIG_UNIX is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_ARP_LIMIT is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_CONNTRACK_MARK=y
CONFIG_IP_NF_H323=y
CONFIG_IP_NF_AMANDA=y
CONFIG_IP_NF_TFTP=y
CONFIG_IP_NF_IRC=y
CONFIG_IP_NF_CT_PROTO_GRE=y
CONFIG_IP_NF_PPTP=y
# CONFIG_IP_NF_PPTP_DEBUG is not set
CONFIG_IP_NF_CT_ACCT=y
CONFIG_IP_NF_CONNTRACK_EVENTS=y
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_IPRANGE=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
CONFIG_IP_NF_MATCH_TIME=y
CONFIG_IP_NF_MATCH_RECENT=y
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_DSCP=y
CONFIG_IP_NF_MATCH_AH_ESP=y
CONFIG_IP_NF_MATCH_LENGTH=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNMARK=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
# CONFIG_IP_NF_MATCH_UNCLEAN is not set
# CONFIG_IP_NF_MATCH_STRING is not set
# CONFIG_IP_NF_MATCH_OWNER is not set
# CONFIG_IP_NF_MATCH_PHYSDEV is not set
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
# CONFIG_IP_NF_TARGET_MIRROR is not set
CONFIG_IP_NF_BIG_CONNTRACK=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_TARGET_NETMAP=y
CONFIG_IP_NF_NAT_H323=y
CONFIG_IP_NF_NAT_AMANDA=y
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_NAT_PPTP=y
CONFIG_IP_NF_NAT_PROTO_GRE=y
CONFIG_IP_NF_NAT_TFTP=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_ECN=y
CONFIG_IP_NF_TARGET_DSCP=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_IMQ=y
# CONFIG_IP_NF_TARGET_LOG is not set
CONFIG_IP_NF_TARGET_CONNMARK=y
# CONFIG_IP_NF_TARGET_CONNLOG is not set
# CONFIG_IP_NF_TARGET_ULOG is not set
CONFIG_IP_NF_TARGET_TCPMSS=y
# CONFIG_IP_NF_ARPTABLES is not set

#
#   IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set

#
#    SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set

#
#  
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
CONFIG_BRIDGE=y
# CONFIG_BRIDGE_NF_EBTABLES is not set
# CONFIG_BRIDGE_EBT_T_FILTER is not set
# CONFIG_BRIDGE_EBT_T_NAT is not set
# CONFIG_BRIDGE_EBT_BROUTE is not set
# CONFIG_BRIDGE_EBT_LOG is not set
# CONFIG_BRIDGE_EBT_IPF is not set
# CONFIG_BRIDGE_EBT_ARPF is not set
# CONFIG_BRIDGE_EBT_AMONG is not set
# CONFIG_BRIDGE_EBT_LIMIT is not set
# CONFIG_BRIDGE_EBT_VLANF is not set
# CONFIG_BRIDGE_EBT_802_3 is not set
# CONFIG_BRIDGE_EBT_PKTTYPE is not set
# CONFIG_BRIDGE_EBT_STP is not set
# CONFIG_BRIDGE_EBT_MARKF is not set
# CONFIG_BRIDGE_EBT_ARPREPLY is not set
# CONFIG_BRIDGE_EBT_SNAT is not set
# CONFIG_BRIDGE_EBT_DNAT is not set
# CONFIG_BRIDGE_EBT_REDIRECT is not set
# CONFIG_BRIDGE_EBT_MARK_T is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_IMQ is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_ARM_AM79C961A is not set
# CONFIG_ARM_CIRRUS is not set
# CONFIG_SUNLANCE is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set
CONFIG_CNXT_EMAC=y
CONFIG_CNXT_EMAC_82=y
# CONFIG_NUM_ETHERNET_IS_1 is not set
CONFIG_NUM_ETHERNET_IS_2=y
# CONFIG_NUM_ETHERNET_IS_3 is not set
# CONFIG_NUM_ETHERNET_IS_4 is not set
# CONFIG_FEC is not set
# CONFIG_CS89x0 is not set
# CONFIG_UCCS8900 is not set
# CONFIG_AX88796 is not set
# CONFIG_DM9000 is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=y
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=y
CONFIG_PPP_SYNC_TTY=y
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y
CONFIG_PPPOE=y
CONFIG_SLIP=y
# CONFIG_SLIP_COMPRESSED is not set
# CONFIG_SLIP_SMART is not set
# CONFIG_SLIP_MODE_SLIP6 is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ATA/IDE/MFM/RLL support
#
# CONFIG_IDE is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI support
#
# CONFIG_SCSI is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=y
# CONFIG_MTD_DEBUG is not set
CONFIG_MTD_PARTITIONS=y
# CONFIG_MTD_CONCAT is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# CONFIG_MTD_UCBOOTSTRAP_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_AFS_PARTS is not set

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=y
CONFIG_MTD_BLOCK=y
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=y
# CONFIG_MTD_CFI_STAA is not set
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# CONFIG_MTD_OBSOLETE_CHIPS is not set
# CONFIG_MTD_AMDSTD is not set
# CONFIG_MTD_SHARP is not set
# CONFIG_MTD_JEDEC is not set
# CONFIG_MTD_PSD4256G is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_PHYSMAP is not set
# CONFIG_MTD_UCBOOTSTRAP is not set
# CONFIG_MTD_DRAGONIX is not set
# CONFIG_MTD_NETtel is not set
# CONFIG_MTD_SNAPGEODE is not set
# CONFIG_MTD_NETteluC is not set
# CONFIG_MTD_MBVANILLA is not set
# CONFIG_MTD_MB_AUTO is not set
# CONFIG_MTD_ML401 is not set
# CONFIG_MTD_SUZAKU is not set
# CONFIG_MTD_KeyTechnology is not set
# CONFIG_MTD_SED_SIOSIII is not set
# CONFIG_MTD_NORA is not set
# CONFIG_MTD_ARM_INTEGRATOR is not set
# CONFIG_MTD_CDB89712 is not set
# CONFIG_MTD_SA1100 is not set
# CONFIG_MTD_DC21285 is not set
# CONFIG_MTD_IQ80310 is not set
# CONFIG_MTD_EPXA10DB is not set
# CONFIG_MTD_SMART is not set
# CONFIG_MTD_FORTUNET is not set
# CONFIG_MTD_AUTCPU12 is not set
# CONFIG_MTD_IXP425 is not set
# CONFIG_MTD_SE4000 is not set
# CONFIG_MTD_SNAPARM is not set
# CONFIG_MTD_DM270 is not set
# CONFIG_MTD_CLPS7500 is not set
# CONFIG_MTD_EDB7312 is not set
# CONFIG_MTD_EDB9301 is not set
# CONFIG_MTD_EDB9302 is not set
# CONFIG_MTD_EDB9312 is not set
# CONFIG_MTD_EDB9315 is not set
# CONFIG_MTD_IMPA7 is not set
# CONFIG_MTD_CEIVA is not set
# CONFIG_MTD_VC547X is not set
CONFIG_MTD_TIBURON=y
# CONFIG_MTD_EB67DIP is not set
# CONFIG_MTD_UCLINUX is not set
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_PCMCIA is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_MTDCNXT is not set
# CONFIG_MTD_BLKMTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOC1000 is not set
# CONFIG_MTD_DOC2000 is not set
# CONFIG_MTD_DOC2001 is not set
# CONFIG_MTD_DOC2001PLUS is not set
# CONFIG_MTD_DOCPROBE is not set

#
# NAND Flash Device Drivers
#
# CONFIG_MTD_NAND is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_CISS_MONITOR_THREAD is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_BLK_DEV_RAMDISK_DATA is not set
# CONFIG_BLK_DEV_BLKMEM is not set
# CONFIG_BLK_STATS is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_QFMT_V2 is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_JBD_DEBUG is not set
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_YAFFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_TMPFS is not set
CONFIG_RAMFS=y
# CONFIG_ISO9660_FS is not set
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
# CONFIG_DEVPTS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
CONFIG_ROMFS_FS=y
# CONFIG_EXT2_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_XFS_FS is not set
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_TRACE is not set
# CONFIG_XFS_DEBUG is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
# CONFIG_ZISOFS_FS is not set
# CONFIG_COREDUMP_PRINTK is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
# CONFIG_SMB_NLS is not set
# CONFIG_NLS is not set

#
# Input core support
#
# CONFIG_INPUT is not set
# CONFIG_INPUT_KEYBDEV is not set
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_SERIAL_CNXT=y
# CONFIG_SERIAL_SPIPE is not set
# CONFIG_CNXT_FLASH is not set
CONFIG_LEDMAN=y
# CONFIG_SNAPDOG is not set
# CONFIG_FAST_TIMER is not set
# CONFIG_DS1302 is not set
# CONFIG_M41T11M6 is not set
# CONFIG_VT is not set
# CONFIG_SERIAL is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_ANAKIN is not set
# CONFIG_SERIAL_ANAKIN_CONSOLE is not set
# CONFIG_SERIAL_AMBA is not set
# CONFIG_SERIAL_AMBA_CONSOLE is not set
# CONFIG_SERIAL_CLPS711X is not set
# CONFIG_SERIAL_CLPS711X_CONSOLE is not set
# CONFIG_SERIAL_21285 is not set
# CONFIG_SERIAL_21285_OLD is not set
# CONFIG_SERIAL_21285_CONSOLE is not set
# CONFIG_SERIAL_UART00 is not set
# CONFIG_SERIAL_UART00_CONSOLE is not set
# CONFIG_SERIAL_SA1100 is not set
# CONFIG_SERIAL_SA1100_CONSOLE is not set
# CONFIG_SERIAL_OMAHA is not set
# CONFIG_SERIAL_OMAHA_CONSOLE is not set
# CONFIG_SERIAL_AT91 is not set
# CONFIG_SERIAL_AT91_CONSOLE is not set
# CONFIG_SERIAL_8250 is not set
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_MULTIPORT is not set
# CONFIG_SERIAL_8250_HUB6 is not set
# CONFIG_UNIX98_PTYS is not set

#
# SPI support
#
# CONFIG_SPI is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_MOUSE is not set
# CONFIG_EDB7312_TS is not set

#
# Joysticks
#
# CONFIG_INPUT_GAMEPORT is not set

#
# Input core support is needed for gameports
#

#
# Input core support is needed for joysticks
#
# CONFIG_QIC02_TAPE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
# CONFIG_IPMI_KCS is not set
# CONFIG_IPMI_WATCHDOG is not set

#
# Controller Area Network Cards/Chips
#
# CONFIG_CAN4LINUX is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_PCWATCHDOG is not set
# CONFIG_COLDFIRE_WATCHDOG is not set
# CONFIG_21285_WATCHDOG is not set
# CONFIG_977_WATCHDOG is not set
# CONFIG_SA1100_WATCHDOG is not set
# CONFIG_EPXA_WATCHDOG is not set
# CONFIG_OMAHA_WATCHDOG is not set
# CONFIG_AT91_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I810_TCO is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_60XX_WDT is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_SCx200_WDT is not set
CONFIG_SOFT_WATCHDOG=y
# CONFIG_W83877F_WDT is not set
# CONFIG_WDT is not set
# CONFIG_WDTPCI is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_TA7_WDT is not set
# CONFIG_SCx200 is not set
# CONFIG_SCx200_GPIO is not set
# CONFIG_AMD_PM768 is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set

#
# Direct Rendering Manager (XFree86 DRI support)
#
# CONFIG_DRM is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Support for USB gadgets
#
# CONFIG_USB_GADGET is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Kernel hacking
#
CONFIG_FRAME_POINTER=y
# CONFIG_REVISIT is not set
# CONFIG_DEBUG_ERRORS is not set
# CONFIG_DEBUG_USER is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_DEBUG_LL is not set
CONFIG_CONTIGUOUS_PAGE_ALLOC=y
CONFIG_MEM_MAP=y
# CONFIG_UNCACHED_MEM is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y

--------------050809020906010407000106--
