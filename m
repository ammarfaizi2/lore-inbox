Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280251AbRJaOja>; Wed, 31 Oct 2001 09:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280249AbRJaOjU>; Wed, 31 Oct 2001 09:39:20 -0500
Received: from waste.org ([209.173.204.2]:50467 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S280246AbRJaOjD>;
	Wed, 31 Oct 2001 09:39:03 -0500
Date: Wed, 31 Oct 2001 08:42:50 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Theodore Tso <tytso@mit.edu>, Horst von Brand <vonbrand@inf.utfsm.cl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random.c bugfix
In-Reply-To: <20011030231926.E800@lynx.no>
Message-ID: <Pine.LNX.4.30.0110310836360.28953-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2001, Andreas Dilger wrote:

> On Oct 30, 2001  11:07 -0500, Theodore Tso wrote:
> > Zero-padding isn't a problem, since it's perfectly safe to mix in zero
> > bytes into the pool.
>
> Well, Oliver tends to disagree.  I don't know enough either way.  It _does_
> seem bad that if you wrote continually wrote 1-byte values into /dev/random
> and padded out the end of the word that it would be bad.  However, in the
> end this is no worse than cat /dev/zero > /dev/random, which is also allowed.

That was just conservatism on my part. There are a large number of hashes
and ciphers for which zero inputs are suboptimal so my gut feel was that
it was a bad idea. That was silly of me, given the way the mixing works.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

