Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264343AbTEZLRN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 07:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264344AbTEZLRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 07:17:13 -0400
Received: from xs4all.vs19.net ([213.84.236.198]:1076 "EHLO spaans.vs19.net")
	by vger.kernel.org with ESMTP id S264343AbTEZLRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 07:17:12 -0400
Date: Mon, 26 May 2003 13:30:23 +0200
From: Jasper Spaans <jasper@vs19.net>
To: linux-kernel@vger.kernel.org, faith@redhat.com, torvalds@transmeta.com
Subject: [BUG/PATCH] mga-dri with highmem broken
Message-ID: <20030526113023.GA20463@spaans.vs19.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2003 C. Jasper Spaans - All Rights Reserved
Keywords: smuggle JFK Ft. Knox New World Order Monica Lewinsky Kenneth Starr FSF 
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When compiling with DRM_MGA and HIGHMEM set, compilation of current BK
fails; the following diff makes it compile but doesn't look clean to me.
Does anyone have a better proposal?

Index: drivers/char/drm/drm_memory.h
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/char/drm/drm_memory.h,v
retrieving revision 1.9
diff -u -r1.9 drm_memory.h
--- drivers/char/drm/drm_memory.h	24 May 2003 19:57:47 -0000	1.9
+++ drivers/char/drm/drm_memory.h	26 May 2003 10:23:29 -0000
@@ -52,6 +52,11 @@
 # endif
 #endif
 
+#ifdef CONFIG_HIGHMEM
+# include <asm/highmem.h>
+#endif
+
+
 #include <asm/tlbflush.h>
 
 /*



Bye, Jasper
-- 
Jasper Spaans
http://jsp.vs19.net/contact/

``Got no clue? Too bad for you.''
