Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbUKMTwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbUKMTwT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 14:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbUKMTwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 14:52:18 -0500
Received: from hera.cwi.nl ([192.16.191.8]:6655 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261157AbUKMTwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 14:52:09 -0500
Date: Sat, 13 Nov 2004 20:52:04 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATH] __init in i386/kernel/cpu/nexgen.c
Message-ID: <20041113195203.GA1996@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -uprN -X /linux/dontdiff a/arch/i386/kernel/cpu/nexgen.c b/arch/i386/kernel/cpu/nexgen.c
--- a/arch/i386/kernel/cpu/nexgen.c	2003-12-18 03:58:08.000000000 +0100
+++ b/arch/i386/kernel/cpu/nexgen.c	2004-11-13 19:48:46.000000000 +0100
@@ -32,7 +32,7 @@ static void __init init_nexgen(struct cp
 	c->x86_cache_size = 256; /* A few had 1 MB... */
 }
 
-static void nexgen_identify(struct cpuinfo_x86 * c)
+static void __init nexgen_identify(struct cpuinfo_x86 * c)
 {
 	/* Detect NexGen with old hypercode */
 	if ( deep_magic_nexgen_probe() ) {
