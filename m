Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbVLUHhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbVLUHhk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 02:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbVLUHhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 02:37:40 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:56722
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932308AbVLUHhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 02:37:39 -0500
Date: Tue, 20 Dec 2005 23:37:39 -0800 (PST)
Message-Id: <20051220.233739.30595170.davem@davemloft.net>
To: chris.leech@gmail.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 4/5] I/OAT DMA support and TCP acceleration
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <41b516cb0512202310q78d5a25apab3c9d6fbb17089e@mail.gmail.com>
References: <43A8F43B.6020307@cosmosbay.com>
	<41b516cb0512202305p45439464o6b7ba6c2c88062bc@mail.gmail.com>
	<41b516cb0512202310q78d5a25apab3c9d6fbb17089e@mail.gmail.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Leech <chris.leech@gmail.com>
Date: Tue, 20 Dec 2005 23:10:07 -0800

>  That could be a good way to deal with it.  Actually, I should double
> check the length of tcp_skb_cb.  I took a quick look and thought that
> there might be some room left there anyway, even though the comment in
> tcp.h says otherwise.

There isn't, it's basically full on 64-bit systems with ipv6 enabled.

Just put the DMA cookie object explicitly into struct sk_buff,
protected by CONFIG_NET_DMA.
