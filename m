Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268340AbUIPRpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268340AbUIPRpW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 13:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268292AbUIPRo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 13:44:26 -0400
Received: from cantor.suse.de ([195.135.220.2]:3301 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268577AbUIPRlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 13:41:07 -0400
Date: Thu, 16 Sep 2004 19:41:06 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arch/ppc/syslib/open_pic2.c ENODEV undeclared
Message-ID: <20040916174106.GA15963@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.6.9-rc2-bk2 gives this with my ppc g5 config

arch/ppc/syslib/open_pic2.c: In function `init_openpic2_sysfs':
arch/ppc/syslib/open_pic2.c:694: error: `ENODEV' undeclared (first use in this function)
arch/ppc/syslib/open_pic2.c:694: error: (Each undeclared identifier is reported only once
arch/ppc/syslib/open_pic2.c:694: error: for each function it appears in.)

possible fix below.

Signed-off-by: Olaf Hering <olh@suse.de>

--- ./arch/ppc/syslib/open_pic2.c.orig	2004-09-16 19:25:37.892805000 +0200
+++ ./arch/ppc/syslib/open_pic2.c	2004-09-16 19:35:25.024163478 +0200
@@ -20,6 +20,7 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/sysdev.h>
+#include <linux/errno.h>
 #include <asm/ptrace.h>
 #include <asm/signal.h>
 #include <asm/io.h>

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
