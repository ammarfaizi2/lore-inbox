Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312739AbSCVQES>; Fri, 22 Mar 2002 11:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312741AbSCVQEJ>; Fri, 22 Mar 2002 11:04:09 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:3742 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S312739AbSCVQD4>; Fri, 22 Mar 2002 11:03:56 -0500
Subject: [PATCH] 2.5.7-dj1, add 2 help texts to arch/s390/Config.help
From: Steven Cole <elenstev@mesatop.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 22 Mar 2002 09:01:07 -0700
Message-Id: <1016812867.3220.50.camel@spc.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds two help texts to arch/s390/Config.help.
The texts were obtained from ESR's v2.97 Configure.help.

Steven

--- linux-2.5.7-dj1/arch/s390/Config.help.orig	Fri Mar 22 08:52:11 2002
+++ linux-2.5.7-dj1/arch/s390/Config.help	Fri Mar 22 08:52:54 2002
@@ -169,3 +169,20 @@
   a debugging option; you probably do not want to set it unless you
   are an S390 port maintainer.
 
+CONFIG_PFAULT
+  Select this option, if you want to use PFAULT pseudo page fault
+  handling under VM. If running native or in LPAR, this option
+  has no effect. If your VM does not support PFAULT, PAGEEX 
+  pseudo page fault handling will be used.
+  Note that VM 4.2 supports PFAULT but has a bug in its 
+  implementation that causes some problems.
+  Everybody who wants to run Linux under VM != VM4.2 should select
+  this option.
+
+CONFIG_SHARED_KERNEL
+  Select this option, if you want to share the text segment of the
+  Linux kernel between different VM guests. This reduces memory
+  usage with lots of guests but greatly increases kernel size.
+  You should only select this option if you know what you are
+  doing and want to exploit this feature.
+



