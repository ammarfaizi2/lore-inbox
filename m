Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132488AbRA3Vcm>; Tue, 30 Jan 2001 16:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132462AbRA3Vcd>; Tue, 30 Jan 2001 16:32:33 -0500
Received: from fe070.worldonline.dk ([212.54.64.208]:38919 "HELO
	fe070.worldonline.dk") by vger.kernel.org with SMTP
	id <S132155AbRA3VcS>; Tue, 30 Jan 2001 16:32:18 -0500
Date: Tue, 30 Jan 2001 22:29:52 +0100
From: Torben Mathiasen <torben@kernel.dk>
To: linux@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Acorn SCSI loading
Message-ID: <20010130222952.G873@fry>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-OS: Linux 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Just noticed the SCSI drivers for the ACORN bus weren't 
updated to the new initialization. AFAIK these drivers couldn't 
have been functional without this patch.


Patch is against 2.4.1



-- 
Torben Mathiasen <torben@kernel.dk>
Linux ThunderLAN maintainer 
http://opensource.compaq.com


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="acorn_scsi.diff"

diff -ur /opt/kernel/kernels/linux/drivers/acorn/scsi/acornscsi.c linux/drivers/acorn/scsi/acornscsi.c
--- /opt/kernel/kernels/linux/drivers/acorn/scsi/acornscsi.c	Tue Sep 19 00:15:22 2000
+++ linux/drivers/acorn/scsi/acornscsi.c	Tue Jan 30 22:18:50 2001
@@ -3118,9 +3118,7 @@
     return pos;
 }
 
-#ifdef MODULE
 
 Scsi_Host_Template driver_template = ACORNSCSI_3;
 
 #include "../../scsi/scsi_module.c"
-#endif
diff -ur /opt/kernel/kernels/linux/drivers/acorn/scsi/arxescsi.c linux/drivers/acorn/scsi/arxescsi.c
--- /opt/kernel/kernels/linux/drivers/acorn/scsi/arxescsi.c	Tue Sep 19 00:15:22 2000
+++ linux/drivers/acorn/scsi/arxescsi.c	Tue Jan 30 22:19:06 2001
@@ -416,8 +416,6 @@
 	return pos;
 }
 
-#ifdef MODULE
 Scsi_Host_Template driver_template = ARXEScsi;
 
 #include "../../scsi/scsi_module.c"
-#endif
diff -ur /opt/kernel/kernels/linux/drivers/acorn/scsi/cumana_1.c linux/drivers/acorn/scsi/cumana_1.c
--- /opt/kernel/kernels/linux/drivers/acorn/scsi/cumana_1.c	Fri Nov 12 01:57:30 1999
+++ linux/drivers/acorn/scsi/cumana_1.c	Tue Jan 30 22:19:29 2001
@@ -359,9 +359,7 @@
 
 #include "../../scsi/NCR5380.c"
 
-#ifdef MODULE
 
 Scsi_Host_Template driver_template = CUMANA_NCR5380;
 
 #include "../../scsi/scsi_module.c"
-#endif
diff -ur /opt/kernel/kernels/linux/drivers/acorn/scsi/cumana_2.c linux/drivers/acorn/scsi/cumana_2.c
--- /opt/kernel/kernels/linux/drivers/acorn/scsi/cumana_2.c	Tue Sep 19 00:15:22 2000
+++ linux/drivers/acorn/scsi/cumana_2.c	Tue Jan 30 22:19:41 2001
@@ -541,8 +541,6 @@
 	return pos;
 }
 
-#ifdef MODULE
 Scsi_Host_Template driver_template = CUMANASCSI_2;
 
 #include "../../scsi/scsi_module.c"
-#endif
diff -ur /opt/kernel/kernels/linux/drivers/acorn/scsi/ecoscsi.c linux/drivers/acorn/scsi/ecoscsi.c
--- /opt/kernel/kernels/linux/drivers/acorn/scsi/ecoscsi.c	Fri Nov 12 01:57:30 1999
+++ linux/drivers/acorn/scsi/ecoscsi.c	Tue Jan 30 22:19:56 2001
@@ -233,9 +233,7 @@
 
 #include "../../scsi/NCR5380.c"
 
-#ifdef MODULE
 
 Scsi_Host_Template driver_template = ECOSCSI_NCR5380;
 
 #include "../../scsi/scsi_module.c"
-#endif
diff -ur /opt/kernel/kernels/linux/drivers/acorn/scsi/eesox.c linux/drivers/acorn/scsi/eesox.c
--- /opt/kernel/kernels/linux/drivers/acorn/scsi/eesox.c	Tue Sep 19 00:15:22 2000
+++ linux/drivers/acorn/scsi/eesox.c	Tue Jan 30 22:20:09 2001
@@ -543,8 +543,6 @@
 	return pos;
 }
 
-#ifdef MODULE
 Scsi_Host_Template driver_template = EESOXSCSI;
 
 #include "../../scsi/scsi_module.c"
-#endif
diff -ur /opt/kernel/kernels/linux/drivers/acorn/scsi/oak.c linux/drivers/acorn/scsi/oak.c
--- /opt/kernel/kernels/linux/drivers/acorn/scsi/oak.c	Fri Nov 12 01:57:30 1999
+++ linux/drivers/acorn/scsi/oak.c	Tue Jan 30 22:20:51 2001
@@ -226,9 +226,7 @@
 
 #include "../../scsi/NCR5380.c"
 
-#ifdef MODULE
 
 Scsi_Host_Template driver_template = OAK_NCR5380;
 
 #include "../../scsi/scsi_module.c"
-#endif
diff -ur /opt/kernel/kernels/linux/drivers/acorn/scsi/powertec.c linux/drivers/acorn/scsi/powertec.c
--- /opt/kernel/kernels/linux/drivers/acorn/scsi/powertec.c	Tue Sep 19 00:15:22 2000
+++ linux/drivers/acorn/scsi/powertec.c	Tue Jan 30 22:21:00 2001
@@ -445,8 +445,6 @@
 	return pos;
 }
 
-#ifdef MODULE
 Scsi_Host_Template driver_template = POWERTECSCSI;
 
 #include "../../scsi/scsi_module.c"
-#endif

--ReaqsoxgOBHFXBhH--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
