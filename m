Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750788AbWFEN2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWFEN2K (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 09:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWFEN2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 09:28:10 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:22788 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1750788AbWFEN2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 09:28:08 -0400
Date: Mon, 5 Jun 2006 09:27:37 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Christoph Hellwig <hch@infradead.org>, Jeff Garzik <jeff@garzik.org>,
        Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: wireless (was Re: 2.6.18 -mm merge plans)
Message-ID: <20060605132732.GA23350@tuxdriver.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20060604135011.decdc7c9.akpm@osdl.org> <20060605010636.GB17361@havoc.gtf.org> <20060605085451.GA26766@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060605085451.GA26766@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2006 at 09:54:51AM +0100, Christoph Hellwig wrote:
> On Sun, Jun 04, 2006 at 09:06:36PM -0400, Jeff Garzik wrote:
> > On Sun, Jun 04, 2006 at 01:50:11PM -0700, Andrew Morton wrote:
> > > acx1xx-wireless-driver.patch
> > > fix-tiacx-on-alpha.patch
> > > tiacx-fix-attribute-packed-warnings.patch
> > > tiacx-pci-build-fix.patch
> > > tiacx-ia64-fix.patch
> > > 
> > >   It is about time we did something with this large and presumably useful
> > >   wireless driver.
> > 
> > I've never had technical objections to merging this, just AFAIK it had a
> > highly questionable origin, namely being reverse-engineered in a
> > non-clean-room environment that might leave Linux legally vulnerable.
> 
> As are at leasdt a fourth of linux drivers.  Andrew, please just go ahead
> and merge it (I'll do another review ASAP).

Actually, I was planning to merge the softmac-based version for 2.6.18.
It looks like I may want some of Andrew's patches on top (ia64, alpha, etc).

http://www.kernel.org/pub/linux/kernel/people/linville/wireless-2.6/master/

	0003-wireless-add-acx-driver.txt
	0004-acxsm-merge-from-acx-0.3.32.txt
	0005-tiacx-Let-only-ACX_PCI-ACX_USB-be-user-visible.txt
	0007-tiacx-revert-neither-PCI-nor-USB-is-selected-change.txt
	0008-tiacx-implement-much-more-flexible-firmware-statistics-parsing.txt
	0009-tiacx-Change-acx_ioctl_-get-set-_encode-to-use-kernel-80211-stack.txt
	0010-tiacx-fix-breakage-of-Get-rid-of-circular-list-of-adev-s.txt
	0011-tiacx-split-module-into-acx-common-acx-pci-acx-usb.txt

Of course, I didn't know there were serious concerns about this
driver's origin.  I hope we aren't confusing this with the atheros
driver...?

> Please don't let this reverse engineering idiocy hinder wireless driver
> adoption, we're already falling far behind openbsd who are very successfull
> reverse engineering lots of wireless chipsets.

This bugbear does seem to keep visiting us.  It is a bit of a
minefield.

I'm inclined to think that Christoph and Arjan are right, that we
have been too cautious.  Of course, neither of these fine gentlemen
are known for their timidity... :-)

Does not the Signed-off-by: line on a patch submission give us some
level of "good faith" protection?

I'm tempted to take contributors at their word, that they have produced
their own work and not copied from others.  What else do we need?

John
-- 
John W. Linville
linville@tuxdriver.com
