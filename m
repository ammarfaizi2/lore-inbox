Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752217AbWAEVlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbWAEVlb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752216AbWAEVlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:41:31 -0500
Received: from waste.org ([64.81.244.121]:63180 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751125AbWAEVla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:41:30 -0500
Date: Thu, 5 Jan 2006 15:34:42 -0600
From: Matt Mackall <mpm@selenic.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Martin Bligh <mbligh@mbligh.org>, Arjan van de Ven <arjan@infradead.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
Message-ID: <20060105213442.GM3356@waste.org>
References: <200601041959_MC3-1-B550-5EE2@compuserve.com> <43BC716A.5080204@mbligh.org> <1136463553.2920.22.camel@laptopd505.fenrus.org> <20060105170255.GK3356@waste.org> <43BD5E6F.1040000@mbligh.org> <Pine.LNX.4.64.0601051112070.3169@g5.osdl.org> <Pine.LNX.4.64.0601051126570.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601051126570.3169@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 11:40:08AM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 5 Jan 2006, Linus Torvalds wrote:
> > 
> > That way the "profile data" actually follows the source code, and is thus 
> > actually relevant to an open-source project. Because we do _not_ start 
> > having specially optimized binaries. That's against the whole point of 
> > being open source and trying to get users to get more deeply involved with 
> > the project.
> 
> Btw, having annotations obviously works, although it equally obviously 
> will limit the scope of this kind of profile data. You won't get the same 
> kind of granularity, and you'd only do the annotations for cases that end 
> up being very clear-cut. But having an automated feedback cycle for adding 
> (and removing!) annotations should make it pretty maintainable in the long 
> run, although the initial annotations migh only end up being for really 
> core code.
> 
> There's a few papers around that claim that programmers are often very 
> wrong when they estimate probabilities for different code-paths, and that 
> you absolutely need automation to get it right. I believe them. But the 
> fact that you need automation doesn't automatically mean that you should 
> feed the compiler a profile-data-blob.

I think it's a mistake to interleave this data into the C source. It's
expensive and tedious to change relative to its volatility. What I was
proposing was something like, say, arch/i386/popularity.lst, which
would simply contain a list of the most popular n% of functions sorted
by popularity. As text, of course.

-- 
Mathematics is the supreme nostalgia of our time.
