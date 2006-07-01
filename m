Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932576AbWGADkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576AbWGADkI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 23:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbWGADj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 23:39:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40423 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932479AbWGADjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 23:39:00 -0400
Date: Fri, 30 Jun 2006 20:35:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] EXPORT_UNUSED_SYMBOL{,GPL}
 {,un}register_die_notifier
Message-Id: <20060630203546.93a7bd87.akpm@osdl.org>
In-Reply-To: <20060630113317.GV19712@stusta.de>
References: <20060630113317.GV19712@stusta.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2006 13:33:17 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> -EXPORT_SYMBOL(register_die_notifier);
> +EXPORT_UNUSED_SYMBOL(register_die_notifier);  /*  June 2006  */
> -EXPORT_SYMBOL(unregister_die_notifier);
> +EXPORT_UNUSED_SYMBOL(unregister_die_notifier);  /*  June 2006  */

I'd expect there are any number of low-level debugging quick-hacky modules
around which want to hook into here.

We can try it I guess, but I expect we'll hear about it.
