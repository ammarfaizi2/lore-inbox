Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268637AbUIGVJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268637AbUIGVJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 17:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268633AbUIGVIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 17:08:17 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:8897
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268637AbUIGVFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 17:05:38 -0400
Date: Tue, 7 Sep 2004 14:02:45 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: util@deuroconsult.ro, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Trivial fix for out of bounds array access in
 xfrm4_policy_check
Message-Id: <20040907140245.675b7240.davem@davemloft.net>
In-Reply-To: <E1C4fMc-000817-00@gondolin.me.apana.org.au>
References: <Pine.LNX.4.61.0409071322100.8637@hosting.rdsbv.ro>
	<E1C4fMc-000817-00@gondolin.me.apana.org.au>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Sep 2004 22:46:22 +1000
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Catalinux aka Dino BOIE <util@deuroconsult.ro> wrote:
> > 
> > Coverity found a bug in accessing xfrm4_policy_check using XFRM_POLICY_FWD 
> > (=2) as index in sk->sk_policy.
> > 
> > sk->sk_policy[] is defined in sock.h as:
> > 
> > struct xfrm_policy *sk_policy[2];
> > 
> > Attached is the fix.
> 
> This is bogus as if the packet is forwarded then sk == NULL.

Agreed.
