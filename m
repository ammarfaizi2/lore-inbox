Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262440AbVAPHXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbVAPHXw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 02:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbVAPHXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 02:23:52 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27405 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262440AbVAPHXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 02:23:49 -0500
Date: Sun, 16 Jan 2005 08:23:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: "prem.de.ms" <prem.de.ms@gmx.de>, linux-kernel@vger.kernel.org,
       kraxel@bytesex.org, Radoslaw Szkodzinski <astralstorm@gmail.com>
Subject: Re: 2.6.10 compile error - blackbird_load_firmware (fwd)
Message-ID: <20050116072345.GQ4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below by Radoslaw Szkodzinski <astralstorm@gmail.com> still 
applies and seems to be still required in 2.6.11-rc1-mm1.


Signed-off-by: Adrian Bunk <bunk@stusta.de>



----- Forwarded message from Radoslaw Szkodzinski <astralstorm@gmail.com> -----

Date:	Mon, 3 Jan 2005 15:27:30 +0100
From: Radoslaw Szkodzinski <astralstorm@gmail.com>
To: "prem.de.ms" <prem.de.ms@gmx.de>
Cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: Re: 2.6.10 compile error - blackbird_load_firmware

On Monday 27 of December 2004 23:00, prem.de.ms wrote:
> Hello,
>
> I get the following error message when I try to compile the new
> 2.6.10-kernel:
>
> <snip>
> Seems like the Conexant drivers are broken because the kernel compiles
> when I uncheck them.
>
It seems Conexant uses the firmware loader as well as I2C w/o requiring them.
Patch attached.

--- linux/drivers/media/video/Kconfig~	2005-01-03 15:24:46.669675320 +0100
+++ linux/drivers/media/video/Kconfig	2005-01-03 15:24:46.680673445 +0100
@@ -303,8 +303,9 @@
 
 config VIDEO_CX88
 	tristate "Conexant 2388x (bt878 successor) support"
-	depends on VIDEO_DEV && PCI && EXPERIMENTAL
+	depends on VIDEO_DEV && PCI && I2C && EXPERIMENTAL
 	select I2C_ALGOBIT
+	select FW_LOADER
 	select VIDEO_BTCX
 	select VIDEO_BUF
 	select VIDEO_TUNER



----- End forwarded message -----


