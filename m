Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSGJKA3>; Wed, 10 Jul 2002 06:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314584AbSGJKA2>; Wed, 10 Jul 2002 06:00:28 -0400
Received: from Morgoth.ESIWAY.NET ([193.194.16.157]:19716 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S312619AbSGJKA1>; Wed, 10 Jul 2002 06:00:27 -0400
Date: Wed, 10 Jul 2002 12:03:08 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Larry McVoy <lm@bitmover.com>
cc: kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: BKL removal
In-Reply-To: <20020708222127.G11300@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0207101144010.728-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[kernel-janitor people please Cc: me if you're going to remove l-k from
the Cc: list]

On Mon, 8 Jul 2002, Larry McVoy wrote:

[...]
> If you were talking about replacing a big lock with one lock, you
> might have a point.  But you aren't.  You can't be, because by
> definition if you take out the big lock you have to put in lots
> of little locks.  And then you get discover all the problems that
> the BKL was hiding that you just exposed by removing it.

[...]
> Can you tell me the list of locks and what they cover in the last 
> multi threaded OS you worked in?  I thought not.  Nobody could.

Larry, there's something I've always wanted to ask you about your
idea of the "locking cliff": when you're counting the number of locks,
are you looking at the running image of an OS or at the source? 
I mean, suppose we have a file object, with its private lock used
to protect access to its "internals" (whatever that means): of course
we may have thousands of these locks living in the running image of
the OS at a given time (most of them unused, BTW). At source level,
it is only one lock, instead. So are you worried about the proliferation
of locks in the source or in the live image of the OS? (I can see 
arguments against both.)

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it

