Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261925AbREXNfr>; Thu, 24 May 2001 09:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261924AbREXNf1>; Thu, 24 May 2001 09:35:27 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:37386 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S261925AbREXNfZ>; Thu, 24 May 2001 09:35:25 -0400
Date: Thu, 24 May 2001 15:29:58 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Linux USB users list <linux-usb-users@lists.sourceforge.net>
Cc: mwm@i.am, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Fix ov511 compile time bug in 2.4.5-pre5
Message-ID: <20010524152958.E1477@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The ov511 driver in 2.4.5-pre5 couldn't be compiled because version was
replaced by DRIVER_VERSION. Please apply this trivial fix.


Erik

--- drivers/usb/ov511.c.orig	Thu May 24 15:21:58 2001
+++ drivers/usb/ov511.c	Thu May 24 15:24:20 2001
@@ -337,7 +337,7 @@
 	/* IMPORTANT: This output MUST be kept under PAGE_SIZE
 	 *            or we need to get more sophisticated. */
 
-	out += sprintf (out, "driver_version  : %s\n", version);
+	out += sprintf (out, "driver_version  : %s\n", DRIVER_VERSION);
 	out += sprintf (out, "custom_id       : %d\n", ov511->customid);
 	out += sprintf (out, "model           : %s\n", ov511->desc ?
 		clist[ov511->desc].description : "unknown");


-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
