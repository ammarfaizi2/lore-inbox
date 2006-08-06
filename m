Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWHFVFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWHFVFT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 17:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWHFVFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 17:05:19 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:10769 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750714AbWHFVFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 17:05:18 -0400
Date: Sun, 6 Aug 2006 22:05:09 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Fix base address configuration in wbsd
Message-ID: <20060806210509.GF16816@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	linux-kernel@vger.kernel.org
References: <20060806202223.13663.66134.stgit@poseidon.drzeus.cx> <20060806204842.GE16816@flint.arm.linux.org.uk> <44D657BF.6070004@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D657BF.6070004@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2006 at 10:57:35PM +0200, Pierre Ossman wrote:
> Russell King wrote:
> > On Sun, Aug 06, 2006 at 10:22:23PM +0200, Pierre Ossman wrote:
> >> There were some confusion about base I/O variables in the wbsd driver.
> >> Seems like things have been working on shear luck so far. The global 'io'
> >> variable (used when manually configuring the resources) was used instead of
> >> the local 'base' variable.
> > 
> > Applied, thanks.
> > 
> > Shouldn't "base" be something other than "int" (eg, unsigned long) ?
> 
> unsigned short would probably be the right<tm> thing as the resource is
> 16 bits. I haven't seen it as big enough issue to warrant a patch.

Is that a safe assumption to make?  Is this only ever going to appear/be
used on x86?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
