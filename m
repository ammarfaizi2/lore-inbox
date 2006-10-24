Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422628AbWJXVhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422628AbWJXVhr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 17:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161246AbWJXVhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 17:37:47 -0400
Received: from havoc.gtf.org ([69.61.125.42]:56278 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1161244AbWJXVhp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 17:37:45 -0400
Date: Tue, 24 Oct 2006 17:37:44 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, John Partridge <johnip@sgi.com>
Subject: Re: Ordering between PCI config space writes and MMIO reads?
Message-ID: <20061024213744.GH2043@havoc.gtf.org>
References: <adafyddcysw.fsf@cisco.com> <1161725063.22348.39.camel@localhost.localdomain> <aday7r5bdx0.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aday7r5bdx0.fsf@cisco.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 02:29:47PM -0700, Roland Dreier wrote:
>  > It is good to be conservative in this area. Some AMD chipsets at least
>  > had ordering problems with some configurations in the K7 era.
> 
> Could you expand a little?  Do you mean that the arch implementation
> of pci_write_config_xxx() should have extra barriers, or that drivers
> should do belt-and-suspenders flushes to make sure config writes are
> really done properly?

Drivers are -already- written to assume the pci_write_config_xxx() has
the requisite barriers.  The fix doesn't belong in the drivers.

	Jeff



