Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWGRPXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWGRPXk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 11:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWGRPXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 11:23:40 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:7439 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932264AbWGRPXj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 11:23:39 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: jhaller@lucent.com (John Haller)
Subject: Re: [RFC PATCH 32/33] Add the Xen virtual network device driver.
Cc: herbert@gondor.apana.org.au, hadi@cyberus.ca, arjan@infradead.org,
       chrisw@sous-sol.org, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       jeremy@goop.org, ak@suse.de, akpm@osdl.org, rusty@rustcorp.com.au,
       zach@vmware.com, ian.pratt@xensource.com,
       Christian.Limpach@cl.cam.ac.uk, netdev@vger.kernel.org
Organization: Core
In-Reply-To: <44BCE15D.2090501@lucent.com>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev,apana.lists.os.xen.devel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1G2rP0-0003bc-00@gondolin.me.apana.org.au>
Date: Wed, 19 Jul 2006 01:22:26 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Haller <jhaller@lucent.com> wrote:
>
> But sending ARPs is not the right thing if the guest is expecting
> to use IPv6 networking, in which case unsolicited neighbor
> advertisements are the right thing to do.  The driver just
> doesn't seem to be the right place to do this, as it doesn't/
> shouldn't need to know the difference between IPv4/IPv6.

In this case it doesn't really matter because AFAIK they're
trying to get switches to notice that the MAC has moved.  So
all you need is some packet that the switches can grok.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
