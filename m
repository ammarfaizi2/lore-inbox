Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265911AbUBBTm5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 14:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265913AbUBBTm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 14:42:57 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:14415 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S265911AbUBBTmy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:42:54 -0500
X-BrightmailFiltered: true
Date: Mon, 2 Feb 2004 20:42:51 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 8/42]
Message-ID: <20040202194251.GH6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


cpqfcTSi2c.c:62: warning: `i2c_delay' declared `static' but never defined

i2c_delay isn't defined, remove useless prototype.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/scsi/cpqfcTSi2c.c linux-2.4/drivers/scsi/cpqfcTSi2c.c
--- linux-2.4-vanilla/drivers/scsi/cpqfcTSi2c.c	Fri Jun 13 16:51:36 2003
+++ linux-2.4/drivers/scsi/cpqfcTSi2c.c	Sat Jan 31 17:00:03 2004
@@ -59,7 +59,6 @@
 #define SLAVE_WRITE_ADDRESS	0xA0
 
 
-static void i2c_delay(u32 mstime);
 static void tl_i2c_clock_pulse(u8, void *GPIOout);
 static u8 tl_read_i2c_data(void *);
 
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
You and me baby ain't nothin' but mammals
So let's do it like they do on the Discovery Channel
