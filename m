Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVFDBpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVFDBpm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 21:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVFDBpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 21:45:42 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:24327 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261217AbVFDBpi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 21:45:38 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: nickpiggin@yahoo.com.au (Nick Piggin)
Subject: Re: Avoiding external fragmentation with a placement policy Version 12
Cc: mbligh@mbligh.org, davem@davemloft.net, jschopp@austin.ibm.com,
       mel@csn.ul.ie, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Organization: Core
In-Reply-To: <429FFC21.1020108@yahoo.com.au>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DeNiA-0008Ap-00@gondolin.me.apana.org.au>
Date: Sat, 04 Jun 2005 11:44:30 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> network code. If the latter, that would suggest at least in theory
> it could use noncongiguous physical pages.

With Dave's latest super-TSO patch, TCP over loopback will only be
doing order-0 allocations in the common case.  UDP and others may
still do large allocations but that logic is all localised in
ip_append_data.

So if we wanted we could easily remove most large allocations over
the loopback device.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
