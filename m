Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263285AbVCKC0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263285AbVCKC0b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 21:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbVCKC0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 21:26:30 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:27071
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S263282AbVCKCWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 21:22:09 -0500
Date: Thu, 10 Mar 2005 18:20:44 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Patrick McHardy <kaber@trash.net>
Cc: andre@tomt.net, vanco@satro.sk, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: 2.6.11 on AMD64 traps
Message-Id: <20050310182044.1d740738.davem@davemloft.net>
In-Reply-To: <422F525F.90404@trash.net>
References: <200503081900.18686.vanco@satro.sk>
	<422DF07D.7010908@tomt.net>
	<422F525F.90404@trash.net>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Mar 2005 20:45:35 +0100
Patrick McHardy <kaber@trash.net> wrote:

> > Michal Vanco wrote:
> >>
> >> I see this problem running 2.6.11 on dual AMD64:
> >>
> >> Running quagga routing daemon (ospf+bgp) and issuing "netstat -rn |wc 
> >> -l" command
> >> while quagga tries to load more than 154000 routes from its bgp 
> >> neighbours causes this trap:
> 
> This patch should fix it. The crash is caused by stale pointers,
> the pointers in fib_iter_state are not reloaded after seq->stop()
> followed by seq->start(pos > 0).

Applied, thanks Patrick.
