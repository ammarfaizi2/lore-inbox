Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264883AbUDWRMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264883AbUDWRMr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 13:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264882AbUDWRMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 13:12:46 -0400
Received: from outmx013.isp.belgacom.be ([195.238.3.64]:13232 "EHLO
	outmx013.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S264879AbUDWRMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 13:12:44 -0400
Subject: [PATCH 2.6.6-rc2-mm1] Default PC bios support fix
From: FabF <Fabian.Frederick@skynet.be>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-AAhiRAy/Hhx0S9DXQskD"
Message-Id: <1082740621.6099.9.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 23 Apr 2004 19:17:02 +0200
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx013.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AAhiRAy/Hhx0S9DXQskD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

	Here's a trivial patch to add PC Bios support by default when
activating Advanced Partition Selection e.g. when someone wants to add
LDM he doens't have potentially vital feature removed which can be very
annoying indeed (especially when you preconize an option to be an
upvalue) :(

Regards,
FabF

--=-AAhiRAy/Hhx0S9DXQskD
Content-Disposition: attachment; filename=partitions1.diff
Content-Type: text/x-patch; name=partitions1.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -Naur orig/fs/partitions/Kconfig edited/fs/partitions/Kconfig
--- orig/fs/partitions/Kconfig	2004-04-04 05:38:13.000000000 +0200
+++ edited/fs/partitions/Kconfig	2004-04-23 19:04:04.000000000 +0200
@@ -100,7 +100,7 @@
 
 config MSDOS_PARTITION
 	bool "PC BIOS (MSDOS partition tables) support" if PARTITION_ADVANCED
-	default y if !PARTITION_ADVANCED && !AMIGA && !ATARI && !MAC && !SGI_IP22 && !ARM && !SGI_IP27
+	default y if !AMIGA && !ATARI && !MAC && !SGI_IP22 && !ARM && !SGI_IP27
 	help
 	  Say Y here if you would like to use hard disks under Linux which
 	  were partitioned on an x86 PC (not necessarily by DOS).

--=-AAhiRAy/Hhx0S9DXQskD--

