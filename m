Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbUCJO42 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 09:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbUCJO42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 09:56:28 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:23815 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262396AbUCJO40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 09:56:26 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.4-rc3] Disable Macintosh device drivers for all but PPC || MAC
Date: Wed, 10 Mar 2004 15:47:27 +0100
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@digeo.com>
X-Operating-System: Linux 2.4.20-wolk4.10s i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Organization: Working Overloaded Linux Kernel
Message-Id: <200403101547.27116@WOLK>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/pyTAmTVLWdDe5h"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_/pyTAmTVLWdDe5h
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Andrew,

the attached patch is needed to stop showing us "Macintosh device 
drivers" for all architectures via menuconfig || xconfig || gconfig.
It's only necessary for PPC and/or MAC.

ACKed by Benjamim.

ciao, Marc

--Boundary-00=_/pyTAmTVLWdDe5h
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="mac-menu-for-ALL-arches-eh.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mac-menu-for-ALL-arches-eh.patch"

diff -Naurp linux-2.6.4-rc1/drivers/macintosh/Kconfig linux-2.6.4-rc1-modified/drivers/macintosh/Kconfig
--- linux-2.6.4-rc1/drivers/macintosh/Kconfig	2004-03-07 20:52:34.000000000 +0100
+++ linux-2.6.4-rc1-modified/drivers/macintosh/Kconfig	2004-03-07 21:12:47.000000000 +0100
@@ -1,5 +1,6 @@
 
 menu "Macintosh device drivers"
+	depends on PPC || MAC
 
 config ADB
 	bool "Apple Desktop Bus (ADB) support"

--Boundary-00=_/pyTAmTVLWdDe5h--

