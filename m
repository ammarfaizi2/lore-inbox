Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275789AbRJFWiD>; Sat, 6 Oct 2001 18:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275816AbRJFWht>; Sat, 6 Oct 2001 18:37:49 -0400
Received: from [195.223.140.107] ([195.223.140.107]:10237 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S275789AbRJFWgx>;
	Sat, 6 Oct 2001 18:36:53 -0400
Date: Sun, 7 Oct 2001 00:36:43 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: chris@scary.beasts.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM: 2.4.10ac4 vs. 2.4.11pre2
Message-ID: <20011007003643.K724@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0110061252450.17262-100000@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110061252450.17262-100000@sphinx.mythic-beasts.com>; from chris@scary.beasts.org on Sat, Oct 06, 2001 at 01:20:23PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2001 at 01:20:23PM +0100, chris@scary.beasts.org wrote:
> 
> dbench 8             34Mbyte/sec       40Mbyte/sec

dbench wants a very unfair vm behaviour. We must penalize all tasks
except one.  I measured a x2 slowdown after Linus introduced
mark_page_accessed after 2.4.10pre11 (but still it was faster than
pre10).

If you want patches to make dbench much faster I can provide them, just
ask, at the moment I just think dbench is a very bad benchmark. I can
implement a /proc/sys/vm/dbench if people wants to post nice numbers
without having to apply patches :).

I'd also like to know what you get using -aa instead of mainline, there
are a few changes that can make a difference in the numbers.

Andrea
