Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVCBXVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVCBXVa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVCBXSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:18:48 -0500
Received: from mo01.iij4u.or.jp ([210.130.0.20]:46570 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261308AbVCBXOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:14:34 -0500
Date: Thu, 3 Mar 2005 08:14:20 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 2.6.11-rc5-mm1] mips: add __init
Message-Id: <20050303081420.52fb2205.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds __init for the function used only for initialization. 
This patch is only for 2.6.11-rc5-mm1.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/vr41xx/casio-e55/setup.c a/arch/mips/vr41xx/casio-e55/setup.c
--- a-orig/arch/mips/vr41xx/casio-e55/setup.c	Wed Mar  2 01:01:57 2005
+++ a/arch/mips/vr41xx/casio-e55/setup.c	Wed Mar  2 08:36:58 2005
@@ -17,6 +17,7 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+#include <linux/init.h>
 #include <linux/ioport.h>
 
 #include <asm/io.h>
@@ -27,7 +28,7 @@
 	return "CASIO CASSIOPEIA E-11/15/55/65";
 }
 
-static int casio_e55_setup(void)
+static int __init casio_e55_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
 	ioport_resource.start = IO_PORT_RESOURCE_START;
@@ -36,4 +37,4 @@
 	return 0;
 }
 
-early_initcall(casio_e55_setup);
+arch_initcall(casio_e55_setup);
diff -urN -X dontdiff a-orig/arch/mips/vr41xx/ibm-workpad/setup.c a/arch/mips/vr41xx/ibm-workpad/setup.c
--- a-orig/arch/mips/vr41xx/ibm-workpad/setup.c	Wed Mar  2 01:01:57 2005
+++ a/arch/mips/vr41xx/ibm-workpad/setup.c	Wed Mar  2 08:36:58 2005
@@ -17,6 +17,7 @@
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+#include <linux/init.h>
 #include <linux/ioport.h>
 
 #include <asm/io.h>
@@ -27,7 +28,7 @@
 	return "IBM WorkPad z50";
 }
 
-static int ibm_workpad_setup(void)
+static int __init ibm_workpad_setup(void)
 {
 	set_io_port_base(IO_PORT_BASE);
 	ioport_resource.start = IO_PORT_RESOURCE_START;
@@ -36,4 +37,4 @@
 	return 0;
 }
 
-early_initcall(ibm_workpad_setup);
+arch_initcall(ibm_workpad_setup);
