Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbUC1T1T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 14:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbUC1T1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 14:27:19 -0500
Received: from av4-1-sn3.vrr.skanova.net ([81.228.9.111]:12958 "EHLO
	av4-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S262365AbUC1T1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 14:27:17 -0500
To: Willy TARREAU <willy@w.ods.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: Re: [PATCH-2.4.26] ip6tables cleanup
References: <20040328042608.GA17969@logos.cnet>
	<20040328115439.GA24421@pcw.home.local>
From: Peter Osterlund <petero2@telia.com>
Date: 28 Mar 2004 21:27:09 +0200
In-Reply-To: <20040328115439.GA24421@pcw.home.local>
Message-ID: <m2d66wsrg2.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy TARREAU <willy@w.ods.org> writes:

> 2.4.26-rc1 returned this warning compiling ip6_tables :
> 
> ip6_tables.c: In function `tcp_match':
> ip6_tables.c:1596: warning: implicit declaration of function `ipv6_skip_exthdr'
> 
> I had to add a cast because ipv6_skip_exthdr() expects a 'struct sk_buff*' while
> its caller uses a 'const struct sk_buff*'. Here is a cleanup patch.

I think it would be better to change the ipv6_skip_exthdr() function
to take a const struct sk_buff* instead. Unnecessary casts are evil.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
