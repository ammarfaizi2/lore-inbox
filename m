Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbVGDOKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVGDOKv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 10:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVGDOKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 10:10:51 -0400
Received: from dsl017-059-136.wdc2.dsl.speakeasy.net ([69.17.59.136]:34961
	"EHLO luther.kurtwerks.com") by vger.kernel.org with ESMTP
	id S261700AbVGDN4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 09:56:46 -0400
Date: Mon, 4 Jul 2005 09:57:00 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net,
       zippel@linux-m68k.org
Subject: [PATCH]Fix menuconfig error message
Message-ID: <20050704135700.GB32056@kurtwerks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net, zippel@linux-m68k.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.12
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you try to run `make menuconfig' on a system that lacks ncurses
development libs, you get an error message telling you to install
ncurses-devel. Some popular distributions don't have an ncurses-devel
package. This patch generalizes the error message. Patch is against
2.6.12.

MAINTAINERS doesn't list a maintainer for menuconfig or lxdialog,
so I sent this to lkml, kbuild-devel, and to the kconfig maintainer.

Signed-off-by: Kurt Wall <kwall@kurtwerks.com>


--- a/scripts/lxdialog/Makefile	2005-07-04 09:31:38.000000000 -0400
+++ b/scripts/lxdialog/Makefile	2005-07-04 09:38:05.000000000 -0400
@@ -35,8 +35,10 @@
 		echo -e "\007" ;\
 		echo ">> Unable to find the Ncurses libraries." ;\
 		echo ">>" ;\
-		echo ">> You must install ncurses-devel in order" ;\
-		echo ">> to use 'make menuconfig'" ;\
+		echo ">> You must install ncurses development libraries" ;\
+		echo ">> to use 'make menuconfig'. If you have an RPM-based" ;\
+		echo ">> Debian-based distribution you should install the" ;\ 
+		echo ">> ncurses-devel package." ;\
 		echo ;\
 		exit 1 ;\
 	fi


Kurt
-- 
"I have a very firm grasp on reality!  I can reach out and strangle it
any time!"
