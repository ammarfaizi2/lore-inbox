Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262102AbUK0FrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbUK0FrW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 00:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbUK0Du7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:50:59 -0500
Received: from zeus.kernel.org ([204.152.189.113]:5572 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262533AbUKZTdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:33:42 -0500
Date: Fri, 26 Nov 2004 12:30:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: [PATCH] swsusp kconfig: Change in wording (fwd)
Message-ID: <20041126113040.GB1028@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Vadim says:

I was reading through the kernel/power/Kconfig file, and noticed that
the wording was slightly unclear. I poked at it a bit, hopefully making
the description a tad more straightforward, but you be the judge. :)
Diffed against 2.6.10-rc2.

Please apply,
								Pavel

From: Vadim Lobanov <vlobanov@speakeasy.net>
Signed-off-by: Vadim Lobanov <vlobanov@speakeasy.net>
Signed-off-by: Pavel Machek <pavel@suse.cz>

===========================================================================
diff -Nru a/kernel/power/Kconfig b/kernel/power/Kconfig
--- a/kernel/power/Kconfig      2004-11-14 21:56:22.000000000 -0800
+++ b/kernel/power/Kconfig      2004-11-25 20:41:57.000000000 -0800
@@ -35,14 +35,13 @@
          You may suspend your machine by 'swsusp' or 'shutdown -z <time>'
          (patch for sysvinit needed).

-         It creates an image which is saved in your active swaps. By the next
-         booting the, pass 'resume=/dev/swappartition' and kernel will
-         detect the saved image, restore the memory from
-         it and then it continues to run as before you've suspended.
-         If you don't want the previous state to continue use the 'noresume'
-         kernel option. However note that your partitions will be fsck'd and
-         you must re-mkswap your swap partitions. It does not work with swap
-         files.
+         It creates an image which is saved in your active swap. Upon next
+         boot, pass the 'resume=/dev/swappartition' argument to the kernel to
+         have it detect the saved image, restore memory state from it, and
+         continue to run as before. If you do not want the previous state to
+         be reloaded, then use the 'noresume' kernel argument. However, note
+         that your partitions will be fsck'd and you must re-mkswap your swap
+         partitions. It does not work with swap files.

          Right now you may boot without resuming and then later resume but
          in meantime you cannot use those swap partitions/files which were
===========================================================================

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
