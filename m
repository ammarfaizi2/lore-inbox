Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267330AbSLKWYC>; Wed, 11 Dec 2002 17:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267332AbSLKWYC>; Wed, 11 Dec 2002 17:24:02 -0500
Received: from air-2.osdl.org ([65.172.181.6]:5760 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S267330AbSLKWX7>;
	Wed, 11 Dec 2002 17:23:59 -0500
Date: Wed, 11 Dec 2002 14:31:45 -0800
From: Bob Miller <rem@osdl.org>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH 2.5.51] Remove compile warning from  net/sctp/sm_statefuns.c
Message-ID: <20021211223145.GD1067@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the quoting of a string that spans multitple lines to remove
a compiler warning.

diff -Nru a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
--- a/net/sctp/sm_statefuns.c	Wed Dec 11 13:41:51 2002
+++ b/net/sctp/sm_statefuns.c	Wed Dec 11 13:41:51 2002
@@ -862,8 +862,8 @@
 	/* Check if the timestamp looks valid.  */
 	if (time_after(hbinfo->sent_at, jiffies) ||
 	    time_after(jiffies, hbinfo->sent_at + max_interval)) {
-		SCTP_DEBUG_PRINTK("%s: HEARTBEAT ACK with invalid timestamp
-				   received for transport: %p\n",
+		SCTP_DEBUG_PRINTK("%s: HEARTBEAT ACK with invalid timestamp "
+				  "received for transport: %p\n",
 				   __FUNCTION__, link);
 		return SCTP_DISPOSITION_DISCARD;
 	}

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
