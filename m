Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264400AbTLQLhF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 06:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264401AbTLQLhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 06:37:05 -0500
Received: from p508EDB0E.dip.t-dialin.net ([80.142.219.14]:56211 "EHLO
	oscar.local.net") by vger.kernel.org with ESMTP id S264400AbTLQLhD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 06:37:03 -0500
Date: Wed, 17 Dec 2003 12:36:52 +0100
From: Patrick Mau <mau@oscar.ping.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] page_alloc.c is missing a ')'
Message-ID: <20031217113652.GA25893@oscar.prima.de>
Reply-To: Patrick Mau <mau@oscar.ping.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my current bk snapshot of Linus' 2.4 tree is missing a closing
brace in page_alloc.c

Here's a patch:

--- page_alloc.c.orig	2003-12-17 12:19:54.000000000 +0100
+++ page_alloc.c	2003-12-17 12:20:29.000000000 +0100
@@ -379,7 +379,7 @@
 	/* here we're in the low on memory slow path */
 
 	if (((current->flags & PF_MEMALLOC) && 
-			(!in_interrupt() || (current->flags & PF_MEMDIE))) {
+			(!in_interrupt() || (current->flags & PF_MEMDIE)))) {
 		zone = zonelist->zones;
 		for (;;) {
 			zone_t *z = *(zone++);

Patrick
