Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262195AbRE0UoB>; Sun, 27 May 2001 16:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262208AbRE0Unv>; Sun, 27 May 2001 16:43:51 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:835
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S262195AbRE0Une>; Sun, 27 May 2001 16:43:34 -0400
Date: Sun, 27 May 2001 22:43:25 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: dag@brattli.net
Cc: linux-irda@pasta.cs.uit.no, linux-kernel@vger.kernel.org
Subject: [PATCH] add restore_flags to error path in irttp.c (245ac1)
Message-ID: <20010527224325.Q857@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch makes irttp_read_proc restore_flags()
in error cases too. Applies against 245ac1.


--- linux-245-ac1-clean/net/irda/irttp.c	Sun May 27 22:15:34 2001
+++ linux-245-ac1/net/irda/irttp.c	Sun May 27 22:37:59 2001
@@ -1598,7 +1598,7 @@
 	self = (struct tsap_cb *) hashbin_get_first(irttp->tsaps);
 	while (self != NULL) {
 		if (!self || self->magic != TTP_TSAP_MAGIC)
-			return len;
+			break;
 
 		len += sprintf(buf+len, "TSAP %d, ", i++);
 		len += sprintf(buf+len, "stsap_sel: %02x, ", 

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Which is worse: Ignorance or Apathy?
Who knows? Who cares?
