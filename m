Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265771AbSJTFPw>; Sun, 20 Oct 2002 01:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265772AbSJTFPw>; Sun, 20 Oct 2002 01:15:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:31192 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265771AbSJTFPw>;
	Sun, 20 Oct 2002 01:15:52 -0400
Date: Sat, 19 Oct 2002 22:14:03 -0700 (PDT)
Message-Id: <20021019.221403.116117803.davem@redhat.com>
To: acme@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: only produce one record in fib_seq_show
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021020050849.GD15254@conectiva.com.br>
References: <20021020010331.GB15254@conectiva.com.br>
	<20021019.211307.00017347.davem@redhat.com>
	<20021020050849.GD15254@conectiva.com.br>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
   Date: Sun, 20 Oct 2002 02:08:49 -0300
   
   Both with CONFIG_SMP, CONFIG_NR_CPUS=2, so almos whooping 2 pages! Almost
   one third of what CONFIG_SECURITY would add! ia32! Imagine on Sparc64! 8-P
   
BTW, you'll top that by just converting ip_statistics,
icmp_statistics, tcp_statistics, and net_statistics to
be per_cpu data :-)

Note that this would prevent ipv4 from being hacked into being
modular, but there are no plans at all to make modular ipv4 for 2.6.x
at all so this is a valid transformation/cleanup.

kernel/timer.c's main data structures desperately want to be per-cpu
or allocated at boot time also.  It, as has been noted often on this
list, is actually more bloat than the ipv4 statistics stuff. :-)
