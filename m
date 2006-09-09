Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965033AbWIIXzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbWIIXzf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 19:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbWIIXzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 19:55:35 -0400
Received: from gw.goop.org ([64.81.55.164]:13256 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S965033AbWIIXzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 19:55:35 -0400
Message-ID: <45035472.8000506@goop.org>
Date: Sat, 09 Sep 2006 16:55:30 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "H. Peter Anvin" <hpa@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Reserve a boot-loader ID number for Xen
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Claim an ID number for Xen in the LOADER_TYPE field.

Also, keep the table in zero-page.txt consistent with boot.txt.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>

===================================================================
--- a/Documentation/i386/boot.txt
+++ b/Documentation/i386/boot.txt
@@ -181,6 +181,7 @@ filled out, however:
 	5  ELILO
 	7  GRuB
 	8  U-BOOT
+	9  Xen
 
 	Please contact <hpa@zytor.com> if you need a bootloader ID
 	value assigned.
===================================================================
--- a/Documentation/i386/zero-page.txt
+++ b/Documentation/i386/zero-page.txt
@@ -63,6 +63,10 @@ 0x210	char		LOADER_TYPE, = 0, old one
 				2 for bootsect-loader
 				3 for SYSLINUX
 				4 for ETHERBOOT
+				5 for ELILO
+				7 for GRuB
+				8 for U-BOOT
+				9 for Xen
 				V = version
 0x211	char		loadflags:
 			bit0 = 1: kernel is loaded high (bzImage)


