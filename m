Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbTDDJrZ (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 04:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263481AbTDDJrZ (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 04:47:25 -0500
Received: from cs-ats40.donpac.ru ([217.107.128.161]:31757 "EHLO pazke")
	by vger.kernel.org with ESMTP id S263472AbTDDJrL (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 04:47:11 -0500
Date: Fri, 4 Apr 2003 13:58:37 +0400
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>, jsimmons@infradead.org
Subject: [PATCH] missing FB_VISUAL_PSEUDOCOLOR in fb_prepare_logo()
Message-ID: <20030404095837.GB964@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>, jsimmons@infradead.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

this patch (2.5.66) fixes mighty penguin logo not appearing
on visual workstation framebuffer. The trouble is missing
'case FB_VISUAL_PSEUDOCOLOR:' in fb_prepare_logo() function.

Please apply.

Best regards.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-logo-fix

diff -urN -X /usr/share/dontdiff linux-2.5.66.vanilla/drivers/video/fbmem.c linux-2.5.66/drivers/video/fbmem.c
--- linux-2.5.66.vanilla/drivers/video/fbmem.c	Mon Mar 31 13:40:56 2003
+++ linux-2.5.66/drivers/video/fbmem.c	Mon Mar 31 15:26:04 2003
@@ -670,6 +670,7 @@
 	case FB_VISUAL_MONO10:
 		fb_logo.needs_logo = 1;
 		break;
+	case FB_VISUAL_PSEUDOCOLOR:
 	case FB_VISUAL_STATIC_PSEUDOCOLOR:
 		if (fb_logo.depth >= 8) {
 			fb_logo.needs_logo = 8;

--z6Eq5LdranGa6ru8--
