Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264559AbSIVVvd>; Sun, 22 Sep 2002 17:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264561AbSIVVvd>; Sun, 22 Sep 2002 17:51:33 -0400
Received: from bigglesworth.mail.be.easynet.net ([212.100.160.67]:19082 "EHLO
	bigglesworth.mail.be.easynet.net") by vger.kernel.org with ESMTP
	id <S264559AbSIVVvd>; Sun, 22 Sep 2002 17:51:33 -0400
Message-ID: <3D8E3D32.2000707@easynet.be>
Date: Sun, 22 Sep 2002 23:59:14 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@easynet.be>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel mailing list <linux-kernel@vger.kernel.org>
CC: greg@kroah.com
Subject: [PATCH] #include <linux/version.h> missing in drivers/usb/host/ohci-hcd.c
References: <Pine.LNX.4.33.0209212130360.2433-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

compile fails with the following message:

	> In file included from ohci-hcd.c:136:
	> ohci-dbg.c:318: parse error
	> make[3]: *** [ohci-hcd.o] Error 1

due to a missing #include <linux/version.h>

Here is a trivial patch for this.

--- linux-2.5.38/drivers/usb/host/ohci-hcd.c    Sun Sep 22 06:25:00 2002
+++ l-2.5.38/drivers/usb/host/ohci-hcd.c        Sun Sep 22 23:47:37 2002
@@ -92,6 +92,7 @@
  #endif

  #include <linux/usb.h>
+#include <linux/version.h>
  #include "../core/hcd.h"

  #include <asm/io.h>

