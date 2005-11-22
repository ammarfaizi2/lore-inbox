Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965080AbVKVWn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbVKVWn3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 17:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbVKVWn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 17:43:29 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:9624
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965074AbVKVWn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 17:43:28 -0500
Date: Tue, 22 Nov 2005 14:43:34 -0800 (PST)
Message-Id: <20051122.144334.23915283.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: kuznet@ms2.inr.ac.ru, cfriesen@nortel.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [NETLINK]: Use tgid instead of pid for nlmsg_pid
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <E1EeJxb-0006xG-00@gondolin.me.apana.org.au>
References: <20051121213549.GA28187@ms2.inr.ac.ru>
	<E1EeJxb-0006xG-00@gondolin.me.apana.org.au>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 22 Nov 2005 09:16:27 +1100

> Alexey Kuznetsov <kuznet@ms2.inr.ac.ru> wrote:
> > 
> > I agree, apparently netlink_autobind was missed when sed'ing pid->tgid.
> > Of course, it does not matter, but tgid is nicer choice from user's viewpoint.
> 
> Great, here is the patch to do just that.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Applied, of course.

I can't for the life of me figure out how we missed this when
we fixed up all the current->pid references under net/.
Ulrich Drepper let us know that the problem existed, and
I was sure we eliminated all such cases.

It is possible we accidently reintroduced current->pid when
we redid all of the netlink hashing. :-)
