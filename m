Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbUBNI5R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 03:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUBNI5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 03:57:17 -0500
Received: from dsl-64-30-195-78.lcinet.net ([64.30.195.78]:10880 "EHLO
	mail.jg555.com") by vger.kernel.org with ESMTP id S261492AbUBNI5Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 03:57:16 -0500
Message-ID: <0da201c3f2d8$78c9e1a0$d300a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] -- Fixes KCONFIG for initrd
Date: Sat, 14 Feb 2004 00:56:44 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Prevents initrd from being built if ram device is built
             as a module.

--- linux-2.6.2/drivers/block/Kconfig.orig    2004-02-14 08:47:03.911807371
+0000
+++ linux-2.6.2/drivers/block/Kconfig 2004-02-14 08:49:37.739118285 +0000
@@ -313,6 +313,7 @@

 config BLK_DEV_INITRD
        bool "Initial RAM disk (initrd) support"
+       depends on BLK_DEV_RAM && BLK_DEV_RAM!=m
        help
          The initial RAM disk is a RAM disk that is loaded by the boot
loader
          (loadlin or lilo) and that is mounted as root before the normal
boot



----
Jim Gifford
maillist@jg555.com

