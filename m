Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262906AbSJBBdd>; Tue, 1 Oct 2002 21:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262921AbSJBBdd>; Tue, 1 Oct 2002 21:33:33 -0400
Received: from bigglesworth.mail.be.easynet.net ([212.100.160.67]:33252 "EHLO
	bigglesworth.mail.be.easynet.net") by vger.kernel.org with ESMTP
	id <S262906AbSJBBdc>; Tue, 1 Oct 2002 21:33:32 -0400
Message-ID: <3D9A4EFD.60703@easynet.be>
Date: Wed, 02 Oct 2002 03:42:21 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@easynet.be>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel mailing list <linux-kernel@vger.kernel.org>
CC: Greg KH <greg@kroah.com>
Subject: [PATCH] 2.5.40: warning fix for drivers/usb/core/usb.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

usb_hotplug()' prototype doesn't match when CONFIG_HOTPLUG is not defined.
Here is the patch:

Regards,

Luc Van Oostenryck


diff -ur linux-2.5.40/drivers/usb/core/usb.c l-2.5.40/drivers/usb/core/usb.c
--- linux-2.5.40/drivers/usb/core/usb.c Wed Oct  2 00:35:06 2002
+++ l-2.5.40/drivers/usb/core/usb.c     Wed Oct  2 00:47:22 2002
@@ -624,7 +624,7 @@
  #else

  static int usb_hotplug (struct device *dev, char **envp,
-                       char *buffer, int buffer_size)
+                       int num_envp, char *buffer, int buffer_size)
  {
         return -ENODEV;
  }

