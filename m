Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262862AbVAFPF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbVAFPF5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 10:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbVAFPEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 10:04:38 -0500
Received: from mo00.iij4u.or.jp ([210.130.0.19]:761 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S262856AbVAFPDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 10:03:14 -0500
Date: Fri, 7 Jan 2005 00:02:59 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.10-mm2] mips: fixed build error about NEC VR4100 series
Message-Id: <20050107000259.085e9e25.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch had fixed build error about NEC VR4100 series.

 * add #include <linux/kernel.h> for printk()

This patch had already applied to Ralf's cvs tree.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff b-orig/arch/mips/vr41xx/common/bcu.c b/arch/mips/vr41xx/common/bcu.c
--- b-orig/arch/mips/vr41xx/common/bcu.c	Sat Dec 25 06:35:27 2004
+++ b/arch/mips/vr41xx/common/bcu.c	Thu Jan  6 23:03:22 2005
@@ -30,6 +30,7 @@
  */
 #include <linux/init.h>
 #include <linux/ioport.h>
+#include <linux/kernel.h>
 #include <linux/smp.h>
 #include <linux/types.h>
 
diff -urN -X dontdiff b-orig/arch/mips/vr41xx/common/pmu.c b/arch/mips/vr41xx/common/pmu.c
--- b-orig/arch/mips/vr41xx/common/pmu.c	Sat Dec 25 06:35:23 2004
+++ b/arch/mips/vr41xx/common/pmu.c	Thu Jan  6 23:03:38 2005
@@ -18,6 +18,7 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/smp.h>
 #include <linux/types.h>
 
