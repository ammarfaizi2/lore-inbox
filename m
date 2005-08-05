Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVHEW6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVHEW6K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 18:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVHEW6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 18:58:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:7345 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262016AbVHEW5j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 18:57:39 -0400
Date: Fri, 5 Aug 2005 15:57:12 -0700
From: Greg KH <greg@kroah.com>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       rajesh.shah@intel.com
Subject: Re: [PATCH] 6700/6702PXH quirk
Message-ID: <20050805225712.GD3782@kroah.com>
References: <1123259263.8917.9.camel@whizzy> <20050805183505.GA32405@kroah.com> <1123279513.4706.7.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123279513.4706.7.camel@whizzy>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 03:05:13PM -0700, Kristen Accardi wrote:
> +int msi_add_quirk(struct pci_dev *dev)
> +{
> +	struct msi_quirk *quirk;
> +
> +	quirk = (struct msi_quirk *) kmalloc(sizeof(*quirk), GFP_KERNEL);
> +	if (!quirk)
> +		return -ENOMEM;
> +	
> +	INIT_LIST_HEAD(&quirk->list);
> +	quirk->dev = dev;

You just messed up the reference counting of this device :(

Anyway, Jeff is right, add another bit field.

thanks,

greg k-h
