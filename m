Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbTLLTCE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 14:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTLLTCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 14:02:04 -0500
Received: from mail.kroah.org ([65.200.24.183]:11467 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261868AbTLLTBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 14:01:38 -0500
Date: Fri, 12 Dec 2003 11:01:05 -0800
From: Greg KH <greg@kroah.com>
To: Johannes Stezenbach <js@convergence.de>, sensors@stimpy.netroedge.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11: i2c-dev.h for userspace
Message-ID: <20031212190105.GB3038@kroah.com>
References: <20031212145652.GA30747@convergence.de> <20031212175656.GA2933@kroah.com> <20031212185357.GB32169@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031212185357.GB32169@convergence.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 07:53:57PM +0100, Johannes Stezenbach wrote:
> On Fri, Dec 12, 2003 at 09:56:57AM -0800, Greg KH wrote:
> > On Fri, Dec 12, 2003 at 03:56:52PM +0100, Johannes Stezenbach wrote:
> > > 
> > > I had some trouble compiling a userspace application
> > > which uses the I2C device interface (the DirectFB
> > > Matrox driver). Apparently some stuff has been removed
> > > from i2c-dev.h
> > 
> > Yes it has.  Do not use the kernel headers in your userspace
> > application.  If you need this interface, use the updated i2c-dev.h that
> > is in the lmsensors release.  That is the proper file.
> 
> I think you create a mess here. Other drivers have usable
> API include files in /usr/include/linux, why are i2c.h and i2c-dev.h
> special?

They aren't.  The rule is:
	DO NOT INCLUDE KERNEL HEADER FILES IN USERSPACE TOOLS.
Please read the archives for lkml on why this is true.

Yeah, we do need a way to have "sanitized" kernel headers so that
userspace can include them, but for now, use what your libc provides.

So please use the headers that are present in the lmsensors project, or
copy those headers into your project.

I don't want this thread to drag out into the usual argument for or
against this issue, please.

> I think that sucks.

Sorry you feel that way, but the i2c header is not going to be any
different than any other kernel header at this time.

greg k-h
