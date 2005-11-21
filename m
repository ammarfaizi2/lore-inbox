Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbVKUWhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbVKUWhO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbVKUWhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:37:14 -0500
Received: from [205.233.219.253] ([205.233.219.253]:48043 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S1751184AbVKUWhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:37:12 -0500
Date: Mon, 21 Nov 2005 17:32:40 -0500
From: Jody McIntyre <scjody@steamballoon.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: bcollins@debian.org, bunk@stusta.de, davej@redhat.com, dan@dennedy.org,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: Re: [2.6 patch] drivers/ieee1394/raw1394.c: fix a NULL pointer dereference
Message-ID: <20051121223240.GS20781@conscoop.ottawa.on.ca>
References: <20051121215226.GN20781@conscoop.ottawa.on.ca> <200511212209.jALM9TpR032499@einhorn.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511212209.jALM9TpR032499@einhorn.in-berlin.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 11:09:02PM +0100, Stefan Richter wrote:
> [PATCH 2.6.15-rc2] raw1394: fix memory deallocation in modify_config_rom
> 
> raw1394: use correct deallocation macro for CSR cache

Applied.

Cheers,
Jody

>  
> Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
> 
> --- linux-2.6.15-rc2/drivers/ieee1394/raw1394.c.orig	2005-11-21 22:17:13.000000000 +0100
> +++ linux-2.6.15-rc2/drivers/ieee1394/raw1394.c	2005-11-21 22:29:19.000000000 +0100
> @@ -2172,7 +2171,7 @@ static int modify_config_rom(struct file
>  		}
>  	}
>  	kfree(cache->filled_head);
> -	kfree(cache);
> +	CSR1212_FREE(cache);
>  
>  	if (ret >= 0) {
>  		/* we have to free the request, because we queue no response,
> 

-- 
