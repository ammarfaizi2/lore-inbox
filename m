Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265728AbUAUQZU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 11:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265744AbUAUQZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 11:25:20 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:31126 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265728AbUAUQZQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 11:25:16 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 21 Jan 2004 17:13:31 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] selinux build fix
Message-ID: <20040121161331.GA2531@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi

trivial one: uses __init and thus needs linux/init.h

  Gerd

--- linux/security/selinux/netif.c.se	2004-01-21 16:42:10.000000000 +0100
+++ linux/security/selinux/netif.c	2004-01-21 16:42:22.000000000 +0100
@@ -12,6 +12,7 @@
  * it under the terms of the GNU General Public License version 2,
  * as published by the Free Software Foundation.
  */
+#include <linux/init.h>
 #include <linux/types.h>
 #include <linux/stddef.h>
 #include <linux/kernel.h>

-- 
"... und auch das ganze Wochenende oll" -- Wetterbericht auf RadioEins
