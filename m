Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266979AbSKPAK6>; Fri, 15 Nov 2002 19:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266952AbSKPAK5>; Fri, 15 Nov 2002 19:10:57 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:62083 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266948AbSKPAKw>; Fri, 15 Nov 2002 19:10:52 -0500
Date: Fri, 15 Nov 2002 16:19:14 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       grundler@dsl2.external.hp.com, willy@debian.org
Subject: Re: [RFC][PATCH] move dma_mask into struct device
Message-ID: <20021116001914.GA3153@beaverton.ibm.com>
Mail-Followup-To: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	grundler@dsl2.external.hp.com, willy@debian.org
References: <200211152034.gAFKYC404219@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211152034.gAFKYC404219@localhost.localdomain>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.E.J. Bottomley [James.Bottomley@steeleye.com] wrote:

> ===== drivers/pci/probe.c 1.17 vs edited =====
> --- 1.17/drivers/pci/probe.c	Fri Nov  1 12:33:02 2002
> +++ edited/drivers/pci/probe.c	Fri Nov 15 14:00:46 2002
> @@ -449,6 +449,7 @@
>  	/* now put in global tree */
>  	strcpy(dev->dev.name,dev->name);
>  	strcpy(dev->dev.bus_id,dev->slot_name);
> +	dev->dev->dma_mask = &dev->dma_mask;

I got a compile error here. This should be.
	dev->dev.dma_mask = &dev->dma_mask;

I did not have a current bk handy on the lab machine, but I ran it on
a 2.5.47 view with a few offset warnings.

The machine is a 2x pci systems with the following drivers loaded:
	aic7xxx, ips, qlogicisp.

It just booted and ran a little IO.

-andmike
--
Michael Anderson
andmike@us.ibm.com

