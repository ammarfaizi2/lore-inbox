Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265770AbUGHDn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265770AbUGHDn3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 23:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265772AbUGHDn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 23:43:29 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:2499 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S265770AbUGHDn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 23:43:28 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, chrisw@osdl.org, akpm@osdl.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil,
       jmorris@redhat.com, mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
References: <20040707122525.X1924@build.pdx.osdl.net>
	<E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
	<20040707202746.1da0568b.davem@redhat.com>
From: Miles Bader <miles@lsi.nec.co.jp>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Thu, 08 Jul 2004 12:43:14 +0900
In-Reply-To: <20040707202746.1da0568b.davem@redhat.com> (David S. Miller's
 message of "Wed, 7 Jul 2004 20:27:46 -0700")
Message-ID: <buo7jtfi2p9.fsf@mctpc71.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:
>> What's wrong with using 0 as the NULL pointer? In contexts where
>> a plain 0 is unsafe, NULL is usually unsafe as well.
>
> It's a general sparse cleanup people are doing across the entire tree.
> It's the "proper" way to do pointer comparisons post-K&R.

But 0 in such a context isn't an integer, it's a pointer...

If sparse really warns about such things, the warning seems wrong.

-Miles
-- 
((lambda (x) (list x x)) (lambda (x) (list x x)))
