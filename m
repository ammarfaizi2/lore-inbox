Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933172AbWK2FES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933172AbWK2FES (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 00:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933709AbWK2FES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 00:04:18 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:50618
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S933172AbWK2FER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 00:04:17 -0500
Date: Tue, 28 Nov 2006 21:04:16 -0800 (PST)
Message-Id: <20061128.210416.59658806.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: kaber@trash.net, khc@pm.waw.pl, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: Re: Broken commit: [NETFILTER]: ipt_REJECT: remove largely
 duplicate route_reverse function
From: David Miller <davem@davemloft.net>
In-Reply-To: <E1GpHVB-0005CB-00@gondolin.me.apana.org.au>
References: <20061128.204440.39160464.davem@davemloft.net>
	<E1GpHVB-0005CB-00@gondolin.me.apana.org.au>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Wed, 29 Nov 2006 15:56:57 +1100

> David Miller <davem@davemloft.net> wrote:
> > 
> > Longer term this is really messy, we should handle this some
> > other way.
> 
> Definitely.  I'm not sure whether 48 is enough even for recursive
> tunnels.  This should really just be a hint.  It's OK to spend a
> bit of time reallocating skb's if it's too small, but it's not OK
> to die.

The recursive tunnel case is handled by the PMTU reductions
in the route, isn't it?
