Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVBQXsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVBQXsJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 18:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVBQXqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 18:46:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:19607 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261235AbVBQXUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 18:20:19 -0500
Date: Thu, 17 Feb 2005 15:07:39 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       tom.l.nguyen@intel.com
Subject: Re: avoiding pci_disable_device()...
Message-ID: <20050217230739.GA21999@kroah.com>
References: <4210021F.7060401@pobox.com> <20050214190619.GA9241@kroah.com> <4211013E.6@pobox.com> <52hdke29sh.fsf@topspin.com> <20050214200043.GA15868@havoc.gtf.org> <52d5v224z3.fsf@topspin.com> <42112544.2030006@pobox.com> <528y5q220h.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <528y5q220h.fsf@topspin.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 02:46:38PM -0800, Roland Dreier wrote:
> OK, I'm happy to go along with that (it definitely simplifies my
> driver code).  Here's the patch.
> 
> 
> Remove the call to request_mem_region() in msix_capability_init() to
> grab the MSI-X vector table.  Drivers should be using
> pci_request_regions() so that they own all of the PCI BARs, and the
> MSI-X core should trust it's being called by a correct driver.
> 
> Signed-off-by: Roland Dreier <roland@topspin.com>

Applied, thanks,

greg k-h
