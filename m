Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265119AbUFVVey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265119AbUFVVey (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 17:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266022AbUFVVeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 17:34:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:7317 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265119AbUFVVbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 17:31:13 -0400
Date: Tue, 22 Jun 2004 14:23:46 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] update ikconfig help text
Message-Id: <20040622142346.15a22171.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some elements of ikconfig have been removed, but the help text
wasn't updated to reflect those changes.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


diffstat:=
 init/Kconfig |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff -Naurp ./init/Kconfig~ikc_help ./init/Kconfig
--- ./init/Kconfig~ikc_help	2004-06-22 11:07:22.000000000 -0700
+++ ./init/Kconfig	2004-06-22 12:20:19.000000000 -0700
@@ -209,26 +209,20 @@ config IKCONFIG
 	bool "Kernel .config support"
 	---help---
 	  This option enables the complete Linux kernel ".config" file
-	  contents, information on compiler used to build the kernel,
-	  kernel running when this kernel was built and kernel version
-	  from Makefile to be saved in the kernel. It provides documentation
+	  contents to be saved in the kernel. It provides documentation
 	  of which kernel options are used in a running kernel or in an
 	  on-disk kernel.  This information can be extracted from the kernel
 	  image file with the script scripts/extract-ikconfig and used as
 	  input to rebuild the current kernel or to build another kernel.
 	  It can also be extracted from a running kernel by reading
-	  /proc/config.gz and /proc/config_built_with, if enabled (below).
-	  /proc/config.gz will list the configuration that was used
-	  to build the kernel and /proc/config_built_with will list
-	  information on the compiler and host machine that was used to
-	  build the kernel.
+	  /proc/config.gz if enabled (below).
 
 config IKCONFIG_PROC
 	bool "Enable access to .config through /proc/config.gz"
 	depends on IKCONFIG && PROC_FS
 	---help---
-	  This option enables access to kernel configuration file and build
-	  information through /proc/config.gz.
+	  This option enables access to the kernel configuration file
+	  through /proc/config.gz.
 
 
 menuconfig EMBEDDED


--
