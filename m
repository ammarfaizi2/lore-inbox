Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbQLGOTy>; Thu, 7 Dec 2000 09:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbQLGOTo>; Thu, 7 Dec 2000 09:19:44 -0500
Received: from [62.172.234.2] ([62.172.234.2]:15337 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S130177AbQLGOTe>;
	Thu, 7 Dec 2000 09:19:34 -0500
Date: Thu, 7 Dec 2000 13:48:38 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>, Andries Brouwer <aeb@veritas.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: [patch-2.4.0-test12-pre6] truncate(2) permissions
In-Reply-To: <Pine.GSO.4.21.0012070709400.20144-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0012071344000.970-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Alexander Viro wrote:
> So correct solution may very well be to change the return value of
> permission(9). FWIW, MAY_TRUNCATE might be a good idea - notice that
> knfsd already has something like that. It makes sense for directories,
> BTW - having may_delete() drop the IS_APPEND() test and pass MAY_TRUNCATE
> to permission() instead.

Alexander,

The above sounds like an excellent idea (MAY_TRUNCATE specifically!) but
please understand that I simply wanted to minimize the amount of
fundamental code changes. Yes, it would be much cleaner to have a MAY_XXX
which groups little specific tests together for every scenario, e.g. for
truncate().

So, I wasn't suggesting BS as the "best thing for all times" but merely as
the "best thing at the moment without changing too much and yet not
leaving dead code in there and not adding too much new code".

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
