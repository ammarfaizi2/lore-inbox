Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbVHCLtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbVHCLtK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 07:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVHCLrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 07:47:09 -0400
Received: from gate.crashing.org ([63.228.1.57]:22446 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262235AbVHCLqn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 07:46:43 -0400
Subject: Re: revert yenta free_irq on suspend
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: abelay@novell.com, Len Brown <len.brown@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Dave Airlie <airlied@gmail.com>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20050802105619.GA1390@elf.ucw.cz>
References: <2e55d42e7427.2e74272e55d4@columbus.rr.com>
	 <1122886189.18835.109.camel@gaston>  <20050802105619.GA1390@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 03 Aug 2005 13:42:12 +0200
Message-Id: <1123069333.30257.31.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-02 at 12:56 +0200, Pavel Machek wrote:
> Hi!
> 
> > > Also, as I said earlier, the better we support OSPM initiated power
> > > management, the more likely APM will break.  This may be technically
> > > unavoidable on some isolated boxes without quirks.  I agree with
> > > Pavel that "do nothing" may make sense, but it seems some devices
> > > may still need to be disabled by the OS.  As a real world example,
> > > we currently can't turn off cardbus bridges because it breaks APM
> > > on a couple of older laptops.
> > 
> > Won't freeing of IRQs cause problems with things like handhelds that
> > actually rely on an interrupt to wake up ?
> 
> Well, you probably don't want to free IRQ that is used for wakeup; but
> if driver is used for wakeup, it probably needs some special handling,
> anyway (right?).

Not necessarily something the driver itself knows about ... For example,
some platforms do a hardware OR between PME and INTA ...

Ben.

