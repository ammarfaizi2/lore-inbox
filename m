Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbUCYXzM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 18:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263789AbUCYXzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 18:55:12 -0500
Received: from gprs214-160.eurotel.cz ([160.218.214.160]:24193 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263702AbUCYXzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:55:00 -0500
Date: Fri, 26 Mar 2004 00:54:40 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp with highmem, testing wanted
Message-ID: <20040325235440.GL2179@elf.ucw.cz>
References: <20040324235702.GA497@elf.ucw.cz> <1080185300.1147.62.camel@gaston> <20040325120250.GC300@elf.ucw.cz> <1080254461.1195.40.camel@gaston> <20040325225946.GI2179@elf.ucw.cz> <1080254675.7097.16.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080254675.7097.16.camel@calvin.wpcb.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On Fri, 2004-03-26 at 10:59, Pavel Machek wrote:
> > > I also think we free too much memory btw (and spend too much time
> > > trying to free memory). Have you looked at some of Nigel stuffs in
> > > swsusp2 ? There may be good ideas to borrow... 
> > 
> > Yes, swsusp2 is faster. It is also 10x more code. We could probably
> > stop freeing as soon as half of memory is free; OTOH if memory is
> > disk cache, it might be faster to drop it than write to swap, then
> > read back [swsusp2 shows its not usually the case, through].
> 
> 10x more code is true, but we also need to ask, how much of that is more
> functionality? How much is debugging code (that can be removed)? How
> much is comments?

Do you think you could strip down features + debugging etc so that
swsusp2 is only, say, 3x bigger than swsusp1? It would certainly make
merging easier.

> 10x implies there's needless bloat and that the two are otherwise
> equivalent. That's simply not true.

If I implied that I should appologize. (Sorry.) swsusp2 *has* more
features, many of them make it faster.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
