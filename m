Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265570AbTFMWUf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 18:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265571AbTFMWUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 18:20:34 -0400
Received: from dat.etsit.upm.es ([138.100.17.73]:30680 "HELO dat.etsit.upm.es")
	by vger.kernel.org with SMTP id S265570AbTFMWU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 18:20:28 -0400
Date: Sat, 14 Jun 2003 00:34:09 +0200
From: Carlos Valdivia =?iso-8859-15?Q?Yag=FCe?= 
	<valyag@dat.etsit.upm.es>
To: linux-kernel@vger.kernel.org
Subject: cs46xx compile failure in 2.4.21
Message-ID: <20030613223409.GA10618@dat.etsit.upm.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

cs46xx.c doesn't compile in 2.4.21 with gcc 3.3:

cs46xx.c:950: error: long, short, signed or unsigned used invalidly for `off'
cs46xx.c:951: error: long, short, signed or unsigned used invalidly for `val'
cs46xx.c: In function `cs_ac97_init':

This patch fixes compilation issue and works fine for my soundcard:

--- linux-2.4.21/drivers/sound/cs46xx.c.orig	2003-06-13 23:29:53.000000000 +0200
+++ linux-2.4.21/drivers/sound/cs46xx.c	2003-06-13 23:37:49.000000000 +0200
@@ -947,8 +947,8 @@
 
 struct InitStruct
 {
-    u32 long off;
-    u32 long val;
+    u32 off;
+    u32 val;
 } InitArray[] = { {0x00000040, 0x3fc0000f},
                   {0x0000004c, 0x04800000},

Best regards.

-- 
Carlos Valdivia Yagüe <valyag@dat.etsit.upm.es>
