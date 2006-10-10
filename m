Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965122AbWJJJPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbWJJJPS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 05:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbWJJJPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 05:15:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:25499 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965122AbWJJJPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 05:15:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=TFsVHzUk1fDmaFk9fOywaYO5Nvs0wYuKoCbnYvtoLqW7oZAAWBIhq/lrRmkqn/YivPLvg8Xxe96jMTScgPpC4gpeI5GqgJkR95yLNiJkUL9pEcyP09BshGbNzFWKiSv84Hj2PObDBTJI7jPcPzsJpn3SPLM9HoYj2mXvbUO9/3w=
Date: Tue, 10 Oct 2006 13:15:01 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] apparent typo in ixgb.h, "_DEBUG_DRIVER_" looks wrong
Message-ID: <20061010091501.GA5369@martell.zuzino.mipt.ru>
References: <Pine.LNX.4.64.0610100219590.3442@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610100219590.3442@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 02:27:34AM -0400, Robert P. J. Day wrote:
> I'm *guessing* that "_DEBUG_DRIVER_" should really be "DEBUG_DRIVER"
> here, since there is no other occurrence of the former anywhere in the
> source tree.

Since it's debugging guard, underscored or not... doesn't matter. Convert to
pr_debug or dev_dbg of you want to deal with it.

> --- a/drivers/net/ixgb/ixgb.h
> +++ b/drivers/net/ixgb/ixgb.h
> @@ -77,7 +77,7 @@ #include "ixgb_hw.h"
>  #include "ixgb_ee.h"
>  #include "ixgb_ids.h"
>
> -#ifdef _DEBUG_DRIVER_
> +#ifdef DEBUG_DRIVER
>  #define IXGB_DBG(args...) printk(KERN_DEBUG "ixgb: " args)
>  #else
>  #define IXGB_DBG(args...)

