Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751836AbWEPQCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbWEPQCx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbWEPQCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:02:53 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:9990 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751834AbWEPQCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:02:52 -0400
Date: Tue, 16 May 2006 18:02:50 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Matt Mackall <mpm@selenic.com>
Cc: akpm@osdl.org, B.Zolnierkiewicz@elka.pw.edu.pl, liux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make number of IDE interfaces configurable
Message-ID: <20060516160250.GE5677@stusta.de>
References: <20060512222952.GQ6616@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060512222952.GQ6616@waste.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 05:29:52PM -0500, Matt Mackall wrote:
>...
> --- 2.6.orig/include/linux/ide.h	2006-05-11 15:07:32.000000000 -0500
> +++ 2.6/include/linux/ide.h	2006-05-12 14:01:53.000000000 -0500
> @@ -252,7 +252,8 @@ static inline void ide_std_init_ports(hw
>  
>  #include <asm/ide.h>
>  
> -#ifndef MAX_HWIFS
> +#if !defined(MAX_HWIFS) || defined(CONFIG_EMBEDDED)
> +#undef MAX_HWIFS
>  #define MAX_HWIFS	CONFIG_IDE_MAX_HWIFS
>  #endif

Why do you need this?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

