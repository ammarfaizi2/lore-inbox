Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTLUGz2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 01:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbTLUGz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 01:55:28 -0500
Received: from mta4.srv.hcvlny.cv.net ([167.206.5.70]:14796 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S262283AbTLUGz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 01:55:27 -0500
Date: Sun, 21 Dec 2003 01:55:22 -0500
From: "Josef 'Jeff' Sipek" <jeffpc@optonline.net>
Subject: [PATCH][TRIVIAL] Bugzilla bug # 322 - double logical operator
 drivers/char/sx.c
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <200312210155.22569.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simple clean up patch to remove double logical operators.

Josef 'Jeff' Sipek

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

