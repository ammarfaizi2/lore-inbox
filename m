Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbULQTr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbULQTr1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 14:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbULQTr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 14:47:27 -0500
Received: from motgate.mot.com ([129.188.136.100]:44955 "EHLO motgate.mot.com")
	by vger.kernel.org with ESMTP id S262142AbULQTrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 14:47:23 -0500
Date: Fri, 17 Dec 2004 13:47:15 -0600 (CST)
From: Kumar Gala <galak@linen.sps.mot.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Make gcapatch work for all bk transports
Message-ID: <Pine.LNX.4.61.0412171343250.26684@linen.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Makes the gcapatch script work for any bk transport (including http).

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

--

diff -Nru a/Documentation/BK-usage/gcapatch b/Documentation/BK-usage/gcapatch
--- a/Documentation/BK-usage/gcapatch	2004-12-17 13:42:32 -06:00
+++ b/Documentation/BK-usage/gcapatch	2004-12-17 13:42:32 -06:00
@@ -5,4 +5,4 @@
 # Usage: gcapatch > foo.patch
 #
 
-bk export -tpatch -hdu -r`bk repogca bk://linux.bkbits.net/linux-2.5`,+
+bk export -tpatch -hdu -r$(bk repogca $(bk parent -p)),+

