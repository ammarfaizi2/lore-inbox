Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVCMXGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVCMXGo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 18:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVCMXGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 18:06:44 -0500
Received: from baikonur.stro.at ([213.239.196.228]:39857 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261501AbVCMXGm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 18:06:42 -0500
Date: Mon, 14 Mar 2005 00:06:39 +0100
From: maximilian attems <janitor@sternwelten.at>
To: lkml <linux-kernel@vger.kernel.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, akpm <akpm@osdl.org>
Subject: [patch] w6692 eliminate bad section references
Message-ID: <20050313230639.GA24301@sputnik.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix w6692 section references:
  convert __initdata to __devinitdata.

Error: ./drivers/isdn/hisax/w6692.o .text refers to 0000002f R_386_32
.init.data

Signed-off-by: maximilian attems <janitor@sternwelten.at>


diff -pruN -X dontdiff linux-2.6.11-bk8/drivers/isdn/hisax/w6692.c 
linux-2.6.11-bk8-max/drivers/isdn/hisax/w6692.c
--- linux-2.6.11-bk8/drivers/isdn/hisax/w6692.c	2005-03-02 08:38:25.000000000 +0100
+++ linux-2.6.11-bk8-max/drivers/isdn/hisax/w6692.c	2005-03-13 23:36:34.000000000 +0100
@@ -45,7 +45,7 @@ const char *w6692_revision = "$Revision:
 
 #define DBUSY_TIMER_VALUE 80
 
-static char *W6692Ver[] __initdata =
+static char *W6692Ver[] __devinitdata =
 {"W6692 V00", "W6692 V01", "W6692 V10",
  "W6692 V11"};
 

