Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315627AbSGFQrN>; Sat, 6 Jul 2002 12:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315628AbSGFQrM>; Sat, 6 Jul 2002 12:47:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63246 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315627AbSGFQrM>;
	Sat, 6 Jul 2002 12:47:12 -0400
Date: Sat, 6 Jul 2002 17:49:48 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] make ips driver compile
Message-ID: <20020706174948.H27706@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Whoever did the strsep patches didn't check that ips still compiles.
here's a patch.

--- linux-2.5.24-flock/drivers/scsi/ips.c	Sun Jun  2 18:44:38 2002
+++ linux-2.5.24-mm/drivers/scsi/ips.c	Tue Jul  2 11:42:20 2002
@@ -596,6 +596,7 @@
    }
 
    return (1);
+}
 
 __setup("ips=", ips_setup);
 
@@ -632,10 +633,9 @@
          }
       }
    }
+}
 
 #endif
-
-}
 
 /****************************************************************************/
 /*                                                                          */

-- 
Revolutions do not require corporate support.
