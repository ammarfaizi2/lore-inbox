Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751549AbWCGTsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbWCGTsY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 14:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbWCGTsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 14:48:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:29126 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751549AbWCGTsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 14:48:23 -0500
X-Authenticated: #704063
Subject: [Patch] Dead code in drivers/isdn/avm/avmcard.h
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: kkeil@suse.de, kai.germaschewski@gmx.de
Content-Type: text/plain
Date: Tue, 07 Mar 2006 20:48:20 +0100
Message-Id: <1141760900.7561.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this fixes coverity id #2. the if (i==0) is pretty useless,
since we assing i=0, just the line before.
Just compile tested.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.16-rc5-mm1/drivers/isdn/hardware/avm/avmcard.h.orig	2006-03-07 20:44:33.000000000 +0100
+++ linux-2.6.16-rc5-mm1/drivers/isdn/hardware/avm/avmcard.h	2006-03-07 20:44:38.000000000 +0100
@@ -437,8 +437,7 @@ static inline unsigned int t1_get_slice(
 #endif
 					dp += i;
 					i = 0;
-					if (i == 0)
-						break;
+					break;
 					/* fall through */
 				default:
 					*dp++ = b1_get_byte(base);


