Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVFOVdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVFOVdA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 17:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVFOVaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 17:30:35 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:23527
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261589AbVFOVaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 17:30:09 -0400
Date: Wed, 15 Jun 2005 14:29:53 -0700 (PDT)
Message-Id: <20050615.142953.59469324.davem@davemloft.net>
To: juhl-lkml@dif.dk
Cc: yoshfuji@linux-ipv6.org, kuznet@ms2.inr.ac.ru, jmorris@redhat.com,
       ross.biro@gmail.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [-mm PATCH][4/4] net: signed vs unsigned cleanup in
 net/ipv4/raw.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.62.0506152316060.3842@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0506152316060.3842@dragon.hyggekrogen.localhost>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Juhl <juhl-lkml@dif.dk>
Date: Wed, 15 Jun 2005 23:32:22 +0200 (CEST)

> -	if (length >= sizeof(*iph) && iph->ihl * 4 <= length) {
> +	if (length >= sizeof(*iph) && (size_t)(iph->ihl * 4) <= length) {

Would changing the "4" into "4U" kill this warning just the same?

I think I'd prefer that.
