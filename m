Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265170AbTFUMTl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 08:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265173AbTFUMTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 08:19:41 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:19143
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265170AbTFUMTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 08:19:40 -0400
Subject: Re: [PATCH] Isapnp warning
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, perex@suse.cz,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <200306151836.h5FIaqv2008285@callisto.of.borg>
References: <200306151836.h5FIaqv2008285@callisto.of.borg>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056198688.25975.25.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Jun 2003 13:31:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-06-15 at 19:36, Geert Uytterhoeven wrote:
> Isapnp: Kill warning if CONFIG_PCI is not set
> 
> --- linux-2.5.x/drivers/pnp/resource.c	Tue May 27 19:03:04 2003
> +++ linux-m68k-2.5.x/drivers/pnp/resource.c	Sun Jun  8 13:31:20 2003
> @@ -97,7 +97,9 @@
>  
>  int pnp_add_irq_resource(struct pnp_dev *dev, int depnum, struct pnp_irq *data)
>  {
> +#ifdef CONFIG_PCI
>  	int i;
> +#endif

This is far uglier than te warning

