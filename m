Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTGOK65 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 06:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267166AbTGOK65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 06:58:57 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:11921 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262123AbTGOK64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 06:58:56 -0400
Date: Tue, 15 Jul 2003 13:13:40 +0200 (MEST)
Message-Id: <200307151113.h6FBDelt011162@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo@conectiva.com.br
Subject: [PATCH][2.4.22-pre6] clean crc temp files in lib/
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A 2.4.22-pre kernel build leaves two temp files in lib/,
crc32table.h and gen_crc32table, that mrproper doesn't remove.
This is ugly. Fixed in the patch below.

/Mikael

--- linux-2.4.22-pre6/Makefile.~1~	2003-07-15 12:10:10.000000000 +0200
+++ linux-2.4.22-pre6/Makefile	2003-07-15 12:32:09.000000000 +0200
@@ -230,6 +230,7 @@
 # files removed with 'make mrproper'
 MRPROPER_FILES = \
 	include/linux/autoconf.h include/linux/version.h \
+	lib/crc32table.h lib/gen_crc32table \
 	drivers/net/hamradio/soundmodem/sm_tbl_{afsk1200,afsk2666,fsk9600}.h \
 	drivers/net/hamradio/soundmodem/sm_tbl_{hapn4800,psk4800}.h \
 	drivers/net/hamradio/soundmodem/sm_tbl_{afsk2400_7,afsk2400_8}.h \
