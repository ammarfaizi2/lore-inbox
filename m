Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWHGXZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWHGXZj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 19:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWHGXZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 19:25:39 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13763 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932337AbWHGXZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 19:25:38 -0400
Date: Tue, 8 Aug 2006 01:25:20 +0200
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <gregkh@suse.de>
Cc: Shem Multinymous <multinymous@gmail.com>, Robert Love <rlove@rlove.org>,
       Jean Delvare <khali@linux-fr.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 01/12] thinkpad_ec: New driver for ThinkPad embedded controller access
Message-ID: <20060807232520.GF2759@elf.ucw.cz>
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548492242899-git-send-email-multinymous@gmail.com> <20060807134440.GD4032@ucw.cz> <41840b750608070813s6d3ffc2enefd79953e0b55caa@mail.gmail.com> <20060807231557.GA2759@elf.ucw.cz> <20060807232330.GA16540@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807232330.GA16540@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2006-08-07 16:23:30, Greg KH wrote:
> On Tue, Aug 08, 2006 at 01:15:57AM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > Thanks for the sign-offs!
> > 
> > No problem.
> > 
> > > >> +module_param_named(debug, tp_debug, int, 0600);
> > > >> +MODULE_PARM_DESC(debug, "Debug level (0=off, 1=on)");
> > > >> +
> > > >> +/* A few macros for printk()ing: */
> > > >> +#define DPRINTK(fmt, args...) \
> > > >> +  do { if (tp_debug) printk(KERN_DEBUG fmt, ## args); } while (0)
> > > >
> > > >Is not there generic function doing this?
> > > 
> > > None that I found. Many drivers do it this way.
> > 
> > linux/kernel.h : pr_debug() looks similar.
> 
> Use dev_dbg() and friends please instead of rolling your own.

Ahha, okay, dev_dbg() looks even better. (But we have pr_debug in
linux/kernel.h; if it should not be used, comment would be nice).

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
