Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268669AbUIQKa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268669AbUIQKa0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 06:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268670AbUIQKa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 06:30:26 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:14094 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S268669AbUIQK1g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 06:27:36 -0400
Date: Fri, 17 Sep 2004 20:27:20 +1000
To: Martin Bouzek <martin.bouzek@radas-atc.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, davem@davemloft.net,
       netdev@oss.sgi.com
Subject: Re: Minor IPSec bug + solution
Message-ID: <20040917102720.GA14579@gondor.apana.org.au>
References: <E1C83f1-0002X7-00@gondolin.me.apana.org.au> <1095413173.2708.106.camel@mabouzek>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095413173.2708.106.camel@mabouzek>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 11:26:13AM +0200, Martin Bouzek wrote:
>
> > > function. For tunnels it returns 
> > > 
> > > tmpl->optional && !xfrm_state_addr_cmp(tmpl, x, family);
> 
> Well, I am not expierienced with the networking kernel code,
> nevertheless I still think the check is not correct. 

If you change the && to ||, then an ESP tunnel SA marked as required
can be matched by a simple IPIP SA with the same addresses.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
