Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264430AbUE3XEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264430AbUE3XEP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 19:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264465AbUE3XEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 19:04:15 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:36101 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264430AbUE3XEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 19:04:08 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.7-bk] vram boot option
Date: Mon, 31 May 2004 01:03:37 +0200
User-Agent: KMail/1.6.2
X-Operating-System: Linux 2.6.5-wolk3.0 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Organization: Linux-Systeme GmbH
Message-Id: <200405310103.37119@WOLK>
Cc: Linus Torvalds <torvalds@osdl.org>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JhmuAGIQhev6uHS"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_JhmuAGIQhev6uHS
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Linus,

could we either change that boot opion to "vram:" to be equal to 2.4 or should 
we change 2.4 to be equal to 2.6.7-bk? I guess we should do the 1st.

I'm speaking about this one:

http://linux.bkbits.net:8080/linux-2.5/gnupatch@40ba1aa0CbdwIRz9E1pww0NREOd4nQ

And document the option, please!

ciao, Marc



--Boundary-00=_JhmuAGIQhev6uHS
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="vram-sane-with-2.4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="vram-sane-with-2.4.patch"

--- a/Documentation/fb/vesafb.txt	2003-12-18 03:59:06.000000000 +0100
+++ b/Documentation/fb/vesafb.txt	2004-05-31 01:01:12.000000000 +0200
@@ -146,6 +146,10 @@ pmipal	Use the protected mode interface 
 
 mtrr	setup memory type range registers for the vesafb framebuffer.
 
+vram:n	remap 'n' MiB of video RAM. If 0 or not specified, remap memory 
+	according to video mode. (2.5.66 patch/idea by Antonino Daplas 
+	reversed to give override possibility (allocate more fb memory 
+	than the kernel would) to 2.4 by tmb@iki.fi)
 
 Have fun!
 
--- a/drivers/video/vesafb.c	2004-05-31 00:59:41.000000000 +0200
+++ b/drivers/video/vesafb.c	2004-05-31 01:00:29.000000000 +0200
@@ -207,7 +207,7 @@ int __init vesafb_setup(char *options)
 			mtrr=1;
 		else if (! strcmp(this_opt, "nomtrr"))
 			mtrr=0;
-		else if (! strncmp(this_opt, "vram=", 5))
+		else if (! strncmp(this_opt, "vram:", 5))
 			vram = simple_strtoul(this_opt+5, NULL, 0);
 	}
 	return 0;

--Boundary-00=_JhmuAGIQhev6uHS--
