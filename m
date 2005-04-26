Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVDZJYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVDZJYU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 05:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVDZJYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 05:24:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33810 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261425AbVDZJYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 05:24:13 -0400
Date: Tue, 26 Apr 2005 10:24:05 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: pci-sysfs resource mmap broken
Message-ID: <20050426102405.B14242@flint.arm.linux.org.uk>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-pci@atrey.karlin.mff.cuni.cz,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>
References: <1114493609.7183.55.camel@gaston> <1114495782.7112.60.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1114495782.7112.60.camel@gaston>; from benh@kernel.crashing.org on Tue, Apr 26, 2005 at 04:09:41PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 04:09:41PM +1000, Benjamin Herrenschmidt wrote:
> Ok, after a bit more thinking, I think I'll go that way for now, please
> let me know if you think I'm wrong:
> 
> rename "resource" to "resources" and make it contain a start address
> that matches the BAR value, that is something that has at least some
> sort of meaning in userland and can be passed to pci_mmap_page_range().
> To do that "translation", I'll read the BAR value, and use it as start,
> then use the resource size & flags.
> 
> The name change will also allow userland to "detect" the fixed
> implementation.

I'll wait until I see code before commenting.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
