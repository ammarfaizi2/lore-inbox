Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751664AbVLGSMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbVLGSMh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 13:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbVLGSMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 13:12:36 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45324 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751662AbVLGSMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 13:12:36 -0500
Date: Wed, 7 Dec 2005 19:12:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ben Gardner <gardner.ben@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, lm-sensors <lm-sensors@lm-sensors.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] i386: CS5535 chip support - cpu
Message-ID: <20051207181234.GF31922@stusta.de>
References: <808c8e9d0512070931k607cd7a9g404d131ded8c014b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <808c8e9d0512070931k607cd7a9g404d131ded8c014b@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 11:31:09AM -0600, Ben Gardner wrote:
>...
> --- linux-2.6.14.orig/arch/i386/kernel/Makefile
> +++ linux-2.6.14/arch/i386/kernel/Makefile
> @@ -42,6 +42,14 @@ EXTRA_AFLAGS   := -traditional
>  
>  obj-$(CONFIG_SCx200)		+= scx200.o
>  
> +obj-$(CONFIG_CS5535)		+= cs5535.o
> +ifeq ($(CONFIG_CS5535_SMB), y)
> +EXTRA_CFLAGS += -DCS5535_SMB
> +endif
> +ifeq ($(CONFIG_CS5535_UART2), y)
> +EXTRA_CFLAGS += -DCS5535_UART2
> +endif
>...

Please use CONFIG_CS5535_{SMB,UART2} in cs5535.c instead of setting 
EXTRA_CFLAGS.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

