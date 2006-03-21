Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751615AbWCUMuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbWCUMuv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 07:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbWCUMuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 07:50:51 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:48135 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751614AbWCUMuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 07:50:50 -0500
Date: Tue, 21 Mar 2006 13:50:49 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       David Vrabel <dvrabel@arcom.com>
Subject: Re: [PATCH 04/23] driver core: platform_get_irq*(): return -ENXIO on error
Message-ID: <20060321125049.GB83095@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	David Vrabel <dvrabel@arcom.com>
References: <11428920373568-git-send-email-gregkh@suse.de> <11428920383013-git-send-email-gregkh@suse.de> <20060321001336.GB84147@dspnet.fr.eu.org> <20060321080709.GD21287@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060321080709.GD21287@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 08:07:09AM +0000, Russell King wrote:
> On Tue, Mar 21, 2006 at 01:13:36AM +0100, Olivier Galibert wrote:
> > On Mon, Mar 20, 2006 at 02:00:38PM -0800, Greg Kroah-Hartman wrote:
> > > platform_get_irq*() cannot return 0 on error as 0 is a valid IRQ on some
> > > platforms, return -ENXIO instead.
> > 
> > 0 is NO_IRQ, and can not be a valid IRQ number, ever.  A
> > platform_get_irq*() returning 0 as a valid irq is buggy.
> > 
> > Check http://lkml.org/lkml/2005/11/21/211
> 
> No.  That's Linus' _opinion_, which is not applicable to systems without
> the obviously broken PCI or ISA busses.  On such systems, IRQ0 has no
> special meaning what so ever.

Do the drivers know?

  OG.
