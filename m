Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267400AbUJNTsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267400AbUJNTsy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 15:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267396AbUJNTqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 15:46:39 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:17915 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S267417AbUJNTmE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 15:42:04 -0400
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U1
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041014143131.GA20258@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	 <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu>
	 <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
	 <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
	 <20041014143131.GA20258@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1097782921.5310.10.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 14 Oct 2004 12:42:01 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This was during NFS startup in init.



using smp_processor_id() in preemptible [00000001] code:
rpc.rquotad/2158
caller is ipt_do_table+0x7b/0x3a0
 [<c011aa15>] smp_processor_id+0x95/0xa0
 [<c038cbfb>] ipt_do_table+0x7b/0x3a0
 [<c038aa8b>] ip_ct_refresh_acct+0xb/0x80
 [<c038f1d4>] ipt_local_hook+0x74/0xc0
 [<c034d73a>] nf_iterate+0x5a/0xa0
 [<c035af00>] dst_output+0x0/0x40
 [<c034da3c>] nf_hook_slow+0x5c/0x100
 [<c035af00>] dst_output+0x0/0x40
 [<c035aaf4>] ip_push_pending_frames+0x414/0x480
 [<c035af00>] dst_output+0x0/0x40
 [<c0377c88>] udp_push_pending_frames+0x148/0x260
 [<c0378178>] udp_sendmsg+0x378/0x6e0
 [<c0134c73>] __mcount+0x13/0x20
 [<c037f7bc>] inet_sendmsg+0x3c/0x60
 [<c03397d8>] sock_sendmsg+0xb8/0xe0
 [<c0134c73>] __mcount+0x13/0x20
 [<c0134c73>] __mcount+0x13/0x20
 [<c0113d30>] mcount+0x14/0x18
 [<c020172a>] __copy_from_user_ll+0xa/0x40
 [<c0133d00>] autoremove_wake_function+0x0/0x60
 [<c03391ef>] move_addr_to_kernel+0x2f/0x60
 [<c033ab36>] sys_sendto+0xd6/0x100
 [<c033d144>] sock_common_setsockopt+0x24/0x40
 [<c0134c73>] __mcount+0x13/0x20
 [<c020172a>] __copy_from_user_ll+0xa/0x40
 [<c0201803>] copy_from_user+0x43/0x80
 [<c0113d30>] mcount+0x14/0x18
 [<c020172a>] __copy_from_user_ll+0xa/0x40
 [<c033b297>] sys_socketcall+0xf7/0x180
 [<c01176a0>] do_page_fault+0x0/0x62a
 [<c0105357>] syscall_call+0x7/0xb


