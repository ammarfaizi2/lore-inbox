Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264610AbUF1B2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264610AbUF1B2R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 21:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264625AbUF1B2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 21:28:17 -0400
Received: from disk.smurf.noris.de ([192.109.102.53]:31369 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S264610AbUF1B2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 21:28:15 -0400
From: "Matthias Urlichs" <smurf@smurf.noris.de>
Date: Mon, 28 Jun 2004 03:24:07 +0200
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [parisc-linux] Re: [PATCH] Fix the cpumask rewrite
Message-ID: <20040628012407.GC4648@kiste>
References: <1088266111.1943.15.camel@mulgrave> <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org> <20040626221802.GA12296@taniwha.stupidest.org> <Pine.LNX.4.58.0406261536590.16079@ppc970.osdl.org> <1088290477.3790.2.camel@localhost.localdomain> <20040627000541.GA13325@taniwha.stupidest.org> <pan.2004.06.27.12.00.03.857572@smurf.noris.de> <20040627224115.GA22532@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040627224115.GA22532@taniwha.stupidest.org>
User-Agent: Mutt/1.5.6+20040523i
X-Smurf-Spam-Score: -3.8 (---)
X-Smurf-Spam-Report: Spam detection software, running on the system "server.smurf.noris.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, Chris Wedgwood: > On Sun, Jun 27, 2004 at
	02:00:03PM +0200, Matthias Urlichs wrote: > > > <heretic> > > #define
	jiffies __get_jiffies() > > </heretic> > > Well, I have that but it's
	only part of the story. > True. [...] 
	Content analysis details:   (-3.8 points, 10.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.1 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Chris Wedgwood:
> On Sun, Jun 27, 2004 at 02:00:03PM +0200, Matthias Urlichs wrote:
> 
> > <heretic>
> > #define jiffies __get_jiffies()
> > </heretic>
> 
> Well, I have that but it's only part of the story.
> 
True.

> As Alan pointed out a suitable API could also make it easier to work
> towards a clock-less system for embedded targets.
> 
Well, drivers do need some way of timing things, else they wouldn't read
jiffies in the first place. So, at minimum, an embedded system would
need a way to trigger a timeout at some specified time in the future.

A simple __get_jiffies() implementation could just set up a 1/HZ-second
timer (and busy-wait for it, and increase its internal jiffies counter)
every tenth call or so. That would probably slow down the whole system
somewhat, but I'd assume it'd mostly work.

-- 
Matthias Urlichs
