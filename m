Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272387AbTHFWb1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 18:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274958AbTHFWbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 18:31:25 -0400
Received: from mta9.srv.hcvlny.cv.net ([167.206.5.42]:34266 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S274964AbTHFWaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 18:30:14 -0400
Date: Wed, 06 Aug 2003 18:30:05 -0400
From: "Josef 'Jeff' Sipek" <jeffpc@optonline.net>
Subject: [PATCH][TRIVIAL] Bugzilla bug # 322 - double logical operator
 drivers/char/sx.c
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <200308061830.05586.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a simple fix to make the statements more readable. (instead of
"i < TIMEOUT > 0" the statement is divided into two, joined by &&.)

Josef 'Jeff' Sipek

--- linux-2.5/drivers/char/sx.c.orig	2003-08-06 18:23:32.000000000 -0400
+++ linux-2.5/drivers/char/sx.c	2003-08-06 18:20:03.000000000 -0400
@@ -511,13 +511,13 @@
 
 	func_enter ();
 
-	for (i=0; i < TIMEOUT_1 > 0;i++) 
+	for (i=0; (i < TIMEOUT_1) && (TIMEOUT_1 > 0);i++) 
 		if ((read_sx_byte (board, offset) & mask) == correctval) {
 			func_exit ();
 			return 1;
 		}
 
-	for (i=0; i < TIMEOUT_2 > 0;i++) {
+	for (i=0; (i < TIMEOUT_2) && (TIMEOUT_2 > 0);i++) {
 		if ((read_sx_byte (board, offset) & mask) == correctval) {
 			func_exit ();
 			return 1;
@@ -537,13 +537,13 @@
 
 	func_enter ();
 
-	for (i=0; i < TIMEOUT_1 > 0;i++) 
+	for (i=0; (i < TIMEOUT_1) && (TIMEOUT_1 > 0);i++) 
 		if ((read_sx_byte (board, offset) & mask) != badval) {
 			func_exit ();
 			return 1;
 		}
 
-	for (i=0; i < TIMEOUT_2 > 0;i++) {
+	for (i=0; (i < TIMEOUT_2) && (TIMEOUT_2 > 0);i++) {
 		if ((read_sx_byte (board, offset) & mask) != badval) {
 			func_exit ();
 			return 1;

