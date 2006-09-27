Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030853AbWI0VHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030853AbWI0VHc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 17:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030833AbWI0VHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 17:07:31 -0400
Received: from farad.aurel32.net ([82.232.2.251]:5780 "EHLO farad.aurel32.net")
	by vger.kernel.org with ESMTP id S1030853AbWI0VH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 17:07:26 -0400
Date: Wed, 27 Sep 2006 23:07:25 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Subject: [PATCH] QEMU - Add support for little endian mips
Message-ID: <20060927210723.GA28334@bode.aurel32.net>
Mail-Followup-To: Aurelien Jarno <aurelien@aurel32.net>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This very small patch adds support for little endian on the virtual QEMU
mips platform. The status of this platform is the same as the big endian
one, ie it is possible to boot a system with init=/bin/sh.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
i

diff -Nurd linux-2.6.18.orig/arch/mips/Kconfig linux-2.6.18/arch/mips/Kconfig
--- linux-2.6.18.orig/arch/mips/Kconfig	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18/arch/mips/Kconfig	2006-09-27 23:00:12.124563754 +0200
@@ -557,6 +557,7 @@
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select ARCH_SPARSEMEM_ENABLE
 	help
 	  Qemu is a software emulator which among other architectures also

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
