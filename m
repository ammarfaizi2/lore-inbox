Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265794AbUGHFXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265794AbUGHFXY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 01:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265780AbUGHFXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 01:23:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:32658 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265794AbUGHFWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 01:22:54 -0400
Date: Wed, 7 Jul 2004 22:22:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Miles Bader <miles@gnu.org>
cc: "David S. Miller" <davem@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, chrisw@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil,
       jmorris@redhat.com, mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
In-Reply-To: <buo7jtfi2p9.fsf@mctpc71.ucom.lsi.nec.co.jp>
Message-ID: <Pine.LNX.4.58.0407072220060.1764@ppc970.osdl.org>
References: <20040707122525.X1924@build.pdx.osdl.net>
 <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <20040707202746.1da0568b.davem@redhat.com>
 <buo7jtfi2p9.fsf@mctpc71.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Jul 2004, Miles Bader wrote:

> "David S. Miller" <davem@redhat.com> writes:
> >> What's wrong with using 0 as the NULL pointer? In contexts where
> >> a plain 0 is unsafe, NULL is usually unsafe as well.
> >
> > It's a general sparse cleanup people are doing across the entire tree.
> > It's the "proper" way to do pointer comparisons post-K&R.
> 
> But 0 in such a context isn't an integer, it's a pointer...

No it's not.

I'm sorry that you are such a K&R-C bigot that you don't like type 
checking. But the kernel DOES like type checking, and the kernel is not 
K&R C. The kernel uses strict ANSI, and in fact, is _more_ strict than 
ANSI C is in many many ways.

One of the "strict typechecking" rules is that you don't mix integers and 
pointers by mistake. The fact that C allows dual usage of the integer "0"
is an anachronism that should have been fixed long ago.

Final word: K&R C without prototypes etc is still "legal C". That doesn't
make it legal kernel code.

		Linus
