Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbUDXSSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbUDXSSF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 14:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbUDXSSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 14:18:05 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:61406 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S261624AbUDXSSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 14:18:02 -0400
Date: Sat, 24 Apr 2004 20:16:57 +0200
To: paulus@au.ibm.com, davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] Mark CONFIG_MAC_SERIAL (drivers/macintosh/macserial.c) as broken
Message-ID: <20040424181657.GY11547@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

CONFIG_MAC_SERIAL (drivers/macintosh/macserial.c) is marked obsolete and
currently doesn't build.

This patch marks it as broken. Against 2.6.6-rc2. Thanks.


 Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/macintosh/Kconfig	2004-04-11 14:05:36.000000000 +0200
+++ b/drivers/macintosh/Kconfig	2004-04-24 20:03:26.000000000 +0200
@@ -127,7 +127,7 @@ config MAC_FLOPPY
 
 config MAC_SERIAL
 	tristate "Support for PowerMac serial ports (OBSOLETE DRIVER)"
-	depends on PPC_PMAC
+	depends on PPC_PMAC && BROKEN
 	help
 	  This driver is obsolete. Use CONFIG_SERIAL_PMACZILOG in
 	  "Character devices --> Serial drivers --> PowerMac z85c30" option.
