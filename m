Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284800AbRLURB3>; Fri, 21 Dec 2001 12:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284794AbRLURBT>; Fri, 21 Dec 2001 12:01:19 -0500
Received: from web12304.mail.yahoo.com ([216.136.173.102]:39949 "HELO
	web12304.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S284882AbRLURBC>; Fri, 21 Dec 2001 12:01:02 -0500
Message-ID: <20011221170101.30520.qmail@web12304.mail.yahoo.com>
Date: Fri, 21 Dec 2001 09:01:01 -0800 (PST)
From: Stephen Cameron <smcameron@yahoo.com>
Subject: [PATCH] cciss_cmd.h, MAXSGENTRIES is 31, not 32.
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply this patch to set MAXSGENTRIES back to 31.
All of the SmartArray 53xx controllers to date will 
reject commands having more than 31 scatter gather 
entries.

Thanks,

-- steve

--- linux-2.5.2-pre1/drivers/block/cciss_cmd.h.orig     Fri Dec 21 10:46:31 2001
+++ linux-2.5.2-pre1/drivers/block/cciss_cmd.h  Fri Dec 21 10:46:41 2001
@@ -7,7 +7,7 @@

 //general boundary defintions
 #define SENSEINFOBYTES          32//note that this value may vary between host implementations
-#define MAXSGENTRIES            32
+#define MAXSGENTRIES            31
 #define MAXREPLYQS              256

 //Command Status value



__________________________________________________
Do You Yahoo!?
Check out Yahoo! Shopping and Yahoo! Auctions for all of
your unique holiday gifts! Buy at http://shopping.yahoo.com
or bid at http://auctions.yahoo.com
