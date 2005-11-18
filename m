Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbVKRXux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbVKRXux (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 18:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbVKRXux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 18:50:53 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:9360
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751230AbVKRXux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 18:50:53 -0500
Date: Fri, 18 Nov 2005 15:51:01 -0800 (PST)
Message-Id: <20051118.155101.51861744.davem@davemloft.net>
To: yanzheng@21cn.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [PATCH]IPv6: Acquire addrconf_hash_lock for reading instead of
 writing in addrconf_verify(...)
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <437BE773.6010007@21cn.com>
References: <437BE773.6010007@21cn.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yan Zheng <yanzheng@21cn.com>
Date: Thu, 17 Nov 2005 10:14:11 +0800

> addrconf_verify(...) only traverse address hash table when addrconf_hash_lock is held
> for writing, and it may hold addrconf_hash_lock for a long time. So I think it's better
> to acquire addrconf_hash_lock for reading instead of  writing
> 
> Signed-off-by: Yan Zheng <yanzheng@21cn.com>

Applied, thanks Yan.
