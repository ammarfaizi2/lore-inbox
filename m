Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWB0WCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWB0WCW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWB0WCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:02:22 -0500
Received: from solarneutrino.net ([66.199.224.43]:62218 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S932347AbWB0WCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:02:21 -0500
Date: Mon, 27 Feb 2006 15:37:41 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: lockd: couldn't create RPC handle for (host)
Message-ID: <20060227203740.GB10719@tau.solarneutrino.net>
References: <20051217055907.GC20539@tau.solarneutrino.net> <1134801822.7946.4.camel@lade.trondhjem.org> <20051217070222.GD20539@tau.solarneutrino.net> <1134847699.7950.25.camel@lade.trondhjem.org> <20051217194553.GE20539@tau.solarneutrino.net> <1134894836.7931.17.camel@lade.trondhjem.org> <20051218180150.GF20539@tau.solarneutrino.net> <1134934267.7966.37.camel@lade.trondhjem.org> <20051218200052.GA21665@tau.solarneutrino.net> <1134944665.11596.9.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1134944665.11596.9.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2005 at 05:24:24PM -0500, Trond Myklebust wrote:
> OK. I think this client patch ought to fix the Oopses. It should apply
> to a 2.6.14 kernel as well as 2.6.15-rc5.

Oops still occurs with 2.6.15.4.

Unable to handle kernel paging request at 0000000100000011 RIP: 
<ffffffff801c3424>{nlmclnt_mark_reclaim+67}
PGD 7bc9b067 PUD 0 
Oops: 0000 [1] 
CPU 0 
Modules linked in:
Pid: 2210, comm: lockd Not tainted 2.6.15.4 #3
RIP: 0010:[<ffffffff801c3424>] <ffffffff801c3424>{nlmclnt_mark_reclaim+67}
RSP: 0018:ffff81007ddf9e70  EFLAGS: 00010206
RAX: 00000000fffffff9 RBX: ffff81007f35a540 RCX: ffff81007ecb5980
RDX: ffff81007ecb5988 RSI: 0000000000000053 RDI: ffff81007f35a540
RBP: ffff81007f8e1800 R08: 00000000fffffffa R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000010 R15: ffffffff803bb460
FS:  00002aaaab00c4a0(0000) GS:ffffffff80489800(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000100000011 CR3: 000000007bc9a000 CR4: 00000000000006e0
Process lockd (pid: 2210, threadinfo ffff81007ddf8000, task ffff81007ed261c0)
Stack: ffffffff801c34db ffff81007f35a540 ffffffff801ca1a6 3256cc8459020002 
       0000000000000000 0000000000000004 ffff81007ec94000 ffff81007ec940a0 
       ffffffff803bc4e0 ffff810061626014 
Call Trace:<ffffffff801c34db>{nlmclnt_recovery+139} <ffffffff801ca1a6>{nlm4svc_proc_sm_notify+188}
       <ffffffff803149d7>{svc_process+871} <ffffffff801c5089>{lockd+344}
       <ffffffff801c4f31>{lockd+0} <ffffffff801c4f31>{lockd+0}
       <ffffffff8010dfaa>{child_rip+8} <ffffffff801c4f31>{lockd+0}
       <ffffffff801c4f31>{lockd+0} <ffffffff8010dfa2>{child_rip+0}
       

Code: 48 39 78 18 75 13 8b 81 8c 00 00 00 a8 01 74 09 83 c8 02 89 
RIP <ffffffff801c3424>{nlmclnt_mark_reclaim+67} RSP <ffff81007ddf9e70>
CR2: 0000000100000011

-ryan
