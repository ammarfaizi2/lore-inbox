Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265773AbSJTFUq>; Sun, 20 Oct 2002 01:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265774AbSJTFUq>; Sun, 20 Oct 2002 01:20:46 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:53770 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S265773AbSJTFUp>; Sun, 20 Oct 2002 01:20:45 -0400
Date: Sun, 20 Oct 2002 02:26:36 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>, Rasmus Andersen <rasmus@jaquet.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: only produce one record in fib_seq_show
Message-ID: <20021020052636.GE15254@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>,
	Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
References: <20021020010331.GB15254@conectiva.com.br> <20021019.211307.00017347.davem@redhat.com> <20021020050849.GD15254@conectiva.com.br> <20021019.221403.116117803.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021019.221403.116117803.davem@redhat.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Oct 19, 2002 at 10:14:03PM -0700, David S. Miller escreveu:
>    From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
>    Date: Sun, 20 Oct 2002 02:08:49 -0300
    
>    Both with CONFIG_SMP, CONFIG_NR_CPUS=2, so almos whooping 2 pages! Almost
>    one third of what CONFIG_SECURITY would add! ia32! Imagine on Sparc64! 8-P

> BTW, you'll top that by just converting ip_statistics, icmp_statistics,
> tcp_statistics, and net_statistics to be per_cpu data :-)
 
> Note that this would prevent ipv4 from being hacked into being modular, but
> there are no plans at all to make modular ipv4 for 2.6.x at all so this is a
> valid transformation/cleanup.
 
> kernel/timer.c's main data structures desperately want to be per-cpu or
> allocated at boot time also.  It, as has been noted often on this list, is
> actually more bloat than the ipv4 statistics stuff. :-)

And thats great! More stuff to shrink, the CONFIG_TINY brigade is taking notes,
isn't it Rasmus? :-) Thanks for the suggestions David.

- Arnaldo
