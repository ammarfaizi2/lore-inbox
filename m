Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWHGXXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWHGXXx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 19:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWHGXXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 19:23:53 -0400
Received: from cantor2.suse.de ([195.135.220.15]:7108 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751192AbWHGXXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 19:23:53 -0400
Date: Mon, 7 Aug 2006 16:23:30 -0700
From: Greg KH <gregkh@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Shem Multinymous <multinymous@gmail.com>, Robert Love <rlove@rlove.org>,
       Jean Delvare <khali@linux-fr.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 01/12] thinkpad_ec: New driver for ThinkPad embedded controller access
Message-ID: <20060807232330.GA16540@suse.de>
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548492242899-git-send-email-multinymous@gmail.com> <20060807134440.GD4032@ucw.cz> <41840b750608070813s6d3ffc2enefd79953e0b55caa@mail.gmail.com> <20060807231557.GA2759@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807231557.GA2759@elf.ucw.cz>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 01:15:57AM +0200, Pavel Machek wrote:
> Hi!
> 
> > Thanks for the sign-offs!
> 
> No problem.
> 
> > >> +module_param_named(debug, tp_debug, int, 0600);
> > >> +MODULE_PARM_DESC(debug, "Debug level (0=off, 1=on)");
> > >> +
> > >> +/* A few macros for printk()ing: */
> > >> +#define DPRINTK(fmt, args...) \
> > >> +  do { if (tp_debug) printk(KERN_DEBUG fmt, ## args); } while (0)
> > >
> > >Is not there generic function doing this?
> > 
> > None that I found. Many drivers do it this way.
> 
> linux/kernel.h : pr_debug() looks similar.

Use dev_dbg() and friends please instead of rolling your own.

thanks,

greg k-h
