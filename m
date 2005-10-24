Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbVJXMKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbVJXMKQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 08:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbVJXMKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 08:10:16 -0400
Received: from send.forptr.21cn.com ([202.105.45.48]:31129 "HELO 21cn.com")
	by vger.kernel.org with SMTP id S1750943AbVJXMKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 08:10:15 -0400
Message-ID: <435CCF7B.6030907@21cn.com>
Date: Mon, 24 Oct 2005 20:11:39 +0800
From: Yan Zheng <yanzheng@21cn.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH]IPv6: fix refcnt of struct ip6_flowlabel
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AIMC-AUTH: yanzheng
X-AIMC-MAILFROM: yanzheng@21cn.com
X-AIMC-Msg-ID: ejkLB4OB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yan Zheng <yanzheng@21cn.com>


Index: net/ipv6/ip6_flowlabel.c
===================================================================
--- linux-2.6.14-rc5/net/ipv6/ip6_flowlabel.c	2005-10-22 10:31:13.000000000 +0800
+++ linux/net/ipv6/ip6_flowlabel.c	2005-10-24 19:55:23.000000000 +0800
@@ -483,7 +483,7 @@
 						goto done;
 					}
 					fl1 = sfl->fl;
-					atomic_inc(&fl->users);
+					atomic_inc(&fl1->users);
 					break;
 				}
 			}

