Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759378AbWLBD3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759378AbWLBD3h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 22:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759381AbWLBD3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 22:29:37 -0500
Received: from rhun.apana.org.au ([64.62.148.172]:53006 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1759378AbWLBD3g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 22:29:36 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: psusi@cfl.rr.com (Phillip Susi)
Subject: Re: What happened to CONFIG_TCP_NAGLE_OFF?
Cc: alan@lxorguk.ukuu.org.uk, matthew.garman@gmail.com,
       linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <457093C5.1040501@cfl.rr.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1GqLZ0-0006iY-00@gondolin.me.apana.org.au>
Date: Sat, 02 Dec 2006 14:29:18 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi <psusi@cfl.rr.com> wrote:
> 
> UDP is highly appropriate because the congestion controls and other 
> features of TCP are not required for this type of data, and in fact, 
> tend to muck things up.  That is why the application needs to implement 
> its own congestion, sequencing, retransmit and connect/disconnect 
> controls; because the way TCP handles them is not good for this 
> application.

Congestion control is always appropriate in a shared network.  Please
note that congestion control does not conflict with the objectives of
UDP.  For UDP, congestion control can simply mean dropping packets at
the source.  DCCP is a good replacement for UDP that has congestion
control.

In general it's much better to much better to drop packets at the
source rather than half-way through.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
