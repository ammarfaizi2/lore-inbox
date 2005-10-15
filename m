Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbVJOWSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbVJOWSP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 18:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVJOWSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 18:18:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:52921 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751245AbVJOWSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 18:18:13 -0400
Subject: Re: Possible memory ordering bug in page reclaim?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: torvalds@osdl.org, herbert@gondor.apana.org.au, hugh@veritas.com,
       paulus@samba.org, anton@samba.org, nickpiggin@yahoo.com.au,
       akpm@osdl.org, andrea@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20051015.122938.14078749.davem@davemloft.net>
References: <E1EQgxs-00061G-00@gondolin.me.apana.org.au>
	 <Pine.LNX.4.64.0510150945460.23590@g5.osdl.org>
	 <20051015.122938.14078749.davem@davemloft.net>
Content-Type: text/plain
Date: Sun, 16 Oct 2005 08:17:00 +1000
Message-Id: <1129414620.7620.14.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-10-15 at 12:29 -0700, David S. Miller wrote:
> From: Linus Torvalds <torvalds@osdl.org>
> Date: Sat, 15 Oct 2005 09:57:47 -0700 (PDT)
> 
> > On Sat, 15 Oct 2005, Herbert Xu wrote:
> > >
> > > Yes atomic_add_negative should always be a barrier.
> > 
> > I disagree. That would be very expensive on anything but x86, where it 
> > just happens to be true for other reasons. Atomics do _not_ implement 
> > barriers.
> 
> When they return values, they are defined to be barriers.
> It's even on the documentation :-)

Ahhh, good to know :)

/me should read the documentation sometimes....

Ben.

