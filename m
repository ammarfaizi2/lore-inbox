Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbSJDCxa>; Thu, 3 Oct 2002 22:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261452AbSJDCxa>; Thu, 3 Oct 2002 22:53:30 -0400
Received: from 12-237-16-92.client.attbi.com ([12.237.16.92]:9866 "EHLO
	ledzep.dyndns.org") by vger.kernel.org with ESMTP
	id <S261451AbSJDCx3>; Thu, 3 Oct 2002 22:53:29 -0400
Message-ID: <3D9D03DB.8030400@attbi.com>
Date: Thu, 03 Oct 2002 21:58:35 -0500
From: Jordan Breeding <jordan.breeding@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] fix cdroms with devfs
Content-Type: multipart/mixed;
 boundary="------------000905000009030706010503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000905000009030706010503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

   This patch fixes the case where devfs in 2.5.x currently makes a 
/dev/cdroms/cdroms directory instead of a /dev/cdroms directory like it 
used to.  Thanks.

Jordan

--------------000905000009030706010503
Content-Type: text/plain;
 name="patch-cdrom-fix-2.5.38-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-cdrom-fix-2.5.38-1"

--- linux-2.5.38/fs/partitions/check.c	2002-09-23 21:55:43.000000000 -0500
+++ linux-2.5.38-bk/fs/partitions/check.c	2002-09-24 22:53:00.000000000 -0500
@@ -348,7 +348,7 @@
 		cdroms = devfs_mk_dir (NULL, "cdroms", NULL);
 
 	dev->number = devfs_alloc_unique_number(&cdrom_numspace);
-	sprintf(vname, "cdroms/cdrom%d", dev->number);
+	sprintf(vname, "cdrom%d", dev->number);
 	if (dev->de) {
 		int pos;
 		devfs_handle_t slave;

--------------000905000009030706010503--

