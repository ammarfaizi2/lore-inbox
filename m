Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263036AbTIFGUl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 02:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263402AbTIFGUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 02:20:40 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:52872 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263036AbTIFGUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 02:20:39 -0400
Date: Sat, 6 Sep 2003 08:20:08 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy v12
Message-ID: <20030906062007.GA15178@wohnheim.fh-wedel.de>
References: <3F58CE6D.2040000@cyberone.com.au> <195560000.1062788044@flay> <20030905202232.GD19041@matchmail.com> <207340000.1062793164@flay> <3F5935EB.4000005@cyberone.com.au> <6470000.1062819391@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6470000.1062819391@[10.10.2.4]>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 September 2003 20:36:32 -0700, Martin J. Bligh wrote:
> 
> Well, if I can be naive for a second (and I'll fully admit I don't
> understand the implications of this), there are two things here - 
> either give it more of a timeslice (bandwidth increase), or make it 
> more interactive (latency increase). Those two seem to be separable,
> but we don't bother. Seems better to pass a more subtle hint to the
> scheduler that this is interactive - nice seems like a very large
> brick between the eyes.

Just as naïve as you, Martin, but your idea is at least incomplete.
We have to make some processes behave differently, right, but we also
have to detect, which ones they are.  Is the user unhappy with gcc
being a bit jerky?  No, so gcc is not a problem.  X, xmms, xine,
mplayer, quake and a thousand more make the user unhappy, but how do
we detect them and only them?  And which ones do we favor if several
are competing?

One way is to let the user tell you, through nice or anything else,
but the user doesn't want to, so that is suboptimal.

Another way is to integrate the GUI into the kernel, so you know which
window is on top, etc.  But we surely don't want that.

A third way may be to accept hints from userspace, so that X can tell
us, which window is on top.  Maybe as a last resort.

What remains is to try to detect the "interactive" processes through
their behaviour and I am not sure if it is possible to always get this
right in the general case.

Detecting the right processes is the real problem, Martin.  If you can
do that, the rest is quite simple.  And so far, we are quite bad at
it. :(

> I'm probably missing something ... feel free to slap me ;-)

*slap*
Maybe you didn't offer me to, but it still felt good. :)

Jörn

-- 
Fools ignore complexity.  Pragmatists suffer it.
Some can avoid it.  Geniuses remove it.
-- Perlis's Programming Proverb #58, SIGPLAN Notices, Sept.  1982
