Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269040AbUI2VMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269040AbUI2VMg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 17:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269031AbUI2VMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 17:12:36 -0400
Received: from mail.kroah.org ([69.55.234.183]:63372 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269040AbUI2VMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 17:12:33 -0400
Date: Wed, 29 Sep 2004 14:11:35 -0700
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, Hanna Linder <hannal@us.ibm.com>,
       linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org,
       kraxel@bytesex.org
Subject: Re: [PATCH 2.6.9-rc2-mm4 bttv-driver.c][4/8] convert pci_find_device to pci_dev_present
Message-ID: <20040929211135.GA24407@kroah.com>
References: <15470000.1096491322@w-hlinder.beaverton.ibm.com> <20040929220344.A17872@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040929220344.A17872@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 10:03:44PM +0100, Christoph Hellwig wrote:
> On Wed, Sep 29, 2004 at 01:55:22PM -0700, Hanna Linder wrote:
> > 
> > As pci_find_device is going away need to replace it. This file did not use the dev returned
> > from pci_find_device so is replaceable by pci_dev_present. I was not able to test it
> > as I do not have the hardware.
> 
> I think this check should just go away completely.  

Good point.  Especially as pci_module_init() can never return -ENODEV
anymore :)

Hanna, care to respin this patch?

thanks,

greg k-h
