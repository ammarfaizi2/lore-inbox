Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWCUVZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWCUVZV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 16:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWCUVZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 16:25:20 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:1459
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932455AbWCUVZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 16:25:19 -0500
Date: Tue, 21 Mar 2006 13:25:14 -0800 (PST)
Message-Id: <20060321.132514.24407022.davem@davemloft.net>
To: hawk@diku.dk
Cc: dipankar@in.ibm.com, Robert.Olsson@data.slu.se, jens.laas@data.slu.se,
       hans.liss@its.uu.se, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel panic: Route cache, RCU, possibly FIB trie.
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0603211538280.28173@ask.diku.dk>
References: <Pine.LNX.4.61.0603211113550.15500@ask.diku.dk>
	<20060321.023705.26111240.davem@davemloft.net>
	<Pine.LNX.4.61.0603211538280.28173@ask.diku.dk>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Dangaard Brouer <hawk@diku.dk>
Date: Tue, 21 Mar 2006 15:51:34 +0100 (CET)

> You guessed right... I did enable IP_ROUTE_MULTIPATH_CACHED, I have
> now disabled it and equal multi path routing in general
> (CONFIG_IP_ROUTE_MULTIPATH).

It is almost certainly the cause of your crashes, that code
is still extremely raw and that's why it is listed as "EXPERIMENTAL".
