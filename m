Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVG0VlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVG0VlY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 17:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbVG0VlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 17:41:18 -0400
Received: from ms-smtp-01-smtplb.rdc-nyc.rr.com ([24.29.109.5]:6126 "EHLO
	ms-smtp-01.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S261222AbVG0VjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 17:39:15 -0400
Message-ID: <42E7FED7.6070609@temple.edu>
Date: Wed, 27 Jul 2005 17:38:31 -0400
From: Nick Sillik <n.sillik@temple.edu>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: linux-kernel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH 2.6.13-rc3-mm2]net/ipv4/netfilter/ip_conntrack_core.c
 fix -Wundef error
References: <42E7F377.9040107@temple.edu> <20050727.142458.112852452.davem@davemloft.net>
In-Reply-To: <20050727.142458.112852452.davem@davemloft.net>
Content-Type: multipart/mixed;
 boundary="------------050604050609040309090500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050604050609040309090500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Apologies

Signed-off-by: Nick Sillik <n.sillik@temple.edu>

David S. Miller wrote:
> From: Nick Sillik <n.sillik@temple.edu>
> Date: Wed, 27 Jul 2005 16:49:59 -0400
> 
> 
>>Sorry for the resend and previously bad subject line.
>>
>>This fixes a single -Wundef error in the file
>>net/ipv4/netfilter/ip_conntrack_core.c ,
> 
> 
> Please supply a proper Signed-off-by: line with your
> patch.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


--------------050604050609040309090500
Content-Type: text/plain;
 name="ipconntrack_wundef.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipconntrack_wundef.patch"

diff -urN a/net/ipv4/netfilter/ip_conntrack_core.c b/net/ipv4/netfilter/ip_conntrack_core.c
--- a/net/ipv4/netfilter/ip_conntrack_core.c	2005-07-27 16:40:16.000000000 -0400
+++ b/net/ipv4/netfilter/ip_conntrack_core.c	2005-07-27 16:41:00.000000000 -0400
@@ -723,7 +723,7 @@
 		/* Welcome, Mr. Bond.  We've been expecting you... */
 		__set_bit(IPS_EXPECTED_BIT, &conntrack->status);
 		conntrack->master = exp->master;
-#if CONFIG_IP_NF_CONNTRACK_MARK
+#ifdef CONFIG_IP_NF_CONNTRACK_MARK
 		conntrack->mark = exp->master->mark;
 #endif
 		nf_conntrack_get(&conntrack->master->ct_general);

--------------050604050609040309090500--
