Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVCMNUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVCMNUZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 08:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVCMNUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 08:20:25 -0500
Received: from chello081018222206.chello.pl ([81.18.222.206]:25874 "EHLO
	plus.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S261226AbVCMNUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 08:20:17 -0500
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [2.6.11.3] gcc4 / psmouse.h - compilation fix.
Date: Sun, 13 Mar 2005 14:20:11 +0100
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_M4DNCmsptEcjXTJ"
Message-Id: <200503131420.12554.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_M4DNCmsptEcjXTJ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Attched patch fixes gcc error:
`drivers/input/mouse/psmouse.h:40: error: field `ps2dev' has incomplete type`

Please apply.

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)

--Boundary-00=_M4DNCmsptEcjXTJ
Content-Type: text/x-diff;
  charset="utf-8";
  name="2.6.11.3-gcc4-psmouse.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="2.6.11.3-gcc4-psmouse.patch"

drivers/input/mouse/psmouse.h:40: error: field `ps2dev' has incomplete type

--- linux-2.6.11.3/drivers/input/mouse/psmouse.h.orig	2005-03-13 07:44:40.000000000 +0100
+++ linux-2.6.11.3/drivers/input/mouse/psmouse.h	2005-03-13 14:08:06.000000000 +0100
@@ -1,6 +1,8 @@
 #ifndef _PSMOUSE_H
 #define _PSMOUSE_H
 
+#include <linux/libps2.h>
+
 #define PSMOUSE_CMD_SETSCALE11	0x00e6
 #define PSMOUSE_CMD_SETSCALE21	0x00e7
 #define PSMOUSE_CMD_SETRES	0x10e8

--Boundary-00=_M4DNCmsptEcjXTJ--
