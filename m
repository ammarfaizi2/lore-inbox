Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293164AbSCEFYY>; Tue, 5 Mar 2002 00:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293608AbSCEFYO>; Tue, 5 Mar 2002 00:24:14 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:1568 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S293164AbSCEFYB>; Tue, 5 Mar 2002 00:24:01 -0500
Date: Tue, 5 Mar 2002 00:23:58 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux390@de.ibm.com, Pete Zaitcev <zaitcev@redhat.com>
Subject: s390 is totally broken in 2.4.18
Message-ID: <20020305002358.A1670@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently, NOBODY bothered to test 2.4.18-pre*, 2.4.18 final,
or 2.4.19-pre* on s390. The broken patch went into 2.4.18-pre1
with a curt changelog:

- S390 merge                                    (IBM)

Patch attached.

-- Pete

--- linux-2.4.18-0.1.s390/arch/s390/kernel/entry.S	Mon Feb 25 11:37:56 2002
+++ linux-2.4.18-0.1-x.s390/arch/s390/kernel/entry.S	Mon Mar  4 19:53:13 2002
@@ -59,7 +59,7 @@
  */
 _TSS_PTREGS  = 0
 _TSS_FPRS    = (_TSS_PTREGS+8)
-_TSS_AR2     = (_TSS_FPRS+136)
+_TSS_AR2     = (_TSS_FPRS+128)
 _TSS_AR4     = (_TSS_AR2+4)
 _TSS_KSP     = (_TSS_AR4+4)
 _TSS_USERSEG = (_TSS_KSP+4)
--- linux-2.4.18-0.1.s390/arch/s390x/kernel/entry.S	Mon Feb 25 11:37:56 2002
+++ linux-2.4.18-0.1-x.s390/arch/s390x/kernel/entry.S	Mon Mar  4 20:04:24 2002
@@ -60,7 +60,7 @@
  */
 _TSS_PTREGS  = 0
 _TSS_FPRS    = (_TSS_PTREGS+8)
-_TSS_AR2     = (_TSS_FPRS+136)
+_TSS_AR2     = (_TSS_FPRS+128)
 _TSS_AR4     = (_TSS_AR2+4)
 _TSS_KSP     = (_TSS_AR4+4)
 _TSS_USERSEG = (_TSS_KSP+8)
