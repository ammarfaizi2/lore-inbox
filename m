Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbTEYVJC (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 17:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbTEYVJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 17:09:02 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:19725 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263775AbTEYVJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 17:09:00 -0400
Date: Sun, 25 May 2003 23:22:09 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: Get more focus on warnings
Message-ID: <20030525212209.GA2569@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20030525210839.GA1704@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030525210839.GA1704@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 25, 2003 at 11:08:39PM +0200, Sam Ravnborg wrote:
> The following patch put focus on warnings when compiling.

OK, here is the patch.

	Sam

===== Makefile 1.406 vs edited =====
--- 1.406/Makefile	Thu May  8 07:12:53 2003
+++ edited/Makefile	Sun May 25 22:56:07 2003
@@ -107,7 +107,7 @@
 # If it is set to "silent_", nothing wil be printed at all, since
 # the variable $(silent_cmd_cc_o_c) doesn't exist.
 
-#	For now, leave verbose as default
+# To put more focus on warnings, less verbose as default
 
 ifdef V
   ifeq ("$(origin V)", "command line")
@@ -115,7 +115,7 @@
   endif
 endif
 ifndef KBUILD_VERBOSE
-  KBUILD_VERBOSE = 1
+  KBUILD_VERBOSE = 0 
 endif
 
 ifdef C
