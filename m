Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262736AbVHDVrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbVHDVrX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 17:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVHDVot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 17:44:49 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42767 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262734AbVHDVom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 17:44:42 -0400
Date: Thu, 4 Aug 2005 23:44:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Message-ID: <20050804214437.GF4029@stusta.de>
References: <200508031559.24704.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508031559.24704.kernel@kolivas.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2005 at 03:59:24PM +1000, Con Kolivas wrote:
>...
> --- linux-2.6.13-rc5-ck2.orig/arch/i386/kernel/time.c	2005-08-03 11:29:08.000000000 +1000
> +++ linux-2.6.13-rc5-ck2/arch/i386/kernel/time.c	2005-08-03 11:29:29.000000000 +1000
>...
> -static inline void do_timer_interrupt(int irq, void *dev_id,
> +inline void do_timer_interrupt(int irq, void *dev_id,
>  					struct pt_regs *regs)
>...

A global inline functions implies an increase of the size of the binary.
Can you drop the "inline"?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

