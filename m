Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267852AbUIPIcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267852AbUIPIcb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 04:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267856AbUIPIcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 04:32:31 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:3084 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267852AbUIPIc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 04:32:27 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] mention that DEBUG_SLAB can slow down machine quite a bit
Date: Thu, 16 Sep 2004 11:32:04 +0300
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_E+USB4BweILrN5O"
Message-Id: <200409161132.05247.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_E+USB4BweILrN5O
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I experienced x3 slowdown due to this option being set.

Please add this small warning to DEBUG_SLAB help text.
--
vda

--Boundary-00=_E+USB4BweILrN5O
Content-Type: text/x-diff;
  charset="koi8-r";
  name="allocdebug.helptext"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="allocdebug.helptext"

diff -urN linux-2.6.9-rc2hz.src/lib/Kconfig.debug linux-2.6.9-rc2hz.helptext/lib/Kconfig.debug
--- linux-2.6.9-rc2hz.src/lib/Kconfig.debug	Mon Sep 13 22:33:37 2004
+++ linux-2.6.9-rc2hz.helptext/lib/Kconfig.debug	Thu Sep 16 11:19:28 2004
@@ -34,7 +34,7 @@
 	help
 	  Say Y here to have the kernel do limited verification on memory
 	  allocation as well as poisoning memory on free to catch use of freed
-	  memory.
+	  memory. This can make kmalloc/kfree-intensive workloads much slower.
 
 config DEBUG_SPINLOCK
 	bool "Spinlock debugging"

--Boundary-00=_E+USB4BweILrN5O--

