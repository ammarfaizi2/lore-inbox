Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVA1RfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVA1RfE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 12:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVA1RfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 12:35:03 -0500
Received: from colo.lackof.org ([198.49.126.79]:53716 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261312AbVA1RcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 12:32:10 -0500
Date: Fri, 28 Jan 2005 10:32:22 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, Greg KH <greg@kroah.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Matthew Wilcox <matthew@wil.cx>,
       linux-pci@atrey.karlin.mff.cuni.cz, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Patch to control VGA bus routing and active VGA device.
Message-ID: <20050128173222.GC30791@colo.lackof.org>
References: <9e47339105011719436a9e5038@mail.gmail.com> <20050125042459.GA32697@kroah.com> <9e473391050127015970e1fedc@mail.gmail.com> <200501270828.43879.jbarnes@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501270828.43879.jbarnes@sgi.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 08:28:43AM -0800, Jesse Barnes wrote:
> But then again,
> I suppose if a platform supports more than one legacy I/O space,

Eh?! there can only be *one* legacy I/O space.
We can support multipl IO port spaces, but only one can be the "legacy".

Moving the VGA device can only function within that legacy space
the way the code is written now (using hard coded addresses).
If it is intended to work with multiple IO Port address spaces,
then it needs to use the pci_dev->resource[] and mangle that appropriately.

grant
