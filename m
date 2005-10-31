Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbVJaARE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbVJaARE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 19:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVJaARE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 19:17:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17427 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932418AbVJaARC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 19:17:02 -0500
Date: Mon, 31 Oct 2005 00:16:47 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, tony.luck@gmail.com,
       paolo.ciarrocchi@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
Message-ID: <20051031001647.GK2846@flint.arm.linux.org.uk>
Mail-Followup-To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
	torvalds@osdl.org, tony.luck@gmail.com, paolo.ciarrocchi@gmail.com,
	linux-kernel@vger.kernel.org
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com> <20051029223723.GJ14039@flint.arm.linux.org.uk> <20051030111241.74c5b1a6.akpm@osdl.org> <200510310148.57021.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510310148.57021.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 01:48:56AM +0100, Andi Kleen wrote:
> On Sunday 30 October 2005 20:12, Andrew Morton wrote:
> 
> > The freezes are for fixing bugs, especially recent regressions.  There's no
> > shortage of them, you know.
> >
> > I you can think of a better way to get kernel developers off their butts
> > and actually fixing bugs, I'm all ears.
> 
> The problem is that you usually cannot do proper bug fixing because
> the release might be just around the corner, so you typically
> chose the ugly workaround or revert, or just reject changes for bugs that a 
> are too risky or the impact too low because there is not enough time to 
> properly test anymore.
> 
> It might work better if we were told when the releases would actually
> happen and you don't need to fear that this not quite tested everywhere
> bugfix you're about to submit might make it into the gold kernel, breaking
> the world for some subset of users.

Indeed - a prime example is the bootmem initialisation problem.  Had
I known on 1st October that the final release wouldn't have been for
a long time, I'd have applied that patch and you wouldn't have had
that problem with ARM relying on the bootmem initialisation order
clashing with your ia64 (or x86_64) swiotlb fix.

But stupid rmk - again I hasten to add - was suckered into this "-rc
is frozen" idea again and decided it wasn't appropriate to submit it.
In hind-sight, there would have been plenty of time to sort out any
issues.

Hell, we held up 2.6.14 for swiotlb _anyway_.

Time to start writing those lines...
I must learn to ignore what Linus says about frozen releases.
I must learn to ignore what Linus says about frozen releases.
I must learn to ignore what Linus says about frozen releases.
I must learn to ignore what Linus says about frozen releases.
I must learn to ignore what Linus says about frozen releases.
I must learn to ignore what Linus says about frozen releases.
I must learn to ignore what Linus says about frozen releases.
I must learn to ignore what Linus says about frozen releases.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
