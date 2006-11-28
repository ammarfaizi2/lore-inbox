Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756395AbWK1VcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756395AbWK1VcV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 16:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756498AbWK1VcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 16:32:21 -0500
Received: from gundega.hpl.hp.com ([192.6.19.190]:23511 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1756395AbWK1VcU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 16:32:20 -0500
Date: Tue, 28 Nov 2006 13:31:59 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@suse.de, Stephane Eranian <eranian@hpl.hp.com>
Subject: [PATCH] remove useless carta_random32.h
Message-ID: <20061128213159.GC27335@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a small patch to remove the carta_random32.h header file.
The carta_random32() function was was put in and removed in favor
of random32(). In the removal process, the header file was
forgotten.

This patch is relative to 2.6.19-rc6-ak-061128 (firstfloor.org).

Changelog:
	- remove useless carta_random32.h header file

signed-off-by: stephane eranian <eranian@hpl.hp.com>

diff --exclude=.git -urNp linux-2.6.19-rc6-ak.orig/include/linux/carta_random32.h linux-2.6.19-rc6-ak/include/linux/carta_random32.h
--- linux-2.6.19-rc6-ak.orig/include/linux/carta_random32.h	2006-11-28 13:16:45.000000000 -0800
+++ linux-2.6.19-rc6-ak/include/linux/carta_random32.h	1969-12-31 16:00:00.000000000 -0800
@@ -1,29 +0,0 @@
-/*
- * Fast, simple, yet decent quality random number generator based on
- * a paper by David G. Carta ("Two Fast Implementations of the
- * `Minimal Standard' Random Number Generator," Communications of the
- * ACM, January, 1990).
- *
- * Copyright (c) 2002-2006 Hewlett-Packard Development Company, L.P.
- *	Contributed by Stephane Eranian <eranian@hpl.hp.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
- * 02111-1307 USA
- */
-#ifndef _LINUX_CARTA_RANDOM32_H_
-#define _LINUX_CARTA_RANDOM32_H_
-
-u64 carta_random32(u64 seed);
-
-#endif /* _LINUX_CARTA_RANDOM32_H_ */
