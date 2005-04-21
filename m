Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVDUXWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVDUXWY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 19:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVDUXWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 19:22:24 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24269 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261706AbVDUXWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 19:22:19 -0400
Date: Fri, 22 Apr 2005 01:22:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Petr Baudis <pasky@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050421232201.GD31207@elf.ucw.cz>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <20050421112022.GB2160@elf.ucw.cz> <20050421120327.GA13834@elf.ucw.cz> <20050421162220.GD30991@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050421162220.GD30991@pasky.ji.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > You should put this into .git/remotes
> > > 
> > > linus	rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 
> (git addremote is preferred for that :-)

Nice, so I now have my own -git tree, with two changes in it...

Is there way to say "git diff -r origin:" but dump it patch-by-patch
with some usable headers?

[Looking at git export]
								Pavel

Index: Documentation/git.txt
===================================================================
--- /dev/null  (tree:9120479b4c721855b378db8907e1259f2e583f2b)
+++ 007d34e2ed3d5fc54cbb4c16880145ade93affef/Documentation/git.txt  (mode:100644 sha1:939d378ddaac5390c879520c139e66d9649ec4c4)
@@ -0,0 +1,19 @@
+	Kernel hacker's guide to git
+	~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+      2005 Pavel Machek <pavel@suse.cz>
+
+You can get git at http://pasky.or.cz/~pasky/dev/git/ . Compile it,
+and place it somewhere in $PATH. Then you can get kernel by running
+
+git init rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
+
+... Run git log to get idea of what happened in tree you are
+tracking. Do git pull linus to pickup latest changes from Linus. You
+can do git diff to see what changes you done in your local tree. git
+cancel will kill any such changes.
+
+You can commit changes by doing git commit... If you want to get diff
+of your changes against mainline, do
+
+git diff -r origin: 
+

-- 
Boycott Kodak -- for their patent abuse against Java.
