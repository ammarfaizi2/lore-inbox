Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVHBLTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVHBLTV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 07:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVHBLTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 07:19:21 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26327 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261407AbVHBLSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 07:18:52 -0400
Date: Tue, 2 Aug 2005 12:56:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: abelay@novell.com, Len Brown <len.brown@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Dave Airlie <airlied@gmail.com>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: revert yenta free_irq on suspend
Message-ID: <20050802105619.GA1390@elf.ucw.cz>
References: <2e55d42e7427.2e74272e55d4@columbus.rr.com> <1122886189.18835.109.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122886189.18835.109.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Also, as I said earlier, the better we support OSPM initiated power
> > management, the more likely APM will break.  This may be technically
> > unavoidable on some isolated boxes without quirks.  I agree with
> > Pavel that "do nothing" may make sense, but it seems some devices
> > may still need to be disabled by the OS.  As a real world example,
> > we currently can't turn off cardbus bridges because it breaks APM
> > on a couple of older laptops.
> 
> Won't freeing of IRQs cause problems with things like handhelds that
> actually rely on an interrupt to wake up ?

Well, you probably don't want to free IRQ that is used for wakeup; but
if driver is used for wakeup, it probably needs some special handling,
anyway (right?).
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
