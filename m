Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030680AbWJCXZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030680AbWJCXZm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 19:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030684AbWJCXZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 19:25:42 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:4066
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030680AbWJCXZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 19:25:41 -0400
Date: Tue, 03 Oct 2006 16:25:44 -0700 (PDT)
Message-Id: <20061003.162544.125897847.davem@davemloft.net>
To: jeff@garzik.org
Cc: per.liden@ericsson.com, jon.maloy@ericsson.com,
       allan.stephens@windriver.com, akpm@osdl.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TIPC: fix printk warning
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061001162413.GA8000@havoc.gtf.org>
References: <20061001162413.GA8000@havoc.gtf.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Garzik <jeff@garzik.org>
Date: Sun, 1 Oct 2006 12:24:13 -0400

> gcc spits out this warning:
> 
> net/tipc/link.c: In function $,1rx(Blink_retransmit_failure$,1ry(B:
> net/tipc/link.c:1669: warning: cast from pointer to integer of different
> size
> 
> More than a little bit ugly, storing integers in void*, but at least the
> code is correct, unlike some of the more crufty Linux kernel code found
> elsewhere.
> 
> Rather than having two casts to massage the value into u32, it's easier
> just to have a single cast and use "%lu", since it's just a printk.
> 
> Signed-off-by: Jeff Garzik <jeff@garzik.org>

Applied, thanks Jeff.
