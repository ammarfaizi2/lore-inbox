Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965215AbVI0WdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965215AbVI0WdQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 18:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965216AbVI0WdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 18:33:16 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:6324
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S965215AbVI0WdP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 18:33:15 -0400
Subject: Re: [PATCH] RT: epca_lock to DEFINE_SPINLOCK
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: dwalker@mvista.com
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <1127845928.4004.24.camel@dhcp153.mvista.com>
References: <1127845928.4004.24.camel@dhcp153.mvista.com>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 28 Sep 2005 00:34:00 +0200
Message-Id: <1127860440.15115.216.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-27 at 11:32 -0700, Daniel Walker wrote:
> Convert epca_lock to the new syntax.
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> 
> Index: linux-2.6.13/drivers/char/epca.c
> ===================================================================
> --- linux-2.6.13.orig/drivers/char/epca.c
> +++ linux-2.6.13/drivers/char/epca.c
> @@ -80,7 +80,7 @@ static int invalid_lilo_config;
>  /* The ISA boards do window flipping into the same spaces so its only sane
>     with a single lock. It's still pretty efficient */
>  
> -static spinlock_t epca_lock = SPIN_LOCK_UNLOCKED;
> +static DEFINE_SPINLOCK(epca_lock);

Please submit also to Andrew/subsystem maintainer. Thats not a -RT
related issue.

tglx


