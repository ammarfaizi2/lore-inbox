Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262674AbVGMPzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbVGMPzp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 11:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262685AbVGMPzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 11:55:45 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:11858 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S262674AbVGMPzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 11:55:43 -0400
Date: Wed, 13 Jul 2005 11:55:42 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Lindent: ignore .indent.pro
Message-ID: <20050713155542.GA4264@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.151-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 When I recently submitted a Lindent patch, it turned out that my .indent.pro
 options were also applied to the tree. This patch directs indent(1) to ignore
 the .indent.pro directives and only use options specified on the command
 line.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>

diff -ruNpX dontdiff linux-2.6.13-rc2/scripts/Lindent linux-2.6.13-rc2.fix/scripts/Lindent
--- linux-2.6.13-rc2/scripts/Lindent	2005-03-02 02:38:12.000000000 -0500
+++ linux-2.6.13-rc2.fix/scripts/Lindent	2005-07-13 13:50:35.000000000 -0400
@@ -1,2 +1,2 @@
 #!/bin/sh
-indent -kr -i8 -ts8 -sob -l80 -ss -ncs "$@"
+indent -npro -kr -i8 -ts8 -sob -l80 -ss -ncs "$@"
-- 
Jeff Mahoney
SuSE Labs
