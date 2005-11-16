Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbVKPGqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbVKPGqw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 01:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVKPGqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 01:46:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:37258 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751185AbVKPGqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 01:46:51 -0500
Date: Tue, 15 Nov 2005 22:22:57 -0800
From: Greg KH <gregkh@suse.de>
To: Adam Belay <abelay@novell.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 5/6] PCI PM: kzalloc() cleanup
Message-ID: <20051116062257.GC31375@suse.de>
References: <1132111891.9809.57.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132111891.9809.57.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 10:31:31PM -0500, Adam Belay wrote:
> Use kzalloc() instead of kmalloc() and memset().
> 
> 
> --- a/drivers/pci/pm.c	2005-11-08 17:10:37.000000000 -0500
> +++ b/drivers/pci/pm.c	2005-11-08 17:11:33.000000000 -0500
> @@ -300,12 +300,10 @@
>  		return -EIO;
>  	}
>  
> -	dev->pm = pm_data = kmalloc(sizeof(struct pci_dev_pm), GFP_KERNEL);
> +	dev->pm = pm_data = kzalloc(sizeof(struct pci_dev_pm), GFP_KERNEL);
>  	if (!pm_data)
>  		return -ENOMEM;
>  
> -	memset(pm_data, 0, sizeof(struct pci_dev_pm));
> -

You can merge this back with your other patch :)

thanks,

greg k-h
