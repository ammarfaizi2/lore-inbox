Return-Path: <linux-kernel-owner+w=401wt.eu-S1753994AbWLRNZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994AbWLRNZ7 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 08:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753996AbWLRNZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 08:25:59 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:4012 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994AbWLRNZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 08:25:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LWgSAZ8BKiqBwuPv8MgvVYcjHgWwDFMvSlew5dzCGlQ9+ID4oD5GMIP9SYLu6694Xxinean/q17DtXjJDsILcReL0+hZTDVIKDdHLNysToXdMcRf35hVvZYIUQnDxY8YJiFEZx9YBk2AwrILE4WxEPLesGkL7GDgAJ6sfa2XeOc=
Message-ID: <625fc13d0612180525m500fcecdta08edebb3dd526a6@mail.gmail.com>
Date: Mon, 18 Dec 2006 07:25:56 -0600
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: [PATCH] Make JFFS depend on CONFIG_BROKEN
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       jffs-dev@axis.com, "David Woodhouse" <dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark JFFS as broken and provide a warning to users that it is
deprecated and scheduled for removal in 2.6.21

Signed-off-by: Josh Boyer <jwboyer@gmail.com>

diff --git a/fs/Kconfig b/fs/Kconfig
index b3b5aa0..4ac367d 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -1204,13 +1204,16 @@ config EFS_FS

 config JFFS_FS
 	tristate "Journalling Flash File System (JFFS) support"
-	depends on MTD && BLOCK
+	depends on MTD && BLOCK && BROKEN
 	help
 	  JFFS is the Journalling Flash File System developed by Axis
 	  Communications in Sweden, aimed at providing a crash/powerdown-safe
 	  file system for disk-less embedded devices. Further information is
 	  available at (<http://developer.axis.com/software/jffs/>).

+	  NOTE: This filesystem is deprecated and is scheduled for removal in
+	  2.6.21.  See Documentation/feature-removal-schedule.txt
+
 config JFFS_FS_VERBOSE
 	int "JFFS debugging verbosity (0 = quiet, 3 = noisy)"
 	depends on JFFS_FS
