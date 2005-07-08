Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262622AbVGHFxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbVGHFxN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 01:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbVGHFxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 01:53:13 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:32408 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262622AbVGHFvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 01:51:11 -0400
Date: Fri, 8 Jul 2005 09:51:04 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "David S. Miller" <davem@davemloft.net>
Cc: linville@tuxdriver.com, rmk+lkml@arm.linux.org.uk, matthew@wil.cx,
       grundler@parisc-linux.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, greg@kroah.com,
       ambx1@neo.rr.com
Subject: Re: [patch 2.6.12 (repost w/ corrected subject)] pci: restore BAR values in pci_enable_device_bars
Message-ID: <20050708095104.A612@den.park.msu.ru>
References: <20050705224620.B15292@flint.arm.linux.org.uk> <20050706033454.A706@den.park.msu.ru> <20050708005701.GA13384@tuxdriver.com> <20050707.201103.41635951.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050707.201103.41635951.davem@davemloft.net>; from davem@davemloft.net on Thu, Jul 07, 2005 at 08:11:03PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 08:11:03PM -0700, David S. Miller wrote:
> > Problem: pci_update_resource doesn't exist for sparc64.
> 
> Yes, the drivers/pci/setup-res.c code isn't compiled in on
> sparc64 because it assumes a totally different model of
> PCI bus probing than we use on sparc64.

Why not just implement sparc64 version of pci_update_resource elsewhere
(perhaps a dummy one, if you don't need PCI PM), rather than force the
rest of the world to duplicate the code?

Ivan.
