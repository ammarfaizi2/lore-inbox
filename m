Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbVKPHMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbVKPHMO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 02:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbVKPHMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 02:12:14 -0500
Received: from peabody.ximian.com ([130.57.169.10]:16344 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1751302AbVKPHMN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 02:12:13 -0500
Subject: Re: [RFC][PATCH 2/6] PCI PM: capability probing and setup
From: Adam Belay <abelay@novell.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051116062154.GB31375@suse.de>
References: <1132111878.9809.52.camel@localhost.localdomain>
	 <20051116062154.GB31375@suse.de>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 02:21:01 -0500
Message-Id: <1132125661.3656.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-15 at 22:21 -0800, Greg KH wrote:
> On Tue, Nov 15, 2005 at 10:31:17PM -0500, Adam Belay wrote:
> > +int pci_setup_device_pm(struct pci_dev *dev)
> 
> Care to give kernel doc for this new function?

Absolutely.  I was planing to do this but must have forgotten.

> > +	unsigned char	state_mask;	/* a mask of supported power states */
> > +	unsigned char	pme_mask;	/* a mask of power states that allow #PME */ 
> 
> Trailing space, use quilt it strips this :)

Sorry about that :)

> 
> > +	struct pci_dev_pm *pm;		/* power management information */
> 
> Why make this a pointer and not just part of this structure?  Don't all
> pci devices need this?

Actually, not every PCI device supports the PCI PM spec.  There are many
devices, even in modern systems, that can only be in D0.  I was thinking
we could save some memory and allocate this structure when PCI PM is
detected.  Would that be ok?

Thanks,
Adam


