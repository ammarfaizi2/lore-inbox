Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbUJYAM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbUJYAM4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 20:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbUJYAM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 20:12:56 -0400
Received: from smtp07.auna.com ([62.81.186.17]:31437 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S261630AbUJYAMw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 20:12:52 -0400
Date: Mon, 25 Oct 2004 00:12:51 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.9-mm1
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
References: <20041022032039.730eb226.akpm@osdl.org>
In-Reply-To: <20041022032039.730eb226.akpm@osdl.org> (from akpm@osdl.org on
	Fri Oct 22 12:20:39 2004)
X-Mailer: Balsa 2.2.5
Message-Id: <1098663171l.6459l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.10.22, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9/2.6.9-mm1/
> 

I suppose this is from the preempt debug code:

Oct 24 23:23:21 werewolf kernel: using smp_processor_id() in preemptible code: pump/4673
Oct 24 23:23:21 werewolf kernel:  [smp_processor_id+135/147] smp_processor_id+0x87/0x93
Oct 24 23:23:22 werewolf kernel:  [<b0116b5e>] smp_processor_id+0x87/0x93
Oct 24 23:23:22 werewolf kernel:  [pg0+1080536608/1338123264] destroy_conntrack+0xc1/0x118 [ip_conntrack]
Oct 24 23:23:22 werewolf kernel:  [<f0a56e20>] destroy_conntrack+0xc1/0x118 [ip_conntrack]
Oct 24 23:23:22 werewolf kernel:  [pg0+1080542311/1338123264] ip_ct_selective_cleanup+0x48/0x6a [ip_conntrack]
Oct 24 23:23:22 werewolf kernel:  [<f0a58467>] ip_ct_selective_cleanup+0x48/0x6a [ip_conntrack]
Oct 24 23:23:22 werewolf kernel:  [pg0+1080509266/1338123264] masq_inet_event+0x14/0x17 [ipt_MASQUERADE]
Oct 24 23:23:22 werewolf kernel:  [<f0a50352>] masq_inet_event+0x14/0x17 [ipt_MASQUERADE]
Oct 24 23:23:22 werewolf kernel:  [notifier_call_chain+21/43] notifier_call_chain+0x15/0x2b
Oct 24 23:23:22 werewolf kernel:  [<b0126cfb>] notifier_call_chain+0x15/0x2b
Oct 24 23:23:22 werewolf kernel:  [inet_insert_ifa+206/335] inet_insert_ifa+0xce/0x14f
Oct 24 23:23:22 werewolf kernel:  [<b02c1bb4>] inet_insert_ifa+0xce/0x14f
Oct 24 23:23:22 werewolf kernel:  [.text.lock.devinet+85/182] .text.lock.devinet+0x55/0xb6
Oct 24 23:23:22 werewolf kernel:  [<b02c3653>] .text.lock.devinet+0x55/0xb6
Oct 24 23:23:22 werewolf kernel:  [devinet_ioctl+1273/1614] devinet_ioctl+0x4f9/0x64e
Oct 24 23:23:22 werewolf kernel:  [<b02c2663>] devinet_ioctl+0x4f9/0x64e
Oct 24 23:23:22 werewolf kernel:  [inet_ioctl+212/231] inet_ioctl+0xd4/0xe7
Oct 24 23:23:22 werewolf kernel:  [<b02c45cb>] inet_ioctl+0xd4/0xe7
Oct 24 23:23:22 werewolf kernel:  [sock_ioctl+424/609] sock_ioctl+0x1a8/0x261
Oct 24 23:23:22 werewolf kernel:  [<b028155d>] sock_ioctl+0x1a8/0x261
Oct 24 23:23:22 werewolf kernel:  [fget+73/94] fget+0x49/0x5e
Oct 24 23:23:22 werewolf kernel:  [<b01532ec>] fget+0x49/0x5e
Oct 24 23:23:22 werewolf kernel:  [sys_ioctl+489/581] sys_ioctl+0x1e9/0x245
Oct 24 23:23:22 werewolf kernel:  [<b016354c>] sys_ioctl+0x1e9/0x245
Oct 24 23:23:22 werewolf kernel:  [filp_close+72/138] filp_close+0x48/0x8a
Oct 24 23:23:22 werewolf kernel:  [<b0151bcb>] filp_close+0x48/0x8a
Oct 24 23:23:22 werewolf kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Oct 24 23:23:22 werewolf kernel:  [<b0103da5>] sysenter_past_esp+0x52/0x71


--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-jam1 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1


