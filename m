Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbTJFLBl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 07:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbTJFLBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 07:01:41 -0400
Received: from mail.tactel.se ([195.22.66.197]:63418 "EHLO mail.tactel.se")
	by vger.kernel.org with ESMTP id S261625AbTJFLBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 07:01:40 -0400
Subject: [PATCH] 2.4 Radeonfb patch for Asus L5
From: Pontus Fuchs <pontus.fuchs@tactel.se>
To: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Content-Type: text/plain
Message-Id: <1065438092.1434.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 06 Oct 2003 13:01:32 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the 2.4 version of the same patch that's now in 2.6.0-mm. It's
needed to the the flatpanel on the Asus L5 laptop working.

--- radeonfb.c.orig	2003-10-02 16:45:49.000000000 +0200
+++ radeonfb.c	2003-10-02 16:46:13.000000000 +0200
@@ -1485,7 +1485,7 @@
 	printk("radeonfb: detected LCD panel size from BIOS: %dx%d\n",
 		rinfo->panel_xres, rinfo->panel_yres);
 
-	for(i=0; i<20; i++) {
+	for(i=0; i<21; i++) {
 		tmp0 = rinfo->bios_seg + readw(tmp+64+i*2);
 		if (tmp0 == 0)
 			break;



