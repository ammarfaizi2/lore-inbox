Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267926AbUGaJiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267926AbUGaJiN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 05:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267923AbUGaJiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 05:38:12 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:27409 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S267926AbUGaJgI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 05:36:08 -0400
Date: Sat, 31 Jul 2004 19:35:45 +1000
To: Willy Tarreau <willy@w.ods.org>
Cc: greearb@candelatech.com, akpm@osdl.org, alan@redhat.com,
       jgarzik@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
Message-ID: <20040731093545.GB16881@gondor.apana.org.au>
References: <20040730121004.GA21305@alpha.home.local> <E1BqkzY-0003mK-00@gondolin.me.apana.org.au> <20040731083308.GA24496@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040731083308.GA24496@alpha.home.local>
User-Agent: Mutt/1.5.6+20040523i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2004 at 10:33:08AM +0200, Willy Tarreau wrote:
> 
> So several reasons :
>   - the change_mtu() function might be called at any time after driver
>     initialization. I don't know at all if there are things to do to

See the sungem.c for a working implementation.

> As previously said, I can take a few minutes to add the 'MODULE_PARM'
> line, it's not much more than replying to this mail. At least it will
> be a good start.

BTW I presume this is for the tulip driver? Does it actually use the
mtu parameter for anything? It seems to just store it in dev->mtu and
then promptly forgets about it.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
