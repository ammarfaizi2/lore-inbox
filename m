Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264754AbTIDGyY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 02:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264767AbTIDGyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 02:54:24 -0400
Received: from [62.241.33.80] ([62.241.33.80]:6152 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264754AbTIDGyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 02:54:16 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.23-pre4] Remove bogus SysKonnect config stuff (was Re: Linux 2.4.23-pre3)
Date: Thu, 4 Sep 2003 08:47:16 +0200
User-Agent: KMail/1.5.3
References: <Pine.LNX.4.44.0309031851310.30503-100000@logos.cnet>
In-Reply-To: <Pine.LNX.4.44.0309031851310.30503-100000@logos.cnet>
Cc: mlindner@syskonnect.de
X-Operating-System: Linux 2.4.20-wolk4.10s i686 GNU/Linux
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0/tV/1r+DtAOQcc"
Message-Id: <200309040847.16668.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_0/tV/1r+DtAOQcc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 03 September 2003 23:53, Marcelo Tosatti wrote:

Hi Marcelo,

> Mirko Lindner:
>   o [netdrvr sk98lin] update to driver version 6.17

this update introduces some bogus config.in stuff. None of the extra options 
are used in the source. The driver is equal for all of the listed cards.

Further, I don't see any reason why all the supported cards should be a 
config.in option, they are listed in the help of the menu option.

And I prefer to list SK-95xx in the menu selection also.

Marcelo, please apply the attached patch.

ciao, Marc

--Boundary-00=_0/tV/1r+DtAOQcc
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.4-sk98lin-bogus-config.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.4-sk98lin-bogus-config.patch"

--- a/drivers/net/Config.in	2003-09-04 08:38:09.000000000 +0200
+++ b/drivers/net/Config.in	2003-09-04 08:38:49.000000000 +0200
@@ -268,18 +268,7 @@ dep_tristate 'National Semiconductor DP8
 dep_tristate 'Packet Engines Hamachi GNIC-II support' CONFIG_HAMACHI $CONFIG_PCI
 dep_tristate 'Packet Engines Yellowfin Gigabit-NIC support (EXPERIMENTAL)' CONFIG_YELLOWFIN $CONFIG_PCI $CONFIG_EXPERIMENTAL
 dep_tristate 'Realtek 8169 Gigabit Ethernet support' CONFIG_R8169 $CONFIG_PCI
-dep_tristate 'Marvell Yukon Chipset / SysKonnect SK-98xx Support' CONFIG_SK98LIN $CONFIG_PCI
-if [ "$CONFIG_SK98LIN" != "n" ]; then
-   bool '  3Com 3C940/3C941 Gigabit Ethernet Adapter' CONFIG_SK98LIN_T1
-   bool '  Allied Telesyn AT-29xx Gigabit Ethernet Adapter' CONFIG_SK98LIN_T3
-   bool '  CNet N-Way Gigabit Ethernet Adapter' CONFIG_SK98LIN_T8
-   bool '  D-Link DGE-530T Gigabit Ethernet Adapter' CONFIG_SK98LIN_T6
-   bool '  Linksys EG10xx Ethernet Server Adapter' CONFIG_SK98LIN_T9
-   bool '  Marvell RDK-80xx Adapter' CONFIG_SK98LIN_T4
-   bool '  Marvell Yukon Gigabit Ethernet Adapter' CONFIG_SK98LIN_T7
-   bool '  SysKonnect SK-98xx Server Gigabit Adapter' CONFIG_SK98LIN_T2
-   bool '  SysKonnect SK-98xx V2.0 Gigabit Ethernet Adapter' CONFIG_SK98LIN_T5
-fi
+dep_tristate 'SysKonnect SK-98xx / SK-95xx / Marvell Yukon Chipset Support' CONFIG_SK98LIN $CONFIG_PCI
 dep_tristate 'Broadcom Tigon3 support' CONFIG_TIGON3 $CONFIG_PCI
 
 if [ "$CONFIG_MOMENCO_OCELOT_C" = "y" -o "$CONFIG_MOMENCO_JAGUAR_ATX" = "y" ]; then

--Boundary-00=_0/tV/1r+DtAOQcc--


