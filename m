Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267419AbTGHPQp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 11:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267451AbTGHPQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 11:16:45 -0400
Received: from gherkin.frus.com ([192.158.254.49]:128 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S267419AbTGHPPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 11:15:52 -0400
Subject: [PATCH] 2.5.74 boot logo
To: linux-kernel@vger.kernel.org
Date: Tue, 8 Jul 2003 10:30:28 -0500 (CDT)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20030708153028.61A304F11@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wouldn't look too good for this to be broken when 2.6 hits the
streets :-).  The fix is trivial, and has been necessary since
2.5.70 at least (nearly two months ago).

--- orig/drivers/video/cfbimgblt.c	Mon May  5 17:39:49 2003
+++ linux/drivers/video/cfbimgblt.c	Tue May 13 23:53:23 2003
@@ -325,7 +325,7 @@
 		else 
 			slow_imageblit(image, p, dst1, fgcolor, bgcolor,
 					start_index, pitch_index);
-	} else if (image->depth == bpp) 
+	} else if (image->depth <= bpp) 
 		color_imageblit(image, p, dst1, start_index, pitch_index);
 }
 

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
