Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272948AbSISUrw>; Thu, 19 Sep 2002 16:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272979AbSISUrv>; Thu, 19 Sep 2002 16:47:51 -0400
Received: from dsl-65-188-251-69.telocity.com ([65.188.251.69]:5280 "EHLO
	orr.homenet") by vger.kernel.org with ESMTP id <S272948AbSISUru>;
	Thu, 19 Sep 2002 16:47:50 -0400
Date: Thu, 19 Sep 2002 16:52:49 -0400
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Donald Becker <becker@scyld.com>,
       Richard Gooch <rgooch@ras.ucalgary.ca>,
       "Patrick R. McManus" <mcmanus@ducksong.com>, edward_peng@dlink.com.tw
Subject: PATCH: sundance #4b
Message-ID: <20020919205249.GB17492@orr.falooley.org>
References: <Pine.LNX.4.44.0209190903050.29420-100000@beohost.scyld.com> <3D8A25D1.3060300@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <3D8A25D1.3060300@mandrakesoft.com>
User-Agent: Mutt/1.4i
From: Jason Lunz <lunz@falooley.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


The aforementioned failure happens unless USE_IO_OPS is defined. It
should be the default, as without it the driver doesn't work at all.

Jason

--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sundance-4b

--- sundance-unreg.c	Thu Sep 19 16:48:22 2002
+++ sundance-ioops.c	Thu Sep 19 16:48:24 2002
@@ -247,6 +247,10 @@
 
 */
 
+/* Work-around for Kendin chip bugs. */
+#ifndef USE_MEM_OPS
+#define USE_IO_OPS 1
+#endif
 
 static struct pci_device_id sundance_pci_tbl[] __devinitdata = {
 	{0x1186, 0x1002, 0x1186, 0x1002, 0, 0, 0},

--gatW/ieO32f1wygP--
