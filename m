Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264894AbUBDXix (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 18:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264365AbUBDXeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 18:34:37 -0500
Received: from gate.crashing.org ([63.228.1.57]:56708 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264566AbUBDXcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 18:32:51 -0500
Subject: Re: fb.h header fix.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@transmeta.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0402041857210.20659-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0402041857210.20659-100000@phoenix.infradead.org>
Content-Type: text/plain
Message-Id: <1075937512.4029.47.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 05 Feb 2004 10:31:53 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Not yet, it's a ppc64 bug, I haven't had time to fix it, for some
> > reason, ppc64 doesn't have readq/writeq nor __raw_ IO accessors.
> 
> This means more than the fbdev layer will break on the ppc64.
> Ben you you post a patch for the ppc64 so the fbdev patch can go in?

Yes, but I think Andrew should still merge your patch at this point,
I'll send the ppc64 fix today hopefully along with other ppc64 io.h
fixes.

Then we need the rest of the core & driver bits in. I'd really like
2.6.3 to be "complete" for PowerMacs (both ppc32 and ppc64) which
means including the fbdev updates. I think the fbdev core changes are
now good enough to get in. I'm fairly sure there are still fbcon bugs
but I'm also sure those are already upstream so they aren't worth
postponing the merge.
 
Ben.

