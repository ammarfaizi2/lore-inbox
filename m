Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbTJOXUr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 19:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbTJOXUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 19:20:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:44972 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262555AbTJOXUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 19:20:46 -0400
Date: Wed, 15 Oct 2003 16:20:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: FBDEV 2.6.0-test7 updates.
Message-Id: <20031015162056.018737f1.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0310152345210.13660-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0310152345210.13660-100000@phoenix.infradead.org>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons <jsimmons@infradead.org> wrote:
>
> Here is the latest fbdev patches.

This one comes up again and again.  What should we do with it?


--- 25/drivers/video/radeonfb.c~radeonfb-line_length-fix	2003-10-05 09:17:58.000000000 -0700
+++ 25-akpm/drivers/video/radeonfb.c	2003-10-05 09:17:58.000000000 -0700
@@ -2090,7 +2090,7 @@ static int radeonfb_set_par (struct fb_i
 	
 	}
 	/* Update fix */
-        info->fix.line_length = rinfo->pitch*64;
+        info->fix.line_length = mode->xres_virtual*(mode->bits_per_pixel/8);
         info->fix.visual = rinfo->depth == 8 ? FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
 
 #ifdef CONFIG_BOOTX_TEXT

_

