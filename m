Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281191AbRLDRE4>; Tue, 4 Dec 2001 12:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281165AbRLDRDd>; Tue, 4 Dec 2001 12:03:33 -0500
Received: from web12302.mail.yahoo.com ([216.136.173.100]:8793 "HELO
	web12302.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S281199AbRLDRCx>; Tue, 4 Dec 2001 12:02:53 -0500
Message-ID: <20011204170252.43996.qmail@web12302.mail.yahoo.com>
Date: Tue, 4 Dec 2001 09:02:52 -0800 (PST)
From: Stephen Cameron <smcameron@yahoo.com>
Subject: cciss max SGs is 31, not 32, 2.5.1-pre5
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys,

wrt 2.5.1-pre5

The change below should be reverted.  The controller will reject a command
with 32 scatter gather entries.  

Thanks,

-- steve

diff -u --recursive --new-file v2.5.0/linux/drivers/block/cciss_cmd.h
linux/drivers/block/cciss_cmd.h
--- v2.5.0/linux/drivers/block/cciss_cmd.h      Fri Nov  2 17:45:42 2001
+++ linux/drivers/block/cciss_cmd.h     Tue Nov 27 09:23:27 2001
@@ -7,7 +7,7 @@

 //general boundary defintions
 #define SENSEINFOBYTES          32//note that this value may vary between host implementations
-#define MAXSGENTRIES            31
+#define MAXSGENTRIES            32
 #define MAXREPLYQS              256


__________________________________________________
Do You Yahoo!?
Buy the perfect holiday gifts at Yahoo! Shopping.
http://shopping.yahoo.com
