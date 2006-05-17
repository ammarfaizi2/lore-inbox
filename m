Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWEQHKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWEQHKS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 03:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWEQHKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 03:10:17 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:65441
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932452AbWEQHKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 03:10:16 -0400
Date: Wed, 17 May 2006 00:09:57 -0700 (PDT)
Message-Id: <20060517.000957.45395448.davem@davemloft.net>
To: kaber@trash.net
Cc: sfrost@snowman.net, azez@ufomechanic.net, willy@w.ods.org,
       gcoady.lk@gmail.com, laforge@netfilter.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       marcelo@kvack.org
Subject: Re: [PATCH] fix mem-leak in netfilter
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <446AC1FB.5070406@trash.net>
References: <20060515204142.GO7774@kenobi.snowman.net>
	<20060515210342.GP7774@kenobi.snowman.net>
	<446AC1FB.5070406@trash.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick McHardy <kaber@trash.net>
Date: Wed, 17 May 2006 08:26:03 +0200

> +	if (info->check_set & (IPT_RECENT_SET | IPT_RECENT_REMOVE) &&
> +	    (info->seconds || info->hit_count))
> +		return 0;

I'm feeling particularly dense today... but what is the relative
precedence of '&' vs '&&'?

I've been told that if you have to look up C operator precedence,
don't bother and add parenthesis instead :)
