Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWGRNLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWGRNLc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 09:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWGRNLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 09:11:31 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:50699 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932163AbWGRNLb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 09:11:31 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: hadi@cyberus.ca
Subject: Re: [RFC PATCH 32/33] Add the Xen virtual network device driver.
Cc: arjan@infradead.org, chrisw@sous-sol.org, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       jeremy@goop.org, ak@suse.de, akpm@osdl.org, rusty@rustcorp.com.au,
       zach@vmware.com, ian.pratt@xensource.com,
       Christian.Limpach@cl.cam.ac.uk, netdev@vger.kernel.org
Organization: Core
In-Reply-To: <1153226379.5283.51.camel@jzny2>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev,apana.lists.os.xen.devel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1G2pJ3-0003LN-00@gondolin.me.apana.org.au>
Date: Tue, 18 Jul 2006 23:08:09 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal <hadi@cyberus.ca> wrote:
>
> I dont think the ifup/ifconfig provide operational status (i.e link
> up/down) - or do they? If they can be made to invoke scripts in such
> a case then we are set.

In fact, that's a very good reason why this shouldn't be in netfront.
Indeed, it shouldn't be in the guest at all.  The reason is that the
guest has no idea whether the physical carrier is present.

It's much better for the host to send the ARP packet on behalf of the
guest since the host knows the carrier status and the guest's MAC
address.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
