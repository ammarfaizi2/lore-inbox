Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbVIXCJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbVIXCJJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 22:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbVIXCJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 22:09:09 -0400
Received: from xenotime.net ([66.160.160.81]:28093 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751361AbVIXCJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 22:09:08 -0400
Date: Fri, 23 Sep 2005 19:09:06 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org, akpm <akpm@osdl.org>
Subject: [PATCH] clarify menuconfig /(search) help text
Message-Id: <20050923190906.5e0d721f.rdunlap@xenotime.net>
In-Reply-To: <20050914065010.GA8430@kestrel.twibright.com>
References: <20050914065010.GA8430@kestrel.twibright.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Add explicit text about
- where menuconfig '/' (search) searches for strings,
- that substrings are allowed, and
- that regular expressions are supported.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 scripts/kconfig/mconf.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -Naurp linux-2614-rc2-git3/scripts/kconfig/mconf.c~search_keyword linux-2614-rc2-git3/scripts/kconfig/mconf.c
--- linux-2614-rc2-git3/scripts/kconfig/mconf.c~search_keyword	2005-08-28 16:41:01.000000000 -0700
+++ linux-2614-rc2-git3/scripts/kconfig/mconf.c	2005-09-23 19:04:39.000000000 -0700
@@ -219,6 +219,7 @@ save_config_help[] = N_(
 search_help[] = N_(
 	"\n"
 	"Search for CONFIG_ symbols and display their relations.\n"
+	"Regular expressions are allowed.\n"
 	"Example: search for \"^FOO\"\n"
 	"Result:\n"
 	"-----------------------------------------------------------------\n"
@@ -531,7 +532,7 @@ again:
 	cprint("--title");
 	cprint(_("Search Configuration Parameter"));
 	cprint("--inputbox");
-	cprint(_("Enter Keyword"));
+	cprint(_("Enter CONFIG_ (sub)string to search for (omit CONFIG_)"));
 	cprint("10");
 	cprint("75");
 	cprint("");

---
