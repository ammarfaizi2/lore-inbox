Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318007AbSHCWFC>; Sat, 3 Aug 2002 18:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318013AbSHCWFC>; Sat, 3 Aug 2002 18:05:02 -0400
Received: from pl204.dhcp.adsl.tpnet.pl ([217.98.31.204]:3712 "EHLO
	bzzzt.slackware.pl") by vger.kernel.org with ESMTP
	id <S318007AbSHCWFC>; Sat, 3 Aug 2002 18:05:02 -0400
Date: Sun, 4 Aug 2002 00:10:45 +0200 (CEST)
From: Pawel Kot <pkot@linuxnews.pl>
X-X-Sender: <pkot@bzzzt.slackware.pl>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>, <trivial@rustcorp.com.au>
Subject: [patch] remove the warning from include/linux/dcache.h
Message-ID: <Pine.LNX.4.33.0208032346150.18950-100000@bzzzt.slackware.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The simple patch removes the warning when compiling files including
<linux/dcache.h> and not <linux/kernel.h> (out_of_line_bug() declaration
is missing). Anyway it's better to have the explicit include.

diff -Nur linux-2.4.19/include/linux/dcache.h linux-2.4.19-pkot/include/linux/dcache.h
--- linux-2.4.19/include/linux/dcache.h	Sat Aug  3 23:15:48 2002
+++ linux-2.4.19-pkot/include/linux/dcache.h	Sat Aug  3 22:39:21 2002
@@ -5,6 +5,7 @@

 #include <asm/atomic.h>
 #include <linux/mount.h>
+#include <linux/kernel.h>

 /*
  * linux/include/linux/dcache.h

pkot
-- 
Pawel Kot <pkot@linuxnews.pl>
http://www.gnokii.org/ :: http://www.slackware.pl/
http://kt.linuxnews.pl/ -- Kernel Traffic po polsku

