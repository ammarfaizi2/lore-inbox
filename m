Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUGIEmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUGIEmS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 00:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUGIEmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 00:42:17 -0400
Received: from mail-relay-2.tiscali.it ([212.123.84.92]:53647 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S264113AbUGIEmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 00:42:16 -0400
Date: Fri, 9 Jul 2004 06:42:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, mason@suse.com
Subject: Re: writepage fs corruption fixes
Message-ID: <20040709044205.GF20947@dualathlon.random>
References: <20040709040151.GB20947@dualathlon.random> <20040708212923.406135f0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708212923.406135f0.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Thu, Jul 08, 2004 at 09:29:23PM -0700, Andrew Morton wrote:
> ooh, nasty, yes.  You must be testing the crap out if it.

;) thanks for the immediate review!

BTW, the new mpage code looks great, it's a pity that reiserfs and ext3
don't use it yet.

> PG_writeback protects the page from truncate, from invalidate and from page
> reclaim.  pagevec_strip() won't touch the buffers due to the
> PageWriteback() test in try_to_release_page().  So I think we're OK in
> there.  I can add a couple more coment fixes for this.

Indeed, sorry. I should have watched more carefully for the writeback
bitflag but I was still in "anything that looks a bug close it and try
again" mode when I made the two "noop" changes ;)
