Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265262AbSKRXOg>; Mon, 18 Nov 2002 18:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265326AbSKRXOb>; Mon, 18 Nov 2002 18:14:31 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:60323 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S265262AbSKRXNj>; Mon, 18 Nov 2002 18:13:39 -0500
Date: Mon, 18 Nov 2002 21:19:26 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tr: make CONFIG_TR depend on CONFIG_LLC=y
Message-ID: <20021118231926.GG30075@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Jeff Garzik <jgarzik@pobox.com>,
	"David S. Miller" <davem@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021116111344.GD24641@conectiva.com.br> <1037660711.5785.2.camel@rth.ninka.net> <3DD973B6.900@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD973B6.900@pobox.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 18, 2002 at 06:11:50PM -0500, Jeff Garzik escreveu:
> David S. Miller wrote:
> 
> >On Sat, 2002-11-16 at 03:13, Arnaldo Carvalho de Melo wrote:
> >
> >>	Please pull from:
> >>
> >>master.kernel.org:/home/acme/BK/net-2.5
> >
> >
> >Pulled, thanks.
> 
> hmmm, did you look at the requirements here?
> 
> when I looked at this a couple weeks ago, it did not seem like the best 
> fix, just the easiest...

Previously the 802.2 llc1 code was statically linked when TR was selected,
problem is now the llc1 code is not separated from the llc2 one, which is
way bigger, my plans are to:

1. make llc1 be available separately, so that we can have the previous
   behaviour
2. to make TR be available as a module

Suggestions on better ways to deal with this are welcome...

- Arnaldo
