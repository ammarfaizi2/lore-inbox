Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265800AbUGHFgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUGHFgS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 01:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265799AbUGHFgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 01:36:17 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:36570 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S265798AbUGHFgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 01:36:00 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, chrisw@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil,
       jmorris@redhat.com, mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
References: <20040707122525.X1924@build.pdx.osdl.net>
	<E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
	<20040707202746.1da0568b.davem@redhat.com>
	<buo7jtfi2p9.fsf@mctpc71.ucom.lsi.nec.co.jp>
	<Pine.LNX.4.58.0407072220060.1764@ppc970.osdl.org>
From: Miles Bader <miles@lsi.nec.co.jp>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Thu, 08 Jul 2004 14:35:49 +0900
In-Reply-To: <Pine.LNX.4.58.0407072220060.1764@ppc970.osdl.org> (Linus
 Torvalds's message of "Wed, 7 Jul 2004 22:22:32 -0700 (PDT)")
Message-ID: <buosmc3gix6.fsf@mctpc71.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:
>> >> What's wrong with using 0 as the NULL pointer? In contexts where
>> >> a plain 0 is unsafe, NULL is usually unsafe as well.
>> >
>> > It's a general sparse cleanup people are doing across the entire tree.
>> > It's the "proper" way to do pointer comparisons post-K&R.
>> 
>> But 0 in such a context isn't an integer, it's a pointer...
>
> No it's not.

I don't have a copy of the standard handy, but google shows this snippet on
the info-minux mailing list:

   From ANSI X3.159-1989 3.2.2.3:

      An integral constant expression with the value 0, or such an expression
      cast to the type void *, is called a null pointer constant. If a null
      pointer constant is assigned to or compared for equality to a pointer,
      the constant is converted to a pointer of that type.

> Final word: K&R C without prototypes etc is still "legal C". That doesn't
> make it legal kernel code.

Your prerogative.

-Miles
-- 
"1971 pickup truck; will trade for guns"
