Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262654AbVCKJhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbVCKJhR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 04:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263239AbVCKJhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 04:37:16 -0500
Received: from gate.crashing.org ([63.228.1.57]:48859 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262654AbVCKJgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 04:36:51 -0500
Subject: Re: [PATCH] ppc64: Add IDE-pmac support for new "Shasta" chipset
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050310231700.5486ccd4.akpm@osdl.org>
References: <1110523540.5751.52.camel@gaston>
	 <20050310231700.5486ccd4.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 20:36:32 +1100
Message-Id: <1110533792.5751.69.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-10 at 23:17 -0800, Andrew Morton wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > The iMac G5 and new single CPU PowerMac G5 come with a new revision of
> >  the K2 ASIC called Shasta. The PATA cell in there now does 133Mhz. This
> >  patch adds support for it. It also adds some power management bits to
> >  the old 100MHz cell that was in Intrepid based ppc32 machines.
> 
> Compile fix:
> 
> --- 25/drivers/ide/ppc/pmac.c~ppc64-add-ide-pmac-support-for-new-shasta-chipset-fix	2005-03-11 07:12:01.000000000 -0700
> +++ 25-akpm/drivers/ide/ppc/pmac.c	2005-03-11 07:12:20.000000000 -0700
> @@ -1301,7 +1301,7 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
>  	 */
>  	if (device_is_compatible(np, "K2-UATA") ||
>  	    device_is_compatible(np, "shasta-ata"))
> -		pmid->cable_80 = 1;
> +		pmif->cable_80 = 1;
>  
>  	/* On Kauai-type controllers, we make sure the FCR is correct */
>  	if (pmif->kauai_fcr)
> _
> 
> (Wonders how well tested this was).

It was tested, sorry about the mistake, I fixed that compile error and
forgot to run "quilt ref" :)

My bad ...

I'll double check that the other patches are indeed the right versions
tomorrow...

Ben.


