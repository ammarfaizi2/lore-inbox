Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262661AbUKMDHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbUKMDHl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 22:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbUKMDFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 22:05:49 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3336 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262661AbUKMDCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 22:02:41 -0500
Date: Sat, 13 Nov 2004 04:02:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] pcmcia/yenta_socket.c: make cardbus_type static
Message-ID: <20041113030207.GV2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since there's no user outside this file, cardbus_type in 
drivers/pcmcia/yenta_socket.c can be made static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/pcmcia/yenta_socket.c.old	2004-11-13 03:04:57.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/pcmcia/yenta_socket.c	2004-11-13 03:05:23.000000000 +0100
@@ -689,7 +689,7 @@
  * Different cardbus controllers have slightly different
  * initialization sequences etc details. List them here..
  */
-struct cardbus_type cardbus_type[] = {
+static struct cardbus_type cardbus_type[] = {
 	[CARDBUS_TYPE_TI]	= {
 		.override	= ti_override,
 		.save_state	= ti_save_state,

