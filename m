Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbUL2IUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbUL2IUx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 03:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbUL2IUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 03:20:45 -0500
Received: from ridcully.inittab.de ([213.146.113.136]:31669 "EHLO
	mail1.inittab.de") by vger.kernel.org with ESMTP id S261398AbUL2IUA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 03:20:00 -0500
Date: Wed, 29 Dec 2004 09:19:58 +0100
From: Norbert Tretkowski <tretkowski@inittab.de>
To: linux-kernel@vger.kernel.org
Subject: Patch: 2.6.10 - CMSPAR in mxser.c undeclared
Message-ID: <20041229081957.GA31981@rollcage.inittab.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

{standard input}: Assembler messages:
{standard input}:5: Warning: setting incorrect section attributes for .got
drivers/char/mxser.c: In function `mxser_ioctl_special':
drivers/char/mxser.c:1564: error: `CMSPAR' undeclared (first use in this function)
drivers/char/mxser.c:1564: error: (Each undeclared identifier is reported only once
drivers/char/mxser.c:1564: error: for each function it appears in.)
make[4]: *** [drivers/char/mxser.o] Error 1
make[3]: *** [drivers/char] Error 2
make[2]: *** [drivers] Error 2


--- drivers/char/mxser.c~       2004-12-24 22:35:14.000000000 +0100
+++ drivers/char/mxser.c        2004-12-29 09:08:59.000000000 +0100
@@ -1561,6 +1561,10 @@

                                mon_data_ext.stopbits[i] = cflag & CSTOPB;

+#ifndef CMSPAR
+#define        CMSPAR 010000000000
+#endif
+
                                mon_data_ext.parity[i] = cflag & (PARENB | PARODD | CMSPAR);

                                mon_data_ext.flowctrl[i] = 0x00;
