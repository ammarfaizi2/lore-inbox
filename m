Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVBZNH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVBZNH1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 08:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261185AbVBZNH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 08:07:27 -0500
Received: from hera.cwi.nl ([192.16.191.8]:955 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261182AbVBZNHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 08:07:23 -0500
Date: Sat, 26 Feb 2005 14:07:16 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] __init in cfq-iosched.c
Message-ID: <20050226130715.GA8015@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cfq_init() calls __init cfq_slab_setup and hence must be __init itself

also made it static

Andries

diff -uprN -X /linux/dontdiff a/drivers/block/cfq-iosched.c b/drivers/block/cfq-iosched.c
--- a/drivers/block/cfq-iosched.c	2005-02-26 12:13:29.000000000 +0100
+++ b/drivers/block/cfq-iosched.c	2005-02-26 14:18:00.000000000 +0100
@@ -1819,7 +1819,7 @@ static struct elevator_type iosched_cfq 
 	.elevator_owner =	THIS_MODULE,
 };
 
-int cfq_init(void)
+static int __init cfq_init(void)
 {
 	int ret;
 
