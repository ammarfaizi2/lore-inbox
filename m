Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318223AbSHSKLW>; Mon, 19 Aug 2002 06:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318224AbSHSKLW>; Mon, 19 Aug 2002 06:11:22 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:29198 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S318223AbSHSKLR>; Mon, 19 Aug 2002 06:11:17 -0400
Date: Mon, 19 Aug 2002 12:15:07 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: "Theodore Ts'o" <tytso@mit.edu>
cc: Oliver Xymoron <oxymoron@waste.org>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
In-Reply-To: <20020819042141.GA26519@think.thunk.org>
Message-ID: <Pine.LNX.4.44.0208191205580.26653-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2002, Theodore Ts'o wrote:

[...]
> P.S.  /dev/urandom should probably also be changed to use an entirely
> separate pool, which then periodically pulls a small amount of entropy
> from the priamry pool as necessary.  That would make /dev/urandom
> slightly more dependent on the strength of SHA, while causing it to
> not draw down as heavily on the entropy stored in /dev/random, which
> would be a good thing.

Shouldn't it be moved to userpace, instead? Pulling a small amount
of entropy from /dev/random can be done in userspace, too. And the
application could choose *how often* and *how many* bits to pull.
The kernel can only make a choice which may be too much for an application
(making it drain more entropy than it needs) or too little for another
(forcing it to use /dev/random directly). Let the kernel implement
the Real Thing only (/dev/random). /dev/urandom really belongs to
userspace.

.TM.

