Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264028AbTE0RqC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbTE0Roz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:44:55 -0400
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:8975 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S264024AbTE0Ro0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:44:26 -0400
Date: Wed, 28 May 2003 02:57:51 +0900 (JST)
Message-Id: <20030528.025751.65947567.yoshfuji@wide.ad.jp>
To: siim@pld.ttu.ee, davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: 2.5.70-bk1 compilation error
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@wide.ad.jp>
In-Reply-To: <Pine.GSO.4.53.0305271949510.10781@pitsa.pld.ttu.ee>
References: <Pine.GSO.4.53.0305271949510.10781@pitsa.pld.ttu.ee>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.53.0305271949510.10781@pitsa.pld.ttu.ee> (at Tue, 27 May 2003 19:55:42 +0300 (EET DST)), Siim Vahtre <siim@pld.ttu.ee> says:

>   CC [M]  drivers/video/i810/i810_main.o
> In file included from drivers/video/i810/i810_main.c:56:
> drivers/video/i810/i810.h:206: error: parse error before "agp_memory"

Index: linux25-LINUS/drivers/video/i810/i810.h
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/drivers/video/i810/i810.h,v
retrieving revision 1.1.1.4
diff -u -r1.1.1.4 i810.h
--- linux25-LINUS/drivers/video/i810/i810.h	17 Apr 2003 18:13:36 -0000	1.1.1.4
+++ linux25-LINUS/drivers/video/i810/i810.h	27 May 2003 17:48:49 -0000
@@ -203,8 +203,8 @@
 #define LOCKUP                      8
 
 struct gtt_data {
-	agp_memory *i810_fb_memory;
-	agp_memory *i810_cursor_memory;
+	struct agp_memory *i810_fb_memory;
+	struct agp_memory *i810_cursor_memory;
 };
 
 struct mode_registers {
Index: linux25-LINUS/drivers/video/sis/sis_main.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/drivers/video/sis/sis_main.c,v
retrieving revision 1.1.1.4
diff -u -r1.1.1.4 sis_main.c
--- linux25-LINUS/drivers/video/sis/sis_main.c	6 May 2003 12:43:02 -0000	1.1.1.4
+++ linux25-LINUS/drivers/video/sis/sis_main.c	27 May 2003 17:48:50 -0000
@@ -2868,8 +2868,8 @@
 	unsigned long *write_port = 0;
 	SIS_CMDTYPE    cmd_type;
 #ifndef AGPOFF
-	agp_kern_info  *agp_info;
-	agp_memory     *agp;
+	struct agp_kern_info  *agp_info;
+	struct agp_memory     *agp;
 	u32            agp_phys;
 #endif
 #endif

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
