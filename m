Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVDAG3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVDAG3F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 01:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVDAG3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 01:29:05 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:49090
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261897AbVDAG3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 01:29:03 -0500
Date: Thu, 31 Mar 2005 22:27:50 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] xfrm_policy destructor fix
Message-Id: <20050331222750.3ad1293a.davem@davemloft.net>
In-Reply-To: <E1DEzq5-0006Bf-00@gondolin.me.apana.org.au>
References: <20050325092813.20e00ef9.davem@davemloft.net>
	<E1DEzq5-0006Bf-00@gondolin.me.apana.org.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Mar 2005 12:11:45 +1100
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> So here is a patch to simplify xfrm_policy_kill() by moving the
> GC linking after the write_unlock_bh().
> 
> Actually, as the code stands, xfrm_policy_kill() should/will never
> be called twice on the same policy.  So we can add a warning to
> catch that.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Applied, thanks Herbert.
