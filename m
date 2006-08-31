Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWHaVlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWHaVlJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 17:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWHaVlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 17:41:09 -0400
Received: from cantor2.suse.de ([195.135.220.15]:27008 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932370AbWHaVlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 17:41:06 -0400
Date: Thu, 31 Aug 2006 14:40:56 -0700
From: Greg KH <greg@kroah.com>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Simple userspace interface for PCI drivers
Message-ID: <20060831214056.GB11939@kroah.com>
References: <20060830062338.GA10285@kroah.com> <1157013027.7566.515.camel@capoeira> <1157056749.4386.137.camel@mindpipe> <1157057934.24286.3.camel@bip.parateam.prv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157057934.24286.3.camel@bip.parateam.prv>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2006 at 10:58:54PM +0200, Xavier Bestel wrote:
> Le jeudi 31 ao?t 2006 ? 16:39 -0400, Lee Revell a ?crit :
> > On Thu, 2006-08-31 at 10:30 +0200, Xavier Bestel wrote:
> > > Hi Greg,
> > > 
> > > On Wed, 2006-08-30 at 08:23, Greg KH wrote:
> > > [...]
> > > > Thomas and I lamented that we were getting tired of seeing stuff like
> > > > this, and it was about time that we added the proper code to the kernel
> > > > to provide everything that would be needed in order to write PCI drivers
> > > > in userspace in a sane manner.  Really all that is needed is a way to
> > > > handle the interrupt, everything else can already be done in userspace
> > > > (look at X for an example of this...)
> > > [...]
> > > > So, here's the code. 
> > > 
> > > I know I look like I'm trolling here, but as this is the perfect
> > > stable-binary-driver-ABI some people have been looking for, it would be
> > > wise to make it taint the kernel with its own flag.
> > 
> > Why?  There's no technical or legal requirement for userspace drivers to
> > be GPLed.
> 
> Precisely. How do you know the bugreport you received isn't caused by
> some weird binary userspace driver hosing the PCI bus ?

You don't know that today.  Nothing new here.  So no, adding a taint
flag would achieve nothing.  Unless you want to do that today for all
the ways a userspace program can directly access a PCI device today?

greg k-h
