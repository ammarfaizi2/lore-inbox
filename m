Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270327AbTHCUkZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 16:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270335AbTHCUkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 16:40:25 -0400
Received: from gandalph.mad.hu ([193.225.158.7]:7949 "EHLO gandalph.mad.hu")
	by vger.kernel.org with ESMTP id S270327AbTHCUkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 16:40:22 -0400
Date: Sun, 3 Aug 2003 22:41:39 +0200
From: Gergely Nagy <algernon@bonehunter.rulez.org>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: [TRIVIAL] compile fix for arch/ppc/kernel/setup.c
Message-ID: <20030803204138.GB18494@gandalph.mad.hu>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm posting both to linuxppc-dev and lkml, since the latter is listed in
MAINTAINERS. I've been trying to get my PowerMac 4400 boot with linux
2.6.0-test2(-bk3), but the compile failed quite early in
arch/ppc/kernel/setup.c. After adding an #include <linux/cpu.h>, it
compiled. Patch is included below.

--- arch/ppc/kernel/setup.c.old	2003-08-03 22:35:51.000000000 +0200
+++ arch/ppc/kernel/setup.c	2003-08-03 22:35:41.000000000 +0200
@@ -2,6 +2,7 @@
  * Common prep/pmac/chrp boot and setup code.
  */
 
+#include <linux/config.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
 #include <linux/string.h>


--
Gergely Nagy
