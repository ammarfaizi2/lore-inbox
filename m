Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290302AbSBXRif>; Sun, 24 Feb 2002 12:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290289AbSBXRiZ>; Sun, 24 Feb 2002 12:38:25 -0500
Received: from [24.243.44.28] ([24.243.44.28]:6411 "EHLO explorer.dummynet")
	by vger.kernel.org with ESMTP id <S290550AbSBXRiK>;
	Sun, 24 Feb 2002 12:38:10 -0500
Date: Sun, 24 Feb 2002 11:37:11 -0600
From: Dan Hopper <dbhopper@austin.rr.com>
To: Greg KH <greg@kroah.com>
Cc: Patrick Mochel <mochel@osdl.org>,
        Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.5.5-pre1 rmmod usb-uhci hangs
Message-ID: <20020224173711.GA2355@yoda.dummynet>
Mail-Followup-To: Dan Hopper <dbhopper@austin.rr.com>,
	Greg KH <greg@kroah.com>, Patrick Mochel <mochel@osdl.org>,
	Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-usb-devel@lists.sourceforge.net
In-Reply-To: <fa.n7cofbv.1him3j@ifi.uio.no> <fa.dsb79pv.on84ii@ifi.uio.no> <20020224025411.GA2418@yoda.dummynet> <20020224062124.GB15060@kroah.com> <20020224063915.GA2799@yoda.dummynet> <20020224064931.GD15060@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020224064931.GD15060@kroah.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> remarked:
> On Sun, Feb 24, 2002 at 12:39:15AM -0600, Dan Hopper wrote:
> > 
> > The reason I'd like to switch back to usb-uhci instead of uhci is
> > twfold:  Vmware seems to want to only use usb-uhci and not uhci
> > (dummies!).  And uhci seems to be unable to get the scanner going
> > such that it doesn't "stutter" all the way down the page.  usb-uhci
> > seems to be able to keep up so that it just sweeps on down the page.
> 
> I noticed that Vmware does that, and was wondering why.
> 
> If you get a chance, can you try the uhci patches that were posted on
> linux-usb-devel last week, or all of them rolled up at:
> 	http://www.kernel.org/pub/linux/kernel/people/gregkh/usb/linux-2.4.18-rc2-gregkh-1.patch.gz
> and let me know if that solves your problem with uhci or not?

Well, that was interesting.  I upgraded to rc2 and applied that
patch.  uhci still behaved the same (can't keep up with scanner). 
But usb-uhci now doesn't lock up the system on a shutdown.  And it
was the patch that did it, not rc2, because I tried a pristine rc2
build, too, and it still locks up.  I note that there's nothing in
the patch that directly touches usb-uhci, so it must be a side
affect of some other fix.

(I'd still like to eventually get uhci working, since the docs
indicate it's the newer, cooler driver.  And the ipaq driver
indicates uhci is preferred over the usb-uhci driver.)

Thanks, Greg!  That was quite useful.

Dan
