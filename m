Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266772AbTAZJgk>; Sun, 26 Jan 2003 04:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266777AbTAZJgk>; Sun, 26 Jan 2003 04:36:40 -0500
Received: from gold.muskoka.com ([216.123.107.5]:19472 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S266772AbTAZJgj>;
	Sun, 26 Jan 2003 04:36:39 -0500
Message-ID: <3E33AE37.463C9CCF@yahoo.com>
Date: Sun, 26 Jan 2003 04:45:27 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Accept-Language: en
MIME-Version: 1.0
To: Adam Belay <ambx1@neo.rr.com>
CC: greg@kroah.com, linux-kernel@vger.kernel.org,
       Jeff Muizelaar <muizelaar@rogers.com>
Subject: Re: [PATCH] NE PnP Update from Jeff Muizelaar (5/6)
References: <20030125201528.GA12845@neo.rr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've a couple of quick comments after looking over the patch:

> -"Last modified Nov 1, 2000 by Paul Gortmaker\n";
> +"Last modified January 20, 2003 by Jeff Muizelaar\n";

Feel free to delete this "Last modified" stuff altogether.
It is just extra verbage at boot we don't need. (Blame 
Jeff Garzik -- he put it there, not me...   ;-)

> +               free_irq(dev->irq, dev);
> +               release_region(dev->base_addr, NE_IO_EXTENT);
> +               unregister_netdev(dev);
> +               kfree(dev->priv);
> +               kfree(dev);

It is usually good practice to unregister a device as the 
first thing, and then release its associated resources once
you know the kernel doesn't hold any references to it.

Thanks,
Paul.

