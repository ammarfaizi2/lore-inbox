Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbUFJPEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUFJPEA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 11:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbUFJPEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 11:04:00 -0400
Received: from witte.sonytel.be ([80.88.33.193]:41364 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261426AbUFJPD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 11:03:56 -0400
Date: Thu, 10 Jun 2004 17:03:35 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       "James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
       Go Taniguchi <go@turbolinux.co.jp>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: SCSI_DPT_I2O (was: Re: Linux 2.6.7-rc2)
In-Reply-To: <Pine.LNX.4.58.0405292349110.1632@ppc970.osdl.org>
Message-ID: <Pine.GSO.4.58.0406101659430.19315@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0405292349110.1632@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 May 2004, Linus Torvalds wrote:
> Summary of changes from v2.6.7-rc1 to v2.6.7-rc2
> ============================================
> Go Taniguchi:
>   o Fix dpt_i2o

I have the impression SCSI_DPT_I2O should depend on PCI.

--- linux-2.6.7-rc3/drivers/scsi/Kconfig	2004-06-09 14:50:53.000000000 +0200
+++ linux-m68k-2.6.7-rc3/drivers/scsi/Kconfig	2004-06-10 11:01:45.000000000 +0200
@@ -352,7 +352,7 @@ source "drivers/scsi/aic7xxx/Kconfig.aic
 # All the I2O code and drivers do not seem to be 64bit safe.
 config SCSI_DPT_I2O
 	tristate "Adaptec I2O RAID support "
-	depends on !64BIT && SCSI
+	depends on !64BIT && SCSI && PCI
 	help
 	  This driver supports all of Adaptec's I2O based RAID controllers as
 	  well as the DPT SmartRaid V cards.  This is an Adaptec maintained

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
