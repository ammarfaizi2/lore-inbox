Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbTDLWRg (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 18:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbTDLWRg (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 18:17:36 -0400
Received: from c-97a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.151]:3712
	"EHLO zaphod.guide") by vger.kernel.org with ESMTP id S261821AbTDLWRe (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 18:17:34 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH?] Fix undefined mem_map in sound/core/memalloc.c
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 13 Apr 2003 00:30:07 +0200
Message-ID: <yw1xvfxjxsb4.fsf@zaphod.guide>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This fixes "mem_map undefined" errors in sound/core/memalloc.c (and
others).  I'm not sure it's the right way to do it, but it works for
playing sound.

--- include/sound/memalloc.h~	Mon Apr  7 19:30:38 2003
+++ include/sound/memalloc.h	Sat Apr 12 19:16:07 2003
@@ -25,6 +25,7 @@
 #define __SOUND_MEMALLOC_H
 
 #include <linux/pci.h>
+#include <linux/mm.h>
 #ifdef CONFIG_SBUS
 #include <asm/sbus.h>
 #endif


-- 
Måns Rullgård
mru@users.sf.net
