Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130768AbRCJAFI>; Fri, 9 Mar 2001 19:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130773AbRCJAE7>; Fri, 9 Mar 2001 19:04:59 -0500
Received: from [63.68.113.130] ([63.68.113.130]:13697 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S130768AbRCJAEq>;
	Fri, 9 Mar 2001 19:04:46 -0500
Date: Fri, 9 Mar 2001 16:01:45 -0800
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, greg@ulima.unil.ch
Subject: [PATCH] aicasm db3 fiasco
Message-ID: <20010309160145.H30901@osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
From: Nathan Dabney <smurf@osdlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Debian does not use db3 at all, yet.

Applies against 2.4.2-ac17

-Nathan

diff -urN linux.orig/drivers/scsi/aic7xxx/aicasm/Makefile linux/drivers/scsi/aic7xxx/aicasm/Makefile
--- linux.orig/drivers/scsi/aic7xxx/aicasm/Makefile	Fri Mar  9 15:38:13 2001
+++ linux/drivers/scsi/aic7xxx/aicasm/Makefile	Fri Mar  9 15:52:27 2001
@@ -28,10 +28,12 @@
 aicdb.h:
 	if [ -e "/usr/include/db3/db_185.h" ]; then		\
 		echo "#include <db3/db_185.h>" > aicdb.h;	\
+	elif [ -e "/usr/include/db2/db_185.h" ]; then		\
+		echo "#include <db2/db_185.h>" > aicdb.h;	\
 	elif [ -e "/usr/include/db/db_185.h" ]; then		\
 		echo "#include <db/db_185.h>" >aicdb.h	;	\
 	else							\
-		echo "*** Install db3 development libraries";	\
+		echo "*** Install db development libraries";	\
 	fi
 
 clean:
