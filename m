Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265312AbUGANww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265312AbUGANww (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 09:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265285AbUGANvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 09:51:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54153 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265265AbUGANvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 09:51:32 -0400
Date: Thu, 1 Jul 2004 15:33:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Wedgwood <cw@f00f.org>, Linus Torvalds <torvalds@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PARISC list <parisc-linux@lists.parisc-linux.org>
Subject: Re: [parisc-linux] Re: [PATCH] Fix the cpumask rewrite
Message-ID: <20040701133308.GQ698@openzaurus.ucw.cz>
References: <1088266111.1943.15.camel@mulgrave> <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org> <20040626221802.GA12296@taniwha.stupidest.org> <Pine.LNX.4.58.0406261536590.16079@ppc970.osdl.org> <1088290477.3790.2.camel@localhost.localdomain> <20040627000541.GA13325@taniwha.stupidest.org> <1088347046.26753.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088347046.26753.3.camel@localhost.localdomain>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'm all for that, except last I counted there are about 5000 users of
> > jiffies.  What do you suggest as a replacement API?
> 
> For a lot of them they shouldn't be polling. For those that do in
> most cases something like
> 
> 	struct timeout_timer t;
> 
> 	timeout_set(t, 5 * HZ)
> 	timeout_cancel(t)
> 
> 	if(timeout_expired(t))
> 
> Where timeout_timer is effectively an existing timer of add_timer
> style and a single variable. The code to build that kind of timer
> on top of add_timer is trivial.

Plus some get_jiffies api for stuff like printk ratelimit would be needed,
right?
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

