Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266955AbSLPRiJ>; Mon, 16 Dec 2002 12:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266957AbSLPRiJ>; Mon, 16 Dec 2002 12:38:09 -0500
Received: from findaloan-online.cc ([216.209.85.42]:10757 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S266955AbSLPRiG>;
	Mon, 16 Dec 2002 12:38:06 -0500
Date: Mon, 16 Dec 2002 12:54:32 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org,
       hpa@zytor.com, terje.eggestad@scali.com
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021216175432.GA5094@mark.mielke.cc>
References: <20021215220132.GB6347@elf.ucw.cz> <200212160733.gBG7XhD67922@saturn.cs.uml.edu> <20021216111759.GA24196@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216111759.GA24196@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 12:17:59PM +0100, Pavel Machek wrote:
> > Sure it's dirty. It's also fast, with the only overhead being
> > a few NOPs that could get skipped on syscall return anyway.
> > Patching overhead is negligible, since it only happens when a
> > page is brought in fresh from the disk.
> Yes but "read only" code changing under you... Should better be
> avoided.

Programs that self verify their own CRC may get a little confused (are
there any of these left?), but other than that, 'goto is better avoided'
as well, but sometimes 'goto' is the best answer.

> > The vsyscall stuff costs you on every syscall. It's nice for
> Well, the cost is basically one call. That's not *that* big cost.

Time for benchmarks... :-)

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

