Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262867AbUB0N6v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 08:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262877AbUB0N6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 08:58:51 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:61873 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262867AbUB0N6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 08:58:49 -0500
Date: Fri, 27 Feb 2004 13:57:29 +0000
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: S390 block devs on !s390.
Message-ID: <20040227135728.GA15016@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is probably useless on x86 for eg..
(Everything else in this file is dependant on some other s390 feature,
 so only this one shows up).  Too bad the drivers/s390/block stuff gets
source'd at all on !s390.

		Dave

--- linux-2.6.3/drivers/s390/block/Kconfig~	2004-02-27 13:54:18.000000000 +0000
+++ linux-2.6.3/drivers/s390/block/Kconfig	2004-02-27 13:54:27.000000000 +0000
@@ -13,6 +13,7 @@
 
 config DCSSBLK
 	tristate "DCSSBLK support"
+	depends on ARCH_S390
 	help
 	  Support for dcss block device
 
