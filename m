Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267449AbTBNUwb>; Fri, 14 Feb 2003 15:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267458AbTBNUwb>; Fri, 14 Feb 2003 15:52:31 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15882 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267449AbTBNUwD>; Fri, 14 Feb 2003 15:52:03 -0500
Subject: PATCH: make mca-legacy bitch at users
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Fri, 14 Feb 2003 21:01:55 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18jmy3-0005em-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This lets me put mca-legacy into drivers to fix them for now without
worrying about losing the fact they want more attention

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.60-ref/include/linux/mca-legacy.h linux-2.5.60-ac1/include/linux/mca-legacy.h
--- linux-2.5.60-ref/include/linux/mca-legacy.h	2003-02-14 21:21:45.000000000 +0000
+++ linux-2.5.60-ac1/include/linux/mca-legacy.h	2003-02-14 19:37:42.000000000 +0000
@@ -7,6 +7,8 @@
 #ifndef _LINUX_MCA_LEGACY_H
 #define _LINUX_MCA_LEGACY_H
 
+#warning "MCA legacy - please move your driver to the new sysfs api"
+
 /* MCA_NOTFOUND is an error condition.  The other two indicate
  * motherboard POS registers contain the adapter.  They might be
  * returned by the mca_find_adapter() function, and can be used as
