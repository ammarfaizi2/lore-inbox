Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756902AbWKVFv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756902AbWKVFv2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 00:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756899AbWKVFv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 00:51:28 -0500
Received: from stinky.trash.net ([213.144.137.162]:52379 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1756900AbWKVFv1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 00:51:27 -0500
Message-ID: <4563E55B.4070503@trash.net>
Date: Wed, 22 Nov 2006 06:51:23 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Faidon Liambotis <paravoid@debian.org>
CC: coreteam@netfilter.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [netfilter-core] [PATCH 2.6.19-rc6] netfilter: fix panic on	ip_conntrack_h323
 with CONFIG_IP_NF_CT_ACCT
References: <20061120193931.GA9913@void.cube.gr>
In-Reply-To: <20061120193931.GA9913@void.cube.gr>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Faidon Liambotis wrote:
> H.323 connection tracking code calls ip_ct_refresh_acct() when
> processing RCFs and URQs but passes NULL as the skb.
> When CONFIG_IP_NF_CT_ACCT is enabled, the connection tracking core tries
> to derefence the skb, which results in an obvious panic.
> ago.
> 
> The patch uses ip_ct_refresh() instead of ip_ct_refresh_acct() to avoid
> double accounting (suggested by Patrick McHardy).


Thanks, I already fixed up your first patch and sent it
upstream/to -stable after loosing hope to hear back from
you :)


