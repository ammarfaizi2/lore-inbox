Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271400AbTHDHPq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 03:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271401AbTHDHPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 03:15:46 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:53263 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S271400AbTHDHPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 03:15:45 -0400
Message-Id: <200308040706.h74763j10508@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Brandon Stewart <rbrandonstewart@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Hang after "Freeing unused kernel memory" with 2.6 test2
Date: Mon, 4 Aug 2003 10:15:34 +0300
X-Mailer: KMail [version 1.3.2]
References: <3F2DF155.3040102@yahoo.com>
In-Reply-To: <3F2DF155.3040102@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's been a while since I tried to compile a kernel, but I did a good 
> effort searching for already existing answers to my situation, so I feel 
> I'm in a somewhat unique situation.
> 
> As the title says, booting up the kernel hangs after
> Mounted devfs on /dev
> Freeing unused kernel memory: 144k freed
> 
> Magic sysreq gives me (painfully transcribed):
> 
> SysRq : Show Regs
> 
> Pid: 1, comm:                 init
> EIP: 0060:[<c012634a>] CPU:0
> EIP is at force_sig_info+0x4a/0x100
>  EFLAGS: 00000282    Not tainted
> EAX: 00000000 EBX: c14cd840 ECX: 00000002 EDX: 00000000
> ESI: 00000004 EDI: c010c6e0 EBP: c14cff18 DS: 007b ES: 007b
> CR0: 8005003b CR2: 4006e950 CR3: 1dd8d000 CR4: 00000080
> Call Trace:
>  [<c010c6e0>] do_invalid_op+0x0/0xb0
>  [<c010c747>] do_invalid_op+0x67/0xb0
>  [<c012517e>] do_timer+0xfe/0x110
>  [<c012517e>] do_timer+0xfe/0x110
>  [<c0111236>] timer_interrupt+0xe6/0xf0
>  [<c0121563>] do_softirq+0xb3/0xc0
>  [<c010c6e0>] do_invalid_op+0x0/0xb0
>  [<c010bdcd>] error_code+0x2d/0x40
> 
> CTRL-ALT-DEL works, so the system isn't totally hung. But no other 
> evidence of activity.

Probably a SIGILL shower is raining on you. Your /sbin/init
is causing it. I had one when I tried to run 686 one on
a 486 box ;)
--
vda
