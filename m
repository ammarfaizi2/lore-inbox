Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUH3XMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUH3XMT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 19:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUH3XMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 19:12:19 -0400
Received: from web52305.mail.yahoo.com ([206.190.39.100]:30844 "HELO
	web52305.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265161AbUH3XMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 19:12:15 -0400
Message-ID: <20040830231214.8697.qmail@web52305.mail.yahoo.com>
Date: Tue, 31 Aug 2004 01:12:14 +0200 (CEST)
From: =?iso-8859-1?q?Albert=20Herranz?= <albert_herranz@yahoo.es>
Subject: [PATCH] 2.6.9-rc1-mm1: kexec ppc KEXEC Kconfig misplacement
To: ebiederm@xmission.com, akpm@osdl.org
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-81601550-1093907534=:8575"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-81601550-1093907534=:8575
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,

The following patch places KEXEC Kconfig ppc option in
a more convenient menu, like in the i386 tree.
It seems that it got again misplaced (in the current
-mm tree it appears within the IBM 40x options menu).

Patch against 2.6.9-rc1-mm1, available here:

http://www.gc-linux.org/down/isobel/kexec/2.6.9-rc1-mm1/broken-out/kexec-kexecppc-kconfig-fix.patch

Cheers,
Albert



		
______________________________________________
Renovamos el Correo Yahoo!: ¡100 MB GRATIS!
Nuevos servicios, más seguridad
http://correo.yahoo.es
--0-81601550-1093907534=:8575
Content-Type: text/plain; name="kexec-kexecppc-kconfig-fix.patch"
Content-Description: kexec-kexecppc-kconfig-fix.patch
Content-Disposition: inline; filename="kexec-kexecppc-kconfig-fix.patch"

--- a/arch/ppc/Kconfig	2004-08-30 10:42:09.000000000 +0200
+++ b/arch/ppc/Kconfig	2004-08-31 00:49:41.000000000 +0200
@@ -245,6 +245,26 @@ config NOT_COHERENT_CACHE
 
 source "drivers/perfctr/Kconfig"
 
+config KEXEC
+	bool "kexec system call (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  kexec is a system call that implements the ability to shutdown your
+	  current kernel, and to start another kernel.  It is like a reboot
+	  but it is indepedent of the system firmware.   And like a reboot
+	  you can start any kernel with it, not just Linux.
+
+	  The name comes from the similiarity to the exec system call.
+
+	  It is an ongoing process to be certain the hardware in a machine
+	  is properly shutdown, so do not be surprised if this code does not
+	  initially work for you.  It may help to enable device hotplugging
+	  support.  As of this writing the exact hardware interface is
+	  strongly in flux, so no good recommendation can be made.
+
+	  In the GameCube implementation, kexec allows you to load and
+	  run DOL files, including kernel and homebrew DOLs.
+
 endmenu
 
 menu "Platform options"
@@ -1222,26 +1242,6 @@ config SERIAL_SICC_CONSOLE
 	depends on SERIAL_SICC && UART0_TTYS1
 	default y
 
-config KEXEC
-	bool "kexec system call (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	help
-	  kexec is a system call that implements the ability to shutdown your
-	  current kernel, and to start another kernel.  It is like a reboot
-	  but it is indepedent of the system firmware.   And like a reboot
-	  you can start any kernel with it, not just Linux.
-
-	  The name comes from the similiarity to the exec system call.
-
-	  It is an ongoing process to be certain the hardware in a machine
-	  is properly shutdown, so do not be surprised if this code does not
-	  initially work for you.  It may help to enable device hotplugging
-	  support.  As of this writing the exact hardware interface is
-	  strongly in flux, so no good recommendation can be made.
-
-	  In the GAMECUBE implementation, kexec allows you to load and
-	  run DOL files, including kernel and homebrew DOLs.
-
 endmenu
 
 source "lib/Kconfig"

--0-81601550-1093907534=:8575--
