Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262332AbVG0Bf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbVG0Bf2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 21:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbVG0Bf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 21:35:28 -0400
Received: from dsl017-059-136.wdc2.dsl.speakeasy.net ([69.17.59.136]:62084
	"EHLO luther.kurtwerks.com") by vger.kernel.org with ESMTP
	id S262332AbVG0BfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 21:35:25 -0400
Date: Tue, 26 Jul 2005 21:36:24 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add text for dealing with "dot releases" to README
Message-ID: <20050727013624.GB2354@kurtwerks.com>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.12.3
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The emergence of so-called "dot releases" that are non-incremental
patches against a base kernel requires different handling of patches
(revert previous patches before applying the newest one). This patch
adds a paragrach to $TOPDIR/README explaining how to do deal with
dot release patches.

The patch is against 2.6.12.3. A possibly too quick glance at
MAINTAINERS didn't show one for README.

Signed-off-by: Kurt Wall <kwall@kurtwerks.com>

--- linux-2.6.12.3/README	2005-07-26 21:18:18.000000000 -0400
+++ b/README	2005-07-26 21:25:13.000000000 -0400
@@ -87,6 +87,16 @@
    kernel source.  Patches are applied from the current directory, but
    an alternative directory can be specified as the second argument.
 
+ - If you are upgrading between releases using the stable series patches
+   (for example, patch-2.6.xx.y), note that these "dot-releases" are
+   not incremental and must be applied to the 2.6.xx base tree. For
+   example, if your base kernel is 2.6.12 and you want to apply the
+   2.6.12.3 patch, you do not and indeed must not first apply the
+   2.6.12.1 and 2.6.12.2 patches. Similarly, if you are running kernel
+   version 2.6.12.2 and want to jump to 2.6.12.3, you must first
+   reverse the 2.6.12.2 patch (that is, patch -R) _before_ applying 
+   the 2.6.12.3 patch.
+
  - Make sure you have no stale .o files and dependencies lying around:
 
 		cd linux
-- 
The first myth of management is that it exists.  The second myth of
management is that success equals skill.
		-- Robert Heller
