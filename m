Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318723AbSHAMpa>; Thu, 1 Aug 2002 08:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318729AbSHAMpa>; Thu, 1 Aug 2002 08:45:30 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:781 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id <S318723AbSHAMp3>;
	Thu, 1 Aug 2002 08:45:29 -0400
Date: Thu, 1 Aug 2002 14:48:36 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Willy TARREAU <willy@w.ods.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.4.19-rc5
Message-ID: <20020801124836.GA186@pcw.home.local>
References: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva> <20020801113205.GA9532@pcw.home.local> <1028210044.15022.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028210044.15022.12.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 02:54:04PM +0100, Alan Cox wrote:
> On Thu, 2002-08-01 at 12:32, Willy TARREAU wrote:
> > Hi Marcello,
> > 
> > This is just a cleanup for the network devices configuration.
> > Basically, the TOSHIBA TC35815 configuration entry appears
> > just between DECchip Tulip, and the 2 Tulip-specific config lines
> > which are indented so we could think that they are related to
> > the TC35815 instead of the Tulip.
> 
> This is true, but the fix wants tweaking - the file is supposed to bein
> basically Alphabetical order. Can you move the toshiba one down instead
> ?

OK, in this case it goes just before VIA rhine. (BTW, [P]CI NE2000 is before
[N]ovell, but I assume we're talking about [N]E2000).

Marcelo, please ignore my previous patch in favor of this one.

Cheers,
Willy

--- linux-2.4.19-rc5/drivers/net/Config.in.orig	Thu Aug  1 14:43:09 2002
+++ linux-2.4.19-rc5/drivers/net/Config.in	Thu Aug  1 14:44:29 2002
@@ -163,7 +163,6 @@
       dep_tristate '    Apricot Xen-II on board Ethernet' CONFIG_APRICOT $CONFIG_ISA
       dep_tristate '    CS89x0 support' CONFIG_CS89x0 $CONFIG_ISA
       dep_tristate '    DECchip Tulip (dc21x4x) PCI support' CONFIG_TULIP $CONFIG_PCI
-      dep_tristate '    TOSHIBA TC35815 Ethernet support' CONFIG_TC35815 $CONFIG_PCI
       if [ "$CONFIG_TULIP" = "y" -o "$CONFIG_TULIP" = "m" ]; then
          dep_bool '      New bus configuration (EXPERIMENTAL)' CONFIG_TULIP_MWI $CONFIG_EXPERIMENTAL
          bool '      Use PCI shared mem for NIC registers' CONFIG_TULIP_MMIO
@@ -195,6 +194,7 @@
       if [ "$CONFIG_PCI" = "y" -o "$CONFIG_EISA" = "y" ]; then
          tristate '    TI ThunderLAN support' CONFIG_TLAN
       fi
+      dep_tristate '    TOSHIBA TC35815 Ethernet support' CONFIG_TC35815 $CONFIG_PCI
       dep_tristate '    VIA Rhine support' CONFIG_VIA_RHINE $CONFIG_PCI
       dep_mbool '      Use MMIO instead of PIO (EXPERIMENTAL)' CONFIG_VIA_RHINE_MMIO $CONFIG_VIA_RHINE $CONFIG_EXPERIMENTAL
       dep_tristate '    Winbond W89c840 Ethernet support' CONFIG_WINBOND_840 $CONFIG_PCI

