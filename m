Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbTEVXdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 19:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbTEVXdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 19:33:12 -0400
Received: from aneto.able.es ([212.97.163.22]:56472 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S263424AbTEVXdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 19:33:11 -0400
Date: Fri, 23 May 2003 01:46:13 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc3
Message-ID: <20030522234613.GA2473@werewolf.able.es>
References: <Pine.LNX.4.55L.0305221915450.1975@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.55L.0305221915450.1975@freak.distro.conectiva>; from marcelo@conectiva.com.br on Fri, May 23, 2003 at 00:19:38 +0200
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.23, Marcelo Tosatti wrote:
> 
> Hi,
> 
> Here goes the third release candidate of 2.4.21.
> 
> 

--- linux/drivers/ide/Config.in.orig	2003-05-23 01:42:20.000000000 +0200
+++ linux/drivers/ide/Config.in	2003-05-23 01:42:37.000000000 +0200
@@ -66,7 +66,7 @@
 	    dep_bool     '      Special UDMA Feature' CONFIG_PDC202XX_BURST $CONFIG_BLK_DEV_PDC202XX_OLD $CONFI_BLK_DEV_IDEDMA_PCI
 	    dep_tristate '    PROMISE PDC202{68|69|70|71|75|76|77} support' CONFIG_BLK_DEV_PDC202XX_NEW $CONFIG_BLK_DEV_IDEDMA_PCI
 		# FIXME - probably wants to be one for old and for new
-	    dep_bool     '    Special FastTrak Feature' CONFIG_PDC202XX_FORCE
+	    dep_bool     '    Special FastTrak Feature' CONFIG_PDC202XX_FORCE $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_tristate '    RZ1000 chipset bugfix/support' CONFIG_BLK_DEV_RZ1000 $CONFIG_X86
 	    dep_tristate '    SCx200 chipset support' CONFIG_BLK_DEV_SC1200 $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_tristate '    ServerWorks OSB4/CSB5/CSB6 chipsets support' CONFIG_BLK_DEV_SVWKS $CONFIG_BLK_DEV_IDEDMA_PCI


Plz, could you run make xconfig sometime ? I know it is too friendly for
kernel hackers...

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-rc2-jam2 (gcc 3.2.3 (Mandrake Linux 9.2 3.2.3-1mdk))
