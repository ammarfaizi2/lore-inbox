Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932551AbVHKXIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbVHKXIt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 19:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbVHKXIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 19:08:48 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:17320 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932546AbVHKXIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 19:08:47 -0400
Date: Thu, 11 Aug 2005 18:08:43 -0500
From: Jack Steiner <steiner@sgi.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Message-ID: <20050811230843.GD9964@sgi.com>
References: <200508111424.43150.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508111424.43150.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(resend with correct cc list).

On Thu, Aug 11, 2005 at 02:24:43PM -0600, Bjorn Helgaas wrote:
> IA64 boxes only have PCI IDE devices, so there's no need to blindly poke
> around in I/O port space.  Poking at things that don't exist causes MCAs
> on HP ia64 systems.

 Hmmmm, can you change the test so that IDE_GENERIC is off by default but
 can still be enabled on IA64. We use the generic IDE driver in our
 simulator environment - yes, it really works.

 Longer term, I'll see if it is feasible to switch to using a PCI device.

> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> Index: work-vga/drivers/ide/Kconfig
> ===================================================================
> --- work-vga.orig/drivers/ide/Kconfig	2005-08-10 14:57:47.000000000 -0600
> +++ work-vga/drivers/ide/Kconfig	2005-08-10 14:58:02.000000000 -0600
> @@ -276,6 +276,7 @@
>  
>  config IDE_GENERIC
>  	tristate "generic/default IDE chipset support"
> +	depends on !IA64
>  	default y
>  	help
>  	  If unsure, say Y.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


