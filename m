Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285147AbRLRUwy>; Tue, 18 Dec 2001 15:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285097AbRLRUwo>; Tue, 18 Dec 2001 15:52:44 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:36878 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S285133AbRLRUwc>; Tue, 18 Dec 2001 15:52:32 -0500
Date: Tue, 18 Dec 2001 18:52:00 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: SteveW@ACM.org, jschlst@samba.org, ncorbic@sangoma.com, eis@baty.hanse.de,
        dag@brattli.net, torvalds@transmeta.com, marcelo@conectiva.com.br,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC 2] cleaning up struct sock
Message-ID: <20011218185200.A1211@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, SteveW@ACM.org,
	jschlst@samba.org, ncorbic@sangoma.com, eis@baty.hanse.de,
	dag@brattli.net, torvalds@transmeta.com, marcelo@conectiva.com.br,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <20011210230810.C896@conectiva.com.br> <20011210.231826.55509210.davem@redhat.com> <20011218033552.B910@conectiva.com.br> <20011217.225134.91313099.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011217.225134.91313099.davem@redhat.com>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 17, 2001 at 10:51:34PM -0800, David S. Miller escreveu:
> Which brings me to...
>    
>    Please let me know if this is something acceptable for 2.5.
> 
> What kind of before/after effect do you see in lat_tcp/lat_connect
> (from lmbench) runs?

Improvements on the lat_connect case? :)

2.4.16
TCP latency using 127.0.0.1: 119.3369 microseconds
TCP latency using 127.0.0.1: 118.9847 microseconds
TCP latency using 127.0.0.1: 118.5139 microseconds
TCP latency using 127.0.0.1: 119.1301 microseconds
TCP latency using 127.0.0.1: 118.6322 microseconds

TCP/IP connection cost to 127.0.0.1: 429.6667 microseconds
TCP/IP connection cost to 127.0.0.1: 430.7692 microseconds
TCP/IP connection cost to 127.0.0.1: 431.4615 microseconds
TCP/IP connection cost to 127.0.0.1: 430.3846 microseconds
TCP/IP connection cost to 127.0.0.1: 435.4615 microseconds

2.4.16-acme5
TCP latency using 127.0.0.1: 119.2639 microseconds
TCP latency using 127.0.0.1: 118.6068 microseconds
TCP latency using 127.0.0.1: 119.0443 microseconds
TCP latency using 127.0.0.1: 119.5683 microseconds
TCP latency using 127.0.0.1: 118.9556 microseconds

TCP/IP connection cost to 127.0.0.1: 408.3571 microseconds
TCP/IP connection cost to 127.0.0.1: 409.6429 microseconds
TCP/IP connection cost to 127.0.0.1: 410.6429 microseconds
TCP/IP connection cost to 127.0.0.1: 409.2143 microseconds
TCP/IP connection cost to 127.0.0.1: 414.8333 microseconds

More results are coming, this time for local connections on a 8-way box

- Arnaldo
