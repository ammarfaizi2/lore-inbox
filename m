Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbUC1UQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 15:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbUC1UQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 15:16:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20661 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262438AbUC1UQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 15:16:24 -0500
Date: Sun, 28 Mar 2004 12:16:01 -0800
From: "David S. Miller" <davem@redhat.com>
To: Peter Osterlund <petero2@telia.com>
Cc: willy@w.ods.org, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: Re: [PATCH-2.4.26] ip6tables cleanup
Message-Id: <20040328121601.21f98f0f.davem@redhat.com>
In-Reply-To: <m2d66wsrg2.fsf@p4.localdomain>
References: <20040328042608.GA17969@logos.cnet>
	<20040328115439.GA24421@pcw.home.local>
	<m2d66wsrg2.fsf@p4.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Mar 2004 21:27:09 +0200
Peter Osterlund <petero2@telia.com> wrote:

> Willy TARREAU <willy@w.ods.org> writes:
> 
> > 2.4.26-rc1 returned this warning compiling ip6_tables :
> > 
> > ip6_tables.c: In function `tcp_match':
> > ip6_tables.c:1596: warning: implicit declaration of function `ipv6_skip_exthdr'
> > 
> > I had to add a cast because ipv6_skip_exthdr() expects a 'struct sk_buff*' while
> > its caller uses a 'const struct sk_buff*'. Here is a cleanup patch.
> 
> I think it would be better to change the ipv6_skip_exthdr() function
> to take a const struct sk_buff* instead. Unnecessary casts are evil.

Yes, and I believe this is how I fixed this warning in the 2.6.x
tree.
