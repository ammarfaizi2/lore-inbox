Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbULQWIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbULQWIi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 17:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbULQWFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 17:05:22 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:60857 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262181AbULQWCt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 17:02:49 -0500
Date: Fri, 17 Dec 2004 14:02:08 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Cleanup PCI power states
Message-ID: <20041217220208.GA22752@kroah.com>
References: <20041116130445.GA10085@elf.ucw.cz> <20041116155613.GA1309@kroah.com> <20041117120857.GA6952@openzaurus.ucw.cz> <20041124234057.GF4649@kroah.com> <20041125113631.GB1027@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125113631.GB1027@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2004 at 12:36:31PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > > This is step 0 before adding type-safety to PCI layer... It introduces
> > > > > constants and uses them to clean driver up. I'd like this to go in
> > > > > now, so that I can convert drivers during 2.6.10... Please apply,
> > > > 
> > > > The tree is in "bugfix only" mode right now.  Changes like this need to
> > > > wait for 2.6.10 to come out before I can send it upward.
> > > > 
> > > > So, care to hold on to it for a while?  Or I can add it to my "to apply
> > > > after 2.6.10 comes out" tree, which will mean it will end up in the -mm
> > > > releases till that happens.
> > > 
> > > I think I'd prefer visibility of "to apply after 2.6.10" tree... Thanks,
> > 
> > Care to resend this, I seem to have lost them :(
> 
> Okay, here it is, slightly expanded version. It actually makes use of
> newly defined type for type-checking purposes; still no code changes.

Alright, I've applied this, and it will show up in the next -mm release.
I also fixed up pci.h for when CONFIG_PCI=N due to your changed
functions.

Now, care to send patches to fix up all of the new sparse warnings in
the drivers/pci/* directory?

Also, next time I need a "Signed-off-by:" line for the patch.

thanks,

greg k-h
