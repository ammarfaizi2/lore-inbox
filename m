Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWBJK1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWBJK1O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 05:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWBJK1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 05:27:13 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:2831 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751226AbWBJK0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 05:26:46 -0500
Date: Fri, 10 Feb 2006 11:26:37 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 1/2] s390: compat signal compile fix
Message-ID: <20060210102637.GB9307@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

For some reason we have a prototype of do_sigaction in our compat signal
code which conflicts with the new prototype.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/kernel/compat_signal.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/s390/kernel/compat_signal.c b/arch/s390/kernel/compat_signal.c
index ef70669..5291b5f 100644
--- a/arch/s390/kernel/compat_signal.c
+++ b/arch/s390/kernel/compat_signal.c
@@ -195,9 +195,6 @@ sys32_sigaction(int sig, const struct ol
 	return ret;
 }
 
-int
-do_sigaction(int sig, const struct k_sigaction *act, struct k_sigaction *oact);
-
 asmlinkage long
 sys32_rt_sigaction(int sig, const struct sigaction32 __user *act,
 	   struct sigaction32 __user *oact,  size_t sigsetsize)
