Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285352AbRL2TiU>; Sat, 29 Dec 2001 14:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285366AbRL2TiB>; Sat, 29 Dec 2001 14:38:01 -0500
Received: from bitmover.com ([192.132.92.2]:51111 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S285352AbRL2Thu>;
	Sat, 29 Dec 2001 14:37:50 -0500
Date: Sat, 29 Dec 2001 11:37:49 -0800
From: Larry McVoy <lm@bitmover.com>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Christer Weinigel <wingel@hog.ctrl-c.liu.se>, linux-kernel@vger.kernel.org
Subject: Re: The direction linux is taking
Message-ID: <20011229113749.D19306@work.bitmover.com>
Mail-Followup-To: Oliver Xymoron <oxymoron@waste.org>,
	Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011229190600.2556C36DE6@hog.ctrl-c.liu.se> <Pine.LNX.4.43.0112291313160.18183-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.43.0112291313160.18183-100000@waste.org>; from oxymoron@waste.org on Sat, Dec 29, 2001 at 01:18:46PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patchbot stuff]

I normally stay out of these discussions because whatever I say usually
gets taken as "he's just promoting BitKeeper" but I think a point needs
to be made.  I promise not to mention BK.



One thing that people seem to be ignoring is that patches tend to need
to be merged.  The only way that can not be true is if the baseline is
revved every time a patch is applied, people get the new baseline before
they send in a patch.

If you have N people trying to patch the same file, you'll require N
releases and some poor shlep is going to have to resubmit their patch
N-1 times before it gets in.

If you look at this carefully, you'll see that in order to have an automated
system, you must serialize all development which touches the same files
(or the same areas in the same files if you are willing to automerge,
but automerging outside of an SCM is difficult to say the least).

I think this is basically why systems like what is being proposed fizzle
out; it's certainly come up over and over.  The world wants to work in
parallel (think "1000's of Linux developers world wide", yeah, it's BS
but there are certainly a couple hundred).  Forcing people to work in
serial isn't the answer.

One way to quantify this is to ask Linus, Alan, Marcelo, et al, how much
time they spend merging, i.e., how often do they get patch rejects?
Regardless of the answer, it will be interesting.  If it is a lot,
then the patchbot idea has marginal usefulness.  If it is none at all,
then that says development is serialized, which means we may be leaving
a lot of progress on the floor.

I wouldn't be surprised if the serialized case is the answer, or close
to it.  It's rare that I hear Open Source leaders complain about merging,
which suggests fairly serialized processes.  In the commercial world,
there is a ton of parallel development and merging is about 90% of what
people do when they are interacting with the SCM system.  Checkin accounts
for about 8%, and after that it's all over the place.

Anyway, I'm interested to see if there are screams of "all I ever do is
merge and I hate it" or "merging?  what's that?".
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
