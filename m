Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315413AbSHVSck>; Thu, 22 Aug 2002 14:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315445AbSHVScj>; Thu, 22 Aug 2002 14:32:39 -0400
Received: from mail01.qualys.com ([12.162.2.5]:7069 "HELO mail01.qualys.com")
	by vger.kernel.org with SMTP id <S315413AbSHVSci>;
	Thu, 22 Aug 2002 14:32:38 -0400
Date: Thu, 22 Aug 2002 10:41:27 -0700
From: Silvio Cesare <silvio@qualys.com>
To: linux-kernel@vger.kernel.org
Cc: silvio@qualys.com
Subject: [PATCH TRIVIAL] 2.5.31/drivers/zorro/proc.c
Message-ID: <20020822104127.A7911@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

trivial patch to use loff_t and not int.

--
Silvio

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch.2.5.31.zorro"

diff -u linux-2.5.31/drivers/zorro/proc.c dev/linux-2.5.31/drivers/zorro/proc.c
--- linux-2.5.31/drivers/zorro/proc.c	Sat Aug 10 18:41:19 2002
+++ dev/linux-2.5.31/drivers/zorro/proc.c	Thu Aug 22 10:36:00 2002
@@ -51,7 +51,7 @@
 	struct proc_dir_entry *dp = PDE(ino);
 	struct zorro_dev *dev = dp->data;
 	struct ConfigDev cd;
-	int pos = *ppos;
+	loff_t pos = *ppos;
 
 	if (pos >= sizeof(struct ConfigDev))
 		return 0;

--x+6KMIRAuhnl3hBn--
