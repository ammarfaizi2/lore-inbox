Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbUKGQSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbUKGQSC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 11:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbUKGQQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 11:16:59 -0500
Received: from mout0.freenet.de ([194.97.50.131]:965 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S261647AbUKGQQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 11:16:40 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH 2.4] fix THIS_MODULE error in arp.c
Date: Sun, 7 Nov 2004 14:58:12 +0100
User-Agent: KMail/1.7.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0nijBpCUSQzEq4g"
Message-Id: <200411071458.12846.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_0nijBpCUSQzEq4g
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcelo,

This fixes an "undeclared THIS_MODULE" compiletime error.

Sorry for the attachment. My mailer is currently broken and
corrupts diffs.

--Boundary-00=_0nijBpCUSQzEq4g
Content-Type: text/x-diff;
  charset="us-ascii";
  name="net-ipv4-arp-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="net-ipv4-arp-fix.diff"

--- linux-2.4.28-rc1-bk4/net/ipv4/arp.c.orig	Sun Nov  7 15:27:45 2004
+++ linux-2.4.28-rc1-bk4/net/ipv4/arp.c	Sun Nov  7 15:28:42 2004
@@ -94,6 +94,7 @@
 #include <linux/stat.h>
 #include <linux/init.h>
 #include <linux/jhash.h>
+#include <linux/module.h>
 #ifdef CONFIG_SYSCTL
 #include <linux/sysctl.h>
 #endif

--Boundary-00=_0nijBpCUSQzEq4g--
