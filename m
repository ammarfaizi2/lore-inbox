Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbWEXSbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWEXSbv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 14:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWEXSbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 14:31:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51093 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932402AbWEXSbv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 14:31:51 -0400
Date: Wed, 24 May 2006 11:31:39 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: <dtor_core@ameritech.net>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Patch for atkbd.c from Ubuntu
Message-Id: <20060524113139.e457d3a8.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dmitry:

What do you think about the attached? Apparently, this is needed to
support Korean input keys. Please let me know if this can be included.

Here's a bug entry for reference:
 https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=192637

Yours,
-- Pete

diff -ruN linux-2.6.16.i686.orig/drivers/input/keyboard/atkbd.c linux-2.6.16.i686/drivers/input/keyboard/atkbd.c
--- linux-2.6.16.i686.orig/drivers/input/keyboard/atkbd.c	2006-05-23 18:16:01.000000000 +0900
+++ linux-2.6.16.i686/drivers/input/keyboard/atkbd.c	2006-05-24 12:46:09.000000000 +0900
@@ -85,7 +85,7 @@
 	  0, 56, 42, 93, 29, 16,  2,  0,  0,  0, 44, 31, 30, 17,  3,  0,
 	  0, 46, 45, 32, 18,  5,  4, 95,  0, 57, 47, 33, 20, 19,  6,183,
 	  0, 49, 48, 35, 34, 21,  7,184,  0,  0, 50, 36, 22,  8,  9,185,
-	  0, 51, 37, 23, 24, 11, 10,  0,  0, 52, 53, 38, 39, 25, 12,  0,
+	  0, 51, 37, 23, 24, 11, 10,122,123, 52, 53, 38, 39, 25, 12,  0,
 	  0, 89, 40,  0, 26, 13,  0,  0, 58, 54, 28, 27,  0, 43,  0, 85,
 	  0, 86, 91, 90, 92,  0, 14, 94,  0, 79,124, 75, 71,121,  0,  0,
 	 82, 83, 80, 76, 77, 72,  1, 69, 87, 78, 81, 74, 55, 73, 70, 99,

-- Pete
