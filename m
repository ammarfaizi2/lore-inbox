Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266570AbUG0SxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266570AbUG0SxI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 14:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266554AbUG0SxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 14:53:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52866 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266558AbUG0SmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 14:42:11 -0400
Date: Tue, 27 Jul 2004 11:42:05 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: <marcelo.tosatti@cyclades.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: USB: correct dbg() arguments in pl2303
Message-Id: <20040727114205.3c877336@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch by Phil Dibowitz.

diff -urp -X dontdiff linux-2.4.27-rc3/drivers/usb/serial/pl2303.c linux-2.4.27-rc3-usbx/drivers/usb/serial/pl2303.c
--- linux-2.4.27-rc3/drivers/usb/serial/pl2303.c	2004-07-25 23:00:17.000000000 -0700
+++ linux-2.4.27-rc3-usbx/drivers/usb/serial/pl2303.c	2004-07-27 11:07:39.000000000 -0700
@@ -652,7 +652,7 @@ static void pl2303_break_ctl (struct usb
 		state = BREAK_OFF;
 	else
 		state = BREAK_ON;
-	dbg("%s - turning break %s", state==BREAK_OFF ? "off" : "on", __FUNCTION__);
+	dbg("%s - turning break %s", __FUNCTION__, state==BREAK_OFF ? "off" : "on");
 
 	result = usb_control_msg (serial->dev, usb_sndctrlpipe (serial->dev, 0),
 				  BREAK_REQUEST, BREAK_REQUEST_TYPE, state, 
