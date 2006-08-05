Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWHFWCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWHFWCU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 18:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWHFWCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 18:02:20 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51469 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750739AbWHFWCP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 18:02:15 -0400
Date: Sat, 5 Aug 2006 11:37:04 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>, trivial@kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use BUG_ON(foo) instead of "if (foo) BUG()" in include/asm-i386/dma-mapping.h
Message-ID: <20060805113703.GD4506@ucw.cz>
References: <200607280928.54306.eike-kernel@sf-tec.de> <20060728004758.5e7c5120.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060728004758.5e7c5120.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > We have BUG_ON() right for this, don't we?
> 
> Well yes, but there are over a thousand BUG->BUG_ON conversion
> possibilities in the tree.  If people start sending them three-at-a-time
> we'll all go mad.
> 
> So.  If we're going to do this, bigger patches, please.

If we are going that way... I guess we should specify if BUG_ON() has
to evaluate its arguments even if it is compiled out...

Or probably better pecify that BUG_ON() must not have side effects?

							Pavel
-- 
Thanks for all the (sleeping) penguins.
