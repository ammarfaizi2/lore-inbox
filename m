Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266679AbUAWT5S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 14:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266680AbUAWT5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 14:57:18 -0500
Received: from smtp-105-friday.noc.nerim.net ([62.4.17.105]:38662 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S266679AbUAWT5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 14:57:14 -0500
Date: Fri, 23 Jan 2004 20:57:15 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Luca Risolia <luca.risolia@studio.unibo.it>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Overflow in w9968cf driver (kernel 2.6.2-rc1)
Message-Id: <20040123205715.4cc1fba4.khali@linux-fr.org>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca, hi list,

I think I've found a possible overflow in w9968cf.c (kernel 2.6.2-rc1).
Proposed fix follows (also fixes a typo).

--- linux-2.6.2-rc1/drivers/usb/media/w9968cf.c.orig	2004-01-23 11:28:56 +0100
+++ linux-2.6.2-rc1/drivers/usb/media/w9968cf.c	2004-01-23 13:47:44 +0100
@@ -98,7 +98,7 @@
 static int specific_debug = W9968CF_SPECIFIC_DEBUG;
 #endif
 
-static unsigned int param_nv[23]; /* number of values per paramater */
+static unsigned int param_nv[24]; /* number of values per parameter */
 
 module_param(vppmod_load, bool, 0444);
 module_param(simcams, ushort, 0444);


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
