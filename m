Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbVFRXSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVFRXSr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 19:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVFRXSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 19:18:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53778 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262196AbVFRXSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 19:18:45 -0400
Date: Sun, 19 Jun 2005 00:18:41 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc6-mm1
Message-ID: <20050619001841.A7252@flint.arm.linux.org.uk>
Mail-Followup-To: Richard Purdie <rpurdie@rpsys.net>,
	LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <20050607042931.23f8f8e0.akpm@osdl.org> <1119134359.7675.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1119134359.7675.38.camel@localhost.localdomain>; from rpurdie@rpsys.net on Sat, Jun 18, 2005 at 11:39:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2005 at 11:39:18PM +0100, Richard Purdie wrote:
> On Tue, 2005-06-07 at 04:29 -0700, Andrew Morton wrote:
> > +git-arm-smp.patch
> > 
> >  ARM git trees
> 
> The arm pxa255 based Zaurus won't resume from a suspend with the patches
> from the above tree applied. The suspend looks normal and gets at least
> as far as pxa_pm_enter(). After that, the device appears to be dead and
> needs a battery removal to reset. I'm unsure if it actually suspends and
> is failing to resume or is crashing in the latter suspend stages.

<grumble>Well, its a bit late for this since (a) stuff has rapidly
moved on at rmk towers since 2.6.12 was released this morning, and
(b) I've just asked Linus to pull this.</grumble>

Thinking about what's probably happening, I suspect all the ARM suspend
and resume code needs to be reworked to save more state.  I'll try to
cook up a patch tomorrow to fix it, but I'll need you to provide
feedback.

Please note that you may see other ARM breakage over the next month
or so - I'm going to be concentrating on merging ARM SMP support,
and whatever bashing other people like yourself can give the kernel
will help ensure that problems are picked up quickly.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
