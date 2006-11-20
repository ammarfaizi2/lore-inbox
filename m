Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756134AbWKTLOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756134AbWKTLOn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 06:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756724AbWKTLOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 06:14:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60606 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1756134AbWKTLOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 06:14:42 -0500
Subject: Re: GoogleEarth triggers 99% System Load... DRI/X problem?
From: Arjan van de Ven <arjan@infradead.org>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20061120115613.04676c09@localhost>
References: <20061120115613.04676c09@localhost>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 20 Nov 2006 12:14:39 +0100
Message-Id: <1164021279.31358.576.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [10234.202497] SysRq : Show Regs
> [10234.202505] CPU 0:
> [10234.202507] Modules linked in: xt_state ip_conntrack ip_queue iptable_filter ip_tables
> [10234.202516] Pid: 13251, comm: googleearth-bin Not tainted 2.6.19-rc6-ge030f829-dirty #23
> [10234.202519] RIP: 0010:[<ffffffff802f2bd6>]  [<ffffffff802f2bd6>] __delay+0xc/0x15
> [10234.202530] RSP: 0018:ffff810018c0fd08  EFLAGS: 00000297
> [10234.202533] RAX: 00000000ac2588b9 RBX: ffff810018c0fd08 RCX: 00000000ac258571
> [10234.202536] RDX: 000000000000148a RSI: 0000000000000100 RDI: 000000000000089b
> [10234.202540] RBP: ffff810018c0fd08 R08: 0000000000000001 R09: 00000000ffeeed68
> [10234.202543] R10: ffff810018c0e000 R11: 0000000000000286 R12: 000000000004dda8
> [10234.202547] R13: ffff81001f993c00 R14: ffffffff804a086a R15: ffff810018c0fc78
> [10234.202552] FS:  00002ae4f268a6d0(0000) GS:ffffffff805f6000(0063) knlGS:00000000f62fe6b0
> [10234.202555] CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
> [10234.202558] CR2: 00002add26650000 CR3: 000000000a240000 CR4: 00000000000006e0
> [10234.202560] 
> [10234.202561] Call Trace:
> [10234.202567]  [<ffffffff802f2bfb>] __const_udelay+0x1c/0x1e
> [10234.202574]  [<ffffffff803698d5>] radeon_freelist_get+0xf1/0x136
> [10234.202578]  [<ffffffff8036b365>] radeon_cp_buffers+0x108/0x194
> [10234.202582]  [<ffffffff8036b25d>] radeon_cp_buffers+0x0/0x194
> [10234.202586]  [<ffffffff80361ee0>] drm_ioctl+0x171/0x1bd
> [10234.202591]  [<ffffffff8036896a>] compat_drm_dma+0xe5/0x12b
> [10234.202596]  [<ffffffff80368885>] compat_drm_dma+0x0/0x12b
> [10234.202600]  [<ffffffff80367c46>] drm_compat_ioctl+0x42/0x70



hmm this looks more like a bug in the X side of things; at least that is
what it normally means (the ringbuffer got full); however since you're
using the ioctl compat stuff it could be that instead (I don't know how
well tested that is).

Maybe open a bug in X.org bugzilla will work best; the people there tend
to look after both the X and the kernel side...


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

