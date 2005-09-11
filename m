Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbVIKGrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbVIKGrO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 02:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVIKGrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 02:47:14 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:44722 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S932325AbVIKGrO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 02:47:14 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Greg KH <greg@kroah.com>
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
Date: Sun, 11 Sep 2005 07:47:21 +0100
User-Agent: KMail/1.8.90
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0509101655520.7081-100000@netrider.rowland.org> <200509102332.54619.s0348365@sms.ed.ac.uk> <20050911044106.GA6611@kroah.com>
In-Reply-To: <20050911044106.GA6611@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509110747.21747.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 September 2005 05:41, Greg KH wrote:
> On Sat, Sep 10, 2005 at 11:32:54PM +0100, Alistair John Strachan wrote:
> > On Saturday 10 September 2005 22:58, Jeff Garzik wrote:
> > > Linus Torvalds wrote:
> > > > Case closed.
> > > >
> > > > Bogus warnings are a _bad_ thing. They cause people to write buggy
> > > > code.
> > > >
> > > > That drivers/pci/pci.c code should be simplified to not look at the
> > > > error return from pci_set_power_state() at all. Special-casing EIO is
> > > > just another bug waiting to happen.
> > >
> > > As a tangent, the 'foo is deprecated' warnings for pm_register() and
> > > inter_module_register() annoy me, primarily because they never seem to
> > > go away.
> > >
> > > The only user of inter_module_xxx is CONFIG_MTD -- thus the deprecated
> > > warning is useless to 90% of us, who will never use MTD.  As for
> > > pm_register(), there are tons of users remaining.  As such, for the
> > > forseeable future, we will continue to see pm_register() warnings and
> > > ignore them -- thus they are nothing but useless build noise.
> > >
> > > I've attached a patch, just tested, which addresses inter_module_xxx by
> > > making its build conditional on the last remaining user.  This solves
> > > the deprecated warning problem for most of us, and makes the kernel
> > > smaller for most of us, at the same time.
> >
> > Though external modules using these functions will be hung out to dry.
>
> External modules are always hung out to dry.  Seriously, you don't have
> code using those functions, do you?  If so, it's not like you haven't
> been warned...

I don't care, and no I don't. I was just making the point before somebody 
makes the mistake of doing something that isn't 100% clear cut.

Either you remove it, or you don't. You don't leave it there for some distros 
to enable with CONFIG_MTD and some not.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
