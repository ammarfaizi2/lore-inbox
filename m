Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268546AbTANC6v>; Mon, 13 Jan 2003 21:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268527AbTANCqT>; Mon, 13 Jan 2003 21:46:19 -0500
Received: from dp.samba.org ([66.70.73.150]:28556 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268526AbTANCqA>;
	Mon, 13 Jan 2003 21:46:00 -0500
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [TRIVIAL] [Tiny PATCH]driver_char_Kconfig bug (fwd)
Date: Tue, 14 Jan 2003 13:27:23 +1100
Message-Id: <20030114025452.74FCA2C3A2@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Roman, I've put you down as maintainer for *Kconfig*, so any trivial
  patches which touch those files get CC'd to you.  Is that OK? --RR ]

From:  Adrian Bunk <bunk@fs.tum.de>

  Hi Linus,
  
  the issue described in the mail forwarded below is still present in 
  2.5.54. Please apply the simple patch supplied there.
  
  TIA
  Adrian
  
  
  ----- Forwarded message from Rusty Lynch <rusty@stinkycat.com> -----
  
  Date:	Fri, 22 Nov 2002 21:56:12 -0800
  From: Rusty Lynch <rusty@stinkycat.com>
  To: esr@thyrsus.com
  Cc: linux-kernel@vger.kernel.org
  Subject: [Tiny PATCH]driver/char/Kconfig bug
  
  VT support requires drivers/char/keyboard.c which makes function
  calls implemented in drivers/input/, so that attempting to set
  CONFIG_INPUT=m or just not setting CONFIG_INPUT will result in a 
  compile error if CONFIG_VT is on.
  
  Here is a trivial patch against 2.5.49.
  
  	-rustyl
  

--- trivial-2.5.57/drivers/char/Kconfig.orig	2003-01-14 12:11:57.000000000 +1100
+++ trivial-2.5.57/drivers/char/Kconfig	2003-01-14 12:11:57.000000000 +1100
@@ -6,6 +6,7 @@
 
 config VT
 	bool "Virtual terminal"
+	requires INPUT=y
 	---help---
 	  If you say Y here, you will get support for terminal devices with
 	  display and keyboard devices. These are called "virtual" because you
-- 
  Don't blame me: the Monkey is driving
  File: Adrian Bunk <bunk@fs.tum.de>: [Tiny PATCH]driver_char_Kconfig bug (fwd)
