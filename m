Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbVKFEVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVKFEVX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 23:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbVKFEVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 23:21:23 -0500
Received: from mail2.genealogia.fi ([194.100.116.229]:26600 "EHLO
	mail2.genealogia.fi") by vger.kernel.org with ESMTP id S932280AbVKFEVW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 23:21:22 -0500
Date: Sat, 5 Nov 2005 20:15:43 -0800
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Adrian Bunk <bunk@stusta.de>
Cc: hostap@shmoo.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       netdev@vger.kernel.org
Subject: Re: [2.6 patch] rename hostap.c to hostap_main.c
Message-ID: <20051106041543.GC8972@jm.kir.nu>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>, hostap@shmoo.com,
	linux-kernel@vger.kernel.org, jgarzik@pobox.com,
	netdev@vger.kernel.org
References: <20051106005343.GF3668@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051106005343.GF3668@stusta.de>
User-Agent: Mutt/1.5.8i
X-Spam-Score: -2.6 (--)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2005 at 01:53:43AM +0100, Adrian Bunk wrote:
> I wanted to remove the #include "hostap_ioctl.c" from hostap.c and build 
> hostap_ioctl.c separately, but this doesn't work since hostap.c has the 
> same name as the module.

Is this patch changing anything in hostap.c or is it just a rename of
the file? Patch file is not exactly ideal for this kind of changes and I
hope git has a better way of storing this kind of rename.

I would rather not rename the file, but if this is the only way of
getting the module built in pieces, I'm okay with the change (assuming
nothing else changed in hostap.c in this changeset).


> +++ linux-2.6.14-rc5-mm1-full/drivers/net/wireless/hostap/Makefile	2005-11-06 00:14:57.000000000 +0100
> @@ -1,5 +1,7 @@
> -obj-$(CONFIG_HOSTAP_CS) += hostap_cs.o
> -obj-$(CONFIG_HOSTAP_PLX) += hostap_plx.o
> -obj-$(CONFIG_HOSTAP_PCI) += hostap_pci.o
> +obj-$(CONFIG_HOSTAP)		+= hostap.o
> +
> +obj-$(CONFIG_HOSTAP_CS)		+= hostap_cs.o
> +obj-$(CONFIG_HOSTAP_PLX)	+= hostap_plx.o
> +obj-$(CONFIG_HOSTAP_PCI)	+= hostap_pci.o

Why were the hostap_{cs,plx,pci} lines changed? I prefer the original
version of those lines (i.e., no extra padding).

-- 
Jouni Malinen                                            PGP id EFC895FA
