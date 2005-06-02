Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVFBUKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVFBUKL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 16:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVFBUKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 16:10:00 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:60299 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261306AbVFBT60
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 15:58:26 -0400
Date: Thu, 2 Jun 2005 21:59:09 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, michael@mihu.de, kraxel@bytesex.org,
       video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Message-ID: <20050602195909.GA14359@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	michael@mihu.de, kraxel@bytesex.org, video4linux-list@redhat.com,
	linux-kernel@vger.kernel.org
References: <20050530205638.GS10441@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050530205638.GS10441@stusta.de>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: 84.189.197.94
Subject: Re: [2.6 patch] drivers/media/common/saa7146_fops.c: make a function static
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 10:56:38PM +0200, Adrian Bunk wrote:
> This patch makes a needlessly global function static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

I committed this patch to linuxtv.org (DVB) CVS.

Thanks,
Johannes

> --- linux-2.6.12-rc2-mm3-full/drivers/media/common/saa7146_fops.c.old	2005-04-19 01:21:37.000000000 +0200
> +++ linux-2.6.12-rc2-mm3-full/drivers/media/common/saa7146_fops.c	2005-04-19 01:21:50.000000000 +0200
> @@ -403,7 +403,7 @@
>  	.llseek		= no_llseek,
>  };
>  
> -void vv_callback(struct saa7146_dev *dev, unsigned long status)
> +static void vv_callback(struct saa7146_dev *dev, unsigned long status)
>  {
>  	u32 isr = status;
>  	
> 
