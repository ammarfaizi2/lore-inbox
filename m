Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263850AbUGFNAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbUGFNAI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 09:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUGFNAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 09:00:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19972 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263850AbUGFNAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 09:00:04 -0400
Date: Tue, 6 Jul 2004 14:00:00 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alexander Sirotkin <demiurg@ti.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cardbus/pci question
Message-ID: <20040706140000.A15348@flint.arm.linux.org.uk>
Mail-Followup-To: Alexander Sirotkin <demiurg@ti.com>,
	linux-kernel@vger.kernel.org
References: <40EA9B31.3000404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40EA9B31.3000404@ti.com>; from demiurg@ti.com on Tue, Jul 06, 2004 at 03:29:37PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2004 at 03:29:37PM +0300, Alexander Sirotkin wrote:
> I could not find any information on this in the archives, so I thought I 
> might ask it here.
> 
> Theoretically, it should be possible to write cardbus driver as a 
> regular PCI driver.

In Linux, a cardbus driver is exactly the same as a regular PCI driver.
There is no difference.  You get all the resources (device BARs) and
interrupts from the pci device structure, just like a regular PCI
driver.

There's no need to fiddle with the cardbus bridge at all.  In fact,
we'll scream at you if you attempt to do that because its a violation
of the system layering.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
