Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317283AbSFRCt6>; Mon, 17 Jun 2002 22:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317286AbSFRCt5>; Mon, 17 Jun 2002 22:49:57 -0400
Received: from [200.203.199.90] ([200.203.199.90]:22802 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S317283AbSFRCt4>; Mon, 17 Jun 2002 22:49:56 -0400
Date: Mon, 17 Jun 2002 23:49:34 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: critson@perlfu.co.uk, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH][2.5.22] OOPS in tcp_v6_get_port
Message-ID: <20020618024934.GA4274@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, critson@perlfu.co.uk,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com
References: <Pine.LNX.4.44.0206171314460.2496-300000@lain.perlfu.co.uk> <20020617.143319.54623892.davem@redhat.com> <20020618005735.GB1146@conectiva.com.br> <20020617.191726.55300824.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020617.191726.55300824.davem@redhat.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 17, 2002 at 07:17:26PM -0700, David S. Miller escreveu:
>    From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
>    Date: Mon, 17 Jun 2002 21:57:35 -0300
> 
>    --- orig/net/ipv6/tcp_ipv6.c	Sat May 25 23:13:56 2002
>    +++ linux/net/ipv6/tcp_ipv6.c	Fri Jun 14 23:23:07 2002
> 
> I've installed this change into my tree in the meantime.
> If we find a better fix, we can just revert this.

OK, I found a better fix, I think, that allowed me to kill inet6_sk_generic
in af_inet6.c, using a constructor for the tcpv6, udpv6 and raw6 slab caches,
as suggested by Russel King, I'll be sending RSN.

- Arnaldo
