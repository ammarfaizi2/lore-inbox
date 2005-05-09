Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVEIJvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVEIJvW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 05:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVEIJvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 05:51:22 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:36760 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261184AbVEIJvT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 05:51:19 -0400
Date: Mon, 9 May 2005 11:50:44 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Chris Pascoe <c.pascoe@itee.uq.edu.au>, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org, Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20050509095043.GA15630@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Adrian Bunk <bunk@stusta.de>,
	Chris Pascoe <c.pascoe@itee.uq.edu.au>,
	linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org,
	Gerd Knorr <kraxel@bytesex.org>
References: <20050509035659.GT3590@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050509035659.GT3590@stusta.de>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: Re: [linux-dvb-maintainer] [2.6 patch] VIDEO_CX88_DVB must select DVB_CX22702
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2005 at 05:56:59AM +0200, Adrian Bunk wrote:
> VIDEO_CX88_DVB must select DVB_CX22702 (due to it's
> cx22702_attach usage).
> 
> This patch fixes kernel Bugzilla #4594
> (http://bugzilla.kernel.org/show_bug.cgi?id=4594).
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

drivers/media/video/Kconfig isn't part of DVB CVS,
and it's also not in video4linux CVS. Please
apply upstream.

Acked-by: Johannes Stezenbach <js@linuxtv.org>

> --- linux-2.6.12-rc4/drivers/media/video/Kconfig.old	2005-05-09 05:02:59.000000000 +0200
> +++ linux-2.6.12-rc4/drivers/media/video/Kconfig	2005-05-09 05:04:18.000000000 +0200
> @@ -326,12 +326,13 @@
>  config VIDEO_CX88_DVB
>  	tristate "DVB Support for cx2388x based TV cards"
>  	depends on VIDEO_CX88 && DVB_CORE
>  	select VIDEO_BUF_DVB
>  	select DVB_MT352
>  	select DVB_OR51132
> +	select DVB_CX22702
>  	---help---
>  	  This adds support for DVB/ATSC cards based on the
>  	  Connexant 2388x chip.
>  
>  config VIDEO_OVCAMCHIP
>  	tristate "OmniVision Camera Chip support"
> 
> 
