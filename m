Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbVCXDki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVCXDki (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 22:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbVCXDjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 22:39:11 -0500
Received: from graphe.net ([209.204.138.32]:10762 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262536AbVCXDh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 22:37:26 -0500
Date: Wed, 23 Mar 2005 19:37:14 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, Tina Yang <tinay@chelsio.com>,
       Scott Bardone <sbardone@chelsio.com>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, linux-net@vger.kernel.org
Subject: Re: [-mm patch] drivers/net/chelsio/osdep.h: small cleanups
In-Reply-To: <20050324031026.GV1948@stusta.de>
Message-ID: <Pine.LNX.4.58.0503231934430.11120@server.graphe.net>
References: <20050321025159.1cabd62e.akpm@osdl.org> <20050324031026.GV1948@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We just send an update to Andrew and Jeff that also fixes this issue.
Sadly that patch is >300k so we cannot post it to the list.

On Thu, 24 Mar 2005, Adrian Bunk wrote:

> The #define MODVERSIONS doesn't make sense.
>
> And there's no need to #ifdef an #include <linux/module.h>.
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> --- linux-2.6.12-rc1-mm1-full/drivers/net/chelsio/osdep.h.old	2005-03-24 01:20:02.000000000 +0100
> +++ linux-2.6.12-rc1-mm1-full/drivers/net/chelsio/osdep.h	2005-03-24 01:20:17.000000000 +0100
> @@ -33,13 +33,7 @@
>  #define __CHELSIO_OSDEP_H
>
>  #include <linux/version.h>
> -#if defined(MODULE) && ! defined(MODVERSIONS)
> -#define MODVERSIONS
> -#endif
> -#ifdef MODULE
>  #include <linux/module.h>
> -#endif
> -
>  #include <linux/config.h>
>  #include <linux/types.h>
>  #include <linux/delay.h>
>
>
