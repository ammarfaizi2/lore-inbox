Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWJ1BMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWJ1BMp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 21:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWJ1BMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 21:12:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:8084 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751411AbWJ1BMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 21:12:44 -0400
Date: Fri, 27 Oct 2006 18:08:55 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Stephen Hemminger <shemminger@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [RFC: 2.6.19 patch] let PCI_MULTITHREAD_PROBE depend on BROKEN
Message-ID: <20061028010855.GA22273@kroah.com>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <20061026224541.GQ27968@stusta.de> <20061027010252.GV27968@stusta.de> <20061027012058.GH5591@parisc-linux.org> <20061026182838.ac2c7e20.akpm@osdl.org> <20061026191131.003f141d@localhost.localdomain> <20061027170748.GA9020@kroah.com> <20061027222326.GC27968@stusta.de> <20061027153854.b44c4ecb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061027153854.b44c4ecb.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2006 at 03:38:54PM -0700, Andrew Morton wrote:
> On Sat, 28 Oct 2006 00:23:26 +0200
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > ...
> > > So no, this should not be marked BROKEN.
> > > 
> > > It's a very experimental feature, as the help text says.  If you can
> > > think of any harsher language to put in that text, please let me know.
> > 
> > The problem is that if only 1 out of 100 people who are compiling a 
> > kernel accidentally enable this option, linux-kernel will be swamped 
> > with bug reports...
> > 
> 
> Yes, that's a legitimate practical concern, IMO.
> 
> I guess many of the people who test -rc kernels have sufficient familarity
> to know to disable this option, but a lot of the people who test major
> releases do not.  So how about we mark PCI_MULTITHREAD_PROBE as broken in
> 2.6.19-rc6, then revert that change in 2.6.20-rc1, and keep doing that
> until the feature is ready?

Ok, I can live with that.  I'll send in a change for this with the next
round of driver core fixes.

thanks,

greg k-h
