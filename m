Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbWAWWQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbWAWWQQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 17:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWAWWQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 17:16:16 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5645 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964963AbWAWWQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 17:16:15 -0500
Date: Mon, 23 Jan 2006 23:16:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mchehab@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, akpm@osdl.org,
       Michael Krufky <mkrufky@m1k.net>
Subject: Re: [PATCH 10/16] make VP-3054 Secondary I2C Bus Support a Kconfig option.
Message-ID: <20060123221604.GA3590@stusta.de>
References: <20060123202404.PS66974000000@infradead.org> <20060123202444.PS83596100010@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060123202444.PS83596100010@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2006 at 06:24:44PM -0200, mchehab@infradead.org wrote:
> From: Michael Krufky <mkrufky@m1k.net>
> 
> - make VP-3054 Secondary I2C Bus Support a Kconfig option.
> 
> Signed-off-by: Michael Krufky <mkrufky@m1k.net>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
> ---
> 
>  drivers/media/video/cx88/Kconfig  |   11 +++++++++++
>  drivers/media/video/cx88/Makefile |    2 +-
>  2 files changed, 12 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/media/video/cx88/Kconfig b/drivers/media/video/cx88/Kconfig
> index fdf45f7..e99dfbb 100644
> --- a/drivers/media/video/cx88/Kconfig
> +++ b/drivers/media/video/cx88/Kconfig
> @@ -49,6 +49,7 @@ config VIDEO_CX88_DVB_ALL_FRONTENDS
>  	default y
>  	depends on VIDEO_CX88_DVB
>  	select DVB_MT352
> +	select VIDEO_CX88_VP3054
>  	select DVB_OR51132
>  	select DVB_CX22702
>  	select DVB_LGDT330X
> @@ -70,6 +71,16 @@ config VIDEO_CX88_DVB_MT352
>  	  This adds DVB-T support for cards based on the
>  	  Connexant 2388x chip and the MT352 demodulator.
>  
> +config VIDEO_CX88_VP3054
> +	tristate "VP-3054 Secondary I2C Bus Support"
> +	default m
>...

This option should be a bool since "m" doesn't make much sense (it's 
anyways interpreted the same as "y").

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

