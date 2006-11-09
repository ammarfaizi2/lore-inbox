Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754341AbWKIHAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754341AbWKIHAy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 02:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754347AbWKIHAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 02:00:54 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:24242
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1754341AbWKIHAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 02:00:54 -0500
Date: Wed, 08 Nov 2006 23:00:59 -0800 (PST)
Message-Id: <20061108.230059.57444310.davem@davemloft.net>
To: kenneth.w.chen@intel.com
Cc: akpm@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [patch] fix up generic csum_ipv6_magic function prototype
From: David Miller <davem@davemloft.net>
In-Reply-To: <000301c703a3$0eedb340$ff0da8c0@amr.corp.intel.com>
References: <000301c703a3$0eedb340$ff0da8c0@amr.corp.intel.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Date: Wed, 8 Nov 2006 18:02:06 -0800

> The generic version of csum_ipv6_magic has the len argument declared as
> __u16, while most arch dependent version declare it as __u32.  After
> looking at the call site of this function, I come up to a conclusion
> that __u32 is a better match with the actual usage.
> 
> Hence, patch to change argument type for greater consistency.
> 
> Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

Architecture implementations such as the ones for m32r and parisc have
the same problem, so "for consistency" please fix them up as well.

Thanks a lot.
