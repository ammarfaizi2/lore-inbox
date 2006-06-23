Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752050AbWFWVDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050AbWFWVDs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 17:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbWFWVDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 17:03:48 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47806 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1752050AbWFWVDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 17:03:47 -0400
Subject: Re: Geode patches for 2.6.17
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       akpm@osdl.org
In-Reply-To: <20060623205637.GD13017@cosmic.amd.com>
References: <20060623170058.GA12819@cosmic.amd.com>
	 <449C4E3C.7000107@garzik.org>  <20060623205637.GD13017@cosmic.amd.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Jun 2006 22:19:23 +0100
Message-Id: <1151097563.4549.90.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-06-23 am 14:56 -0600, ysgrifennodd Jordan Crouse:
> +config VGA_NOPROBE
> +       bool "Don't probe VGA at boot" if EMBEDDED
> +       default n
> +       help
> +         Saying Y here will cause the kernel to not probe VGA at boot time.
> +         This will break everything that depends on the probed screen
> +         data.  Say N here unless you are absolutely sure this is what you
> +         want.

GAK given all the ifdefs this causes wouldn't it be easier to just fix
the firmware 8)

> @@ -81,6 +96,7 @@ static void gx_set_mode(struct fb_info *
>  	writel(((info->var.xres * info->var.bits_per_pixel/8) >> 3) + 2,
>  	       par->dc_regs + DC_LINE_SIZE);
>  
> +
>  	/* Enable graphics and video data and unmask address lines. */
>  	dcfg |= DC_DCFG_GDEN | DC_DCFG_VDEN | DC_DCFG_A20M | DC_DCFG_A18M;
>  

Spurious blank line

Otherwise looks good

