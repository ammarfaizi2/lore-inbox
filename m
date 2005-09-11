Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbVIKGLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbVIKGLG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 02:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbVIKGLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 02:11:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:22234 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964781AbVIKGLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 02:11:04 -0400
Date: Sat, 10 Sep 2005 21:41:06 -0700
From: Greg KH <greg@kroah.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
Message-ID: <20050911044106.GA6611@kroah.com>
References: <Pine.LNX.4.44L0.0509101655520.7081-100000@netrider.rowland.org> <Pine.LNX.4.58.0509101410300.30958@g5.osdl.org> <43235707.7050909@pobox.com> <200509102332.54619.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509102332.54619.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2005 at 11:32:54PM +0100, Alistair John Strachan wrote:
> On Saturday 10 September 2005 22:58, Jeff Garzik wrote:
> > Linus Torvalds wrote:
> > > Case closed.
> > >
> > > Bogus warnings are a _bad_ thing. They cause people to write buggy code.
> > >
> > > That drivers/pci/pci.c code should be simplified to not look at the error
> > > return from pci_set_power_state() at all. Special-casing EIO is just
> > > another bug waiting to happen.
> >
> > As a tangent, the 'foo is deprecated' warnings for pm_register() and
> > inter_module_register() annoy me, primarily because they never seem to
> > go away.
> >
> > The only user of inter_module_xxx is CONFIG_MTD -- thus the deprecated
> > warning is useless to 90% of us, who will never use MTD.  As for
> > pm_register(), there are tons of users remaining.  As such, for the
> > forseeable future, we will continue to see pm_register() warnings and
> > ignore them -- thus they are nothing but useless build noise.
> >
> > I've attached a patch, just tested, which addresses inter_module_xxx by
> > making its build conditional on the last remaining user.  This solves
> > the deprecated warning problem for most of us, and makes the kernel
> > smaller for most of us, at the same time.
> 
> Though external modules using these functions will be hung out to dry.

External modules are always hung out to dry.  Seriously, you don't have
code using those functions, do you?  If so, it's not like you haven't
been warned...

thanks,

greg k-h
