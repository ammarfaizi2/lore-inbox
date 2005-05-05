Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbVEEMjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVEEMjG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 08:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVEEMjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 08:39:06 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:19433 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262084AbVEEMjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 08:39:02 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc3-mm3
Date: Thu, 5 May 2005 14:39:29 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <20050504221057.1e02a402.akpm@osdl.org>
In-Reply-To: <20050504221057.1e02a402.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505051439.29919.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 5 of May 2005 07:10, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm3/
> 

A small compile fix follows.

Greets,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

--- orig/net/decnet/dn_dev.c	2005-05-05 13:30:35.000000000 +0200
+++ linux-2.6.12-rc3-mm3/net/decnet/dn_dev.c	2005-05-05 14:16:08.000000000 +0200
@@ -1426,7 +1426,7 @@ static struct rtnetlink_link dnet_rtnetl
 	[RTM_GETRULE  - RTM_BASE] = { .dumpit	= dn_fib_dump_rules,	},
 #else
 	[RTM_GETROUTE - RTM_BASE] = { .doit	= dn_cache_getroute,
-				      .dumpit	= dn_cache_dump,	
+				      .dumpit	= dn_cache_dump,	},
 #endif
 
 };

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
