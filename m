Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWHVHHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWHVHHM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 03:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWHVHHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 03:07:12 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:3972
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751051AbWHVHHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 03:07:10 -0400
Date: Tue, 22 Aug 2006 00:07:20 -0700 (PDT)
Message-Id: <20060822.000720.27786753.davem@davemloft.net>
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

Ok applied.  And I'll push this to -stable.

Thanks a lot Stephen.
