Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbVIQQrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbVIQQrQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 12:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbVIQQrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 12:47:16 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:266 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751151AbVIQQrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 12:47:15 -0400
Date: Sat, 17 Sep 2005 12:46:52 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Greg KH <greg@kroah.com>
Cc: Tony Luck <tony.luck@gmail.com>, Keith Owens <kaos@sgi.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: 2.6.14-rc1 breaks tg3 on ia64
Message-ID: <20050917164649.GC19854@tuxdriver.com>
Mail-Followup-To: Greg KH <greg@kroah.com>, Tony Luck <tony.luck@gmail.com>,
	Keith Owens <kaos@sgi.com>, linux-kernel@vger.kernel.org,
	linux-ia64@vger.kernel.org
References: <20050913065937.GA7849@kroah.com> <25288.1126596450@kao2.melbourne.sgi.com> <12c511ca05091708476aa136cd@mail.gmail.com> <20050917155911.GB19854@tuxdriver.com> <20050917161617.GA23171@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050917161617.GA23171@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2005 at 09:16:17AM -0700, Greg KH wrote:
> On Sat, Sep 17, 2005 at 11:59:14AM -0400, John W. Linville wrote:
> > On Sat, Sep 17, 2005 at 08:47:03AM -0700, Tony Luck wrote:

> > > Anyone know anything more about this problem?  I'm not seeing it
> > > on any of my systems ... so perhaps it only affects cards with a
> > > PCI bridge on them, or cards that haven't already been initialized
> > > by EFI.
> > 
> > I posted a patch on Wednesday:
> > 
> > 	http://www.ussg.iu.edu/hypermail/linux/kernel/0509.1/2193.html
> > 
> > The original reporter (Keith Owens <kaos@sgi.com>) confirmed this
> > patch to fix the problem.
> 
> Yes, and a number of people objected to that patch.  Care to respond to
> them?

Care to check your email? :-)

	http://www.ussg.iu.edu/hypermail/linux/kernel/0509.1/2267.html

Basically, the concerns raised are non-issues.	The new patch
merely limits the BAR restoration to those situations where it is
truly needed.  Anything broken in that situation was broken before
the original patch as well.

The only other point was that this particular ia64 hardware is
broken if you can't rewrite its BARs.  That may well be, but we can
accomodate it w/o losing the intent of the original patch.

Tony's post indicates that this is not a generic ia64 problem.  If you
want a patch along the lines of what Dave Miller and Ivan Kokshaysky
advocate (i.e. something in the pci access routines for this box),
then Keith or someone else w/ knowledge of (and access to) this box
will need to step forward w/ a patch or at least some information.

John
-- 
John W. Linville
linville@tuxdriver.com
