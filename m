Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbULQWEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbULQWEu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 17:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbULQWEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 17:04:49 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:1261 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262178AbULQWCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 17:02:49 -0500
Date: Fri, 17 Dec 2004 14:02:36 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Cleanup PCI power states
Message-ID: <20041217220236.GB22752@kroah.com>
References: <20041116130445.GA10085@elf.ucw.cz> <20041116155613.GA1309@kroah.com> <20041117120857.GA6952@openzaurus.ucw.cz> <20041124234057.GF4649@kroah.com> <20041125113913.GC1027@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125113913.GC1027@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2004 at 12:39:13PM +0100, Pavel Machek wrote:
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
> Could this go to "after 2.6.10 tree", too? It is a helper that
> converts system state into PCI state. We really do not want to have
> this copied into every driver, because it will need to change when
> system state gets type-checked / expanded to struct.

Applied, but you might want to modify pci.h so people can actually call
this function :)

thanks,

greg k-h
