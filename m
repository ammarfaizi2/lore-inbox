Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280725AbRLRMB3>; Tue, 18 Dec 2001 07:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281360AbRLRMBK>; Tue, 18 Dec 2001 07:01:10 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:47377 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S280725AbRLRMBH>;
	Tue, 18 Dec 2001 07:01:07 -0500
Date: Tue, 18 Dec 2001 10:01:04 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: SteveW@ACM.org, jschlst@samba.org, ncorbic@sangoma.com, eis@baty.hanse.de,
        dag@brattli.net, torvalds@transmeta.com, marcelo@conectiva.com.br,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC 2] cleaning up struct sock
Message-ID: <20011218100104.A2000@conectiva.com.br>
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
>    From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
>    Date: Tue, 18 Dec 2001 03:35:52 -0200
> 
>    the only thing that still has to be done is to remove things
>    like daddr, saddr, rcv_saddr, dport, sport and other ipv4 specific members
>    of struct sock
> 
> Actually, I'd like to keep the first couple cache lines of struct
> sock the way it is :-(  For hash lookups the identity + the hash next
> pointer fit perfectly in one cache line on nearly all platforms.

fair
 
> Which brings me to...
>    
>    Please let me know if this is something acceptable for 2.5.
> 
> What kind of before/after effect do you see in lat_tcp/lat_connect
> (from lmbench) runs?

Will see today, I concentrated on the cleanup part trying not to harm
performance  by following the suggestions for the first patch (i.e., just one
allocation, etc). I'll test it later today, at the lab, UP and SMP (4 and 8
way) and submit the results here.

Apart from possible performance problems, does the patch looks OK?

- Arnaldo
