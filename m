Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVCOROL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVCOROL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 12:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVCOROJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 12:14:09 -0500
Received: from aun.it.uu.se ([130.238.12.36]:55248 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261542AbVCORNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 12:13:37 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16951.6077.612190.675720@alkaid.it.uu.se>
Date: Tue, 15 Mar 2005 18:13:33 +0100
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.6.11] generic_serial.h gcc4 fix
Cc: R.E.Wolff@BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix

drivers/char/generic_serial.c:38: error: static declaration of 'gs_debug' follows non-static declaration
include/linux/generic_serial.h:94: error: previous declaration of 'gs_debug' was here

compilation error from gcc4 in generic_serial.h.

/Mikael

--- linux-2.6.11/include/linux/generic_serial.h.~1~	2005-03-02 19:24:19.000000000 +0100
+++ linux-2.6.11/include/linux/generic_serial.h	2005-03-15 17:11:07.000000000 +0100
@@ -91,6 +91,4 @@ int  gs_setserial(struct gs_port *port, 
 int  gs_getserial(struct gs_port *port, struct serial_struct __user *sp);
 void gs_got_break(struct gs_port *port);
 
-extern int gs_debug;
-
 #endif
