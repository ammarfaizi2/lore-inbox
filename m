Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317854AbSGKQcw>; Thu, 11 Jul 2002 12:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317857AbSGKQcv>; Thu, 11 Jul 2002 12:32:51 -0400
Received: from waste.org ([209.173.204.2]:63212 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S317854AbSGKQcv>;
	Thu, 11 Jul 2002 12:32:51 -0400
Date: Thu, 11 Jul 2002 11:35:24 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Daniel Phillips <phillips@arcor.de>
cc: Jesse Barnes <jbarnes@sgi.com>, Andreas Dilger <adilger@clusterfs.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: spinlock assertion macros
In-Reply-To: <E17SWXm-0002BL-00@starship>
Message-ID: <Pine.LNX.4.44.0207111131550.15441-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jul 2002, Daniel Phillips wrote:

> I was thinking of something as simple as:
>
>    #define spin_assert_locked(LOCK) BUG_ON(!spin_is_locked(LOCK))
>
> but in truth I'd be happy regardless of the internal implementation.  A note
> on names: Linus likes to shout the names of his BUG macros.  I've never been
> one for shouting, but it's not my kernel, and anyway, I'm happy he now likes
> asserts.  I bet he'd like it more spelled like this though:
>
>    MUST_HOLD(&lock);

I prefer that form too.

> And, dare I say it, what I'd *really* like to happen when the thing triggers
> is to get dropped into kdb.  Ah well, perhaps in a parallel universe...

It ought to.

As long as we're talking about spinlock debugging, I've found it extremely
useful to add an entry to the spinlock to record where the spinlock was
taken.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

