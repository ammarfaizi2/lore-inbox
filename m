Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318701AbSHAL24>; Thu, 1 Aug 2002 07:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318703AbSHAL24>; Thu, 1 Aug 2002 07:28:56 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:60940 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S318701AbSHAL24>;
	Thu, 1 Aug 2002 07:28:56 -0400
Date: Thu, 1 Aug 2002 13:32:05 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.4.19-rc5
Message-ID: <20020801113205.GA9532@pcw.home.local>
References: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcello,

This is just a cleanup for the network devices configuration.
Basically, the TOSHIBA TC35815 configuration entry appears
just between DECchip Tulip, and the 2 Tulip-specific config lines
which are indented so we could think that they are related to
the TC35815 instead of the Tulip.

You only see them when Tulip is enabled though.

Here is the obvious fix against -rc5 which avoids this confusion :

Cheers,
Willy

--- linux-2.4.19-rc5/drivers/net/Config.in.orig	Thu Aug  1 13:26:58 2002
+++ linux-2.4.19-rc5/drivers/net/Config.in	Thu Aug  1 13:27:14 2002
@@ -162,8 +162,8 @@
 
       dep_tristate '    Apricot Xen-II on board Ethernet' CONFIG_APRICOT $CONFIG_ISA
       dep_tristate '    CS89x0 support' CONFIG_CS89x0 $CONFIG_ISA
-      dep_tristate '    DECchip Tulip (dc21x4x) PCI support' CONFIG_TULIP $CONFIG_PCI
       dep_tristate '    TOSHIBA TC35815 Ethernet support' CONFIG_TC35815 $CONFIG_PCI
+      dep_tristate '    DECchip Tulip (dc21x4x) PCI support' CONFIG_TULIP $CONFIG_PCI
       if [ "$CONFIG_TULIP" = "y" -o "$CONFIG_TULIP" = "m" ]; then
          dep_bool '      New bus configuration (EXPERIMENTAL)' CONFIG_TULIP_MWI $CONFIG_EXPERIMENTAL
          bool '      Use PCI shared mem for NIC registers' CONFIG_TULIP_MMIO

