Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263246AbTFGQ0O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 12:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263250AbTFGQ0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 12:26:14 -0400
Received: from granite.he.net ([216.218.226.66]:59652 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263246AbTFGQ0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 12:26:14 -0400
Date: Sat, 7 Jun 2003 09:07:43 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: James Morris <jmorris@intercode.com.au>, pam.delaney@lsil.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compile fix for MPT Fusion driver for 2.5.70 bk
Message-ID: <20030607160743.GA17624@kroah.com>
References: <Mutt.LNX.4.44.0306060154230.2735-100000@excalibur.intercode.com.au> <20030607114543.GG15311@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607114543.GG15311@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 01:45:44PM +0200, Adrian Bunk wrote:
> -			pdev2 = pci_peek_next_dev(pdev);
> +			pdev2 = (pdev) != pci_dev_g(&pci_devices) ? pci_dev_g((pdev)->global_list.next) : NULL;

This will not work, as pci_devices is no longer exported in Linus's bk
tree.

As for removing all the old compatibility stuff, that's up to the
maintainer of the driver.

thanks,

greg k-h
