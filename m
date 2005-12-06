Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbVLFR5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbVLFR5S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 12:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbVLFR5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 12:57:18 -0500
Received: from solarneutrino.net ([66.199.224.43]:41477 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S964794AbVLFR5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 12:57:17 -0500
Date: Tue, 6 Dec 2005 12:57:09 -0500
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>, Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       ryan@tau.solarneutrino.net
Subject: Re: Fw: crash on x86_64 - mm related?
Message-ID: <20051206175709.GA12220@tau.solarneutrino.net>
References: <20051129092432.0f5742f0.akpm@osdl.org> <Pine.LNX.4.63.0512012040390.5777@kai.makisara.local> <Pine.LNX.4.64.0512011136000.3099@g5.osdl.org> <20051201195657.GB7236@tau.solarneutrino.net> <Pine.LNX.4.61.0512012008420.28450@goblin.wat.veritas.com> <20051202180326.GB7634@tau.solarneutrino.net> <Pine.LNX.4.61.0512021856170.4940@goblin.wat.veritas.com> <20051202194447.GA7679@tau.solarneutrino.net> <Pine.LNX.4.61.0512022037230.6058@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512022037230.6058@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A little more of the last oops made it out to the syslog server:

Dec  6 00:35:50 xarello kernel:  NMI Watchdog detected LOCKUP on CPU 1
Dec  6 00:35:50 xarello kernel: Modules linked in: bonding
Dec  6 00:35:50 xarello kernel: RIP: 0010:[<ffffffff8038385b>] <ffffffff8038385b>{.text.lock.spinlock+116}
Dec  6 00:35:50 xarello kernel: RAX: ffff810004820740 RBX: ffff810004820788 RCX: 000000000000000c
Dec  6 00:35:50 xarello kernel: RBP: ffff810004834440 R08: ffff8100048208c0 R09: 0000000000000000
Dec  6 00:35:50 xarello kernel: FS:  00002aaaab53d8e0(0000) GS:ffffffff804db880(0000) knlGS:00000000555bc920
Dec  6 00:35:50 xarello kernel: CR2: 00002aaaaaac0000 CR3: 00000000a21af000 CR4: 00000000000006e0
Dec  6 00:35:50 xarello kernel: Stack: ffffffff801607d9 ffff810073bafac0 0000000000000282 ffff810004820ec0
Dec  6 00:35:50 xarello kernel:        ffffffff801597ca ffff810073bafac0
Dec  6 00:35:50 xarello kernel:        <ffffffff80180031>{bio_put+49} <ffffffff8017f62a>{end_bio_bh_io_sync+58}
Dec  6 00:35:50 xarello kernel:        <ffffffff80306d08>{handle_stripe+3752} <ffffffff80307885>{raid5d+741}
Dec  6 00:35:50 xarello kernel:        <ffffffff8030ddb9>{md_thread+281} <ffffffff8014a2f0>{autoremove_wake_function+0}
Dec  6 00:35:50 xarello kernel:        <ffffffff8030dca0>{md_thread+0} <ffffffff80149cc2>{kthread+146}
Dec  6 00:35:50 xarello kernel:        <ffffffff80149c30>{kthread+0} <ffffffff8010e9fa>{child_rip+0}
Dec  6 00:35:50 xarello kernel:
Dec  6 00:35:50 xarello kernel: console shuts up ...

-ryan
