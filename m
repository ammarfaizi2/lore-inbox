Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWAIRgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWAIRgm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbWAIRgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:36:42 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:26710 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S1750801AbWAIRgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:36:41 -0500
Date: Mon, 9 Jan 2006 12:36:40 -0500
From: Jeff Mahoney <jeffm@suse.com>
To: ocfs2-devel@oss.oracle.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ocfs2/dlm: fix compilation on ia64
Message-ID: <20060109173640.GA25744@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.201-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Including <asm/signal.h> results in compilation failure on ia64 due to
 not including <linux/compiler.h>

 Including <linux/signal.h> corrects the problem.

 Please apply.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -ruNpX dontdiff linux-2.6.15/fs/ocfs2/dlm/userdlm.c linux-2.6.15-fix/fs/ocfs2/dlm/userdlm.c
--- linux-2.6.15/fs/ocfs2/dlm/userdlm.c	2006-01-08 23:19:50.000000000 -0500
+++ linux-2.6.15-fix/fs/ocfs2/dlm/userdlm.c	2006-01-09 12:31:08.056894624 -0500
@@ -27,7 +27,7 @@
  * Boston, MA 021110-1307, USA.
  */
 
-#include <asm/signal.h>
+#include <linux/signal.h>
 
 #include <linux/module.h>
 #include <linux/fs.h>
-- 
Jeff Mahoney
SuSE Labs
