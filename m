Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267515AbUIWXRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267515AbUIWXRx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 19:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267478AbUIWWzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 18:55:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:52619 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267535AbUIWWwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 18:52:00 -0400
Date: Thu, 23 Sep 2004 15:50:35 -0700
From: Greg KH <greg@kroah.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org,
       davej@codemonkey.org.uk, hpa@zytor.com
Subject: Re: [PATCH 2.6.9-rc2-mm2] Create new function to see if pci dev is present
Message-ID: <20040923225035.GB14274@kroah.com>
References: <2480000.1095978400@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2480000.1095978400@w-hlinder.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 03:26:40PM -0700, Hanna Linder wrote:
> + * @from: Previous PCI device found in search, or %NULL for new search.

from is not needed in a function like this.  Just vendor and device
should work.

> +static inline int pci_dev_present(unsigned int vendor, unsigned int device, struct pci_dev *from)
> +{return -1; }
> +

This should return 0, not -1.

Care to redo your patches based on this?

thanks,

greg k-h
