Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265832AbUAKL2D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 06:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265834AbUAKL2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 06:28:03 -0500
Received: from gprs214-122.eurotel.cz ([160.218.214.122]:23680 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265832AbUAKL1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 06:27:53 -0500
Date: Sun, 11 Jan 2004 12:29:20 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Document tricks to get S3/swsusp working
Message-ID: <20040111112920.GA741@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I was sending this to users that had problems with swsusp, then lost
it. It would be nice to have it directly in the tree... Please apply,

								Pavel
--- /dev/null	2003-09-12 10:38:14.000000000 +0200
+++ linux/Documentation/power/tricks.txt	2004-01-11 12:28:12.000000000 +0100
@@ -0,0 +1,25 @@
+	swsusp/S3 tricks
+	~~~~~~~~~~~~~~~~
+Pavel Machek <pavel@suse.cz>
+
+If you want to trick swsusp/S3 into working, you might want to try:
+
+* go with minimal config, turn off drivers like USB, AGP you don't
+  really need
+
+* use ext2. At least it has working fsck. [If something seemes to go
+  wrong, force fsck when you have a chance]
+
+* turn off modules
+
+* use vga text console, shut down X. [If you really want X, you might
+  want to try vesafb later]
+
+* try running as few processes as possible, preferably go to single
+  user mode.
+
+* due to video issues, swsusp should be easier to get working than
+  S3. Try that first.
+
+When you make it work, try to find out what exactly was it that broke
+suspend, and preferably fix that.

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
