Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317988AbSFSTzd>; Wed, 19 Jun 2002 15:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317989AbSFSTzc>; Wed, 19 Jun 2002 15:55:32 -0400
Received: from mx1.elte.hu ([157.181.1.137]:5603 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317988AbSFSTzc>;
	Wed, 19 Jun 2002 15:55:32 -0400
Date: Wed, 19 Jun 2002 21:53:23 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Dave Jones <davej@suse.de>, Daniel Phillips <phillips@bonn-fries.net>,
       Craig Kulesa <ckulesa@as.arizona.edu>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>, Linus Torvalds <torvalds@transmeta.com>,
       <rwhron@earthlink.net>
Subject: Re: [PATCH] (1/2) reverse mapping VM for 2.5.23 (rmap-13b)
In-Reply-To: <Pine.LNX.4.44L.0206191429300.2598-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0206192151390.20865-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Jun 2002, Rik van Riel wrote:

> I am encouraged by Craig's test results, which show that
> rmap did a LOT less swapin IO and rmap with page aging even
> less. The fact that it did too much swapout IO means one
> part of the system needs tuning but doesn't say much about
> the thing as a whole.

btw., isnt there a fair chance that by 'fixing' the aging+rmap code to
swap out less, you'll ultimately swap in more? [because the extra swappout
likely ended up freeing up RAM as well, which in turn decreases the amount
of trashing.]

	Ingo

