Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbTFZAW0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 20:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265188AbTFZAW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 20:22:26 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:65178 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265161AbTFZAWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 20:22:25 -0400
Date: Wed, 25 Jun 2003 17:36:20 -0700
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [RFC] pci_name()
Message-ID: <20030626003620.GB13892@kroah.com>
References: <20030625233525.GB451@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030625233525.GB451@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 26, 2003 at 12:35:25AM +0100, Matthew Wilcox wrote:
> 
> I'd kind of like to get rid of pci_dev->slot_name.  It's redundant with
> pci_dev->dev.bus_id, but that's one hell of a search and replace job.
> So let me propose pci_name(pci_dev) as a replacement.  That has the
> benefit of being shorter than either of the others and lets us do fun
> & interesting things later (maybe construct it on the fly for systems
> that want to save 20 bytes per device?).  We can transition it in over
> 2.5/2.6/2.7 and kill pci_dev->slot_name for 2.8.

That sounds reasonable.  But do we really need to do this for 2.6?

Just trying to keep things sane...

thanks,

greg k-h
