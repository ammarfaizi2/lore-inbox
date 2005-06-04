Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVFDAEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVFDAEm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 20:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbVFDAEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 20:04:42 -0400
Received: from gate.crashing.org ([63.228.1.57]:43487 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261184AbVFDAEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 20:04:37 -0400
Subject: Re: pci_enable_msi() for everyone?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <gregkh@suse.de>, tom.l.nguyen@intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       roland@topspin.com, davem@davemloft.net,
       Michael Chan <mchan@broadcom.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <42A0E4B4.3050309@pobox.com>
References: <20050603224551.GA10014@kroah.com>  <42A0E4B4.3050309@pobox.com>
Content-Type: text/plain
Date: Sat, 04 Jun 2005 10:01:04 +1000
Message-Id: <1117843264.31082.204.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	pci_enable(info on what to enable)
> 
> so that drivers can specify ahead of time "don't enable PIO, only MMIO", 
> "don't enable MMIO, only PIO", "don't use MSI", etc.  and add a 
> pci_disable() to undo all of that.
> 
> The more we add singleton functions like pci_enable_msi(), 
> pci_set_master(), etc. the more I wish for a single function that 
> handled all those details at one atomic point.  There is a lot of 
> standard patterns that are hand-coded into every PCI driver's probe 
> functions.

Agreed, with the proper arch hook to deal with arch brokenness of
course.

That could be a bitmap. What I'm not 100% confident at this point is
wether we want a bit per BAR or an "IO" bit and an "MMIO" bit. I think
I'd rather go for the first one.

Ben.


