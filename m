Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264892AbTLWF5X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 00:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264947AbTLWF5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 00:57:23 -0500
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:63110 "HELO
	develer.com") by vger.kernel.org with SMTP id S264892AbTLWF5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 00:57:21 -0500
Message-ID: <3FE7D92A.1090205@develer.com>
Date: Tue, 23 Dec 2003 06:56:58 +0100
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: mtd@infradead.org
CC: Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix static build of drivers/mtd/chips/jedec_probe.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

one liner fix for building jedec_probe statically in m68knommu and possibly other archs.

Applies to 2.6.0.


--- drivers/mtd/chips/jedec_probe.c	2003-12-23 06:50:51.842514068 +0100
+++ drivers/mtd/chips/jedec_probe.c.orig	2003-12-23 06:51:15.512685112 +0100
@@ -8,7 +8,6 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
-#include <linux/init.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <asm/io.h>

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/


