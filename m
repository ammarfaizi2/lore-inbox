Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWG3WoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWG3WoI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 18:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWG3WoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 18:44:08 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:49285
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751428AbWG3WoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 18:44:07 -0400
Date: Sun, 30 Jul 2006 15:44:16 -0700 (PDT)
Message-Id: <20060730.154416.121293840.davem@davemloft.net>
To: herbert@gondor.apana.org.au
Cc: yoshfuji@linux-ipv6.org, Matt_Domsch@dell.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [IPV6]: Audit all ip6_dst_lookup/ip6_dst_store calls
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060729043325.GA7035@gondor.apana.org.au>
References: <20060728194531.GA17744@lists.us.dell.com>
	<20060729043325.GA7035@gondor.apana.org.au>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sat, 29 Jul 2006 14:33:25 +1000

> [IPV6]: Audit all ip6_dst_lookup/ip6_dst_store calls
> 
> The current users of ip6_dst_lookup can be divided into two classes:
> 
> 1) The caller holds no locks and is in user-context (UDP).
> 2) The caller does not want to lookup the dst cache at all.
> 
> The second class covers everyone except UDP because most people do
> the cache lookup directly before calling ip6_dst_lookup.  This patch
> adds ip6_sk_dst_lookup for the first class.
> 
> Similarly ip6_dst_store users can be divded into those that need to
> take the socket dst lock and those that don't.  This patch adds
> __ip6_dst_store for those (everyone except UDP/datagram) that don't
> need an extra lock.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Applied, thanks Herbert.
