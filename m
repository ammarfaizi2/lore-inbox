Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbTELOGl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 10:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbTELOGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 10:06:41 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:42760 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262144AbTELOGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 10:06:40 -0400
Date: Mon, 12 May 2003 16:19:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Hellwig <hch@infradead.org>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ioctl32: kill code duplication (sparc64 tester wanted)
Message-ID: <20030512141923.GA23352@atrey.karlin.mff.cuni.cz>
References: <20030512114055.GA3539@atrey.karlin.mff.cuni.cz> <20030512134353.A28931@infradead.org> <20030512130518.GA15227@atrey.karlin.mff.cuni.cz> <20030512140834.A29260@infradead.org> <20030512131326.GB15227@atrey.karlin.mff.cuni.cz> <20030512141600.A29386@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030512141600.A29386@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > > What's the reason you can't build fs/compat_ioctl.c normally and pull
> > > in the arch magic through a magic asm/ header?  
> > 
> > Some architectures need special stuff (mtrr's), so I'd have to include
> > .c files, too (the other way). [Look at how the table of ioctls is
> > generated, its asm magic].
> 
> Shouldn't that special stuff move to the dynamic ioctl handler
> registration method or the new ->compat_ioctl?

Davem probably would not like bloat
resulting from that (There's a lot of
arch specific stuff out there). Agreed it
would be nice to do that, but I feel
we need to make small steps.


> 
> > Are you asking why are there #includes in compat_ioctl.c? Its because
> > there is so many of them, and having to update all archs when you
> > tuoch fs/compat_ioctl.c would be bad.
> 
> I'm asking for the #ifdef INCLUDES in fs/compat_ioctl.c.  Why do you
> need it instead of including the headers uncondtionally?

Because I'm including compat_ioctl.c from few places.
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
