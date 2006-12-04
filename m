Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758963AbWLDRid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758963AbWLDRid (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 12:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758986AbWLDRid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 12:38:33 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:58277 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758959AbWLDRib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 12:38:31 -0500
Date: Mon, 4 Dec 2006 09:38:59 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, ak@suse.de
Subject: [PATCH] numaq build error
Message-Id: <20061204093859.42e3123a.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

  CC      arch/i386/boot/compressed/misc.o
arch/i386/boot/compressed/misc.c:120: error: static declaration of 'xquad_portio' follows non-static declaration
include/asm/io.h:275: error: previous declaration of 'xquad_portio' was here
make[2]: *** [arch/i386/boot/compressed/misc.o] Error 1

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 arch/i386/boot/compressed/misc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19-git4.orig/arch/i386/boot/compressed/misc.c
+++ linux-2.6.19-git4/arch/i386/boot/compressed/misc.c
@@ -117,7 +117,7 @@ static int vidport;
 static int lines, cols;
 
 #ifdef CONFIG_X86_NUMAQ
-static void * xquad_portio = NULL;
+void *xquad_portio = NULL;
 #endif
 
 #include "../../../../lib/inflate.c"


---
