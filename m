Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbVCAVZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVCAVZB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 16:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVCAVZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 16:25:00 -0500
Received: from gprs215-167.eurotel.cz ([160.218.215.167]:1677 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262074AbVCAVYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 16:24:11 -0500
Date: Tue, 1 Mar 2005 22:23:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] ppc32: uninorth-agp suspend support
Message-ID: <20050301212347.GB2129@elf.ucw.cz>
References: <1109651140.7669.17.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109651140.7669.17.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> (This is for -mm, to be merged along with the aty128fb and radeonfb
> related patches).
> 
> This patch adds suspend/resume support to the Apple UniNorth AGP bridge
> to make sure AGP is properly disabled when the machine goes to sleep.
> Without this, the r300 based laptops will fail to wakeup from sleep when
> using the new experimental r300 DRI driver. It should also improve
> reliablility in general with other chips.

> --- linux-work.orig/drivers/char/agp/uninorth-agp.c	2005-03-01 13:53:32.000000000 +1100
> +++ linux-work/drivers/char/agp/uninorth-agp.c	2005-03-01 14:36:54.000000000 +1100
> @@ -155,6 +161,56 @@
>  	uninorth_tlbflush(NULL);
>  }
>  
> +#ifdef CONFIG_PM
> +static int agp_uninorth_suspend(struct pci_dev *pdev, u32 state)

pm_message_t state, please.

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
