Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268425AbUH3Ar3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268425AbUH3Ar3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 20:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267930AbUH3Ar3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 20:47:29 -0400
Received: from launch.server101.com ([216.218.196.178]:8381 "EHLO
	mail-pop3-1.server101.com") by vger.kernel.org with ESMTP
	id S268425AbUH3ArO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 20:47:14 -0400
From: Tim Fairchild <tim@bcs4me.com>
To: linux-kernel@vger.kernel.org
Subject: K3b and 2.6.9?
Date: Mon, 30 Aug 2004 10:47:06 +1000
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408301047.06780.tim@bcs4me.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi. Sorry for the silly question from a user who can't code their way out of a 
paper bag, but I have compiled 2.6.9-rc1-bk5 and currently running okay (the 
nvidia module will now compile) with no oops so far. But K3B still does not 
work - as with 2.6.8.1. 

Am I right in assuming that this is the way things will be done in the kernel 
from now on and that we will need new versions of k3b/cdrecord to run with 
these newer kernels? 

Without knowing a better way, I am currently using the same sort of quick 
patch as 2.6.8.1 to use k3b on 2.6.9-rc1-bk5 ie:

--- a/drivers/block/scsi_ioctl.c        2004-08-30 03:52:08.000000000 +1000
+++ b/drivers/block/scsi_ioctl.c        2004-08-30 09:31:44.955159390 +1000
@@ -220,9 +220,9 @@
                return -EINVAL;
        if (copy_from_user(cmd, hdr->cmdp, hdr->cmd_len))
                return -EFAULT;
-       if (verify_command(file, cmd))
+/*     if (verify_command(file, cmd))
                return -EPERM;
-
+*/
        /*
         * we'll do that later
         */


--tim
