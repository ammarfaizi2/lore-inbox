Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVDDSLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVDDSLM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 14:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVDDSLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 14:11:12 -0400
Received: from baikonur.stro.at ([213.239.196.228]:19856 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261314AbVDDSLG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 14:11:06 -0400
Date: Mon, 4 Apr 2005 20:11:02 +0200
From: maximilian attems <janitor@sternwelten.at>
To: lkml <linux-kernel@vger.kernel.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, akpm <akpm@osdl.org>
Subject: [patch 2/3] hd eliminate bad section references
Message-ID: <20050404181102.GB12394@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix hd section references:
make parse_hd_setup() __init

Error: ./drivers/ide/legacy/hd.o .text refers to 00000943 R_386_PC32
.init.text

Signed-off-by: maximilian attems <janitor@sternwelten.at>


--- linux-2.6.12-rc1-bk5/drivers/ide/legacy/hd.c.orig	2005-04-04 18:39:04.000000000 +0200
+++ linux-2.6.12-rc1-bk5/drivers/ide/legacy/hd.c	2005-04-04 19:02:57.908576221 +0200
@@ -851,7 +851,7 @@
 	goto out;
 }
 
-static int parse_hd_setup (char *line) {
+static int __init parse_hd_setup (char *line) {
 	int ints[6];
 
 	(void) get_options(line, ARRAY_SIZE(ints), ints);
