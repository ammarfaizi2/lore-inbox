Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbTDFWGo (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 18:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263138AbTDFWGo (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 18:06:44 -0400
Received: from pop.gmx.de ([213.165.65.60]:26191 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263129AbTDFWGl convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 18:06:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Karl Weigel <xml-22047@gmx.de>
To: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [PATCH] config/dep bugs
Date: Mon, 7 Apr 2003 00:18:49 +0200
User-Agent: KMail/1.4.3
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53L.0304041815110.32674@freak.distro.conectiva> <20030405224233.GA12746@werewolf.able.es> <20030405230600.GC12864@werewolf.able.es>
In-Reply-To: <20030405230600.GC12864@werewolf.able.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304070018.49185.xml-22047@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found these bugs too, but only when I start "make xconfig". Using "make 
menuconfig" does not produce these errors. May this be considered a bug in 
"make menuconfig"?

Kind regards
Karl Weigel




> On 04.06, J.A. Magallon wrote:
> > On 04.04, Marcelo Tosatti wrote:
> > > So here goes -pre7. Hopefully the last -pre.
>
> --- linux/drivers/net/Config.in.orig	2003-03-13 23:48:55.000000000 +0100
> +++ linux/drivers/net/Config.in	2003-03-13 23:49:33.000000000 +0100
> @@ -185,7 +185,7 @@
>        dep_tristate '    Davicom DM910x/DM980x support' CONFIG_DM9102
> $CONFIG_PCI dep_tristate '    EtherExpressPro/100 support (eepro100,
> original Becker driver)' CONFIG_EEPRO100 $CONFIG_PCI if [ "$CONFIG_VISWS" =
> "y" ]; then
> -         define_mbool CONFIG_EEPRO100_PIO y
> +         define_bool CONFIG_EEPRO100_PIO y
>        else
>           dep_mbool '      Use PIO instead of MMIO' CONFIG_EEPRO100_PIO
> $CONFIG_EEPRO100 fi
> --- linux/drivers/ide/Config.in.orig	2003-04-05 02:23:30.000000000 +0200
> +++ linux/drivers/ide/Config.in	2003-04-05 02:23:43.000000000 +0200
> @@ -43,7 +43,7 @@
>  	    define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_PCI
>  	    dep_bool '      ATA Work(s) In Progress (EXPERIMENTAL)'
> CONFIG_IDEDMA_PCI_WIP $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_EXPERIMENTAL #	   
> dep_bool '      Good-Bad DMA Model-Firmware (WIP)'
> CONFIG_IDEDMA_NEW_DRIVE_LISTINGS $CONFIG_IDEDMA_PCI_WIP -           
> dep_tristate '    Pacific Digital ADMA-100 basic support'
> CONFIG_BLK_DEV_ADMA100 +            dep_tristate '    Pacific Digital
> ADMA-100 basic support' CONFIG_BLK_DEV_ADMA100 $CONFIG_BLK_DEV_IDEDMA_PCI
> dep_tristate '    AEC62XX chipset support' CONFIG_BLK_DEV_AEC62XX
> $CONFIG_BLK_DEV_IDEDMA_PCI dep_tristate '    ALI M15x3 chipset support'
> CONFIG_BLK_DEV_ALI15X3 $CONFIG_BLK_DEV_IDEDMA_PCI dep_mbool    '      ALI
> M15x3 WDC support (DANGEROUS)' CONFIG_WDC_ALI15X3 $CONFIG_BLK_DEV_ALI15X3

