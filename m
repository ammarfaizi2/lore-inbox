Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUFWMVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUFWMVP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 08:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUFWMVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 08:21:14 -0400
Received: from gprs214-143.eurotel.cz ([160.218.214.143]:49803 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261184AbUFWMVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 08:21:10 -0400
Date: Wed, 23 Jun 2004 14:20:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp minor docs updates
Message-ID: <20040623122055.GA29473@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I shot myself in the foot with swsusp, so I guess documenting that
particular trap is right thing to do (tm). Somehow two copies of
"radeon hint" crept in; fix that, too. Please apply,

Signed-off-by: Pavel Machek <pavel@suse.cz>

								Pavel

--- linux.orig/Documentation/power/swsusp.txt	2004-06-22 12:53:18.000000000 +0200
+++ linux/Documentation/power/swsusp.txt	2004-06-22 12:37:40.000000000 +0200
@@ -12,6 +12,9 @@
  *				...you'd better find out how to get along
  *				   without your data.
  *
+ * If you change kernel command line between suspend and resume...
+ *			        ...prepare for nasty fsck or worse.
+ *
  * (*) pm interface support is needed to make it safe.
 
 You need to append resume=/dev/your_swap_partition to kernel command

--- clean/Documentation/power/video.txt	2004-06-22 12:35:44.000000000 +0200
+++ linux/Documentation/power/video.txt	2004-06-23 14:19:13.000000000 +0200
@@ -30,10 +30,6 @@
   patched X, and plain text console (no vesafb or radeonfb), see
   http://www.doesi.gmxhome.de/linux/tm800s3/s3.html. (Acer TM 800)
 
-* radeon systems, where X can soft-boot your video card. You'll need
-  patched X, and plain text console (no vesafb or radeonfb), see
-  http://www.doesi.gmxhome.de/linux/tm800s3/s3.html. (Acer TM 800)
-
 Now, if you pass acpi_sleep=something, and it does not work with your
 bios, you'll get hard crash during resume. Be carefull.
 


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
