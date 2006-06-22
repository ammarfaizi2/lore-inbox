Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932739AbWFVA4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739AbWFVA4N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 20:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932743AbWFVA4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 20:56:13 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:44300 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932739AbWFVA4L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 20:56:11 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Memory corruption in 8390.c ? (was Re: Possible leaks in network	drivers)
Cc: snakebyte@gmx.de, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       netdev@vger.kernel.org, davem@davemloft.net
Organization: Core
In-Reply-To: <1150909982.15275.100.camel@localhost.localdomain>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1FtDU0-0005nd-00@gondolin.me.apana.org.au>
Date: Thu, 22 Jun 2006 10:55:44 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> skb_padto() returns either a new buffer or the existing one depending
> upon the space situation. If it returns a new buffer then it frees the
> old one.

I think skb_padto simply shouldn't allocate a new skb.  It only needs
to extend the data area.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
