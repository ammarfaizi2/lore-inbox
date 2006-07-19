Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbWGSEL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWGSEL0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 00:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWGSEL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 00:11:26 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:15328
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932489AbWGSELZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 00:11:25 -0400
Date: Tue, 18 Jul 2006 21:11:49 -0700 (PDT)
Message-Id: <20060718.211149.132925536.davem@davemloft.net>
To: takis@lumumba.uhasselt.be
Cc: linux-kernel@vger.kernel.org, acme@conectiva.com.br,
       patrick@tykepenguin.com, per.liden@ericsson.com, mitch@sfgoth.com,
       samuel@sortiz.org, eis@baty.hanse.de, ralf@linux-mips.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] net: Conversions from kmalloc+memset to k(z|c)alloc.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060719010343.GC30823@lumumba.uhasselt.be>
References: <20060719010343.GC30823@lumumba.uhasselt.be>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: takis@lumumba.uhasselt.be (Panagiotis Issaris)
Date: Wed, 19 Jul 2006 03:03:43 +0200

> From: Panagiotis Issaris <takis@issaris.org>
> 
> net: Conversions from kmalloc+memset to kzalloc.
> 
> Signed-off-by: Panagiotis Issaris <takis@issaris.org>

Applied, thanks a lot.

One of the ieee80211 cases is even a bug fix because it
was memset()'ing without checking if kmalloc() returned
NULL.
