Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbVBKDsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbVBKDsg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 22:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbVBKDsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 22:48:36 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:36076
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262135AbVBKDsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 22:48:35 -0500
Date: Thu, 10 Feb 2005 19:46:57 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: wa@almesberger.net, anton@samba.org, okir@suse.de, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arp_queue: serializing unlink + kfree_skb
Message-Id: <20050210194657.41fc2907.davem@davemloft.net>
In-Reply-To: <20050210045647.GA15552@gondor.apana.org.au>
References: <20050131102920.GC4170@suse.de>
	<E1CvZo6-0001Bz-00@gondolin.me.apana.org.au>
	<20050203142705.GA11318@krispykreme.ozlabs.ibm.com>
	<20050203150821.2321130b.davem@davemloft.net>
	<20050204113305.GA12764@gondor.apana.org.au>
	<20050204154855.79340cdb.davem@davemloft.net>
	<20050204222428.1a13a482.davem@davemloft.net>
	<20050210012304.E25338@almesberger.net>
	<20050210045647.GA15552@gondor.apana.org.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2005 15:56:47 +1100
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> > ? If yes, is this a good idea ?
> 
> Dave mentioned that on sparc64, atomic_inc_and_test is much more
> expensive than the second variant.

Actually, besides the memory barriers themselves, all variants
are equally expensive.

On old i386 chips, the test variants are indeed more expensive.
Linus told me this and there is a note about this in the
atomic_ops.txt file if you look at the current copy :-)

