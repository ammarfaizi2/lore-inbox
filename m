Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264495AbTIIVq3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 17:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264502AbTIIVq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 17:46:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:29918 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264495AbTIIVq1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 17:46:27 -0400
Date: Tue, 9 Sep 2003 14:46:08 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] get rid of unused function warning (aztcd)
Message-Id: <20030909144608.3991c140.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.6.0-test5, this driver defines a function pa_ok which is only used in some
commented out debug code.

diff -Nru a/drivers/cdrom/aztcd.c b/drivers/cdrom/aztcd.c
--- a/drivers/cdrom/aztcd.c	Tue Sep  9 14:41:41 2003
+++ b/drivers/cdrom/aztcd.c	Tue Sep  9 14:41:41 2003
@@ -373,6 +373,7 @@
 	} while (aztIndatum != AFL_OP_OK);
 }
 
+#if 0
 /* Wait for PA_OK = drive answers with AFL_PA_OK after receiving parameters*/
 # define PA_OK pa_ok()
 static void pa_ok(void)
@@ -387,6 +388,7 @@
 		}
 	} while (aztIndatum != AFL_PA_OK);
 }
+#endif
 
 /* Wait for STEN=Low = handshake signal 'AFL_.._OK available or command executed*/
 # define STEN_LOW  sten_low()
