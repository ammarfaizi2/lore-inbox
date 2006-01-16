Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWAPVKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWAPVKb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 16:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWAPVKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 16:10:31 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17677 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751204AbWAPVKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 16:10:30 -0500
Date: Mon, 16 Jan 2006 22:10:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mchehab@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, akpm@osdl.org
Subject: Re: [PATCH 13/25] cx88 Kconfig fixes for cx88-alsa
Message-ID: <20060116211031.GH29663@stusta.de>
References: <20060116091105.PS83611600000@infradead.org> <20060116091122.PS42877600013@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060116091122.PS42877600013@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 07:11:22AM -0200, mchehab@infradead.org wrote:
> 
> From: Mauro Carvalho Chehab <mchehab@infradead.org>
> 
> - Cx88 alsa is experimental.
> - Removed need of PCM OSS for an ALSA module.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
> ---
> 
>  drivers/media/video/cx88/Kconfig |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/video/cx88/Kconfig b/drivers/media/video/cx88/Kconfig
> index 76fcb4e..5330891 100644
> --- a/drivers/media/video/cx88/Kconfig
> +++ b/drivers/media/video/cx88/Kconfig
> @@ -31,8 +31,7 @@ config VIDEO_CX88_DVB
>  
>  config VIDEO_CX88_ALSA
>  	tristate "ALSA DMA audio support"
> -	depends on VIDEO_CX88 && SND
> -	select SND_PCM_OSS
> +	depends on VIDEO_CX88 && SND && EXPERIMENTAL
>  	---help---
>  	  This is a video4linux driver for direct (DMA) audio on
>  	  Conexant 2388x based TV cards.

This patch introduces a bug.

While select'ing SND_PCM_OSS isn't required, SND_PCM must be select'ed.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

