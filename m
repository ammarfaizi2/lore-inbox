Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWA1Sji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWA1Sji (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 13:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWA1Sji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 13:39:38 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:58378 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S964813AbWA1Sji
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 13:39:38 -0500
Date: Sat, 28 Jan 2006 18:38:15 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: Sam Ravnborg <sam@ravnborg.org>, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [mips] Accept various mips sub-types in SUBARCH
Message-ID: <20060128183815.GA27304@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

uname -m on MIPS can give a number of results, such as mips64.  We
need to add another substitution to the sed call for SUBARCH in the
main Makefile.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

---

 Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Makefile	2006-01-28 18:33:03.000000000 +0000
+++ b/Makefile	2006-01-28 18:33:45.000000000 +0000
@@ -152,7 +152,7 @@
 SUBARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ \
 				  -e s/arm.*/arm/ -e s/sa110/arm/ \
 				  -e s/s390x/s390/ -e s/parisc64/parisc/ \
-				  -e s/ppc.*/powerpc/ )
+				  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ )
 
 # Cross compiling and selecting different set of gcc/bin-utils
 # ---------------------------------------------------------------------------

-- 
Martin Michlmayr
http://www.cyrius.com/
