Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317996AbSFSUWQ>; Wed, 19 Jun 2002 16:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317997AbSFSUWP>; Wed, 19 Jun 2002 16:22:15 -0400
Received: from loke.as.arizona.edu ([128.196.209.61]:24072 "EHLO
	loke.as.arizona.edu") by vger.kernel.org with ESMTP
	id <S317996AbSFSUWP>; Wed, 19 Jun 2002 16:22:15 -0400
Date: Wed, 19 Jun 2002 13:21:29 -0700 (MST)
From: Craig Kulesa <ckulesa@as.arizona.edu>
To: Ingo Molnar <mingo@elte.hu>
cc: Rik van Riel <riel@conectiva.com.br>, Dave Jones <davej@suse.de>,
       Daniel Phillips <phillips@bonn-fries.net>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
       Linus Torvalds <torvalds@transmeta.com>, <rwhron@earthlink.net>
Subject: Re: [PATCH] (1/2) reverse mapping VM for 2.5.23 (rmap-13b)
In-Reply-To: <Pine.LNX.4.44.0206192151390.20865-100000@e2>
Message-ID: <Pine.LNX.4.44.0206191310590.4292-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Jun 2002, Ingo Molnar wrote:

> btw., isnt there a fair chance that by 'fixing' the aging+rmap code to
> swap out less, you'll ultimately swap in more? [because the extra swappout
> likely ended up freeing up RAM as well, which in turn decreases the amount
> of trashing.]

Agree.  Heightened swapout in this rather simplified example) isn't a 
problem in itself, unless it really turns out to be a bottleneck in a 
wide variety of loads.  As long as the *right* pages are being swapped 
and don't have to be paged right back in again.   

I'll try a more varied set of tests tonight, with cpu usage tabulated.

-Craig

