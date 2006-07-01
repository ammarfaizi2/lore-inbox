Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWGADhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWGADhu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 23:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWGADhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 23:37:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9703 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932250AbWGADht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 23:37:49 -0400
Date: Fri, 30 Jun 2006 20:34:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kernel/sysctl.c: EXPORT_UNUSED_SYMBOL
Message-Id: <20060630203436.5728ea86.akpm@osdl.org>
In-Reply-To: <20060630113141.GK19712@stusta.de>
References: <20060630113141.GK19712@stusta.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2006 13:31:41 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> --- linux-2.6.17-mm4-full/kernel/sysctl.c.old	2006-06-30 02:34:13.000000000 +0200
> +++ linux-2.6.17-mm4-full/kernel/sysctl.c	2006-06-30 02:34:39.000000000 +0200
> @@ -2746,7 +2746,7 @@
>  EXPORT_SYMBOL(proc_dointvec);
>  EXPORT_SYMBOL(proc_dointvec_jiffies);
>  EXPORT_SYMBOL(proc_dointvec_minmax);
> -EXPORT_SYMBOL(proc_dointvec_userhz_jiffies);
> +EXPORT_UNUSED_SYMBOL(proc_dointvec_userhz_jiffies);  /*  June 2006  */
>  EXPORT_SYMBOL(proc_dointvec_ms_jiffies);
>  EXPORT_SYMBOL(proc_dostring);
>  EXPORT_SYMBOL(proc_doulongvec_minmax);

That export is integral to this API.  Please drop.
