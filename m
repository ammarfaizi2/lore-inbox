Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288071AbSBIBtL>; Fri, 8 Feb 2002 20:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288061AbSBIBtB>; Fri, 8 Feb 2002 20:49:01 -0500
Received: from arsenal.visi.net ([206.246.194.60]:32928 "EHLO visi.net")
	by vger.kernel.org with ESMTP id <S288071AbSBIBsp>;
	Fri, 8 Feb 2002 20:48:45 -0500
Date: Fri, 8 Feb 2002 20:47:52 -0500
From: Ben Collins <bcollins@debian.org>
To: linux-kernel@vger.kernel.org
Subject: [patch] remove .i files on clean too
Message-ID: <20020209014752.GA792@blimpo.internal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I find it useful to build with -save-temps a lot of times, when tracking
a bug. This little change helps cleanup the .i files that get left
around. Am I the only one that does this? :) Probably the lowest
priority patch right now, but what the hell.


Ben

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/       Ben Collins    --    Debian GNU/Linux    --    WatchGuard.com      \
`          bcollins@debian.org   --   Ben.Collins@watchguard.com           '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'



diff -u -r1.485.2.12 Makefile
--- Makefile	4 Feb 2002 22:37:38 -0000	1.485.2.12
+++ Makefile	9 Feb 2002 01:49:25 -0000
@@ -415,7 +415,7 @@
 endif
 
 clean:	archclean
-	find . \( -name '*.[oas]' -o -name core -o -name '.*.flags' \) -type f -print \
+	find . \( -name '*.[oasi]' -o -name core -o -name '.*.flags' \) -type f -print \
 		| grep -v lxdialog/ | xargs rm -f
 	rm -f $(CLEAN_FILES)
 	rm -rf $(CLEAN_DIRS)
