Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbWECNpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWECNpg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 09:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbWECNpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 09:45:36 -0400
Received: from mail-a02.ithnet.com ([217.64.83.97]:48591 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S1030208AbWECNpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 09:45:35 -0400
X-Sender-Authentication: net64
Date: Wed, 3 May 2006 15:45:32 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org,
       ja@ssi.bg
Subject: Re: Linux 2.6.16.13 / Problem
Message-Id: <20060503154532.a0963c65.skraw@ithnet.com>
In-Reply-To: <20060502222827.GA29287@kroah.com>
References: <20060502222827.GA29287@kroah.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

unfortunately I see some problem regarding 2.6.16.13:

May  3 13:28:02 web-a02 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
May  3 13:28:02 web-a02 kernel:  printing eip:
May  3 13:28:02 web-a02 kernel: c01513a3
May  3 13:28:02 web-a02 kernel: *pde = 00000000
May  3 13:28:02 web-a02 kernel: Oops: 0002 [#1]
May  3 13:28:02 web-a02 kernel: Modules linked in: speedstep_lib freq_table ipv6 nfs lockd sunrpc hw_random intel_agp agpgart e100 mii e1000
May  3 13:28:02 web-a02 kernel: CPU:    0
May  3 13:28:02 web-a02 kernel: EIP:    0060:[cache_reap+197/370]    Not tainted VLI
May  3 13:28:02 web-a02 kernel: EIP:    0060:[<c01513a3>]    Not tainted VLI
May  3 13:28:02 web-a02 kernel: EFLAGS: 00010046   (2.6.16.13 #1)
May  3 13:28:02 web-a02 kernel: EIP is at cache_reap+0xc5/0x172
May  3 13:28:02 web-a02 kernel: eax: 00000000   ebx: f7c2f6c0   ecx: f3c2f6d0   edx: 00000000
May  3 13:28:02 web-a02 kernel: esi: 00000002   edi: f7c2c740   ebp: f7c2c788   esp: c2129efc
May  3 13:28:02 web-a02 kernel: ds: 007b   es: 007b   ss: 0068
May  3 13:28:02 web-a02 kernel: Process events/0 (pid: 4, threadinfo=c2128000 task=c2108a70)
May  3 13:28:02 web-a02 kernel: Stack: <0>f7c2c740 f7f97220 00000000 00000000 f7c2f6d0 00000000 c03d92a4 00000296
May  3 13:28:02 web-a02 kernel:        c20ef6c0 00000000 c01276e3 00000000 00000000 cb301600 c20ef6d8 c20ef6c8
May  3 13:28:02 web-a02 kernel:        c01512de c20ef6d0 c2129f88 c20ef6c8 c2128000 c012789d c20ef6c0 c2129f68
May  3 13:28:02 web-a02 kernel: Call Trace:
May  3 13:28:02 web-a02 kernel:  [run_workqueue+96/195] run_workqueue+0x60/0xc3
May  3 13:28:02 web-a02 kernel:  [<c01276e3>] run_workqueue+0x60/0xc3   
May  3 13:28:02 web-a02 kernel:  [cache_reap+0/370] cache_reap+0x0/0x172
May  3 13:28:02 web-a02 kernel:  [<c01512de>] cache_reap+0x0/0x172
May  3 13:28:02 web-a02 kernel:  [worker_thread+343/370] worker_thread+0x157/0x172
May  3 13:28:02 web-a02 kernel:  [<c012789d>] worker_thread+0x157/0x172
May  3 13:28:02 web-a02 kernel:  [default_wake_function+0/18] default_wake_function+0x0/0x12
May  3 13:28:02 web-a02 kernel:  [<c0116549>] default_wake_function+0x0/0x12
May  3 13:28:02 web-a02 kernel:  [default_wake_function+0/18] default_wake_function+0x0/0x12
May  3 13:28:02 web-a02 kernel:  [<c0116549>] default_wake_function+0x0/0x12  
May  3 13:28:02 web-a02 kernel:  [worker_thread+0/370] worker_thread+0x0/0x172
May  3 13:28:02 web-a02 kernel:  [<c0127746>] worker_thread+0x0/0x172
May  3 13:28:02 web-a02 kernel:  [kthread+158/200] kthread+0x9e/0xc8
May  3 13:28:02 web-a02 kernel:  [<c012a6ea>] kthread+0x9e/0xc8  
May  3 13:28:02 web-a02 kernel:  [kthread+0/200] kthread+0x0/0xc8
May  3 13:28:02 web-a02 kernel:  [<c012a64c>] kthread+0x0/0xc8
May  3 13:28:02 web-a02 kernel:  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb
May  3 13:28:02 web-a02 kernel:  [<c0101345>] kernel_thread_helper+0x5/0xb
May  3 13:28:02 web-a02 kernel: Code: 83 ea 01 89 d0 31 d2 f7 f1 89 c6 8d 43 10 89 44 24 10 8b 4b 10 3b 4c 24 10 74 73 8b 41 10 85 c0 0f 85 a5 00 00 00 8b 01 8b 51 04 <89> 50 04 89 02 c7 41 04 00 02 20 00 c7 01 00 01 10 00 8b 43 18
May  3 13:28:02 web-a02 kernel:  BUG: events/0/4, lock held at task exit time!
May  3 13:28:02 web-a02 kernel:  [c033c980] {cache_chain_mutex}
May  3 13:28:02 web-a02 kernel: .. held by:          events/0:    4 [c2108a70, 110] 
May  3 13:28:02 web-a02 kernel: ... acquired at:               cache_reap+0x11/0x172


And again:

May  3 14:09:14 web-a02 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
May  3 14:09:14 web-a02 kernel:  printing eip:
May  3 14:09:14 web-a02 kernel: c0150ad8
May  3 14:09:14 web-a02 kernel: *pde = 00000000
May  3 14:09:14 web-a02 kernel: Oops: 0002 [#2]
May  3 14:09:14 web-a02 kernel: Modules linked in: speedstep_lib freq_table ipv6 nfs lockd sunrpc hw_random intel_agp agpgart e100 mii e1000
May  3 14:09:14 web-a02 kernel: CPU:    0
May  3 14:09:14 web-a02 kernel: EIP:    0060:[cache_alloc_refill+214/505]    Not tainted VLI
May  3 14:09:14 web-a02 kernel: EIP:    0060:[<c0150ad8>]    Not tainted VLI
May  3 14:09:14 web-a02 kernel: EFLAGS: 00010046   (2.6.16.13 #1)
May  3 14:09:14 web-a02 kernel: EIP is at cache_alloc_refill+0xd6/0x1f9
May  3 14:09:14 web-a02 kernel: eax: 00000000   ebx: 00000010   ecx: 00000000   edx: 00000000
May  3 14:09:14 web-a02 kernel: esi: f3c2f6d0   edi: 0000000a   ebp: f7cc29c0   esp: f151be90
May  3 14:09:14 web-a02 kernel: ds: 007b   es: 007b   ss: 0068
May  3 14:09:14 web-a02 kernel: Process pickup (pid: 12756, threadinfo=f151a000 task=f1520a70)
May  3 14:09:14 web-a02 kernel: Stack: <0>f7c2c740 f3c2f6d0 00000000 f7c2f6c8 f7c2f6c0 00000296 f7c2c740 00000001
May  3 14:09:14 web-a02 kernel:        c035a800 c0150dab f7c2c740 000000d0 00000000 c027ce32 f7c2c740 000000d0
May  3 14:09:14 web-a02 kernel:        00000000 f7eb471c 00000001 c027a06d c20e2340 00000000 f14ca980 00000001
May  3 14:09:14 web-a02 kernel: Call Trace:
May  3 14:09:14 web-a02 kernel:  [kmem_cache_alloc+62/64] kmem_cache_alloc+0x3e/0x40
May  3 14:09:14 web-a02 kernel:  [<c0150dab>] kmem_cache_alloc+0x3e/0x40
May  3 14:09:14 web-a02 kernel:  [sk_alloc+34/183] sk_alloc+0x22/0xb7
May  3 14:09:14 web-a02 kernel:  [<c027ce32>] sk_alloc+0x22/0xb7
May  3 14:09:14 web-a02 kernel:  [sock_alloc_inode+24/89] sock_alloc_inode+0x18/0x59
May  3 14:09:14 web-a02 kernel:  [<c027a06d>] sock_alloc_inode+0x18/0x59
May  3 14:09:14 web-a02 kernel:  [unix_create1+68/235] unix_create1+0x44/0xeb
May  3 14:09:14 web-a02 kernel:  [<c02da22e>] unix_create1+0x44/0xeb
May  3 14:09:14 web-a02 kernel:  [new_inode+26/130] new_inode+0x1a/0x82
May  3 14:09:14 web-a02 kernel:  [<c016b6e6>] new_inode+0x1a/0x82
May  3 14:09:14 web-a02 kernel:  [unix_create+81/117] unix_create+0x51/0x75
May  3 14:09:14 web-a02 kernel:  [<c02da326>] unix_create+0x51/0x75
May  3 14:09:14 web-a02 kernel:  [__sock_create+200/403] __sock_create+0xc8/0x193
May  3 14:09:14 web-a02 kernel:  [<c027b16f>] __sock_create+0xc8/0x193
May  3 14:09:14 web-a02 kernel:  [sock_create+47/51] sock_create+0x2f/0x33
May  3 14:09:14 web-a02 kernel:  [<c027b269>] sock_create+0x2f/0x33
May  3 14:09:14 web-a02 kernel:  [sys_socket+40/85] sys_socket+0x28/0x55
May  3 14:09:14 web-a02 kernel:  [<c027b2c8>] sys_socket+0x28/0x55
May  3 14:09:14 web-a02 kernel:  [sys_socketcall+595/600] sys_socketcall+0x253/0x258
May  3 14:09:14 web-a02 kernel:  [<c027c20c>] sys_socketcall+0x253/0x258
May  3 14:09:14 web-a02 kernel:  [do_page_fault+0/1370] do_page_fault+0x0/0x55a
May  3 14:09:14 web-a02 kernel:  [<c01145f1>] do_page_fault+0x0/0x55a
May  3 14:09:14 web-a02 kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
May  3 14:09:14 web-a02 kernel:  [<c0102cd7>] sysenter_past_esp+0x54/0x75
May  3 14:09:14 web-a02 kernel: Code: 24 04 8b 44 24 28 89 04 24 e8 78 fd ff ff 89 44 9d 10 8b 54 24 28 8b 42 1c 39 46 10 73 08 83 ef 01 83 ff ff 75 c9 8b 56 04 8b 06 <89> 50 04 89 02 c7 46 04 00 02 20 00 83 7e 14 ff c7 06 00 01 10

The same box runs flawlessly with 2.6.16.11. A completely identical box runs 2.6.16.12 without problems.
The kernel is only patched with hidden-2.6.12-1.diff from Julian (as .11 and .12).

The box looks like:

0000:00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
0000:00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02)
0000:00:03.0 PCI bridge: Intel Corp. 82875P Processor to PCI to CSA Bridge (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 82801EB USB (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801EB USB (rev 02)
0000:00:1d.2 USB Controller: Intel Corp. 82801EB USB (rev 02)
0000:00:1d.3 USB Controller: Intel Corp. 82801EB USB (rev 02)
0000:00:1d.7 USB Controller: Intel Corp. 82801EB USB2 (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corp. 82801EB LPC Interface Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801EB SMBus Controller (rev 02)
0000:02:01.0 Ethernet controller: Intel Corp. 82547EI Gigabit Ethernet Controller (LOM)
0000:03:00.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
0000:03:02.0 Ethernet controller: Intel Corp. 82541EI Gigabit Ethernet Controller (Copper)
0000:03:07.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
0000:03:08.0 Ethernet controller: Intel Corp.: Unknown device 1051 (rev 02)


cpu:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.66GHz
stepping        : 9
cpu MHz         : 2673.054
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips        : 5354.15

If you need further infos feel free to ask.

Regards,
Stephan



On Tue, 2 May 2006 15:28:27 -0700
Greg KH <gregkh@suse.de> wrote:

> We (the -stable team) are announcing the release of the 2.6.16.13
> kernel.
> 
> The diffstat and short summary of the fixes are below.
> 
> I'll also be replying to this message with a copy of the patch between
> 2.6.16.12 and 2.6.16.13, as it is small enough to do so.
> 
> The updated 2.6.16.y git tree can be found at:
>  	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
> and can be browsed at the normal kernel.org git web browser:
> 	www.kernel.org/git/
> 
> thanks,
> 
> greg k-h
> 
> --------
> 
>  Makefile                                     |    2 +-
>  net/ipv4/netfilter/ip_conntrack_proto_sctp.c |   11 +++++++----
>  net/netfilter/nf_conntrack_proto_sctp.c      |   11 +++++++----
>  3 files changed, 15 insertions(+), 9 deletions(-)
> 
> Summary of changes from v2.6.16.12 to v2.6.16.13
> ================================================
> 
> Greg Kroah-Hartman:
>       Linux 2.6.16.13
> 
> Patrick McHardy:
>       NETFILTER: SCTP conntrack: fix infinite loop (CVE-2006-1527)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

