Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264919AbUGSPmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUGSPmZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 11:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265275AbUGSPmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 11:42:24 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:26052 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S264919AbUGSPmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 11:42:21 -0400
Date: Mon, 19 Jul 2004 17:41:45 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: dwmw2@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][2.6.8-rc2] Fix JFFS2_COMPRESSION_OPTIONS in Kconfig
Message-ID: <20040719154145.GA5429@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
It seems to me that JFFS2_COMPRESSION_OPTIONS depends on JFFS2_FS:

--- linux-2.6/fs/Kconfig.orig	2004-07-19 17:39:06.000000000 +0200
+++ linux-2.6/fs/Kconfig	2004-07-19 17:39:27.000000000 +0200
@@ -1151,6 +1151,7 @@
 
 config JFFS2_COMPRESSION_OPTIONS
 	bool "Advanced compression options for JFFS2"
+	depends on JFFS2_FS
 	default n
 	help
 	  Enabling this option allows you to explicitly choose which

HTH,
Luca
-- 
Home: http://kronoz.cjb.net
"New processes are created by other processes, just like new
 humans. New humans are created by other humans, of course,
 not by processes." -- Unix System Administration Handbook
