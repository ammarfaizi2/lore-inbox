Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbTDDFqe (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 00:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTDDFqe (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 00:46:34 -0500
Received: from cs-ats40.donpac.ru ([217.107.128.161]:60167 "EHLO pazke")
	by vger.kernel.org with ESMTP id S263460AbTDDFqZ (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 00:46:25 -0500
Date: Fri, 4 Apr 2003 09:57:47 +0400
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>, jsimmons@infradead.org
Subject: [PATCH] visws framebuffer driver needs mm.h
Message-ID: <20030404055747.GA964@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>, jsimmons@infradead.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

this trivial patch (2.5.66) fixes visws framebuffer driver which
needs vm_area_struct from linux/mm.h

Please apply.

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-visws-framebuffer-fix

diff -urN -X /usr/share/dontdiff linux-2.5.66.vanilla/drivers/video/sgivwfb.c linux-2.5.66/drivers/video/sgivwfb.c
--- linux-2.5.66.vanilla/drivers/video/sgivwfb.c	Mon Mar 31 13:37:32 2003
+++ linux-2.5.66/drivers/video/sgivwfb.c	Mon Mar 31 16:11:01 2003
@@ -12,6 +12,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/mm.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
 #include <linux/fb.h>

--9amGYk9869ThD9tj--
