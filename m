Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269913AbRHSDtz>; Sat, 18 Aug 2001 23:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269950AbRHSDtp>; Sat, 18 Aug 2001 23:49:45 -0400
Received: from odyssey.netrox.net ([204.253.4.3]:9886 "EHLO t-rex.netrox.net")
	by vger.kernel.org with ESMTP id <S269913AbRHSDtg>;
	Sat, 18 Aug 2001 23:49:36 -0400
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
From: Robert Love <rml@tech9.net>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0108182231030.31188-100000@waste.org>
In-Reply-To: <Pine.LNX.4.30.0108182231030.31188-100000@waste.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.18.07.08 (Preview Release)
Date: 18 Aug 2001 23:49:59 -0400
Message-Id: <998193001.653.3.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Aug 2001 22:33:54 -0500, Oliver Xymoron wrote:
> The network is still feeding data to the pool, yes? It's merely
> underestimating the value of that data. If you think you're getting enough
> entropy for your application, use /dev/urandom, don't weaken /dev/random.
> 
> Practically speaking, /dev/urandom is pretty damn strong anyway.

Honestly, I don't have a clue what you are talking about.  I think you
have a misconception about how the entropy gathering works, the
differences between /dev/random and /dev/urandom, and what entropy even
is.

I don't know what your problem is with with allowing net devices to feed
the pool.

Finally, /dev/random and /dev/urandom have the same "strength" -- the
_only_ difference is that /dev/random will block if the _entropy_ count
is 0. note, again, this is not the byte count.  by design, the size of
the pool does not decrement as you read from it. just the estimate of
the entropy.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

