Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVBHS5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVBHS5f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 13:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVBHS5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 13:57:35 -0500
Received: from gprs215-10.eurotel.cz ([160.218.215.10]:54226 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261628AbVBHS53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 13:57:29 -0500
Date: Tue, 8 Feb 2005 19:41:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: ieee1394 needs CONFIG_NET but does not depend on it
Message-ID: <20050208184136.GA7369@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

If I attempt to compile IEE1394 without CONFIG_NET, I get:

drivers/built-in.o(.text+0xcf885): In function `hpsb_alloc_packet':
: undefined reference to `alloc_skb'
drivers/built-in.o(.text+0xd03a6): In function `hpsb_send_packet':
: undefined reference to `skb_queue_tail'
drivers/built-in.o(.text+0xd0ea3): In function `abort_requests':
: undefined reference to `skb_dequeue'
drivers/built-in.o(.text+0xd0f99): In function
`queue_packet_complete':
: undefined reference to `skb_queue_tail'
drivers/built-in.o(.text+0xd1026): In function `hpsbpkt_thread':
: undefined reference to `skb_dequeue'
drivers/built-in.o(.text+0xcf930): In function `hpsb_free_packet':
: undefined reference to `__kfree_skb'
make: *** [.tmp_vmlinux1] Error 1
9.20user 0.83system 10.05 (0m10.058s) elapsed 99.83%CPU
pavel@amd:/usr/src/linux-mm$

Looks like some Kconfig dependency is needed...
							Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
