Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVAXK4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVAXK4a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 05:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVAXK4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 05:56:30 -0500
Received: from bbned23-32-100.dsl.hccnet.nl ([80.100.32.23]:33750 "EHLO
	fw-loc.vanvergehaald.nl") by vger.kernel.org with ESMTP
	id S261489AbVAXK42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 05:56:28 -0500
Date: Mon, 24 Jan 2005 11:56:10 +0100
From: Toon van der Pas <toon@hout.vanvergehaald.nl>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Alessandro Sappia <a.sappia@ngi.it>, linux-kernel@vger.kernel.org
Subject: Re: chvt issue
Message-ID: <20050124105610.GA20644@hout.vanvergehaald.nl>
References: <41F442B0.80900@ngi.it> <20050124081449.GA2650@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124081449.GA2650@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 09:14:49AM +0100, Andries Brouwer wrote:
> On Mon, Jan 24, 2005 at 01:34:56AM +0100, Alessandro Sappia wrote:
> 
> > I was reading vt driver
> > and I saw
> >         /*
> >          * To have permissions to do most of the vt ioctls, we either have
> >          * to be the owner of the tty, or have CAP_SYS_TTY_CONFIG.
> >          */
> >         perm = 0;
> >         if (current->signal->tty == tty || capable(CAP_SYS_TTY_CONFIG))
> >                 perm = 1;
> > 
> > (lines 382-388 - drivers/char/vt_ioctl.c)
> > 
> > After reading the comment I thinked I can change vt
> > from one of my own to another one of mine.
> 
> Yes, the comment. But you should read the code instead.

In general, a comment reflects the intention of the programmer, whereas
the code reflects what he in fact ended up doing (the implementation).
So if the two don't match, the code is probably buggy.
This is why comments can be important; they reflect the intention of
the programmer at the time he wrote the code.

Toon.
-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
