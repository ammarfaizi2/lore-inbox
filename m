Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbVJSRA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbVJSRA2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 13:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbVJSRA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 13:00:28 -0400
Received: from mail.kroah.org ([69.55.234.183]:37594 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751153AbVJSRA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 13:00:27 -0400
Date: Wed, 19 Oct 2005 09:59:40 -0700
From: Greg KH <greg@kroah.com>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, acpi-devel@lists.sourceforge.net,
       pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       "Shah, Rajesh" <rajesh.shah@intel.com>,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: [ACPI] Re: [Pcihpd-discuss] RE: [patch 2/2] acpi: add ability to derive irq when doing a surpriseremoval of an adapter
Message-ID: <20051019165940.GA2177@kroah.com>
References: <59D45D057E9702469E5775CBB56411F190A57F@pdsmsx406> <1129053267.15526.9.camel@whizzy> <1129679877.30588.5.camel@whizzy> <200510190929.06728.bjorn.helgaas@hp.com> <1129740711.31966.21.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129740711.31966.21.camel@whizzy>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2005 at 09:51:51AM -0700, Kristen Accardi wrote:
> On Wed, 2005-10-19 at 09:29 -0600, Bjorn Helgaas wrote:
> > On Tuesday 18 October 2005 5:57 pm, Kristen Accardi wrote:
> > > For surprise hotplug removal, the interrupt pin must be guessed, as any
> > > attempts to read it would obviously be invalid.  This patch adds a new
> > > function to cycle through all possible pin values, and tries to either
> > > lookup or derive the right irq to disable.
> > 
> > I don't really like this because it adds a new path that's only
> > used for "surprise" removals.  So we have acpi_pci_irq_disable(),
> > which is used for normal removals, and acpi_pci_irq_disable_nodev()
> > for the surprise path.  That feels like a maintenance problem.
> > 
> > Other, non-ACPI, IRQ routing schemes should have the same problem
> > (needing to know the interrupt pin after the device has been removed),
> > so maybe the pin needs to be cached in the pci_dev?
> 
> This seems like a good idea to me, if nobody objects to adding another
> field to pci_dev, I can change the patch to do this and resubmit. 

No objection from me.

thanks,

greg k-h
