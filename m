Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265675AbTGDCKw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 22:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265676AbTGDCIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 22:08:19 -0400
Received: from granite.he.net ([216.218.226.66]:54286 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265728AbTGDCID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 22:08:03 -0400
Date: Thu, 3 Jul 2003 19:22:26 -0700
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Patrick Mochel <mochel@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [7/6] PCI config space in sysfs
Message-ID: <20030704022225.GA4532@kroah.com>
References: <20030703204258.GB23597@parcelfarce.linux.theplanet.co.uk> <20030704013131.GF23597@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030704013131.GF23597@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 04, 2003 at 02:31:31AM +0100, Matthew Wilcox wrote:
> On Thu, Jul 03, 2003 at 09:42:58PM +0100, Matthew Wilcox wrote:
> >  - Fix a couple of bugs in sysfs's handling of binary files (my fault).
> 
> Now I'm having second thoughts.  Sigh ;-)

Bleah, right after I sent these patches off :(

> My intended design was that sysfs would copy to/from buffer + offset
> rather than buffer.  Seems that change 1.6 to this file (hm, bkweb seems
> broken at the moment?) changed that.  so that broke my pci-sysfs changes
> which weren't in the tree at the time.
> 
> It probably makes more sense to copy to/from buffer rather than
> buffer+offset so we can implement larger sized binary files (we can use
> a smaller buffer than the size of the file and do multiple read/write
> calls).
> 
> So I think I'd like to hold off on this patchset, not change sysfs and
> adapt my changes to the new API (which I didn't even know had changed.
> grr.)

Ok, want to send a patch to backout only the api changes that you made?

thanks,

greg k-h
