Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbVKCArq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbVKCArq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 19:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbVKCArq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 19:47:46 -0500
Received: from send.forptr.21cn.com ([202.105.45.47]:23762 "HELO 21cn.com")
	by vger.kernel.org with SMTP id S1030232AbVKCArp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 19:47:45 -0500
Message-ID: <43695E77.3080707@21cn.com>
Date: Thu, 03 Nov 2005 08:48:55 +0800
From: Yan Zheng <yanzheng@21cn.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org,
       Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: [PATCH]A old patch for addrconf_ifdown(...).
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AIMC-AUTH: yanzheng
X-AIMC-MAILFROM: yanzheng@21cn.com
X-AIMC-Msg-ID: yx4S37OB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The patch may be got lost. It's already acked by YOSHIFUJI.


Signed-off-by: Yan Zheng<yanzheng@21cn.com>

Index:  net/ipv6/addrconf.c
------------------------------------------------------------------------
--- linux-2.6.14/net/ipv6/addrconf.c	2005-10-28 08:02:08.000000000 +0800
+++ linux/net/ipv6/addrconf.c	2005-11-03 08:35:11.000000000 +0800
@@ -2167,7 +2167,7 @@ static int addrconf_ifdown(struct net_de
 
 	/* Step 5: netlink notification of this interface */
 	idev->tstamp = jiffies;
-	inet6_ifinfo_notify(RTM_NEWLINK, idev);
+	inet6_ifinfo_notify(RTM_DELLINK, idev);
 	
 	/* Shot the device (if unregistered) */
 

