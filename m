Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269261AbRGaLf5>; Tue, 31 Jul 2001 07:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269262AbRGaLfh>; Tue, 31 Jul 2001 07:35:37 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:34299 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S269261AbRGaLf2>;
	Tue, 31 Jul 2001 07:35:28 -0400
Date: Tue, 31 Jul 2001 13:34:43 +0200
From: David Weinehall <tao@acc.umu.se>
To: Hans Reiser <reiser@namesys.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Christoph Hellwig <hch@caldera.de>,
        linux-kernel@vger.kernel.org, Vitaly Fertman <vitaly@namesys.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Message-ID: <20010731133443.N9244@khan.acc.umu.se>
In-Reply-To: <Pine.LNX.4.33L.0107301858350.5582-100000@duckman.distro.conectiva> <3B65E0FE.CC84FF98@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3B65E0FE.CC84FF98@namesys.com>; from reiser@namesys.com on Tue, Jul 31, 2001 at 02:34:38AM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 31, 2001 at 02:34:38AM +0400, Hans Reiser wrote:

[snipping earlier discussion]

> I am saying that you can put so many internal checks into a filesytem
> that it is unusable for any real usage.  Guess what?  ReiserFS does
> that!  But we surround the checks with a #define.  The only limit we
> have on the checks, is that after the relevant bug disappears we cut
> out the ones that make things so slow that it noticeably
> inconveniences our debugging.  It has to slow things down quite a lot
> that we can't stand to wait for it while debugging, but there are some
> kinds of checks that you can do that are that slow.
> 
> ReiserFS checks more things than the rest of the kernel does.  We can
> do this because we use the #define, and pay no price for it.  You
> should do this also in your code....
> 
> Every major kernel component should have a #define which if on checks
> every imaginable thing the developer can think of to check regardless
> of how slow it makes the code go to check it.  Then, when users (or at
> least as usefully, developers adding a new feature) have bugs in that
> component, they can turn it on.

Ugh! I think you need to have a little chat with Linus about this
opinion of yours on how to use #ifdef / #endif in code... I'm not all
that sure he'll agree with you.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
