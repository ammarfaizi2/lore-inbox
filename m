Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271552AbRHPKz4>; Thu, 16 Aug 2001 06:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271553AbRHPKzq>; Thu, 16 Aug 2001 06:55:46 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:9738 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S271552AbRHPKzh>; Thu, 16 Aug 2001 06:55:37 -0400
Date: Thu, 16 Aug 2001 12:55:46 +0200
From: Kurt Roeckx <Q@ping.be>
To: linux-kernel@vger.kernel.org
Subject: system freeze with 2.4.8.
Message-ID: <20010816125546.A1598@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.4.8 with the ext3 0.9.6 patch.

I was running make dep, and suddenly it the disk stopped doing
anything.  All I could do with the keyboard was switch consoles.

I pressed alt+scroll lock a few times, and the EIP was about the
same each time, so I assume it's looping somewhere.

I wrote the EIP and Call trace down, and ran that thru ksymoops,
and got this:

>>EIP; c013d830 <prune_icache+28/114>   <=====
Trace; c013d934 <shrink_icache_memory+18/2c>
Trace; c0125410 <do_try_to_free_pages+1c/44>
Trace; c012548e <kswapd+56/e4>
Trace; c0105448 <kernel_thread+28/38>


Kurt

