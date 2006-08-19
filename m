Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751594AbWHSAA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbWHSAA3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 20:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbWHSAA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 20:00:29 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:52913
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751592AbWHSAA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 20:00:28 -0400
Date: Fri, 18 Aug 2006 17:00:30 -0700 (PDT)
Message-Id: <20060818.170030.74563682.davem@davemloft.net>
To: shemminger@osdl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tcp: limit window scaling if window is clamped
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060818102938.5abc1bcf@dxpl.pdx.osdl.net>
References: <20060818102938.5abc1bcf@dxpl.pdx.osdl.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Fri, 18 Aug 2006 10:29:38 -0700

> This small change allows for easy per-route workarounds for broken hosts or
> middleboxes that are not compliant with TCP standards for window scaling.
> Rather than having to turn off window scaling globally. This patch allows
> reducing or disabling window scaling if window clamp is present.
> 
> Example: Mark Lord reported a problem with 2.6.17 kernel being unable to
> access http://www.everymac.com
> 
> # ip route add 216.145.246.23/32 via 10.8.0.1 window 65535
> 
> I would argue this ought to go in stable kernel as well.
> 
> Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

I want to think about this some more, it might have unintended
consequences.  I really am not all that thrilled about putting in
workaround for this problem especially if it hurts a legitimate use of
some kind.
