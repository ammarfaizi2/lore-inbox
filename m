Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVAIS3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVAIS3r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 13:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbVAIS3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 13:29:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:7655 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261685AbVAIS3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 13:29:45 -0500
Date: Sun, 9 Jan 2005 10:29:37 -0800
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@lst.de>
Cc: davej@redhat.com, hannal@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix pci_get_device conversion in intel-agp
Message-ID: <20050109182937.GA13531@kroah.com>
References: <20050108190815.GA7031@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050108190815.GA7031@lst.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 08:08:15PM +0100, Christoph Hellwig wrote:
> +	if (intel_i810_private.i810_dev)
> +		pci_dev_put(intel_i810_private.i830_dev);
> +	if (intel_i810_private.i830_dev)
> +		pci_dev_put(intel_i830_private.i830_dev);

It's legal to call pci_dev_put() with a NULL pointer, so these checks
are not needed.

thanks,

greg k-h
