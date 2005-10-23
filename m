Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbVJWWcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbVJWWcX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 18:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbVJWWcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 18:32:23 -0400
Received: from mail.kroah.org ([69.55.234.183]:23456 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750817AbVJWWcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 18:32:22 -0400
Date: Sun, 23 Oct 2005 15:29:57 -0700
From: Greg KH <greg@kroah.com>
To: Laurent Riffard <laurent.riffard@free.fr>, linux-kernel@vger.kernel.org,
       dmo@osdl.org, mike.miller@hp.com, iss_storagedev@hp.com,
       Jeff Garzik <garzik@pobox.com>
Subject: Re: [patch] drivers/block: updates .owner field of struct pci_driver
Message-ID: <20051023222956.GA8332@kroah.com>
References: <20051023204947.430464000@antares.localdomain> <20051023204956.213142000@antares.localdomain> <20051023211320.GB19915@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051023211320.GB19915@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2005 at 10:13:20PM +0100, Russell King wrote:
> On Sun, Oct 23, 2005 at 10:49:48PM +0200, Laurent Riffard wrote:
> > This patch updates .owner field of struct pci_driver.
> > 
> > This allows SYSFS to create the symlink from the driver to the
> > module which provides it.
> > 
> > Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
> 
> Wouldn't it be better to eliminate pci_driver's .owner field and
> set the generic device driver's owner field directly? (and fix
> the PCI code not to overwrite that if pci_driver's .owner field
> is NULL for compatibility.)

No there isn't, we should use the struct device .name and .owner fields
instead of the pci drivers's structure.  Then we can just get rid of the
pci driver's fields too.

I just did this for the usb-serial drivers on Friday.

thanks,

greg k-h
