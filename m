Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbUKDLVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbUKDLVo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 06:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbUKDLUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 06:20:54 -0500
Received: from sd291.sivit.org ([194.146.225.122]:22489 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262169AbUKDLQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 06:16:33 -0500
Date: Thu, 4 Nov 2004 12:16:48 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 8/12] meye: module parameters documentation fixes
Message-ID: <20041104111647.GN3472@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <20041104111231.GF3472@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104111231.GF3472@crusoe.alcove-fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

ChangeSet@1.2347, 2004-11-02 16:13:47+01:00, stelian@popies.net
  meye: module parameters documentation fixes
  
  Signed-off-by: Stelian Pop <stelian@popies.net>

===================================================================

 kernel-parameters.txt |    2 +-
 video4linux/meye.txt  |   11 ++++-------
 2 files changed, 5 insertions(+), 8 deletions(-)

===================================================================

diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	2004-11-04 11:30:33 +01:00
+++ b/Documentation/kernel-parameters.txt	2004-11-04 11:30:33 +01:00
@@ -701,7 +701,7 @@
 			[KNL,ACPI] Mark specific memory as reserved.
 			Region of memory to be used, from ss to ss+nn.
 
-	meye=		[HW] Set MotionEye Camera parameters
+	meye.*=		[HW] Set MotionEye Camera parameters
 			See Documentation/video4linux/meye.txt.
 
 	mga=		[HW,DRM]
diff -Nru a/Documentation/video4linux/meye.txt b/Documentation/video4linux/meye.txt
--- a/Documentation/video4linux/meye.txt	2004-11-04 11:30:33 +01:00
+++ b/Documentation/video4linux/meye.txt	2004-11-04 11:30:33 +01:00
@@ -41,13 +41,10 @@
 Driver options:
 ---------------
 
-Several options can be passed to the meye driver, either by adding them
-to /etc/modprobe.conf file, when the driver is compiled as a module, or
-by adding the following to the kernel command line (in your bootloader):
-
-	meye=gbuffers[,gbufsize[,video_nr]]
-
-where:
+Several options can be passed to the meye driver using the standard
+module argument syntax (<param>=<value> when passing the option to the
+module or meye.<param>=<value> on the kernel boot line when meye is
+statically linked into the kernel). Those options are:
 
 	gbuffers:	number of capture buffers, default is 2 (32 max)
 
