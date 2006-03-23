Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWCWQ4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWCWQ4M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 11:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWCWQ4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 11:56:12 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11282 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751449AbWCWQ4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 11:56:11 -0500
Date: Thu, 23 Mar 2006 16:55:58 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.16-git6: build failure: ne2k-pci: footbridge_defconfig
Message-ID: <20060323165558.GE25849@flint.arm.linux.org.uk>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
References: <20060323164109.GD25849@flint.arm.linux.org.uk> <1143132732.3147.33.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143132732.3147.33.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 05:52:12PM +0100, Arjan van de Ven wrote:
> On Thu, 2006-03-23 at 16:41 +0000, Russell King wrote:
> > Building the ARM footbridge_defconfig provokes this build error:
> > 
> >   CC      drivers/net/ne2k-pci.o
> > drivers/net/ne2k-pci.c:123: error: pci_clone_list causes a section type conflict
> > make[2]: *** [drivers/net/ne2k-pci.o] Error 1
> > make[1]: *** [drivers/net] Error 2
> > make: *** [drivers] Error 2
> > make: Leaving directory `/var/tmp/kernel-orig'
> > 
> > static const struct {
> >         char *name;
> >         int flags;
> > } pci_clone_list[] __devinitdata = {
> > 
> > const data can't be __devinitdata.
> 
> 
> that's a gcc bug; probably arm specific even?

It's gcc 4.01... the kautobuild folk are going to try gcc 4.04 instead.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
