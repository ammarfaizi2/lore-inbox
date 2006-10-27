Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752333AbWJ0RWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbWJ0RWZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 13:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752335AbWJ0RWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 13:22:25 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58595 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1752314AbWJ0RWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 13:22:24 -0400
Date: Fri, 27 Oct 2006 19:22:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [RFC: 2.6.19 patch] let PCI_MULTITHREAD_PROBE depend on BROKEN
Message-ID: <20061027172219.GC30416@elf.ucw.cz>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <20061026224541.GQ27968@stusta.de> <20061027010252.GV27968@stusta.de> <20061027012058.GH5591@parisc-linux.org> <20061026182838.ac2c7e20.akpm@osdl.org> <20061026191131.003f141d@localhost.localdomain> <20061027170748.GA9020@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061027170748.GA9020@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > PCI_MULTITHREAD_PROBE is an interesting feature, but in it's current 
> > > > > state it seems to be more of a trap for users who accidentally
> > > > > enable it.
> > > > > 
> > > > > This patch lets PCI_MULTITHREAD_PROBE depend on BROKEN for 2.6.19.
> > > > > 
> > > > > The intention is to get this patch reversed in -mm as soon as it's in 
> > > > > Linus' tree, and reverse it for 2.6.20 or 2.6.21 after the fallout of 
> > > > > in-kernel problems PCI_MULTITHREAD_PROBE causes got fixed.
> > > > 
> > > > People who enable features clearly marked as EXPERIMENTAL deserve what
> > > > they get, IMO.
> > > 
> > > It's not the impact on "people" which is of concern - it's the impact on
> > > kernel developers - specifically those who spend time looking at bug
> > > reports :(
> > 
> > Either it is broken and should be removed, or is barely working and
> > should be fixed. If Greg wants to take bug reports then it can stay.
> 
> I want to keep taking bug reports.
> 
> I've found only 1 real bug from all of this.  The pci MSI initialization
> issue.  It's on my queue of things to fix.  Andrew has also sent me
> another "interesting" patch about making sure devices are found by the
> time we hit another init level which I'll see about adding too.

And the swsusp vs. SATA issue? Currently, SATA can be initialized
after swsusp, leading to swsusp not finding its image and failing...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
