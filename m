Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbVJOTaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbVJOTaY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 15:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbVJOTaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 15:30:24 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:49552
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751210AbVJOTaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 15:30:23 -0400
Date: Sat, 15 Oct 2005 12:29:38 -0700 (PDT)
Message-Id: <20051015.122938.14078749.davem@davemloft.net>
To: torvalds@osdl.org
Cc: herbert@gondor.apana.org.au, benh@kernel.crashing.org, hugh@veritas.com,
       paulus@samba.org, anton@samba.org, nickpiggin@yahoo.com.au,
       akpm@osdl.org, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Possible memory ordering bug in page reclaim?
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0510150945460.23590@g5.osdl.org>
References: <E1EQgxs-00061G-00@gondolin.me.apana.org.au>
	<Pine.LNX.4.64.0510150945460.23590@g5.osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Sat, 15 Oct 2005 09:57:47 -0700 (PDT)

> On Sat, 15 Oct 2005, Herbert Xu wrote:
> >
> > Yes atomic_add_negative should always be a barrier.
> 
> I disagree. That would be very expensive on anything but x86, where it 
> just happens to be true for other reasons. Atomics do _not_ implement 
> barriers.

When they return values, they are defined to be barriers.
It's even on the documentation :-)
