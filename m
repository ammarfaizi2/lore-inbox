Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261641AbTCQLf2>; Mon, 17 Mar 2003 06:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261643AbTCQLf1>; Mon, 17 Mar 2003 06:35:27 -0500
Received: from valaran.com ([66.153.38.244]:21240 "HELO vader.valaran.com")
	by vger.kernel.org with SMTP id <S261641AbTCQLf0>;
	Mon, 17 Mar 2003 06:35:26 -0500
Date: Mon, 17 Mar 2003 06:46:20 -0500
From: "Keith R. John Warno" <keith.warno@valaran.com>
To: linux-kernel@vger.kernel.org
Subject: "kernel BUG at page_alloc.c:102!" (kernel 2.4.20)
Message-ID: <8EE4126620031047901034.13328.smtp@valaran.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Valaran Corporation
User-Agent: Mutt 1.4i (2002-05-29)
X-Mailer: Mutt 1.4i (2002-05-29)
X-Editor: VIM - Vi IMproved 6.1 (2002 Mar 24, compiled Dec 13 2002 12:46:19)
X-Operating-System: GNU/Linux (2.4.20)
X-Location: USA, New Jersey, Trenton
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.

On a relatively idle system (used mainly for syslog things) that had
been up for ~42 days, kswapd croaked and the kernel claimed (sorry if
these lines are wrapped):

kernel BUG at page_alloc.c:102!
invalid operand: 0000
CPU:    0
EIP:    0010:[__free_pages_ok+68/656]    Tainted: P 
EFLAGS: 00010286
eax: c11703ec   ebx: c151fabc   ecx: c151fad8   edx: c0254c9c
esi: 00000000   edi: 00000010   ebp: 000001f5   esp: c16f5f14
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c16f5000)
Stack: d7b64dc0 c151fabc 00000010 000001f5 c0136d2c c151fabc 000001d0 00000010 
       000001f5 c01351b9 d7b64dc0 c151fabc c012cb52 c012db8b c012cb8b 00000020 
       000001d0 00000020 00000006 00000006 c16f4000 000021dd 000001d0 c0254e34 
Call Trace:    [try_to_free_buffers+140/224] [try_to_release_page+73/80] [shrink_cache+498/784] [__free_pages+27/32] [shrink_cache+555/784]
  [shrink_caches+86/128] [try_to_free_pages_zone+60/96] [kswapd_balance_pgdat+65/144] [kswapd_balance+22/48] [kswapd+157/192] [kernel_thread+40/64]

Code: 0f 0b 66 00 53 f6 21 c0 89 d8 2b 05 f0 20 2b c0 69 c0 a3 8b 


The box is essentially a LinuxFromScratch (actually a severely
overhauled SuSE 6.2) box.  Vanilla kernel 2.4.20 (no patches), glibc
2.2.5, gcc 2.95.3.  It's all running on an Abit KT7A mainboard (Athlon
1.4GHz) with 640MB or so of RAM.

I rebooted the box but it hung when trying to turn off swap.  :-)  (BTW,
is there a means by which to "restart" kswapd if need be?)

I've been using 2.4.20 since a few days after its release.  This is the
first time I've seen this "kernel BUG"; I have absolutely no idea what
triggered it, nor how to reproduce it.

If you need more info, just ask!

Regards,
krjw.
-- 
Keith R. John Warno                         [SA, Valaran Corporation]
