Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbTE2Qwp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 12:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbTE2QvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 12:51:19 -0400
Received: from air-2.osdl.org ([65.172.181.6]:10148 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262373AbTE2QvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 12:51:04 -0400
Subject: [2.5.70][PATCH][TRIVIAL][USB] usbaudio.c, usbmixer.c : fix
	strlcat() arg2 type
From: Andy Pfiffer <andyp@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1054227831.12658.16.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 29 May 2003 10:03:52 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or
higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1428  -> 1.1429 
#	sound/usb/usbmixer.c	1.13    -> 1.14   
#	sound/usb/usbaudio.c	1.35    -> 1.36   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/29	andyp@andyp.pdx.osdl.net	1.1429
# Eliminate compile-time warnings.
# --------------------------------------------
#
diff -Nru a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
--- a/sound/usb/usbaudio.c	Thu May 29 09:57:35 2003
+++ b/sound/usb/usbaudio.c	Thu May 29 09:57:35 2003
@@ -2413,7 +2413,7 @@
 		}
 	}
 	if (len > 0)
-		strlcat(card->longname, ' ', sizeof(card->longname));
+		strlcat(card->longname, " ", sizeof(card->longname));
 
 	len = strlen(card->longname);
 
diff -Nru a/sound/usb/usbmixer.c b/sound/usb/usbmixer.c
--- a/sound/usb/usbmixer.c	Thu May 29 09:57:35 2003
+++ b/sound/usb/usbmixer.c	Thu May 29 09:57:35 2003
@@ -1191,7 +1191,7 @@
 			if (! len)
 				strlcpy(kctl->id.name, name, sizeof(kctl->id.name));
 		}
-		strlcat(kctl->id.name, ' ', sizeof(kctl->id.name));
+		strlcat(kctl->id.name, " ", sizeof(kctl->id.name));
 		strlcat(kctl->id.name, valinfo->suffix, sizeof(kctl->id.name));
 
 		snd_printdd(KERN_INFO "[%d] PU [%s] ch = %d, val = %d/%d\n",



