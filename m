Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbVI1JjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbVI1JjY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 05:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbVI1JjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 05:39:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:36314 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030236AbVI1JjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 05:39:23 -0400
Subject: Re: [PATCH] RT: epca_lock to DEFINE_SPINLOCK
From: Arjan van de Ven <arjan@infradead.org>
To: dwalker@mvista.com
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <1127845928.4004.24.camel@dhcp153.mvista.com>
References: <1127845928.4004.24.camel@dhcp153.mvista.com>
Content-Type: text/plain
Date: Wed, 28 Sep 2005 11:39:09 +0200
Message-Id: <1127900349.2893.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
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
>  
>  /* ------------------

this is really ugly though; at minimum a DEFINE_STATIC_SPINLOCK() would
be needed to make this less ugly.


