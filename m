Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbVJRPhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbVJRPhR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 11:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVJRPhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 11:37:16 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:50951 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S1750810AbVJRPhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 11:37:13 -0400
Date: Tue, 18 Oct 2005 13:37:02 -0200
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: ahendry@tusc.com.au, eis@baty.hanse.de, linux-x25@vger.kernel.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] X25: Add ITU-T facilites
Message-ID: <20051018153702.GC23167@mandriva.com>
Mail-Followup-To: acme@ghostprotocols.net,
	"YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
	ahendry@tusc.com.au, eis@baty.hanse.de, linux-x25@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <1129513666.3747.50.camel@localhost.localdomain> <20051017022826.GA23167@mandriva.com> <1129615767.3695.15.camel@localhost.localdomain> <20051018.152318.68554424.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051018.152318.68554424.yoshfuji@linux-ipv6.org>
X-Url: http://advogato.org/person/acme
User-Agent: Mutt/1.5.9i
From: acme@ghostprotocols.net (Arnaldo Carvalho de Melo)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 18, 2005 at 03:23:18PM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@ escreveu:
> In article <1129615767.3695.15.camel@localhost.localdomain> (at Tue, 18 Oct 2005 16:09:27 +1000), Andrew Hendry <ahendry@tusc.com.au> says:
> 
> > +/* 
> > +*     ITU DTE facilities
> > +*     Only the called and calling address
> > +*     extension are currently implemented.
> > +*     The rest are in place to avoid the struct
> > +*     changing size if someone needs them later
> > ++ */
> > +struct x25_dte_facilities {
> > +	unsigned int    calling_len, called_len;
> > +	char            calling_ae[20];
> > +	char            called_ae[20];
> > +	unsigned char   min_throughput;
> > +	unsigned short  delay_cumul;
> > +	unsigned short  delay_target;
> > +	unsigned short  delay_max;
> > +	unsigned char   expedited;
> > +};
> 
> Why don't you use fixed size members?
> And we can eliminate 8bit hole.
> 
> struct x25_dte_facilities {
>      u32             calling_len
>      u32             called_len;

I guess the two above can be 'u8' as they refer to calling_ae and called_ae
that at most will be '20'?

>      u8              calling_ae[20];
>      u8              called_ae[20];

- Arnaldo
