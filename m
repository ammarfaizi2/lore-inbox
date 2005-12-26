Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbVLZIaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbVLZIaB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 03:30:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbVLZIaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 03:30:01 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23518 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751069AbVLZIaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 03:30:01 -0500
Date: Mon, 26 Dec 2005 09:29:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jaco Kroon <jaco@kroon.co.za>
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Re: [PATCH] ati-agp suspend/resume support (try 2)
Message-ID: <20051226082934.GD1844@elf.ucw.cz>
References: <43AF7724.8090302@kroon.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43AF7724.8090302@kroon.co.za>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Based on the patch at
> http://unixhead.org/docs/thinkpad/ati-agp/ati-agp.diff, add support for
> suspend/resume in the ati-agp module.
> 
> Signed-of-by: Jaco Kroon <jaco@kroon.co.za>

ACKed-by: Pavel Machek <pavel@suse.cz>

> --- linux-2.6.15-rc6/drivers/char/agp/ati-agp.c.orig	2005-12-25
> 22:21:32.000000000 +0200
> +++ linux-2.6.15-rc6/drivers/char/agp/ati-agp.c	2005-12-26
> 06:47:26.000000000 +0200

Your email client did some nasty word wrapping here. I guess the way
to proceed is try #3, this time add my ACK and Cc: akpm...

								Pavel

> @@ -243,6 +243,10 @@
>  	return 0;
>  }
> 
> +static int agp_ati_resume(struct pci_dev *dev)
> +{
> +	return ati_configure();
> +}
> 
>  /*
>   *Since we don't need contigious memory we just try
> @@ -525,6 +529,7 @@
>  	.id_table	= agp_ati_pci_table,
>  	.probe		= agp_ati_probe,
>  	.remove		= agp_ati_remove,
> +	.resume		= agp_ati_resume,
>  };
> 
>  static int __init agp_ati_init(void)

-- 
Thanks, Sharp!
