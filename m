Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVBOW6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVBOW6v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 17:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVBOW5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 17:57:04 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:15028
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261936AbVBOW4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 17:56:47 -0500
Date: Tue, 15 Feb 2005 14:53:48 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: mirko.parthey@informatik.tu-chemnitz.de, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, yoshfuji@linux-ipv6.org, shemminger@osdl.org
Subject: Re: [IPSEC] Move dst->child loop from dst_ifdown to xfrm_dst_ifdown
Message-Id: <20050215145348.36ed3508.davem@davemloft.net>
In-Reply-To: <20050208013140.GB30659@gondor.apana.org.au>
References: <20050131162201.GA1000@stilzchen.informatik.tu-chemnitz.de>
	<20050205052407.GA17266@gondor.apana.org.au>
	<20050204213813.4bd642ad.davem@davemloft.net>
	<20050205061110.GA18275@gondor.apana.org.au>
	<20050204221344.247548cb.davem@davemloft.net>
	<20050205064643.GA29758@gondor.apana.org.au>
	<20050205201044.1b95f4e8.davem@davemloft.net>
	<20050206065117.GC16057@gondor.apana.org.au>
	<20050208012929.GA30659@gondor.apana.org.au>
	<20050208013140.GB30659@gondor.apana.org.au>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2005 12:31:40 +1100
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Tue, Feb 08, 2005 at 12:29:29PM +1100, herbert wrote:
> > 
> > This one moves the dst->child processing from dst_ifdown into
> > xfrm_dst_ifdown.
> 
> This patch adds a net_device argument to ifdown.  After all,
> it's a bit silly to notify someone of an ifdown event without
> telling them what which device it was for :)
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Ok, I'm going to try and get these two patches into 2.6.11
