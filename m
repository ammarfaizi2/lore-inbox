Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933020AbWJJLb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933020AbWJJLb1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 07:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933023AbWJJLb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 07:31:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32169 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S933020AbWJJLb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 07:31:27 -0400
Subject: Re: [PATCH] ixgb.h: Redefine IXGB_DBG() macro to use pr_debug().
From: Arjan van de Ven <arjan@infradead.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       trivial@kernel.org
In-Reply-To: <Pine.LNX.4.64.0610100713350.7179@localhost.localdomain>
References: <Pine.LNX.4.64.0610100713350.7179@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 10 Oct 2006 13:31:23 +0200
Message-Id: <1160479883.3000.284.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 07:17 -0400, Robert P. J. Day wrote:
> Simplify the definition of IXGB_DBG() to be based on pr_debug().
> 
> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
> ---
> diff --git a/drivers/net/ixgb/ixgb.h b/drivers/net/ixgb/ixgb.h
> index 50ffe90..16e6c3d 100644
> --- a/drivers/net/ixgb/ixgb.h
> +++ b/drivers/net/ixgb/ixgb.h
> @@ -77,11 +77,7 @@ #include "ixgb_hw.h"
>  #include "ixgb_ee.h"
>  #include "ixgb_ids.h"
> 
> -#ifdef _DEBUG_DRIVER_
> -#define IXGB_DBG(args...) printk(KERN_DEBUG "ixgb: " args)
> -#else
> -#define IXGB_DBG(args...)
> -#endif
> +#define IXGB_DBG(args...) pr_debug("ixgb: ", args)


while this is of course correct, why not go all the way and replace all
IXGB() users to pr_debug() directly? 


