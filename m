Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131410AbRC0QiN>; Tue, 27 Mar 2001 11:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131411AbRC0Qhx>; Tue, 27 Mar 2001 11:37:53 -0500
Received: from maestro.symsys.com ([208.223.9.37]:61202 "EHLO
	maestro.symsys.com") by vger.kernel.org with ESMTP
	id <S131410AbRC0Qhs>; Tue, 27 Mar 2001 11:37:48 -0500
Date: Tue, 27 Mar 2001 10:37:06 -0600 (CST)
From: Greg Ingram <ingram@symsys.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.2.19 drivers/net/Config.in
In-Reply-To: <3AC0BC80.DD6B2F4F@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0103271033300.21814-100000@maestro.symsys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Mar 2001, Jeff Garzik wrote:

> Greg Ingram wrote:
> > 
> > In 2.2.19 CONFIG_RTL8139 depends on CONFIG_EXPERIMENTAL.  The RTL8139
> > driver is not labelled as experimental.  Is this an error?
> 
> Yeah, add '(EXPERIMENTAL)' to the text.  Send a patch to Alan if you
> want...

Okay.  I really thought it would be the other way around, that is, that
the driver is no longer experimental.  Anyway, I also tagged the 8139too
driver as experimental.  Patch follows.

- Greg

--- linux/drivers/net/Config.in.orig	Tue Mar 27 10:26:52 2001
+++ linux/drivers/net/Config.in	Tue Mar 27 10:27:39 2001
@@ -98,10 +98,10 @@
     tristate 'NI6510 support' CONFIG_NI65
   fi
   if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-      tristate 'RealTek 8129/8139 (not 8019/8029!) support' CONFIG_RTL8139
+      tristate 'RealTek 8129/8139 (not 8019/8029!) support (EXPERIMENTAL)' CONFIG_RTL8139
   fi
   if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-      tristate 'Alternative RealTek 8139 driver (8139too) support' CONFIG_RTL8139TOO
+      tristate 'Alternative RealTek 8139 driver (8139too) support (EXPERIMENTAL)' CONFIG_RTL8139TOO
       if [ "$CONFIG_RTL8139TOO" != "n" ]; then
           bool '  Use PIO instead of MMIO' CONFIG_8139TOO_PIO
           bool '  Support for automatic channel equalization' CONFIG_8139TOO_TUNE_TWISTER

