Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317974AbSFSSiZ>; Wed, 19 Jun 2002 14:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317975AbSFSSiY>; Wed, 19 Jun 2002 14:38:24 -0400
Received: from netfinity.realnet.co.sz ([196.28.7.2]:48323 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317974AbSFSSiX>; Wed, 19 Jun 2002 14:38:23 -0400
Date: Wed, 19 Jun 2002 20:10:22 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: (2.5.23) buffer layer error at buffer.c:2326
Message-ID: <Pine.LNX.4.44.0206192007210.1263-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The ide drive holding the mounted filesystem dropped out of DMA and then 
spewed the following a number of times. Anyone interested?

 buffer layer error at buffer.c:2326
Pass this trace through ksymoops for reporting
c13f7e8c 00000916 c1014ef0 c13f6000 c0868d8c c0861da0 c014e500 c1014ef0
       c13f6000 c0861da0 c13f6000 c0861da0 c0186f3b c1014ef0 00000000 00000000
       c1000018 c033893c 00000203 000001d0 c13f6000 c0868d8c 0000000a c017d55e
Call Trace: [<c014e500>] [<c0186f3b>] [<c017d55e>] [<c014cb62>] [<c013cb70>]
   [<c013d0b5>] [<c013d11c>] [<c013d1c2>] [<c013d236>] [<c013d38f>] [<c0117820>]
   [<c0105000>] [<c0105000>] [<c01057f6>] [<c013d2d0>]

Trace; c014e500 <try_to_free_buffers+80/110>
Trace; c0186f3b <journal_try_to_free_buffers+20b/220>
Trace; c017d55e <ext3_releasepage+1e/30>
Trace; c014cb62 <try_to_release_page+42/60>
Trace; c013cb70 <shrink_cache+3e0/6e0>
Trace; c013d0b5 <shrink_caches+65/a0>
Trace; c013d11c <try_to_free_pages+2c/50>
Trace; c013d1c2 <kswapd_balance_pgdat+52/a0>
Trace; c013d236 <kswapd_balance+26/40>
Trace; c013d38f <kswapd+bf/c6>
Trace; c0117820 <default_wake_function+0/40>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c01057f6 <kernel_thread+26/30>
Trace; c013d2d0 <kswapd+0/c6>

-- 
http://function.linuxpower.ca
		

