Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVCFXth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVCFXth (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 18:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVCFXrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 18:47:17 -0500
Received: from coderock.org ([193.77.147.115]:4784 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261581AbVCFWiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:38:04 -0500
Subject: [patch 1/8] isdn_bsdcomp.c - vfree() checking cleanups
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, isdn4linux@listserv.isdn4linux.de,
       domen@coderock.org, jlamanna@gmail.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 23:37:59 +0100
Message-Id: <20050306223800.1BBDC1EC90@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



isdn_bsdcomp.c vfree() checking cleanups.

Signed-off by: James Lamanna <jlamanna@gmail.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/isdn/i4l/isdn_bsdcomp.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff -puN drivers/isdn/i4l/isdn_bsdcomp.c~vfree-drivers_isdn_i4l_isdn_bsdcomp drivers/isdn/i4l/isdn_bsdcomp.c
--- kj/drivers/isdn/i4l/isdn_bsdcomp.c~vfree-drivers_isdn_i4l_isdn_bsdcomp	2005-03-05 16:10:31.000000000 +0100
+++ kj-domen/drivers/isdn/i4l/isdn_bsdcomp.c	2005-03-05 16:10:31.000000000 +0100
@@ -283,18 +283,14 @@ static void bsd_free (void *state)
 		/*
 		 * Release the dictionary
 		 */
-		if (db->dict) {
-			vfree (db->dict);
-			db->dict = NULL;
-		}
+		vfree (db->dict);
+		db->dict = NULL;
 
 		/*
 		 * Release the string buffer
 		 */
-		if (db->lens) {
-			vfree (db->lens);
-			db->lens = NULL;
-		}
+		vfree (db->lens);
+		db->lens = NULL;
 
 		/*
 		 * Finally release the structure itself.
_
