Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266347AbRGFKZw>; Fri, 6 Jul 2001 06:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266356AbRGFKZm>; Fri, 6 Jul 2001 06:25:42 -0400
Received: from main.braxis.co.uk ([213.77.40.29]:10515 "EHLO main.braxis.co.uk")
	by vger.kernel.org with ESMTP id <S266347AbRGFKZb>;
	Fri, 6 Jul 2001 06:25:31 -0400
Date: Fri, 6 Jul 2001 12:25:20 +0200
From: Krzysztof Rusocki <kszysiu@braxis.co.uk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] hgafb.c as module (unresolved symbol) 2.4.6+
Message-ID: <20010706122520.A22693@main.braxis.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

As far as i noticed - since 2.4.6
there should be defined

#define INCLUDE_LINUX_LOGO_DATA

instead of

#define INCLUDE_LINUX_LOGOBW

otherwise linux logos do not get included and unresolved symbol occures

patch against 2.4.7-pre{1,2,3} attached, which afaik also applies for 2.4.6


PS.
in any case - please CC - not subscribed

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hgafb.c.diff"

--- linux/drivers/video/hgafb.c.orig	Thu Feb 22 22:09:04 2001
+++ linux/drivers/video/hgafb.c	Fri Jul  6 12:08:54 2001
@@ -49,7 +49,7 @@
 
 #ifdef MODULE
 
-#define INCLUDE_LINUX_LOGOBW
+#define INCLUDE_LINUX_LOGO_DATA
 #include <linux/linux_logo.h>
 
 #endif /* MODULE */

--XsQoSWH+UP9D9v3l--
