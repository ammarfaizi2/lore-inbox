Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWCIGgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWCIGgJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 01:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWCIGgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 01:36:08 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:44197 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S1750903AbWCIGgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 01:36:07 -0500
Date: Thu, 9 Mar 2006 08:37:43 +0200
From: Dan Aloni <da-x@monatomic.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: John Stoffel <john@stoffel.org>
Subject: Re: [PATCH] sata_mv: stabilize for 5081 and other fixes
Message-ID: <20060309063743.GA23297@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Dan> -	MV_MAX_SG_CT		= 176,
> Dan> +	MV_MAX_SG_CT		= 256,
> Dan>  	MV_SG_TBL_SZ		= (16 * MV_MAX_SG_CT),
> Dan> -	MV_PORT_PRIV_DMA_SZ	= (MV_CRQB_Q_SZ + MV_CRPB_Q_SZ + MV_SG_TBL_SZ),
> Dan> +	MV_PORT_PRIV_DMA1_SZ	= (MV_CRQB_Q_SZ + MV_CRPB_Q_SZ),
> Dan> +	MV_PORT_PRIV_DMA2_SZ	= (MV_SG_TBL_SZ),
> 
> I don't like these names for the reagions.  DMA1 and DMA2 mean
> nothing.  Should be be something a little more descriptive?  And a
> comment why you split them up would be good too.

I admit I don't like these names either - however I didn't dedicate
enough time for this patch because I'd like the maintainer(s) to 
give notes about my changes unrelated to coding conventions, but 
thanks anyway.

If this patch is Right (tm) then I'll repost a better-looking version 
of it or let the maintainer(s) implement in the way they see fit.

> Dan> +#pragma pack(1)
>
> I don't see these used anywhere else in the kernel, they should
> probably go.  

It might not affect the packing anyway in this case, but I was 
paranoid when I tried to fix the driver.

> Dan> -/*
> Dan> - * module options
> Dan> - */
> Dan> -static int msi;	      /* Use PCI msi; either zero (off, default) or non-zero */
> Dan> +static int msi;              /* Use PCI msi; either zero (off, default) or non-zero */
 
Whoops, shouldn't have removed the comment. I guess I'll re-post
anyway.

-- 
Dan Aloni
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net, dan@xiv.co.il
