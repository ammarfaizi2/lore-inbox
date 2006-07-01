Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbWGADix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWGADix (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 23:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWGADiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 23:38:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20455 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932402AbWGADh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 23:37:58 -0400
Date: Fri, 30 Jun 2006 20:34:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kernel/sys.c: EXPORT_UNUSED_SYMBOL{,_GPL}
Message-Id: <20060630203444.4eee0597.akpm@osdl.org>
In-Reply-To: <20060630113147.GL19712@stusta.de>
References: <20060630113147.GL19712@stusta.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2006 13:31:47 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> This patch marks unused exports as EXPORT_UNUSED_SYMBOL{,_GPL}.
> 
> ..
>
> -EXPORT_SYMBOL_GPL(kernel_restart);
> +EXPORT_UNUSED_SYMBOL_GPL(kernel_restart);  /*  June 2006  */
> -EXPORT_SYMBOL_GPL(kernel_halt);
> +EXPORT_UNUSED_SYMBOL_GPL(kernel_halt);  /*  June 2006  */

These are grouped with kernel_power_off() which remains exported.

> -EXPORT_SYMBOL(in_egroup_p);
> +EXPORT_UNUSED_SYMBOL(in_egroup_p);  /*  June 2006  */

And this is grouped with in_group_p, which remains exported.

Please drop.
