Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269563AbUI3V6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269563AbUI3V6u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 17:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269535AbUI3V6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 17:58:50 -0400
Received: from smtp09.auna.com ([62.81.186.19]:6300 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S269563AbUI3V6I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 17:58:08 -0400
Date: Thu, 30 Sep 2004 21:58:04 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: Stack traces in 2.6.9-rc2-mm4
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
References: <6.1.2.0.2.20040927184123.019b48b8@tornado.reub.net>
	<20040927085744.GA32407@elte.hu> <1096326753l.5222l.2l@werewolf.able.es>
	<20040928072123.GA15177@elte.hu>
In-Reply-To: <20040928072123.GA15177@elte.hu> (from mingo@elte.hu on Tue Sep
	28 09:21:23 2004)
X-Mailer: Balsa 2.2.4
Message-Id: <1096581484l.9853l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.09.28, Ingo Molnar wrote:
> 
> * J.A. Magallon <jamagallon@able.es> wrote:
> 
> > I got the same on another place...
> > 

Well, one more (I hope this at least serves to clean the kernel...).
This time using pump over 3c59x:

03:0a.0 Ethernet controller: 3Com Corporation 3c980-C 10/100baseTX NIC [Python-T] (rev 78)

Sep 30 23:54:41 werewolf pumpd[9843]: intf: numDns: 2
Sep 30 23:54:41 werewolf pumpd[9843]: intf: broadcast: 255.255.255.255
Sep 30 23:54:41 werewolf pumpd[9843]: intf: network: 82.198.40.0
Sep 30 23:54:41 werewolf kernel: using smp_processor_id() in preemptible code: pump/9843
Sep 30 23:54:41 werewolf kernel:  [smp_processor_id+135/141] smp_processor_id+0x87/0x8d
Sep 30 23:54:41 werewolf kernel:  [<b011bc8f>] smp_processor_id+0x87/0x8d
Sep 30 23:54:41 werewolf kernel:  [pg0+1079594592/1337930752] death_by_timeout+0x11/0x65 [ip_conntrack]
Sep 30 23:54:41 werewolf kernel:  [<f099fe60>] death_by_timeout+0x11/0x65 [ip_conntrack]
Sep 30 23:54:41 werewolf kernel:  [pg0+1079600227/1337930752] ip_ct_selective_cleanup+0x68/0x6a [ip_conntrack]
Sep 30 23:54:41 werewolf kernel:  [<f09a1463>] ip_ct_selective_cleanup+0x68/0x6a [ip_conntrack]
Sep 30 23:54:41 werewolf kernel:  [pg0+1077916498/1337930752] masq_inet_event+0x14/0x17 [ipt_MASQUERADE]
Sep 30 23:54:41 werewolf kernel:  [<f0806352>] masq_inet_event+0x14/0x17 [ipt_MASQUERADE]
Sep 30 23:54:41 werewolf kernel:  [notifier_call_chain+21/43] notifier_call_chain+0x15/0x2b
Sep 30 23:54:41 werewolf kernel:  [<b012cc43>] notifier_call_chain+0x15/0x2b
Sep 30 23:54:41 werewolf kernel:  [inet_insert_ifa+206/335] inet_insert_ifa+0xce/0x14f
Sep 30 23:54:41 werewolf kernel:  [<b02dcf96>] inet_insert_ifa+0xce/0x14f
Sep 30 23:54:41 werewolf kernel:  [.text.lock.devinet+85/181] .text.lock.devinet+0x55/0xb5
Sep 30 23:54:41 werewolf kernel:  [<b02de9dc>] .text.lock.devinet+0x55/0xb5
Sep 30 23:54:41 werewolf kernel:  [devinet_ioctl+1273/1614] devinet_ioctl+0x4f9/0x64e
Sep 30 23:54:41 werewolf kernel:  [<b02dda37>] devinet_ioctl+0x4f9/0x64e
Sep 30 23:54:41 werewolf kernel:  [inet_ioctl+212/231] inet_ioctl+0xd4/0xe7
Sep 30 23:54:41 werewolf kernel:  [<b02df95b>] inet_ioctl+0xd4/0xe7
Sep 30 23:54:41 werewolf kernel:  [sock_ioctl+424/609] sock_ioctl+0x1a8/0x261
Sep 30 23:54:41 werewolf kernel:  [<b029e30a>] sock_ioctl+0x1a8/0x261
Sep 30 23:54:41 werewolf kernel:  [fget+73/94] fget+0x49/0x5e
Sep 30 23:54:41 werewolf kernel:  [<b01577f7>] fget+0x49/0x5e
Sep 30 23:54:41 werewolf kernel:  [sys_ioctl+489/581] sys_ioctl+0x1e9/0x245
Sep 30 23:54:41 werewolf kernel:  [<b0167410>] sys_ioctl+0x1e9/0x245
Sep 30 23:54:41 werewolf kernel:  [filp_close+72/138] filp_close+0x48/0x8a
Sep 30 23:54:41 werewolf kernel:  [<b015613d>] filp_close+0x48/0x8a
Sep 30 23:54:41 werewolf kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Sep 30 23:54:41 werewolf kernel:  [<b0103fc5>] sysenter_past_esp+0x52/0x71
Sep 30 23:54:41 werewolf kernel: using smp_processor_id() in preemptible code: pump/9843
Sep 30 23:54:41 werewolf kernel:  [smp_processor_id+135/141] smp_processor_id+0x87/0x8d
Sep 30 23:54:41 werewolf kernel:  [<b011bc8f>] smp_processor_id+0x87/0x8d
Sep 30 23:54:41 werewolf kernel:  [pg0+1079594488/1337930752] destroy_conntrack+0xc1/0x118 [ip_conntrack]
Sep 30 23:54:41 werewolf kernel:  [<f099fdf8>] destroy_conntrack+0xc1/0x118 [ip_conntrack]
Sep 30 23:54:41 werewolf kernel:  [pg0+1079600195/1337930752] ip_ct_selective_cleanup+0x48/0x6a [ip_conntrack]
Sep 30 23:54:41 werewolf kernel:  [<f09a1443>] ip_ct_selective_cleanup+0x48/0x6a [ip_conntrack]
Sep 30 23:54:41 werewolf kernel:  [pg0+1077916498/1337930752] masq_inet_event+0x14/0x17 [ipt_MASQUERADE]
Sep 30 23:54:41 werewolf kernel:  [<f0806352>] masq_inet_event+0x14/0x17 [ipt_MASQUERADE]
Sep 30 23:54:41 werewolf kernel:  [notifier_call_chain+21/43] notifier_call_chain+0x15/0x2b
Sep 30 23:54:41 werewolf kernel:  [<b012cc43>] notifier_call_chain+0x15/0x2b
Sep 30 23:54:41 werewolf kernel:  [inet_insert_ifa+206/335] inet_insert_ifa+0xce/0x14f
Sep 30 23:54:41 werewolf kernel:  [<b02dcf96>] inet_insert_ifa+0xce/0x14f
Sep 30 23:54:41 werewolf kernel:  [.text.lock.devinet+85/181] .text.lock.devinet+0x55/0xb5
Sep 30 23:54:41 werewolf kernel:  [<b02de9dc>] .text.lock.devinet+0x55/0xb5
Sep 30 23:54:41 werewolf kernel:  [devinet_ioctl+1273/1614] devinet_ioctl+0x4f9/0x64e
Sep 30 23:54:41 werewolf kernel:  [<b02dda37>] devinet_ioctl+0x4f9/0x64e
Sep 30 23:54:41 werewolf kernel:  [inet_ioctl+212/231] inet_ioctl+0xd4/0xe7
Sep 30 23:54:41 werewolf kernel:  [<b02df95b>] inet_ioctl+0xd4/0xe7
Sep 30 23:54:41 werewolf kernel:  [sock_ioctl+424/609] sock_ioctl+0x1a8/0x261
Sep 30 23:54:41 werewolf kernel:  [<b029e30a>] sock_ioctl+0x1a8/0x261
Sep 30 23:54:41 werewolf kernel:  [fget+73/94] fget+0x49/0x5e
Sep 30 23:54:41 werewolf kernel:  [<b01577f7>] fget+0x49/0x5e
Sep 30 23:54:41 werewolf kernel:  [sys_ioctl+489/581] sys_ioctl+0x1e9/0x245
Sep 30 23:54:41 werewolf kernel:  [<b0167410>] sys_ioctl+0x1e9/0x245
Sep 30 23:54:41 werewolf kernel:  [filp_close+72/138] filp_close+0x48/0x8a
Sep 30 23:54:41 werewolf kernel:  [<b015613d>] filp_close+0x48/0x8a
Sep 30 23:54:41 werewolf kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Sep 30 23:54:41 werewolf kernel:  [<b0103fc5>] sysenter_past_esp+0x52/0x71

And I aldo get many times this one:

Sep 30 23:54:41 werewolf kernel: ACPI: PCI interrupt 0000:03:0a.0[A] -> GSI 22 (level, low) -> IRQ 22

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc2-mm4 (gcc 3.4.1 (Mandrakelinux (Alpha 3.4.1-3mdk)) #1


