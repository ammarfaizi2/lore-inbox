Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbVJWVNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbVJWVNb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 17:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVJWVNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 17:13:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20234 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750773AbVJWVNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 17:13:30 -0400
Date: Sun, 23 Oct 2005 22:13:20 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Laurent Riffard <laurent.riffard@free.fr>, Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, dmo@osdl.org, mike.miller@hp.com,
       iss_storagedev@hp.com, Jeff Garzik <garzik@pobox.com>
Subject: Re: [patch] drivers/block: updates .owner field of struct pci_driver
Message-ID: <20051023211320.GB19915@flint.arm.linux.org.uk>
Mail-Followup-To: Laurent Riffard <laurent.riffard@free.fr>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	dmo@osdl.org, mike.miller@hp.com, iss_storagedev@hp.com,
	Jeff Garzik <garzik@pobox.com>
References: <20051023204947.430464000@antares.localdomain> <20051023204956.213142000@antares.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051023204956.213142000@antares.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2005 at 10:49:48PM +0200, Laurent Riffard wrote:
> This patch updates .owner field of struct pci_driver.
> 
> This allows SYSFS to create the symlink from the driver to the
> module which provides it.
> 
> Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>

Wouldn't it be better to eliminate pci_driver's .owner field and
set the generic device driver's owner field directly? (and fix
the PCI code not to overwrite that if pci_driver's .owner field
is NULL for compatibility.)

I ask for the second time recently on linux-kernel.  Is there
*really* any point in duplicating these fields?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
