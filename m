Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbUKEVvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbUKEVvm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 16:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbUKEVvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 16:51:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:29337 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261170AbUKEVvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 16:51:15 -0500
Date: Fri, 5 Nov 2004 13:48:41 -0800
From: Greg KH <greg@kroah.com>
To: Justin Thiessen <jthiessen@penguincomputing.com>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com,
       phil@netroedge.com
Subject: Re: [PATCH] 2.6 lm85.c driver update
Message-ID: <20041105214841.GI1750@kroah.com>
References: <20041004200943.GE22290@penguincomputing.com> <20041019222920.GJ9521@kroah.com> <20041025203610.GA19053@penguincomputing.com> <20041025225959.6026626f.khali@linux-fr.org> <20041025220526.GC19053@penguincomputing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025220526.GC19053@penguincomputing.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 03:05:26PM -0700, Justin Thiessen wrote:
> On Mon, Oct 25, 2004 at 10:59:59PM +0200, Jean Delvare wrote:
> > > > Hm, there are a number of rejects in this patch.  Care to resync up
> > > > with the next kernel release and resend this?
> > > 
> > > Ok, try this:
> > > 
> > > signed off by:  Justin Thiessen  <jthiessen@penguincomputing.com>
> > > 
> > > patch for kernel 2.6.X lm85 driver follows:
> > > ----------------------------------------------------
> > > 
> > > --- linux-2.6.9/drivers/i2c/chips/lm85.c.orig	2004-10-18 14:53:46.000000000 -0700
> > > +++ linux-2.6.9/drivers/i2c/chips/lm85.c	2004-10-24 18:16:04.188509824 -0700
> > 
> > Unfortunately this won't be OK either. 2.6.10-rc1 has a lot of i2c
> > changes, including a number of things your patch attempts to fix (macro
> > abuse reported by Mark Hoffman). So it won't apply to Greg's tree.
> 
> 
> Aiiiiiiiieeeeeee.
> 
> 
> > Please provide your patch against 2.6.10-rc1. Sorry that you always seem
> > to provide your patch against the not-really-last tree ;)
> 
> It's not your fault I expect kernel releases to be rolled out by punchcards and
> horse-drawn wagon.
> 
> Thanks for the heads-up; see the following patch for a new, "improved" version.

Applied, thanks.

But now I get the following build warnings:

drivers/i2c/chips/lm85.c:220: warning: 'SMOOTH_TO_REG' defined but not used
drivers/i2c/chips/lm85.c:236: warning: 'SPINUP_TO_REG' defined but not used

Care to send me a patch to fix them up?

thanks,

greg k-h
