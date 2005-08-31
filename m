Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbVHaMOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbVHaMOs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 08:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbVHaMOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 08:14:48 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:57517 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932508AbVHaMOr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 08:14:47 -0400
Date: Wed, 31 Aug 2005 14:14:38 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Michael Hunold <hunold@linuxtv.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20050831121438.GA17473@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Michael Hunold <hunold@linuxtv.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org> <20050811064217.GB21395@titan.lahn.de> <E1E3CJE-0001NJ-PH@allen.werkleitz.de> <20050815071723.GB8524@titan.lahn.de> <20050815215855.GB5860@linuxtv.org> <E1E4vSG-0005r7-KG@allen.werkleitz.de> <20050824065954.GA4368@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050824065954.GA4368@titan.lahn.de>
User-Agent: Mutt/1.5.10i
X-SA-Exim-Connect-IP: 84.189.244.102
Subject: Re: [PATCH] saa7146_i2c device model integration
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 Philipp Matthias Hahn wrote:
> Integrate saa7146_i2c adapter into device model:
> Moves entries from /sys/device/platform to /sys/device/pci*.
> 
> Signed-off-by: Philipp Hahn <pmhahn@titan.lahn.de>

I added this patch to linuxtv.org CVS.

Thanks,
Johannes


> --- linux/drivers/media/common/saa7146_i2c.c	2004-10-26 22:24:09.000000000 +0200
> +++ linux/drivers/media/common/saa7146_i2c.c	2004-10-24 16:00:32.000000000 +0200
> @@ -409,6 +409,7 @@ int saa7146_i2c_adapter_prepare(struct s
>  #else
>  		BUG_ON(!i2c_adapter->class);
>  		i2c_set_adapdata(i2c_adapter,dev);
> +		i2c_adapter->dev.parent    = &dev->pci->dev;
>  #endif
>  		i2c_adapter->algo	   = &saa7146_algo;
>  		i2c_adapter->algo_data     = NULL;
> 
