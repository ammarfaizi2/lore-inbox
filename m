Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264894AbUAZUip (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 15:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265094AbUAZUip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 15:38:45 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:31211 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S264894AbUAZUim
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 15:38:42 -0500
Date: Mon, 26 Jan 2004 13:38:30 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-rc1-mm3
Message-ID: <20040126203830.GA32525@stop.crashing.org>
References: <20040124180022.14fe495e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040124180022.14fe495e.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 24, 2004 at 06:00:22PM -0800, Andrew Morton wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc1/2.6.2-rc1-mm3/
> 
> - 2.6.2-rc1-mm3's allyesconfig now successfully builds with current gcc-3.5
>   CVS.  However allyesconfig doesn't link because of symbol clashes in IRDA.
> 
> - Various random fixes.

I sent this against -mm1, and no one commented on it, so I'm resending.

>From Tom Rini <trini@kernel.crashing.org>

Switch PPC32 over to drivers/Kconfig

 arch/ppc/Kconfig |   41 +----------------------------------------
 1 files changed, 1 insertion(+), 40 deletions(-)
--- 1.47/arch/ppc/Kconfig	Mon Jan 19 16:38:06 2004
+++ edited/arch/ppc/Kconfig	Thu Jan 22 13:47:15 2004
@@ -989,8 +989,6 @@
 
 source "drivers/pcmcia/Kconfig"
 
-source "drivers/parport/Kconfig"
-
 endmenu
 
 menu "Advanced setup"
@@ -1088,36 +1086,7 @@
 	depends on ADVANCED_OPTIONS && 8xx
 endmenu
 
-source "drivers/base/Kconfig"
-
-source "drivers/mtd/Kconfig"
-
-source "drivers/pnp/Kconfig"
-
-source "drivers/block/Kconfig"
-
-source "drivers/md/Kconfig"
-
-source "drivers/ide/Kconfig"
-
-source "drivers/scsi/Kconfig"
-
-source "drivers/message/fusion/Kconfig"
-
-source "drivers/ieee1394/Kconfig"
-
-source "drivers/message/i2o/Kconfig"
-
-source "net/Kconfig"
-
-source "drivers/isdn/Kconfig"
-
-source "drivers/video/Kconfig"
-
-source "drivers/cdrom/Kconfig"
-
-source "drivers/input/Kconfig"
-
+source "drivers/Kconfig"
 
 menu "Macintosh device drivers"
 
@@ -1253,14 +1222,8 @@
 
 endmenu
 
-source "drivers/char/Kconfig"
-
-source "drivers/media/Kconfig"
-
 source "fs/Kconfig"
 
-source "sound/Kconfig"
-
 source "arch/ppc/8xx_io/Kconfig"
 
 source "arch/ppc/8260_io/Kconfig"
@@ -1284,8 +1247,6 @@
 	default y
 
 endmenu
-
-source "drivers/usb/Kconfig"
 
 source "lib/Kconfig"
 
-- 
Tom Rini
http://gate.crashing.org/~trini/
