Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVBGDIC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVBGDIC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 22:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVBGDIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 22:08:02 -0500
Received: from smtp815.mail.sc5.yahoo.com ([66.163.170.1]:45667 "HELO
	smtp815.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261345AbVBGDHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 22:07:50 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-input@atrey.karlin.mff.cuni.cz
Subject: [PATCH] twiddler compile fix.
Date: Sun, 6 Feb 2005 22:07:48 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502062207.49276.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Somehow this part of one of the earlier patches was lost...

-- 
Dmitry


===================================================================


ChangeSet@1.2122, 2005-02-06 20:25:21-05:00, dtor_core@ameritech.net
  Input: fix compie error in twidjoy.c
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 twidjoy.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)


===================================================================



diff -Nru a/drivers/input/joystick/twidjoy.c b/drivers/input/joystick/twidjoy.c
--- a/drivers/input/joystick/twidjoy.c	2005-02-06 21:56:05 -05:00
+++ b/drivers/input/joystick/twidjoy.c	2005-02-06 21:56:05 -05:00
@@ -58,7 +58,9 @@
 #include <linux/serio.h>
 #include <linux/init.h>
 
-MODULE_DESCRIPTION("Handykey Twiddler keyboard as a joystick driver");
+#define DRIVER_DESC	"Handykey Twiddler keyboard as a joystick driver"
+
+MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
 /*
