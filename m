Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266687AbUGVQBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266687AbUGVQBD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 12:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266697AbUGVQBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 12:01:03 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.20.8]:44419 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266687AbUGVQBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 12:01:00 -0400
Date: Thu, 22 Jul 2004 18:00:55 +0200
From: Rudo Thomas <rudo@matfyz.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: scheduling while atomic (Re: voluntary-preempt-2.6.8-rc2-H9)
Message-ID: <20040722160055.GA4837@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org
References: <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721183010.GA2206@yoda.timesys> <20040721210051.GA2744@yoda.timesys> <20040721211826.GB30871@elte.hu> <20040721223749.GA2863@yoda.timesys> <20040722100657.GA14909@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722100657.GA14909@elte.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there.

I finally managed to try out the voluntary preemption patch (H9 on 2.6.8-rc2).

The syslog got flooded by these

bad: ksoftirqd/0(2) scheduling while atomic (1)!
[<c0244529>] schedule+0x529/0x560
[<c0115444>] try_to_wake_up+0xa4/0xc0
[<c0121190>] process_timeout+0x0/0x10
[<c0121190>] process_timeout+0x0/0x10
[<c011677a>] cond_resched_softirq+0x3a/0x60
[<c0120ed0>] run_timer_softirq+0xd0/0x1b0
[<c011d1d0>] ksoftirqd+0x0/0xc0
[<c011ce3d>] ___do_softirq+0x7d/0x90
[<c011ce96>] _do_softirq+0x6/0x10
[<c011d238>] ksoftirqd+0x68/0xc0
[<c012b565>] kthread+0xa5/0xb0
[<c012b4c0>] kthread+0x0/0xb0
[<c0103d91>] kernel_thread_helper+0x5/0x14

Is this by any means normal?

If it is, can these messages be turned off? (Note that I want to have
CONFIG_DEBUG_KERNEL on to be able to use the magic SysRq key.)

Bye for now.

Rudo.
