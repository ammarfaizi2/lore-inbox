Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932490AbWHHEvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbWHHEvv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 00:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbWHHEvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 00:51:51 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:27556
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932490AbWHHEvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 00:51:51 -0400
Date: Mon, 07 Aug 2006 21:51:52 -0700 (PDT)
Message-Id: <20060807.215152.98863622.davem@davemloft.net>
To: bunk@stusta.de
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [-mm patch] net/: make code static
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060807154947.GE3691@stusta.de>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	<20060807154947.GE3691@stusta.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Mon, 7 Aug 2006 17:49:47 +0200

> This patch makes needlessly global code static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Looks reasonable, applied.

> It doesn't seem to be intended that the new
> ipv4/fib_rules.c:fib4_rules_cleanup() is completely unused?

I'll kill it off.

IPv4 can't be built as a module and therefore there is no
relevant exit or module load error path for ipv4 for which
this function should be called.

Thanks.
