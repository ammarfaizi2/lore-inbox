Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161336AbWALV67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161336AbWALV67 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 16:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161338AbWALV67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 16:58:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18855 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161335AbWALV66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 16:58:58 -0500
Date: Thu, 12 Jan 2006 13:58:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.15-mm3
Message-Id: <20060112135839.2e74d8a8.akpm@osdl.org>
In-Reply-To: <200601122205.04714.rjw@sisk.pl>
References: <20060111042135.24faf878.akpm@osdl.org>
	<200601122205.04714.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> Hi,
> 
> On Wednesday, 11 January 2006 13:21, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm3/
> 
> I got that on system shutdown (x86-64, 1 CPU):

Thanks.   ipv6 died.  I think shemminger had a recent problem with ipv6 too?

I don't think there were any core networking changes in -mm3 which weren't
in linus-at-that-time.

> Unable to handle kernel NULL pointer dereference at 00000000000001b4 RIP:
> <ffffffff881cba51>{:ipv6:ip6_xmit+593}
> PGD 2441f067 PUD 231b1067 PMD 0
> Oops: 0000 [1] PREEMPT
> CPU 0
> Modules linked in: ipt_LOG ipt_limit ipt_pkttype ipt_state ipt_REJECT iptable_mangle iptable_nat iptable_filter ip6table_mangle ip_nat_ftp
> ip_nat ip_conntrack_ftp ip_conntrack ip_tables ip6table_filter ip6_tables ipv6 usbserial thermal processor fan button battery ac snd_pcm_os
> s snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc af_packet pcmcia firmware_class yen
> ta_socket rsrc_nonstatic pcmcia_core usbhid ehci_hcd ohci_hcd sk98lin evdev joydev sg st sr_mod sd_mod scsi_mod ide_cd cdrom dm_mod parport
> _pc lp parport
> Pid: 18912, comm: kcminit Not tainted 2.6.15-mm3 #25
> RIP: 0010:[<ffffffff881cba51>] <ffffffff881cba51>{:ipv6:ip6_xmit+593}
> RSP: 0018:ffffffff80489cc8  EFLAGS: 00010246
> RAX: ffff810029a47658 RBX: ffff810029a47658 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff80489d50 RDI: ffff810001f33e00
> RBP: ffffffff80489d28 R08: 0000000000000000 R09: 0000000000000080
> R10: ffff8100201a9f5c R11: ffffffff80489d40 R12: ffff810001f33dd8
> R13: 0000000000000000 R14: ffffffff80489d38 R15: 0000000000000014
> FS:  00002aaaae769de0(0000) GS:ffffffff80515000(0000) knlGS:000000005617d560
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 00000000000001b4 CR3: 00000000249eb000 CR4: 00000000000006e0
> Process kcminit (pid: 18912, threadinfo ffff8100233ca000, task ffff810028afa090)
> Stack: ffff810029a476a0 ffff8100201a9e60 0000000000000000 00000000881cb324
>        ffff810029a47658 ffffffff80489d40 0600000180489d48 ffff810029a476a0
>        ffffffff80489d40 ffff810001f33e00
> Call Trace: <IRQ> <ffffffff881e9aad>{:ipv6:tcp_v6_send_reset+525}
>        <ffffffff80361dd8>{inet6_lookup_listener+264} <ffffffff881ec8e2>{:ipv6:tcp_v6_rcv+1842}
>        <ffffffff881ccd48>{:ipv6:ip6_input+568} <ffffffff881cd14f>{:ipv6:ipv6_rcv+527}
>        <ffffffff8030283b>{netif_receive_skb+635} <ffffffff80302939>{process_backlog+153}
>        <ffffffff803014c3>{net_rx_action+179} <ffffffff80135f10>{__do_softirq+80}
>        <ffffffff8010fd12>{call_softirq+30}  <EOI> <ffffffff801116e5>{do_softirq+53}
>        <ffffffff801361b2>{local_bh_enable+114} <ffffffff80302fc7>{dev_queue_xmit+583}
>        <ffffffff8030971f>{neigh_resolve_output+639} <ffffffff881cbf82>{:ipv6:ip6_output2+562}
>        <ffffffff881c9d40>{:ipv6:dst_output+0} <ffffffff881cc7cd>{:ipv6:ip6_output+2045}
>        <ffffffff881cbaeb>{:ipv6:ip6_xmit+747} <ffffffff881f0f21>{:ipv6:inet6_csk_xmit+769}
>        <ffffffff803357ff>{tcp_transmit_skb+1743} <ffffffff802fe4ff>{__alloc_skb+127}
>        <ffffffff80335e43>{tcp_connect+723} <ffffffff881eba49>{:ipv6:tcp_v6_connect+1529}
>        <ffffffff80148d33>{__mutex_init+83} <ffffffff803652d8>{_spin_unlock_bh+24}
>        <ffffffff8034871f>{inet_stream_connect+207} <ffffffff803652d8>{_spin_unlock_bh+24}
>        <ffffffff802fa369>{lock_sock+201} <ffffffff803652d8>{_spin_unlock_bh+24}
>        <ffffffff80180b0a>{fget+170} <ffffffff802f92ac>{sys_connect+140}
>        <ffffffff802f8022>{sys_setsockopt+162} <ffffffff8010ec9e>{system_call+126}
> 
> 
> Code: 41 8b 95 b4 01 00 00 89 90 98 00 00 00 48 8b 45 a8 8b 58 40
> RIP <ffffffff881cba51>{:ipv6:ip6_xmit+593} RSP <ffffffff80489cc8>
> CR2: 00000000000001b4
>  <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
>  <4>atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
> atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
> atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
> atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be trying access hardware directly.
> 
> and so on forever.
> 
> Greetings,
> Rafael
