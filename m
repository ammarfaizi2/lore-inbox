Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVAaEPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVAaEPn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 23:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVAaEPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 23:15:43 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:25613 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261912AbVAaEPk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 23:15:40 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: kaber@trash.net (Patrick McHardy)
Subject: Re: Memory leak in 2.6.11-rc1?
Cc: rmk+lkml@arm.linux.org.uk, davem@davemloft.net, Robert.Olsson@data.slu.se,
       akpm@osdl.org, torvalds@osdl.org, alexn@dsv.su.se, kas@fi.muni.cz,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Organization: Core
In-Reply-To: <41FD2043.3070303@trash.net>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CvSuS-00056x-00@gondolin.me.apana.org.au>
Date: Mon, 31 Jan 2005 15:11:32 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy <kaber@trash.net> wrote:
> 
> Ok, final decision: you are right :) conntrack also defragments locally
> generated packets before they hit ip_fragment. In this case the fragments
> have skb->dst set.

Well caught.  The same thing is needed for IPv6, right?
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
