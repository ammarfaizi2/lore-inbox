Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261789AbSI2VHt>; Sun, 29 Sep 2002 17:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261794AbSI2VHt>; Sun, 29 Sep 2002 17:07:49 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:12279 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261789AbSI2VHs>; Sun, 29 Sep 2002 17:07:48 -0400
Subject: Re: [PATCH] ALSA update [6/10] - 2002/07/20
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0209292230500.591-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.33.0209292230500.591-100000@pnote.perex-int.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Sep 2002 22:19:35 +0100
Message-Id: <1033334375.13762.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-29 at 21:34, Jaroslav Kysela wrote:
> -	if (hwdev == NULL || ((u32)hwdev->dma_mask != 0xffffffff))
> +	if (hwdev == NULL || (u32)hwdev->dma_mask <= 0x00ffffff)
>  		gfp |= GFP_DMA;

This is wrong. You just broke ISA DMA handling, and also blocking of
devices with sub ISA requirements


