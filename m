Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269497AbUIRODX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269497AbUIRODX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 10:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269505AbUIRODX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 10:03:23 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:10766 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S269497AbUIRODT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 10:03:19 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH] trivial patch for 2.4: resolve megaraid_info name collision
Date: Sat, 18 Sep 2004 17:03:12 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200409161428.27425.vda@port.imtp.ilyichevsk.odessa.ua> <200409172155.29561.vda@port.imtp.ilyichevsk.odessa.ua> <200409181657.23833.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200409181657.23833.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Message-Id: <200409181702.35550.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gAETBAeS6A8ePIk"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_gAETBAeS6A8ePIk
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm not sure whether it make sense to compile in
megaraid and megaraid2 at once, but it does not build
without this patch.
--
vda



--Boundary-00=_gAETBAeS6A8ePIk
Content-Type: text/x-diff;
  charset="koi8-r";
  name="linux-2.4.27-pre3.megaraid2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-2.4.27-pre3.megaraid2.patch"

diff -urpN linux-2.4.27-pre3.org/drivers/scsi/megaraid2.c linux-2.4.27-pre3.fix/drivers/scsi/megaraid2.c
--- linux-2.4.27-pre3.org/drivers/scsi/megaraid2.c	Sat May 22 22:41:59 2004
+++ linux-2.4.27-pre3.fix/drivers/scsi/megaraid2.c	Sat Sep 18 00:15:11 2004
@@ -2647,7 +2647,7 @@ mega_free_sgl(adapter_t *adapter)
  * Get information about the card/driver
  */
 const char *
-megaraid_info(struct Scsi_Host *host)
+megaraid2_info(struct Scsi_Host *host)
 {
 	static char buffer[512];
 	adapter_t *adapter;
diff -urpN linux-2.4.27-pre3.org/drivers/scsi/megaraid2.h linux-2.4.27-pre3.fix/drivers/scsi/megaraid2.h
--- linux-2.4.27-pre3.org/drivers/scsi/megaraid2.h	Sat May 22 22:41:59 2004
+++ linux-2.4.27-pre3.fix/drivers/scsi/megaraid2.h	Sat Sep 18 00:15:21 2004
@@ -126,7 +126,7 @@
 	.proc_name =		 	"megaraid",		\
 	.detect =			megaraid_detect,	\
 	.release =			megaraid_release,	\
-	.info =				megaraid_info,		\
+	.info =				megaraid2_info,		\
 	.command =			megaraid_command,	\
 	.queuecommand =			megaraid_queue,		\
 	.max_sectors =			MAX_SECTORS_PER_IO,	\
@@ -1086,7 +1086,7 @@ typedef enum { LOCK_INT, LOCK_EXT } lock
 #define MBOX_ABORT_SLEEP	60
 #define MBOX_RESET_SLEEP	30
 
-const char *megaraid_info (struct Scsi_Host *);
+const char *megaraid2_info(struct Scsi_Host *);
 
 static int megaraid_detect(Scsi_Host_Template *);
 static void mega_find_card(Scsi_Host_Template *, u16, u16);

--Boundary-00=_gAETBAeS6A8ePIk--

