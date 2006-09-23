Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbWIWFZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWIWFZK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 01:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWIWFZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 01:25:09 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:21648
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751044AbWIWFZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 01:25:08 -0400
Date: Fri, 22 Sep 2006 22:25:07 -0700 (PDT)
Message-Id: <20060922.222507.74751476.davem@davemloft.net>
To: akpm@osdl.org
Cc: auke-jan.h.kok@intel.com, Holger.Kiehl@dwd.de,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@vger.kernel.org, john.ronciak@intel.com
Subject: Re: 2.6.1[78] page allocation failure. order:3, mode:0x20
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060922215000.c1fde093.akpm@osdl.org>
References: <20060922004253.2e2e2612.akpm@osdl.org>
	<4514190C.8010901@intel.com>
	<20060922215000.c1fde093.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Fri, 22 Sep 2006 21:50:00 -0700

> On Fri, 22 Sep 2006 10:10:36 -0700
> Auke Kok <auke-jan.h.kok@intel.com> wrote:
> 
> > e1000: account for NET_IP_ALIGN when calculating bufsiz
> > 
> > Account for NET_IP_ALIGN when requesting buffer sizes from netdev_alloc_skb to 
> > reduce slab allocation by half.
> 
> Could we please do whatever is needed to get this blessed and merged?  This
> is such a common problem on such a common driver that I would suggest that
> we want this in 2.6.18.x as well.  At least, I'd expect distributors to
> ship this fix (they're nuts if they don't) and so it makes sense to deliver
> it from kernel.org.

The NET_IP_ALIGN existed not just for fun :)  There are ramifications
for removing it.

