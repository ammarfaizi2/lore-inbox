Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318224AbSHSKWO>; Mon, 19 Aug 2002 06:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318250AbSHSKWO>; Mon, 19 Aug 2002 06:22:14 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:27872 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S318224AbSHSKWN> convert rfc822-to-8bit; Mon, 19 Aug 2002 06:22:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Marco Colombo <marco@esi.it>, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Date: Mon, 19 Aug 2002 12:25:22 +0200
User-Agent: KMail/1.4.1
Cc: Oliver Xymoron <oxymoron@waste.org>, Robert Love <rml@tech9.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208191205580.26653-100000@Megathlon.ESI>
In-Reply-To: <Pine.LNX.4.44.0208191205580.26653-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208191225.22517.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 19. August 2002 12:15 schrieb Marco Colombo:
> On Mon, 19 Aug 2002, Theodore Ts'o wrote:
>
> [...]
>
> > P.S.  /dev/urandom should probably also be changed to use an entirely
> > separate pool, which then periodically pulls a small amount of entropy
> > from the priamry pool as necessary.  That would make /dev/urandom
> > slightly more dependent on the strength of SHA, while causing it to
> > not draw down as heavily on the entropy stored in /dev/random, which
> > would be a good thing.
>
> Shouldn't it be moved to userpace, instead? Pulling a small amount
> of entropy from /dev/random can be done in userspace, too. And the

1. You create a problem for in kernel users of random numbers.
2. You forgo the benefit of randomness by concurrent access to /dev/urandom
3. You will not benefit from hardware random number generators as easily.

> application could choose *how often* and *how many* bits to pull.

If you really care, you can implement this for /dev/urandom, too.

	Regards
		Oliver

