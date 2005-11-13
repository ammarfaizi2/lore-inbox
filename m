Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbVKMH7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbVKMH7b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 02:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVKMH7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 02:59:31 -0500
Received: from send.forptr.21cn.com ([202.105.45.49]:37321 "HELO 21cn.com")
	by vger.kernel.org with SMTP id S964902AbVKMH7b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 02:59:31 -0500
Message-ID: <4376F2CE.4050003@21cn.com>
Date: Sun, 13 Nov 2005 16:01:18 +0800
From: Yan Zheng <yanzheng@21cn.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org, yoshfuji@linux-ipv6.org
Subject: [PATCH]small fix for __ipv6_addr_type(...)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AIMC-AUTH: yanzheng
X-AIMC-MAILFROM: yanzheng@21cn.com
X-AIMC-Msg-ID: USenMbOB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I think the scope for loopback address should be node local.

Regards

Signed-off-by: Yan Zheng <yanzheng@21cn.com>

========================================================================
--- linux-2.6.15-rc1/net/ipv6/addrconf.c	2005-11-13 12:23:06.000000000 +0800
+++ linux/net/ipv6/addrconf.c	2005-11-13 15:50:03.000000000 +0800
@@ -249,7 +249,7 @@ int __ipv6_addr_type(const struct in6_ad
 
 			if (addr->s6_addr32[3] == htonl(0x00000001))
 				return (IPV6_ADDR_LOOPBACK | IPV6_ADDR_UNICAST |
-					IPV6_ADDR_SCOPE_TYPE(IPV6_ADDR_SCOPE_LINKLOCAL));	/* addr-select 3.4 */
+					IPV6_ADDR_SCOPE_TYPE(IPV6_ADDR_SCOPE_NODELOCAL));	/* addr-select 3.4 */
 
 			return (IPV6_ADDR_COMPATv4 | IPV6_ADDR_UNICAST |
 				IPV6_ADDR_SCOPE_TYPE(IPV6_ADDR_SCOPE_GLOBAL));	/* addr-select 3.3 */
