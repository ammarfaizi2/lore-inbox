Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbTEKQII (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 12:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbTEKQII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 12:08:08 -0400
Received: from tomts15.bellnexxia.net ([209.226.175.3]:37565 "EHLO
	tomts15-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261727AbTEKQIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 12:08:05 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: akpm@digeo.com, davem@redhat.com, linux-mm@kvack.org
Subject: Re: Slab corruption mm3 + davem fixes
Date: Sun, 11 May 2003 12:21:25 -0400
User-Agent: KMail/1.5.9
References: <20030511031940.97C24251B@oscar.casa.dyndns.org>
In-Reply-To: <20030511031940.97C24251B@oscar.casa.dyndns.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305111221.26048.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am also seeing this on 69-bk (as of Sunday morning)

Ed

On May 10, 2003 11:19 pm, Ed Tomlinson wrote:
> Hi,
>
> I looked at my logs and found the following error in it.  My kernel is
> 69-mm3 with two davem fixes on it.
>
> May 10 22:41:06 oscar kernel:
> ***************************************************************************
>**********
> ***************************************************************************
>****************************************
> ***************************************************************************
>****************************************
> ***************************************************************************
>****************************************
> ***************************************************************************
>****************************************
> ***************************************************************************
>****************************************
> ***************************************************************************
>****************************************
> ***************************************************************************
>****************************************
> ***************************************************************************
>****************************** May 10 22:41:06 oscar kernel:
> **********************************************************************A5
> May 10 22:41:06 oscar kernel: Call Trace:
> May 10 22:41:06 oscar kernel:  [__slab_error+30/32] __slab_error+0x1e/0x20
> May 10 22:41:06 oscar kernel:  [check_poison_obj+376/384]
> check_poison_obj+0x178/0x180 May 10 22:41:06 oscar kernel: 
> [kmalloc+221/392] kmalloc+0xdd/0x188 May 10 22:41:06 oscar kernel: 
> [alloc_skb+64/240] alloc_skb+0x40/0xf0 May 10 22:41:06 oscar kernel: 
> [alloc_skb+64/240] alloc_skb+0x40/0xf0 May 10 22:41:06 oscar kernel: 
> [skb_copy+45/204] skb_copy+0x2d/0xcc May 10 22:41:06 oscar kernel: 
> [_end+615445203/1070187180] skb_ip_make_writable+0xcf/0x164 [iptable_nat]
> May 10 22:41:06 oscar kernel:  [cache_init_objs+71/308]
> cache_init_objs+0x47/0x134 May 10 22:41:06 oscar kernel: 
> [_end+615444563/1070187180] icmp_reply_translation+0x33/0x1e4 [iptable_nat]
> May 10 22:41:06 oscar kernel:  [_end+615450270/1070187180]
> gcc2_compiled.+0xc2/0x1d8 [iptable_nat] May 10 22:41:06 oscar kernel: 
> [_end+615450641/1070187180] ip_nat_out+0x5d/0x64 [iptable_nat] May 10
> 22:41:06 oscar kernel:  [ip_finish_output2+0/416]
> ip_finish_output2+0x0/0x1a0 May 10 22:41:06 oscar kernel: 
> [nf_iterate+63/156] nf_iterate+0x3f/0x9c May 10 22:41:06 oscar kernel: 
> [ip_finish_output2+0/416] ip_finish_output2+0x0/0x1a0 May 10 22:41:06 oscar
> kernel:  [nf_hook_slow+149/296] nf_hook_slow+0x95/0x128 May 10 22:41:06
> oscar kernel:  [ip_finish_output2+0/416] ip_finish_output2+0x0/0x1a0 May 10
> 22:41:06 oscar kernel:  [_end+615462636/1070187180] ip_nat_out_ops+0x0/0x1c
> [iptable_nat] May 10 22:41:06 oscar kernel:  [ip_output+535/544]
> ip_output+0x217/0x220 May 10 22:41:06 oscar kernel: 
> [ip_finish_output2+0/416] ip_finish_output2+0x0/0x1a0 May 10 22:41:06 oscar
> kernel:  [nf_hook_slow+149/296] nf_hook_slow+0x95/0x128 May 10 22:41:06
> oscar kernel:  [ip_forward_finish+39/60] ip_forward_finish+0x27/0x3c May 10
> 22:41:06 oscar kernel:  [nf_hook_slow+208/296] nf_hook_slow+0xd0/0x128 May
> 10 22:41:06 oscar kernel:  [ip_forward+490/564] ip_forward+0x1ea/0x234 May
> 10 22:41:06 oscar kernel:  [ip_forward_finish+0/60]
> ip_forward_finish+0x0/0x3c May 10 22:41:06 oscar kernel: 
> [ip_rcv_finish+441/512] ip_rcv_finish+0x1b9/0x200 May 10 22:41:06 oscar
> kernel:  [nf_hook_slow+208/296] nf_hook_slow+0xd0/0x128 May 10 22:41:06
> oscar kernel:  [ip_rcv+924/984] ip_rcv+0x39c/0x3d8 May 10 22:41:06 oscar
> kernel:  [ip_rcv_finish+0/512] ip_rcv_finish+0x0/0x200 May 10 22:41:06
> oscar kernel:  [netif_receive_skb+283/332] netif_receive_skb+0x11b/0x14c
> May 10 22:41:06 oscar kernel:  [process_backlog+113/292]
> process_backlog+0x71/0x124 May 10 22:41:06 oscar kernel: 
> [net_rx_action+114/328] net_rx_action+0x72/0x148 May 10 22:41:06 oscar
> kernel:  [do_softirq+82/172] do_softirq+0x52/0xac May 10 22:41:06 oscar
> kernel:  [local_bh_enable+82/108] local_bh_enable+0x52/0x6c May 10 22:41:06
> oscar kernel:  [_end+614250407/1070187180] ppp_asynctty_receive+0x4f/0x84
> [ppp_async] May 10 22:41:06 oscar kernel:  [pty_write+237/336]
> pty_write+0xed/0x150 May 10 22:41:06 oscar kernel:  [write_chan+424/516]
> write_chan+0x1a8/0x204 May 10 22:41:06 oscar kernel: 
> [default_wake_function+0/24] default_wake_function+0x0/0x18 May 10 22:41:06
> oscar kernel:  [default_wake_function+0/24] default_wake_function+0x0/0x18
> May 10 22:41:06 oscar kernel:  [tty_write+515/708] tty_write+0x203/0x2c4
> May 10 22:41:06 oscar kernel:  [write_chan+0/516] write_chan+0x0/0x204 May
> 10 22:41:06 oscar kernel:  [vfs_write+162/208] vfs_write+0xa2/0xd0 May 10
> 22:41:06 oscar kernel:  [sys_write+46/76] sys_write+0x2e/0x4c May 10
> 22:41:06 oscar kernel:  [syscall_call+7/11] syscall_call+0x7/0xb May 10
> 22:41:06 oscar kernel:
>
> And with an ipchains based firewall:
>
> May  9 19:55:54 oscar kernel:
> ***************************************************************************
>**********
> ***************************************************************************
>****************************************
> ***************************************************************************
>****************************************
> ***************************************************************************
>****************************************
> ***************************************************************************
>****************************************
> ***************************************************************************
>****************************************
> ***************************************************************************
>****************************************
> ***************************************************************************
>****************************************
> ***************************************************************************
>****************************** May  9 19:55:54 oscar kernel:
> **********************************************************************A5
> May  9 19:55:54 oscar kernel: Call Trace:
> May  9 19:55:55 oscar kernel:  [__slab_error+30/32] __slab_error+0x1e/0x20
> May  9 19:55:55 oscar kernel:  [check_poison_obj+376/384]
> check_poison_obj+0x178/0x180 May  9 19:55:55 oscar kernel: 
> [kmalloc+221/392] kmalloc+0xdd/0x188 May  9 19:55:55 oscar kernel: 
> [alloc_skb+64/240] alloc_skb+0x40/0xf0 May  9 19:55:55 oscar kernel: 
> [alloc_skb+64/240] alloc_skb+0x40/0xf0 May  9 19:55:55 oscar kernel: 
> [_end+547372157/1070273676] icmp_manip_pkt+0x45/0x64 [ipchains] May  9
> 19:55:55 oscar kernel:  [skb_copy+45/204] skb_copy+0x2d/0xcc May  9
> 19:55:55 oscar kernel:  [_end+547367523/1070273676]
> skb_ip_make_writable+0xcf/0x164 [ipchains] May  9 19:55:55 oscar kernel: 
> [_end+547367236/1070273676] icmp_reply_translation+0x194/0x1e4 [ipchains]
> May  9 19:55:55 oscar kernel:  [_end+547366883/1070273676]
> icmp_reply_translation+0x33/0x1e4 [ipchains] May  9 19:55:55 oscar kernel: 
> [_end+547362523/1070273676] check_for_demasq+0xbb/0x1bc [ipchains] May  9
> 19:55:55 oscar kernel:  [_end+547400300/1070273676]
> ip_conntrack_protocol_icmp+0x0/0x40 [ipchains] May  9 19:55:55 oscar
> kernel:  [_end+547359450/1070273676] fw_in+0x162/0x2b8 [ipchains] May  9
> 19:55:55 oscar kernel:  [_end+547400948/1070273676] ipfw_ops+0x0/0x18
> [ipchains] May  9 19:55:55 oscar kernel:  [_end+547359672/1070273676]
> fw_in+0x240/0x2b8 [ipchains] May  9 19:55:55 oscar kernel: 
> [nf_iterate+63/156] nf_iterate+0x3f/0x9c May  9 19:55:55 oscar kernel: 
> [ip_rcv_finish+0/512] ip_rcv_finish+0x0/0x200 May  9 19:55:55 oscar kernel:
>  [nf_hook_slow+149/296] nf_hook_slow+0x95/0x128 May  9 19:55:55 oscar
> kernel:  [ip_rcv_finish+0/512] ip_rcv_finish+0x0/0x200 May  9 19:55:55
> oscar kernel:  [_end+547400364/1070273676] preroute_ops+0x0/0x1c [ipchains]
> May  9 19:55:55 oscar kernel:  [ip_rcv+924/984] ip_rcv+0x39c/0x3d8 May  9
> 19:55:55 oscar kernel:  [ip_rcv_finish+0/512] ip_rcv_finish+0x0/0x200 May 
> 9 19:55:55 oscar kernel:  [netif_receive_skb+283/332]
> netif_receive_skb+0x11b/0x14c May  9 19:55:55 oscar kernel: 
> [process_backlog+113/292] process_backlog+0x71/0x124 May  9 19:55:55 oscar
> kernel:  [net_rx_action+114/328] net_rx_action+0x72/0x148 May  9 19:55:55
> oscar kernel:  [do_softirq+82/172] do_softirq+0x52/0xac May  9 19:55:55
> oscar kernel:  [local_bh_enable+82/108] local_bh_enable+0x52/0x6c May  9
> 19:55:55 oscar kernel:  [_end+547215751/1070273676]
> ppp_asynctty_receive+0x4f/0x84 [ppp_async] May  9 19:55:55 oscar kernel: 
> [pty_write+237/336] pty_write+0xed/0x150 May  9 19:55:55 oscar kernel: 
> [write_chan+424/516] write_chan+0x1a8/0x204 May  9 19:55:55 oscar kernel: 
> [default_wake_function+0/24] default_wake_function+0x0/0x18 May  9 19:55:55
> oscar kernel:  [default_wake_function+0/24] default_wake_function+0x0/0x18
> May  9 19:55:55 oscar kernel:  [tty_write+515/708] tty_write+0x203/0x2c4
> May  9 19:55:55 oscar kernel:  [write_chan+0/516] write_chan+0x0/0x204 May 
> 9 19:55:55 oscar kernel:  [vfs_write+162/208] vfs_write+0xa2/0xd0 May  9
> 19:55:55 oscar kernel:  [sys_write+46/76] sys_write+0x2e/0x4c May  9
> 19:55:55 oscar kernel:  [syscall_call+7/11] syscall_call+0x7/0xb May  9
> 19:55:55 oscar kernel:
>
> Hope this helps,
> Ed Tomlinson
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"aart@kvack.org"> aart@kvack.org </a>
