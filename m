Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbVIGCsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbVIGCsI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 22:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVIGCsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 22:48:08 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:49046
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750809AbVIGCsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 22:48:06 -0400
Date: Tue, 06 Sep 2005 19:48:05 -0700 (PDT)
Message-Id: <20050906.194805.111546627.davem@davemloft.net>
To: kaber@trash.net
Cc: daniele@orlandi.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: proto_unregister sleeps while atomic
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <431E2978.2030701@trash.net>
References: <431E1FE9.7030405@trash.net>
	<20050906.160728.25203864.davem@davemloft.net>
	<431E2978.2030701@trash.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick McHardy <kaber@trash.net>
Date: Wed, 07 Sep 2005 01:42:48 +0200

> The only other user of proto_list besides proto_register, which
> doesn't care, are the seqfs functions. They use the slab pointer,
> but in a harmless way:
> 
>                     proto->slab == NULL ? "no" : "yes",
> 
> Anyway, I've moved it up to the top.

Ok thanks, patch applied.
