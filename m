Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262148AbVANUQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbVANUQN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 15:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbVANUNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 15:13:23 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:40890 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262131AbVANULj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 15:11:39 -0500
Date: Fri, 14 Jan 2005 12:11:25 -0800
From: Dave Jiang <dave.jiang@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       smaurer@teja.com, linux@arm.linux.org.uk, greg@kroah.com,
       mporter@kernel.crashing.org
Subject: [PATCH 3/5] resource: i386 arch fixes for u64 resources
Message-ID: <20050114201125.GA19681@plexity.net>
Reply-To: dave.jiang@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Corp.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386 arch update to changing resource from unsigned long to u64

Signed-off-by: Dave Jiang <dave.jiang@gmail.com>


diff -Naur linux-2.6.11-rc1/arch/i386/pci/i386.c linux-2.6.11-rc1-u64/arch/i386/pci/i386.c
--- linux-2.6.11-rc1/arch/i386/pci/i386.c	2004-12-24 14:34:26.000000000 -0700
+++ linux-2.6.11-rc1-u64/arch/i386/pci/i386.c	2005-01-13 11:45:41.830462776 -0700
@@ -48,7 +48,7 @@
  */
 void
 pcibios_align_resource(void *data, struct resource *res,
-		       unsigned long size, unsigned long align)
+		       u64 size, u64 align)
 {
 	if (res->flags & IORESOURCE_IO) {
 		unsigned long start = res->start;

