Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267758AbTBRMCT>; Tue, 18 Feb 2003 07:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267760AbTBRMCT>; Tue, 18 Feb 2003 07:02:19 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:63956 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S267758AbTBRMCR>; Tue, 18 Feb 2003 07:02:17 -0500
Message-ID: <3E5222D3.9060100@oracle.com>
Date: Tue, 18 Feb 2003 13:10:59 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030214
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: James Simmons <jsimmons@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] 2.5.62 radeonfb soft cursor
Content-Type: multipart/mixed;
 boundary="------------060907070904090705020907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060907070904090705020907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

   it looks like this one has been forgotten - but it's needed
   to display a cursor on my Radeon Mobility 7500's framebuffer.

  James posted it a while ago, and it always Worked For Me (TM).


Thanks & ciao,

--alessandro

  "Life is for the living, you've got to be willing
    A song ain't a song until someone starts singing"
       (Wallflowers, "Too Late To Quit")

--------------060907070904090705020907
Content-Type: text/plain;
 name="radeonfb-cursor.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radeonfb-cursor.diff"

--- linux/drivers/video/radeonfb.c-2.5.62	2003-01-03 01:31:42.000000000 +0100
+++ linux/drivers/video/radeonfb.c	2003-02-18 12:13:07.000000000 +0100
@@ -2212,6 +2212,7 @@
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
 #endif
+	.fb_cursor	= soft_cursor,
 };
 
 

--------------060907070904090705020907--

