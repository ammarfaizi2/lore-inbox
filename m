Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275856AbRI1G7W>; Fri, 28 Sep 2001 02:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275855AbRI1G7M>; Fri, 28 Sep 2001 02:59:12 -0400
Received: from mail.spylog.com ([194.67.35.220]:42156 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S275856AbRI1G67>;
	Fri, 28 Sep 2001 02:58:59 -0400
Date: Fri, 28 Sep 2001 10:59:19 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: Hubert Mantel <mantel@suse.de>, Andrea Arcangeli <andrea@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bug report: linux-2.4.10.SuSE-0.tar.bz2
Message-ID: <20010928105919.B2517@spylog.ru>
Mail-Followup-To: Hubert Mantel <mantel@suse.de>,
	Andrea Arcangeli <andrea@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010926004612.A6621@spylog.ru> <20010926115449.L17951@suse.de> <20010926225958.A27526@spylog.ru> <20010927113145.H22554@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20010927113145.H22554@suse.de>
User-Agent: Mutt/1.3.22i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Hardware: 1.5Gb RAM/Mylex Acceleraid 250(Mylex DAC960PTL1)/2CPU-PIII

Kernel: 2.4.10.SuSE-0K-4GB-SMP

dmesg:

...
Adding Swap: 2048248k swap-space (priority -1)
__alloc_pages: 0-order allocation failed (gfp=0x20/0)
e032be24 e02b45c0 00000000 00000020 00000000 00000020 e298f960 00000246 
00000020 00000001 e0315a6c e0315bc4 00000020 00000000 e013914e 00000000 
e01395da e0134cb1 e298f960 00000000 e298f9d8 00000020	e298f9d8 00000020 
Call Trace: [<e013914e>] [<e01395da>] [<e0134cb1>] [<e0135bbc>] [<e01c7716>] 
[<e024c26a>] [<e02703f3>] [<e0270dd4>] [<e0270c38>] [<e012220d>] [<e01222f0>] 
[<e011d604>] [<e011d4d9>] [<e011d25f>] [<e0108f45>]	[<e0105290>] [<e0105290>] 
[<e0105290>] [<e0105290>] [<e01052bc>] [<e0105322>] [<e0105000>] [<e010509a>] 
__alloc_pages: 0-order allocation failed (gfp=0x20/0)
e032be34 e02b45c0 00000000 00000020 00000000 00000020 e298f720 00000246 
00000020 00000001 e0315a6c e0315bc4 00000020 00000000 e013914e 00000000 
e01395da e0134cb1 e298f720 00000000 e298f798 00000020 e298f798 00000020 
Call Trace: [<e013914e>] [<e01395da>] [<e0134cb1>] [<e0135bbc>]
[<e024c26a>] [<e01f6ec7>] [<e0114000>] [<e01f6729>] [<e0114050>]
[<e0108ba3>] [<e0108e9d>] [<e0105290>] [<e0105290>] [<e0105290>] [<e0105290>]
[<e01052bc>] [<e0105322>] [<e0105000>] [<e010509a>] 

ksymoops -m /boot/System.map
 
Trace; e013914e <_alloc_pages+16/18>
Trace; e01395da <__get_free_pages+a/18>
Trace; e0134cb1 <kmem_cache_grow+149/4a0>
Trace; e0135bbc <kmalloc+31c/348>
Trace; e024c26a <alloc_skb+102/1c8>
Trace; e02703f3 <tcp_send_ack+23/cc>
Trace; e0270dd4 <tcp_delack_timer+19c/228>
Trace; e0270c38 <tcp_delack_timer+0/228>
Trace; e012220d <timer_bh+301/3c4>
Trace; e01219fe <tqueue_bh+16/1c>
Trace; e011d604 <bh_action+50/108>
Trace; e011d4d9 <tasklet_hi_action+6d/a0>
Trace; e011d25f <do_softirq+6f/cc>
Trace; e0108f45 <do_IRQ+1b1/1c0>
Trace; e029fd68 <stext_lock+ec0/7a85>
Trace; e01147c7 <do_page_fault+2eb/904>
Trace; e01144dc <do_page_fault+0/904>
Trace; e0248e23 <sock_read+8b/98>
Trace; e015612d <do_fcntl+1f1/404>
Trace; e0116e98 <sys_sched_setscheduler+14/18>
Trace; e01075d4 <error_code+34/3c>

Trace; e013914e <_alloc_pages+16/18>
Trace; e01395da <__get_free_pages+a/18>
Trace; e0134cb1 <kmem_cache_grow+149/4a0>
Trace; e0135888 <kmem_cache_alloc+2e4/2fc>
Trace; e0121e1c <update_process_times+20/9c>
Trace; e012302c <send_signal+2c/100>
Trace; e012311d <deliver_signal+1d/fc>
Trace; e01232cf <send_sig_info+d3/128>
Trace; e0124331 <sys_rt_sigqueueinfo+119/130>
Trace; e01074e3 <system_call+33/38>



PS: Previous incindent with this kernel: can't get "ps ax" output and
    "cat /proc/$uid/cmdline". Just hang.

-- 
bye.
Andrey Nekrasov, SpyLOG.
