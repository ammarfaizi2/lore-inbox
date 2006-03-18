Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWCRT7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWCRT7T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 14:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWCRT7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 14:59:19 -0500
Received: from thing.hostingexpert.com ([67.15.235.34]:46053 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1750841AbWCRT7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 14:59:19 -0500
Message-ID: <441C6695.1060808@linuxtv.org>
Date: Sat, 18 Mar 2006 14:59:17 -0500
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: mchehab@infradead.org, linux-kernel@vger.kernel.org,
       linux-dvb-maintainer@linuxtv.org
Subject: Re: [PATCH 16/21] Kconfig: swap VIDEO_CX88_ALSA and VIDEO_CX88_DVB
References: <20060317205359.PS65198900000@infradead.org> <20060317205437.PS38148600016@infradead.org>
In-Reply-To: <20060317205437.PS38148600016@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please apply this one.  When VIDEO_CX88_ALSA was added, it was put in 
the wrong place, and caused the VIDEO_CX88_DVB stuff to get split up, 
making the menu harder to understand.  Swapping these two menu items 
fixes the problem.

Thank you,

Michael Krufky


mchehab@infradead.org wrote:
> From: Michael Krufky <mkrufky@linuxtv.org>
> Date: 1142400973 \-0300
> 
> VIDEO_CX88_ALSA should not be between
> VIDEO_CX88_DVB and VIDEO_CX88_DVB_ALL_FRONTENDS
> When cx88-alsa was added to cx88/Kconfig, it was
> added in between VIDEO_CX88_DVB and
> VIDEO_CX88_DVB_ALL_FRONTENDS.  This caused
> undesireable effects to the appearance of the menu
> options in menuconfig.
> This fix reorders cx88-alsa and cx88-dvb in Kconfig,
> to match saa7134, and restore the correct menuconfig
> appearance.
> 
> Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
> ---
> 
>  drivers/media/video/cx88/Kconfig |   28 ++++++++++++++--------------
>  1 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/media/video/cx88/Kconfig b/drivers/media/video/cx88/Kconfig
> index e99dfbb..87d79df 100644
> --- a/drivers/media/video/cx88/Kconfig
> +++ b/drivers/media/video/cx88/Kconfig
> @@ -15,20 +15,6 @@ config VIDEO_CX88
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called cx8800
>  
> -config VIDEO_CX88_DVB
> -	tristate "DVB/ATSC Support for cx2388x based TV cards"
> -	depends on VIDEO_CX88 && DVB_CORE
> -	select VIDEO_BUF_DVB
> -	---help---
> -	  This adds support for DVB/ATSC cards based on the
> -	  Connexant 2388x chip.
> -
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called cx88-dvb.
> -
> -	  You must also select one or more DVB/ATSC demodulators.
> -	  If you are unsure which you need, choose all of them.
> -
>  config VIDEO_CX88_ALSA
>  	tristate "ALSA DMA audio support"
>  	depends on VIDEO_CX88 && SND && EXPERIMENTAL
> @@ -44,6 +30,20 @@ config VIDEO_CX88_ALSA
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called cx88-alsa.
>  
> +config VIDEO_CX88_DVB
> +	tristate "DVB/ATSC Support for cx2388x based TV cards"
> +	depends on VIDEO_CX88 && DVB_CORE
> +	select VIDEO_BUF_DVB
> +	---help---
> +	  This adds support for DVB/ATSC cards based on the
> +	  Connexant 2388x chip.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called cx88-dvb.
> +
> +	  You must also select one or more DVB/ATSC demodulators.
> +	  If you are unsure which you need, choose all of them.
> +
>  config VIDEO_CX88_DVB_ALL_FRONTENDS
>  	bool "Build all supported frontends for cx2388x based TV cards"
>  	default y
> 

