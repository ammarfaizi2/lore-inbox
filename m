Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbWHTRrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWHTRrH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWHTRrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:47:07 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:65036 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751062AbWHTRrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:47:06 -0400
Date: Sun, 20 Aug 2006 19:47:05 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Josh Triplett <josht@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Paul McKenney <paulmck@us.ibm.com>
Subject: [-mm patch] make kernel/rcutorture.c:rcu_bh_torture_synchronize() static
Message-ID: <20060820174705.GP7813@stusta.de>
References: <20060819220008.843d2f64.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060819220008.843d2f64.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2006 at 10:00:08PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc4-mm1:
>...
> +rcu-add-fake-writers-to-rcutorture.patch
> 
>  RCU stuff
>...

This patch makes the needlessly global rcu_bh_torture_synchronize() 
static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc4-mm2/kernel/rcutorture.c.old	2006-08-20 19:30:16.000000000 +0200
+++ linux-2.6.18-rc4-mm2/kernel/rcutorture.c	2006-08-20 19:30:28.000000000 +0200
@@ -308,7 +308,7 @@
 	complete(&rcu->completion);
 }
 
-void rcu_bh_torture_synchronize(void)
+static void rcu_bh_torture_synchronize(void)
 {
 	struct rcu_bh_torture_synchronize rcu;
 

