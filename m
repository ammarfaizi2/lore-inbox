Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293076AbSCOSeU>; Fri, 15 Mar 2002 13:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293058AbSCOSeK>; Fri, 15 Mar 2002 13:34:10 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:32142 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S293076AbSCOSdx>; Fri, 15 Mar 2002 13:33:53 -0500
Date: Fri, 15 Mar 2002 13:33:46 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: schwidefsky@de.ibm.com
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: 2.4.19-pre3 s390 patch for warnings
Message-ID: <20020315133346.D24597@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dunno about others, but I do pay attention to warnings.
Please consider.

Thanks,
-- Pete

diff -ur -X dontdiff linux-2.4.19-pre3/arch/s390/kernel/setup.c linux-2.4.19-pre3-390/arch/s390/kernel/setup.c
--- linux-2.4.19-pre3/arch/s390/kernel/setup.c	Tue Mar 12 10:53:36 2002
+++ linux-2.4.19-pre3-390/arch/s390/kernel/setup.c	Fri Mar 15 09:12:47 2002
@@ -486,7 +486,7 @@
 static int show_cpuinfo(struct seq_file *m, void *v)
 {
         struct cpuinfo_S390 *cpuinfo;
-	unsigned long n = (unsigned long) v - 1;
+	int n = (int) v - 1;
 
 	if (!n) {
 		seq_printf(m, "vendor_id       : IBM/S390\n"
diff -ur -X dontdiff linux-2.4.19-pre3/drivers/s390/block/dasd_diag.c linux-2.4.19-pre3-390/drivers/s390/block/dasd_diag.c
--- linux-2.4.19-pre3/drivers/s390/block/dasd_diag.c	Sun Sep 30 12:26:07 2001
+++ linux-2.4.19-pre3-390/drivers/s390/block/dasd_diag.c	Fri Mar 15 08:39:17 2002
@@ -427,7 +427,7 @@
 	}
 	if (req->cmd == READ) {
 		rw_cmd = MDSK_READ_REQ;
-	} else if (req->cmd == WRITE) {
+	} else {
 		rw_cmd = MDSK_WRITE_REQ;
 	}
 	bhct = 0;
