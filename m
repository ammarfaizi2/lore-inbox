Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbUKFBbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbUKFBbn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 20:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbUKFBbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 20:31:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:22696 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261281AbUKFBbi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 20:31:38 -0500
Date: Fri, 5 Nov 2004 17:31:36 -0800
From: Chris Wright <chrisw@osdl.org>
To: marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compile fix for neighbour scalability backport
Message-ID: <20041105173136.M14339@build.pdx.osdl.net>
References: <20041105172414.L14339@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041105172414.L14339@build.pdx.osdl.net>; from chrisw@osdl.org on Fri, Nov 05, 2004 at 05:24:14PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And another compile fix for neighbour scalability fixes.

arp.c:1342: error: `THIS_MODULE' undeclared here (not in a function)
arp.c:1342: error: initializer element is not constant
arp.c:1342: error: (near initialization for `arp_seq_fops.owner')

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== net/ipv4/arp.c 1.18 vs edited =====
--- 1.18/net/ipv4/arp.c	2004-10-05 12:33:32 -07:00
+++ edited/net/ipv4/arp.c	2004-11-05 17:25:52 -08:00
@@ -76,6 +76,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/config.h>
 #include <linux/socket.h>

