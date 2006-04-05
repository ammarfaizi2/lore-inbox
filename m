Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbWDEDRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWDEDRM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 23:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWDEDQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 23:16:53 -0400
Received: from xenotime.net ([66.160.160.81]:471 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751048AbWDEDQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 23:16:51 -0400
Date: Tue, 4 Apr 2006 20:17:26 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: wingel@nano-system.com, wim@iguana.be, akpm <akpm@osdl.org>
Subject: [PATCH] Doc: fix simple watchdog daemon to build cleanly
Message-Id: <20060404201726.ad042761.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix the simple watchdog daemon program in Doc/watchdog/watchdog-api.txt
to build cleanly.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/watchdog/watchdog-api.txt |    3 +++
 1 files changed, 3 insertions(+)

--- linux-2617-rc1-docsrc.orig/Documentation/watchdog/watchdog-api.txt
+++ linux-2617-rc1-docsrc/Documentation/watchdog/watchdog-api.txt
@@ -36,6 +36,9 @@ timeout or margin.  The simplest way to 
 some data to the device.  So a very simple watchdog daemon would look
 like this:
 
+#include <stdlib.h>
+#include <fcntl.h>
+
 int main(int argc, const char *argv[]) {
 	int fd=open("/dev/watchdog",O_WRONLY);
 	if (fd==-1) {


---
