Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272371AbRH3Ruj>; Thu, 30 Aug 2001 13:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272372AbRH3Ru3>; Thu, 30 Aug 2001 13:50:29 -0400
Received: from mclean.mail.mindspring.net ([207.69.200.57]:17157 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S272371AbRH3RuT>; Thu, 30 Aug 2001 13:50:19 -0400
Subject: Re: Linux 2.4.9-ac4
From: Robert Love <rml@tech9.net>
To: Alan Cox <laughing@shared-source.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010830154637.A4570@lightning.swansea.linux.org.uk>
In-Reply-To: <20010830154637.A4570@lightning.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.21.23.41 (Preview Release)
Date: 30 Aug 2001 13:50:35 -0400
Message-Id: <999193838.3255.3.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-08-30 at 10:46, Alan Cox wrote:
> 2.4.9-ac4
> <snip>

`make xconfig' fails on 2.4.9-ac4 with:
drivers/video/Config.in: 359: unterminated 'if' condition

...someone forgot a /.  following patch fixes it:


--- linux-2.4.9-ac4/drivers/video/Config.in	Thu Aug 30 13:22:04 2001
+++ linux/drivers/video/Config.in	Thu Aug 30 13:45:47 2001
@@ -356,7 +356,7 @@
 	   "$CONFIG_FB_RIVA" = "y" -o "$CONFIG_FB_ATY128" = "y" -o \
 	   "$CONFIG_FB_FM2" = "y" -o "$CONFIG_FB_SGIVW" = "y" -o \
 	   "$CONFIG_FB_RADEON" = "y" -o "$CONFIG_FB_PVR2" = "y" -o \
-	   "$CONFIG_FB_3DFX" = "y" -o "$CONFIG_FB_SIS" = "y" -o 
+	   "$CONFIG_FB_3DFX" = "y" -o "$CONFIG_FB_SIS" = "y" -o \
 	   "$CONFIG_FB_VOODOO1" = "y" ]; then
 	 define_tristate CONFIG_FBCON_CFB32 y
       else


-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

