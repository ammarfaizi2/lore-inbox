Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263138AbRE1Uba>; Mon, 28 May 2001 16:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263139AbRE1UbU>; Mon, 28 May 2001 16:31:20 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:1363
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S263138AbRE1UbO>; Mon, 28 May 2001 16:31:14 -0400
Date: Mon, 28 May 2001 22:31:04 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] remove unnecessary zero initializations from aironet4500_proc.c (245ac1)
Message-ID: <20010528223103.J846@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Forgot l-k again... :<)

----- Forwarded message from Rasmus Andersen <rasmus@jaquet.dk> -----

Hi.

The following patch removes two superfluous initializations
from aironet4500_proc.c, making the .o ~12K smaller in
size. It applies against 245ac1 and was discovered by Adam
Ritcher some time ago.
 
--- linux-245-ac1-clean/drivers/net/aironet4500_proc.c	Sat May 19 20:58:24 2001
+++ linux-245-ac1/drivers/net/aironet4500_proc.c	Mon May 28 22:13:26 2001
@@ -59,7 +59,7 @@
 	char 				proc_name[10];
 };	        
 static char awc_drive_info[AWC_STR_SIZE]="Zcom \n\0";
-static char awc_proc_buff[AWC_STR_SIZE]="\0";
+static char awc_proc_buff[AWC_STR_SIZE];
 static int  awc_int_buff;
 static struct awc_proc_private awc_proc_priv[MAX_AWCS]; 
 
@@ -403,7 +403,7 @@
         {0}
 };
 
-struct ctl_table_header * awc_driver_sysctl_header = NULL;
+struct ctl_table_header * awc_driver_sysctl_header;
 
 const char awc_procname[]= "awc5";
-- 
        Rasmus(rasmus@jaquet.dk)

"If you aim the gun at your foot and pull the trigger, it's UNIX's job to 
ensure reliable delivery of the bullet to where you aimed the gun (in
this case, Mr. Foot)." -- Terry Lambert, FreeBSD-Hackers mailing list.
