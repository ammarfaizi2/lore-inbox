Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265746AbUFUHhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265746AbUFUHhc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 03:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265879AbUFUHhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 03:37:31 -0400
Received: from snickers.hotpop.com ([38.113.3.51]:30605 "EHLO
	snickers.hotpop.com") by vger.kernel.org with ESMTP id S265746AbUFUHhQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 03:37:16 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-mm1: empty help text for FB_RIVA_I2C
Date: Mon, 21 Jun 2004 15:38:33 +0800
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20040620174632.74e08e09.akpm@osdl.org> <20040621014002.GH27822@fs.tum.de>
In-Reply-To: <20040621014002.GH27822@fs.tum.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406211538.33446.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 June 2004 09:40, Adrian Bunk wrote:
> On Sun, Jun 20, 2004 at 05:46:32PM -0700, Andrew Morton wrote:
> >...
> > All 226 patches:
> >
> >
> > linus.patch
> >...
>
> FB_RIVA_I2C has an empty help text.
>
> Please add a help text with some information.
>

Ok.

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>

diff -Naur linux-2.6.7-rc3-mm2-orig/drivers/video/Kconfig linux-2.6.7-rc3-mm2/drivers/video/Kconfig
--- linux-2.6.7-rc3-mm2-orig/drivers/video/Kconfig	2004-06-21 07:22:00.113603640 +0000
+++ linux-2.6.7-rc3-mm2/drivers/video/Kconfig	2004-06-21 07:34:13.975039744 +0000
@@ -436,7 +436,14 @@
         bool "Enable DDC support"
 	depends on FB_RIVA && I2C
 	help
-
+	  This enables I2C support for nVidia Chipsets.  This is used
+	  only for getting EDID information from the attached display
+	  allowing for robust video mode handling and switching.
+
+	  Because fbdev-2.6 requires that drivers must be able to 
+	  independently validate video mode parameters, you should say Y
+	  here.	  
+	  	  
 config FB_I810
 	tristate "Intel 810/815 support (EXPERIMENTAL)"
 	depends on FB && AGP && AGP_INTEL && EXPERIMENTAL && PCI	


