Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275063AbTHGBaB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 21:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275064AbTHGBaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 21:30:01 -0400
Received: from mta2.srv.hcvlny.cv.net ([167.206.5.5]:20872 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S275063AbTHGB37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 21:29:59 -0400
Date: Wed, 06 Aug 2003 21:29:52 -0400
From: "Josef 'Jeff' Sipek" <jeffpc@optonline.net>
Subject: Re: [PATCH][TRIVIAL] Bugzilla bug # 322 - double logical operator
 drivers/char/sx.c
In-reply-to: <3F319EE7.8010409@techsource.com>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <200308062129.52742.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5.2
References: <200308061830.05586.jeffpc@optonline.net>
 <3F319EE7.8010409@techsource.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the updated patch:

--- linux-2.5/drivers/char/sx.c.orig	2003-08-06 18:23:32.000000000 -0400
+++ linux-2.5/drivers/char/sx.c	2003-08-06 18:20:03.000000000 -0400
@@ -511,13 +511,13 @@
 
 	func_enter ();
 
-	for (i=0; i < TIMEOUT_1 > 0;i++) 
+	for (i=0; i < TIMEOUT_1 ;i++) 
 		if ((read_sx_byte (board, offset) & mask) == correctval) {
 			func_exit ();
 			return 1;
 		}
 
-	for (i=0; i < TIMEOUT_2 > 0;i++) {
+	for (i=0; i < TIMEOUT_2 ;i++) {
 		if ((read_sx_byte (board, offset) & mask) == correctval) {
 			func_exit ();
 			return 1;
@@ -537,13 +537,13 @@
 
 	func_enter ();
 
-	for (i=0; i < TIMEOUT_1 > 0;i++) 
+	for (i=0; i < TIMEOUT_1 ;i++) 
 		if ((read_sx_byte (board, offset) & mask) != badval) {
 			func_exit ();
 			return 1;
 		}
 
-	for (i=0; i < TIMEOUT_2 > 0;i++) {
+	for (i=0; i < TIMEOUT_2 ;i++) {
 		if ((read_sx_byte (board, offset) & mask) != badval) {
 			func_exit ();
 			return 1;



