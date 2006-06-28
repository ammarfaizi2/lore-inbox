Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWF1RHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWF1RHF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932848AbWF1RHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 13:07:00 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:57488 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932320AbWF1RG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 13:06:57 -0400
Date: Wed, 28 Jun 2006 21:03:54 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove drivers/w1/w1_io.h
Message-ID: <20060628170354.GA11892@2ka.mipt.ru>
References: <20060628165522.GF13915@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060628165522.GF13915@stusta.de>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 28 Jun 2006 21:03:54 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 06:55:22PM +0200, Adrian Bunk (bunk@stusta.de) wrote:
> drivers/w1/w1_io.h is both a subset of drivers/w1/w1.h and no longer 
> #include'd by any file.
> 
> This patch therefore removes w1_io.h.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Your patch is correct, thank you Adrian.
I will push it upstrem soon.

> ---
> 
>  drivers/w1/w1_io.h |   36 ------------------------------------
>  1 file changed, 36 deletions(-)
> 
> --- linux-2.6.17-mm3-full/drivers/w1/w1_io.h	2006-06-27 11:04:12.000000000 +0200
> +++ /dev/null	2006-04-23 00:42:46.000000000 +0200
> @@ -1,36 +0,0 @@
> -/*
> - *	w1_io.h
> - *
> - * Copyright (c) 2004 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> - *
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> - */
> -
> -#ifndef __W1_IO_H
> -#define __W1_IO_H
> -
> -#include "w1.h"
> -
> -u8 w1_triplet(struct w1_master *dev, int bdir);
> -void w1_write_8(struct w1_master *, u8);
> -int w1_reset_bus(struct w1_master *);
> -u8 w1_calc_crc8(u8 *, int);
> -void w1_write_block(struct w1_master *, const u8 *, int);
> -u8 w1_read_block(struct w1_master *, u8 *, int);
> -void w1_search_devices(struct w1_master *dev, w1_slave_found_callback cb);
> -int w1_reset_select_slave(struct w1_slave *sl);
> -
> -#endif /* __W1_IO_H */

-- 
	Evgeniy Polyakov
