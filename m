Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVBGWSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVBGWSx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 17:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVBGWSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 17:18:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:27852 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261223AbVBGWSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 17:18:31 -0500
Date: Mon, 7 Feb 2005 14:18:20 -0800
From: Greg KH <greg@kroah.com>
To: brking@us.ibm.com
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: Dynids - passing driver data
Message-ID: <20050207221820.GA27543@kroah.com>
References: <200502072200.j17M0S0N008552@d01av02.pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502072200.j17M0S0N008552@d01av02.pok.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2005 at 04:00:27PM -0600, brking@us.ibm.com wrote:
> 
> Currently, code exists in the pci layer to allow userspace to specify
> driver data when adding a pci dynamic id from sysfs. However, this data
> is never used and there exists no way in the existing code to use it.

Which is a good thing, right?  "driver_data" is usually a pointer to
somewhere.  Having userspace specify it would not be a good thing.

> This patch allows device drivers to indicate that they want driver data
> passed to them on dynamic id adds by initializing use_driver_data in their
> pci_driver->pci_dynids struct. The documentation has also been updated
> to reflect this.

What driver wants to use this?

thanks,

greg k-h
