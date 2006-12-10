Return-Path: <linux-kernel-owner+w=401wt.eu-S1756821AbWLJLWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756821AbWLJLWL (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 06:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757101AbWLJLWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 06:22:11 -0500
Received: from livid.absolutedigital.net ([66.92.46.173]:1631 "EHLO
	mx2.absolutedigital.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756344AbWLJLWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 06:22:10 -0500
Date: Sun, 10 Dec 2006 06:22:05 -0500 (EST)
From: Cal Peake <cp@absolutedigital.net>
To: Linus Torvalds <torvalds@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH] add MODULE_* attributes to bit reversal library
In-Reply-To: <Pine.LNX.4.64.0612100600110.1396@lancer.cnet.absolutedigital.net>
Message-ID: <Pine.LNX.4.64.0612100619560.8192@lancer.cnet.absolutedigital.net>
References: <Pine.LNX.4.64.0612100600110.1396@lancer.cnet.absolutedigital.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ugh, to early in the morn... here's one that applies properly:

From: Cal Peake <cp@absolutedigital.net>

Add MODULE_* attributes to the new bit reversal library. Most notably 
MODULE_LICENSE which prevents superfluous kernel tainting.

Signed-off-by: Cal Peake <cp@absolutedigital.net>

--- ./lib/bitrev.c~orig	2006-12-08 18:11:00.000000000 -0500
+++ ./lib/bitrev.c	2006-12-10 05:56:46.000000000 -0500
@@ -2,6 +2,10 @@
 #include <linux/module.h>
 #include <linux/bitrev.h>
 
+MODULE_AUTHOR("Akinobu Mita <akinobu.mita@gmail.com>");
+MODULE_DESCRIPTION("Bit ordering reversal functions");
+MODULE_LICENSE("GPL");
+
 const u8 byte_rev_table[256] = {
 	0x00, 0x80, 0x40, 0xc0, 0x20, 0xa0, 0x60, 0xe0,
 	0x10, 0x90, 0x50, 0xd0, 0x30, 0xb0, 0x70, 0xf0,
