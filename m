Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758916AbWK2WxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758916AbWK2WxA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758919AbWK2WxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:53:00 -0500
Received: from hera.kernel.org ([140.211.167.34]:52902 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1758916AbWK2Ww7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:52:59 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: net: sk98lin bracket question
Date: Wed, 29 Nov 2006 14:52:16 -0800
Organization: OSDL
Message-ID: <20061129145216.0722651b@freekitty>
References: <200611292335.08563.m.kozlowski@tuxland.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1164840736 482 10.8.0.54 (29 Nov 2006 22:52:16 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 29 Nov 2006 22:52:16 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 23:35:07 +0100
Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:

> Hello,
> 
> 	Somewhere below is either one extra or one missing bracket. Any idea how to fix that?
> 
> Is the patch below correct?
> 
> --- linux-2.6.19-rc6-mm2-a/drivers/net/sk98lin/skgesirq.c	2006-11-16 05:03:40.000000000 +0100
> +++ linux-2.6.19-rc6-mm2-b/drivers/net/sk98lin/skgesirq.c	2006-11-29 23:32:02.000000000 +0100
> @@ -1319,7 +1319,7 @@ SK_BOOL	AutoNeg)	/* Is Auto-negotiation 
>  	SkXmPhyRead(pAC, IoC, Port, PHY_BCOM_INT_STAT, &Isrc);
>  
>  #ifdef xDEBUG
> -	if ((Isrc & ~(PHY_B_IS_HCT | PHY_B_IS_LCT) ==
> +	if ((Isrc & ~(PHY_B_IS_HCT | PHY_B_IS_LCT)) ==
>  		(PHY_B_IS_SCR_S_ER | PHY_B_IS_RRS_CHANGE | PHY_B_IS_LRS_CHANGE)) {
>  
>  		SK_U32	Stat1, Stat2, Stat3;
> 
> 
> PS. Who is the maintainer of this driver?
> 

Nobody is maintaining this driver, it is being obsoleted and replaced by skge.

-- 
Stephen Hemminger <shemminger@osdl.org>
