Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262291AbVDLLQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbVDLLQT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbVDLLQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:16:09 -0400
Received: from fire.osdl.org ([65.172.181.4]:14538 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262242AbVDLKc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:58 -0400
Message-Id: <200504121032.j3CAWpW7005697@shell0.pdx.osdl.net>
Subject: [patch 139/198] hd: eliminate bad section references
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, janitor@sternwelten.at
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: maximilian attems <janitor@sternwelten.at>

Fix hd section references:
make parse_hd_setup() __init

Error: ./drivers/ide/legacy/hd.o .text refers to 00000943 R_386_PC32
.init.text

Signed-off-by: maximilian attems <janitor@sternwelten.at>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/ide/legacy/hd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/ide/legacy/hd.c~hd-eliminate-bad-section-references drivers/ide/legacy/hd.c
--- 25/drivers/ide/legacy/hd.c~hd-eliminate-bad-section-references	2005-04-12 03:21:36.912525344 -0700
+++ 25-akpm/drivers/ide/legacy/hd.c	2005-04-12 03:21:36.916524736 -0700
@@ -851,7 +851,7 @@ Enomem:
 	goto out;
 }
 
-static int parse_hd_setup (char *line) {
+static int __init parse_hd_setup (char *line) {
 	int ints[6];
 
 	(void) get_options(line, ARRAY_SIZE(ints), ints);
_
