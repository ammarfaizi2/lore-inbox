Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbWE2RtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWE2RtJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 13:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWE2RtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 13:49:08 -0400
Received: from mail.linicks.net ([217.204.244.146]:3772 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1750952AbWE2RtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 13:49:07 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Question on Space.c
Date: Mon, 29 May 2006 18:49:04 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605291849.04769.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw Space.o being build, and seeing as it is Capitalised thought I would see 
why, and maybe a patch to make it all lower case.

The patch is trivial:

--- drivers/net/MakefileOrig    2006-05-29 17:59:09.000000000 +0100
+++ drivers/net/Makefile        2006-05-29 17:59:23.000000000 +0100
@@ -79,7 +79,7 @@

 obj-$(CONFIG_SUNDANCE) += sundance.o
 obj-$(CONFIG_HAMACHI) += hamachi.o
-obj-$(CONFIG_NET) += Space.o loopback.o
+obj-$(CONFIG_NET) += space.o loopback.o
 obj-$(CONFIG_SEEQ8005) += seeq8005.o
 obj-$(CONFIG_NET_SB1000) += sb1000.o
 obj-$(CONFIG_MAC8390) += mac8390.o 8390.o

then/and rename drivers/net/Space.c -> drivers/net/space.c

It all builds OK (not booted with it though).

Doing a grep of source after changes reveals only a few documentation/comments 
refer to Space.c - no other code.

I have looked though docs and googled as to why this One File Is Like This to 
no avail?  Convention?

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
