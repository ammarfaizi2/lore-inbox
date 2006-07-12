Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWGLLMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWGLLMZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 07:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWGLLMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 07:12:25 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57321 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751224AbWGLLMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 07:12:24 -0400
Date: Wed, 12 Jul 2006 13:11:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Fix compilation on arm in -rc1-git
Message-ID: <20060712111157.GA1978@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

After latest git update, I was getting compile errors until doing:

Fix compilation on ARM. Not sure if it is the clean fix.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 80a1958320e8e055029fea08ac7523d069cb1855
tree 5f6afc72867ea56bab33b2c31b2b12b499239071
parent 12280deab4c82a57c766eb0321b6edf8e323a50e
author <pavel@amd.ucw.cz> Wed, 12 Jul 2006 13:11:06 +0200
committer <pavel@amd.ucw.cz> Wed, 12 Jul 2006 13:11:06 +0200

 include/linux/root_dev.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/root_dev.h b/include/linux/root_dev.h
index ea4bc9d..09247d6 100644
--- a/include/linux/root_dev.h
+++ b/include/linux/root_dev.h
@@ -2,6 +2,7 @@
 #define _ROOT_DEV_H_
 
 #include <linux/major.h>
+#include <linux/kdev_t.h>
 
 enum {
 	Root_NFS = MKDEV(UNNAMED_MAJOR, 255),

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
