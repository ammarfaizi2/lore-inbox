Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267467AbTANG2R>; Tue, 14 Jan 2003 01:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267468AbTANG2R>; Tue, 14 Jan 2003 01:28:17 -0500
Received: from gw.lowendale.com.au ([203.26.242.120]:20496 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S267467AbTANG2Q>; Tue, 14 Jan 2003 01:28:16 -0500
Date: Tue, 14 Jan 2003 17:34:49 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, Jean Tourrilhes <jt@hpl.hp.com>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: [TRIVIAL 2.2] CONFIG_NET_RADIO and Wireless Extensions
Message-ID: <Pine.LNX.4.05.10301141720390.27512-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Configure.help in 2.2 appearss, er, "misleading" re the implications of
CONFIG_NET_RADIO as selecting CONFIG_NET_RADIO (at least) includes the
/proc/net/wireless stuff in net/core/dev.c. Appended patch lifts
apparently more correct text from 2.4.

Lastly, both 2.2 and 2.4 refer to ftp://shadow.cabi.net/pub/Linux - AFAICS
shadow.cabi.net no longer exists.  I presume this should be
updated/dropped too?

Regards,
Neale.

--- linux-2.2.24-rc1-ntb1/Documentation/Configure.help	Fri Jan  3 08:43:03 2003
+++ linux-2.2.24-rc1-ntb1a/Documentation/Configure.help	Tue Jan 14 17:04:20 2003
@@ -5715,14 +5715,24 @@
   modules". If unsure, say N.
 
 Wireless LAN (non-hamradio)
 CONFIG_NET_RADIO
   Support for wireless LANs and everything having to do with radio,
-  but not with amateur radio. Note that the answer to this question
-  won't directly affect the kernel: saying N will just cause this
-  configure script to skip all the questions about radio
-  interfaces. 
+  but not with amateur radio or FM broadcasting.
+
+  Saying Y here also enables the Wireless Extensions (creates
+  /proc/net/wireless and enables ifconfig access). The Wireless
+  Extension is a generic API allowing a driver to expose to the user
+  space configuration and statistics specific to common Wireless LANs.
+  The beauty of it is that a single set of tool can support all the
+  variations of Wireless LANs, regardless of their type (as long as
+  the driver supports Wireless Extension). Another advantage is that
+  these parameters may be changed on the fly without restarting the
+  driver (or Linux). If you wish to use Wireless Extensions with
+  wireless PCMCIA (PC-) cards, you need to say Y here; you can fetch
+  the tools from
+  <http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html>.
 
   Some user-level drivers for scarab devices which don't require
   special kernel support are available via FTP (user: anonymous) from
   ftp://shadow.cabi.net/pub/Linux.
 

