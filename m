Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262664AbVBCF20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262664AbVBCF20 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 00:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262847AbVBCF20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 00:28:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45003 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262799AbVBCF2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 00:28:18 -0500
Date: Thu, 3 Feb 2005 00:28:16 -0500
From: Dave Jones <davej@redhat.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: fix matroxfb ppc compile.
Message-ID: <20050203052815.GB10847@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Code references these vars even though they don't exist.
Untested other than compile test.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.10/drivers/video/matrox/matroxfb_base.c~	2005-01-27 20:06:10.000000000 -0500
+++ linux-2.6.10/drivers/video/matrox/matroxfb_base.c	2005-01-27 20:08:49.000000000 -0500
@@ -1276,6 +1276,10 @@ static int dfp;				/* "matrox:dfp */
 static int dfp_type = -1;		/* "matrox:dfp:xxx */
 static int memtype = -1;		/* "matrox:memtype:xxx" */
 static char outputs[8];			/* "matrox:outputs:xxx" */
+#ifdef CONFIG_PPC_PMAC
+static int vmode;
+static int cmode;
+#endif
 
 #ifndef MODULE
 static char videomode[64];		/* "matrox:mode:xxxxx" or "matrox:xxxxx" */

