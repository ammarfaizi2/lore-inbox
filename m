Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315230AbSD2WxL>; Mon, 29 Apr 2002 18:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315231AbSD2WxK>; Mon, 29 Apr 2002 18:53:10 -0400
Received: from www.transvirtual.com ([206.14.214.140]:14092 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S315230AbSD2WxK>; Mon, 29 Apr 2002 18:53:10 -0400
Date: Mon, 29 Apr 2002 15:52:47 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: "Ivan G." <ivangurdiev@linuxfreemail.com>
cc: LKML <linux-kernel@vger.kernel.org>,
        LFB <linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: 2.5.11 framebuffer kernel panic 
In-Reply-To: <02042914382500.00843@cobra.linux>
Message-ID: <Pine.LNX.4.10.10204291552240.1337-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Try this patch and tell me if it works. 

--- /usr/src/linux-2.5.11/drivers/video/aty/atyfb_base.c	Mon Apr 29 10:48:07 2002
+++ atyfb_base.c	Mon Apr 29 15:48:22 2002
@@ -2625,7 +2625,7 @@
 
 #ifdef CONFIG_FB_ATY_CT
     /* Erase HW Cursor */
-    if (info->cursor)
+    if (info->cursor && (fb->currcon >= 0))
 	atyfb_cursor(&fb_display[fb->currcon], CM_ERASE,
 		     info->cursor->pos.x, info->cursor->pos.y);
 #endif /* CONFIG_FB_ATY_CT */

