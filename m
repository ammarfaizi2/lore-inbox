Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264767AbTFLMxO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 08:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264777AbTFLMxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 08:53:14 -0400
Received: from dp.samba.org ([66.70.73.150]:34284 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264767AbTFLMxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 08:53:13 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16104.31251.530055.156452@nanango.paulus.ozlabs.org>
Date: Thu, 12 Jun 2003 23:03:15 +1000 (EST)
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix macserial driver compilation
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a missing declaration of serial_driver in macserial.c,
causing the compilation to fail.  This patch adds a suitable
declaration.

Please apply.

Thanks,
Paul.

diff -urN linux-2.5/drivers/macintosh/macserial.c pmac-2.5/drivers/macintosh/macserial.c
--- linux-2.5/drivers/macintosh/macserial.c	2003-06-12 20:33:22.000000000 +1000
+++ pmac-2.5/drivers/macintosh/macserial.c	2003-06-12 22:58:04.000000000 +1000
@@ -76,6 +76,8 @@
    in the order we want. */
 #define RECOVERY_DELAY	eieio()
 
+static struct tty_driver *serial_driver;
+
 struct mac_zschannel zs_channels[NUM_CHANNELS];
 
 struct mac_serial zs_soft[NUM_CHANNELS];
