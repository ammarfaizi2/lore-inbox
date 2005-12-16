Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbVLPDTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbVLPDTQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 22:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbVLPDTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 22:19:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:44186 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751295AbVLPDTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 22:19:16 -0500
Date: Thu, 15 Dec 2005 16:51:38 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>
Subject: Re: MSI and driver APIs
Message-ID: <20051216005138.GA20547@kroah.com>
References: <1134617893.16880.17.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134617893.16880.17.camel@gaston>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 02:38:12PM +1100, Benjamin Herrenschmidt wrote:
> So I want to start looking into separate implementation for powerpc, and
> based on what I come up with, find the commonalities and split the
> generic code.

That would be great, as it really is i386/x86-64 specific right now.

> However, there is at least one assumption that annoys me:
> 
> Currently, we assume that MSIs are disabled upon discovery of a device.
> That is, a driver probe() routine is called with MSIs off.
> 
> This is annoying on platforms with "intelligent" firmwares like POWER
> with hypervisor, as the firmware will have already configured MSIs for
> the full system & assigned them to devices.

If you are curious as to why this is, look at the lkml archives about a
month or two ago, where I tried to enable MSI by default.  It was a real
mess and caused way more problems than it tried to solve.

So, as David said, I don't think this is going to work out, sorry.

thanks,

greg k-h
