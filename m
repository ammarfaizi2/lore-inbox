Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbWBCVCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWBCVCw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 16:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbWBCVCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 16:02:51 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56333 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030236AbWBCVCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 16:02:50 -0500
Date: Fri, 3 Feb 2006 22:02:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Robert Olsson <robert.olsson@its.uu.se>,
       davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [-mm patch] net/ipv4/fib_rules.c: make struct fib_rules static again
Message-ID: <20060203210248.GK4408@stusta.de>
References: <20060203000704.3964a39f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203000704.3964a39f.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 12:07:04AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.15-mm4:
>...
>  git-net.patch
>...
>  Git trees
>...

struct fib_rules became global for no good reason.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc1-mm5-full/net/ipv4/fib_rules.c.old	2006-02-03 16:12:48.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/net/ipv4/fib_rules.c	2006-02-03 16:13:00.000000000 +0100
@@ -100,7 +100,7 @@
 	.r_action =	RTN_UNICAST,
 };
 
-struct hlist_head fib_rules;
+static struct hlist_head fib_rules;
 
 /* writer func called from netlink -- rtnl_sem hold*/
 

