Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316825AbSGQVMN>; Wed, 17 Jul 2002 17:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316826AbSGQVMN>; Wed, 17 Jul 2002 17:12:13 -0400
Received: from dsl-213-023-038-064.arcor-ip.net ([213.23.38.64]:28351 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316825AbSGQVMM>;
	Wed, 17 Jul 2002 17:12:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: HZ, preferably as small as possible
Date: Wed, 17 Jul 2002 23:16:25 +0200
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207171359000.6820-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0207171359000.6820-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Uw9p-0004QY-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 July 2002 23:02, Linus Torvalds wrote:
> On Wed, 17 Jul 2002, Richard B. Johnson wrote:
> >
> > It is hardly novel and I can't imagine how Bresenham or whomever
> > could make such a claim to the obvious. Even the DOS writer(s) used
> > this technique to get one-second time intervals from the 18.206
> > ticks/per second.
> 
> Ehh.. Look at _existing_ linux code to do exactly the same.
> 
> See update_wall_time_one_tick() and second_overflow() (which does a lot
> more besides, but it does largely boil down to this "average fractions
> using basic integer math" thing.

I see lots of stuff in there all right, but I don't see anything that
implements the numerator/denominator error analysis technique I
described above.  Maybe I just didn't look hard enough.

-- 
Daniel
