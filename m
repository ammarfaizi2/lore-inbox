Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265252AbTL0KRJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 05:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265268AbTL0KRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 05:17:09 -0500
Received: from holomorphy.com ([199.26.172.102]:51630 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265252AbTL0KRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 05:17:06 -0500
Date: Sat, 27 Dec 2003 02:16:55 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@surriel.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: Page aging broken in 2.6
Message-ID: <20031227101655.GJ27687@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Rik van Riel <riel@surriel.com>, Andrew Morton <akpm@osdl.org>
References: <1072423739.15458.62.camel@gaston> <Pine.LNX.4.58.0312260957100.14874@home.osdl.org> <1072482941.15458.90.camel@gaston> <Pine.LNX.4.58.0312261626260.14874@home.osdl.org> <1072485899.15456.96.camel@gaston> <Pine.LNX.4.58.0312261649070.14874@home.osdl.org> <1072487027.15476.105.camel@gaston> <20031227023752.GF1676@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031227023752.GF1676@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 27, 2003 at 03:37:53AM +0100, Andrea Arcangeli wrote:
> It's hard for me to evaluate how much the young bit matters by only
> thinking about it,  I know for sure the heavily swapping behaviour on
> the alpha was noticeably less smooth than on x86 (alpha has^Hd no way to
> implement the young bit, not even like you do in software through hash
> faults). So I guess it's worthwhile for you to account for it even if in
> software (i.e. ppc not ppc64).

I have a vague notion it should be possible to turn off the PAL
pagetable emulation and do these things yourself, though I'm not
entirely clear on how practical this is to do (e.g. whether the real
MMU's docs are public, whether the PAL code can be turned off at all,
etc.). It would be a relatively large amount of arch code to bang out,
and for a largely (and rather unfortunately) dead architecture at that.

Probably a moot point depending on the level of resistance to the idea
(which seems to dominate technical concerns for a number of things) and
how thin I'm spread. I've got a multia, but (a) multias suck and (b)
it's stripped, so unless I feel like debugging swapping over the network,
that's useless apart from making sure it boots and runs luserspace.

I guess the point of this was really a roundabout way to ask if there
was enough information to either do that with or rule it out just to
satisfy my own curiosity, since it's not likely I'll ever get around
to actually trying to implement it.


-- wli
