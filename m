Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVC2WoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVC2WoX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 17:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVC2WmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 17:42:08 -0500
Received: from gate.crashing.org ([63.228.1.57]:12003 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261617AbVC2Wk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 17:40:59 -0500
Subject: Re: u32 vs. pm_message_t in ppc and radeon
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050329192016.GA8323@elf.ucw.cz>
References: <20050329192016.GA8323@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 08:39:56 +1000
Message-Id: <1112135996.5353.48.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 21:20 +0200, Pavel Machek wrote:

> --- clean/drivers/video/aty/radeonfb.h	2005-03-19 00:31:59.000000000 +0100
> +++ linux/drivers/video/aty/radeonfb.h	2005-03-22 12:20:53.000000000 +0100
> @@ -608,7 +608,7 @@
>  extern int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn, u8 **out_edid);
>  
>  /* PM Functions */
> -extern int radeonfb_pci_suspend(struct pci_dev *pdev, u32 state);
> +extern int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t state);
>  extern int radeonfb_pci_resume(struct pci_dev *pdev);
>  extern void radeonfb_pm_init(struct radeonfb_info *rinfo, int dynclk);
>  extern void radeonfb_pm_exit(struct radeonfb_info *rinfo);
>  
Well, if you change the .h, you should change the .c too :)

I'll have a look later.

Ben.


