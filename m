Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264787AbTIDIDc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 04:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbTIDIDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 04:03:32 -0400
Received: from mail.skjellin.no ([80.239.42.67]:1927 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S264787AbTIDIDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 04:03:22 -0400
Message-ID: <3F56F1CC.3010402@tomt.net>
Date: Thu, 04 Sep 2003 10:03:24 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030820 Mozilla Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Tomt <andre@tomt.net>
CC: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org, mlindner@syskonnect.de
Subject: Re: [PATCH 2.4.23-pre4] Remove bogus SysKonnect config stuff (was
 Re: Linux 2.4.23-pre3)
References: <Pine.LNX.4.44.0309031851310.30503-100000@logos.cnet> <200309040847.16668.m.c.p@wolk-project.de> <3F56E998.3060500@tomt.net>
In-Reply-To: <3F56E998.3060500@tomt.net>
Content-Type: multipart/mixed;
 boundary="------------070605030808000406060900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070605030808000406060900
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andre Tomt wrote:

> Marc-Christian Petersen wrote:
> 
>>> Mirko Lindner:
>>>  o [netdrvr sk98lin] update to driver version 6.17
>>
>>
>>
>> this update introduces some bogus config.in stuff. None of the extra 
>> options are used in the source. The driver is equal for all of the 
>> listed cards.
>>
>> Further, I don't see any reason why all the supported cards should be 
>> a config.in option, they are listed in the help of the menu option.
>>
>> And I prefer to list SK-95xx in the menu selection also.
> 
> 
> If we're going to nuke those options, the Configure.help entries should 
> go away too. The attached trivial patch "fixes" this.

Erm, minor cosmetic knit, ignore the previous patch from me, this one 
also includes syncing the Configure.help header with mcp's Config.in.

--------------070605030808000406060900
Content-Type: text/plain;
 name="sk98lin-configure-help-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sk98lin-configure-help-2.patch"

diff -Naur linux-2.4.23-pre3/Documentation/Configure.help linux-2.4.23-pre3-1/Documentation/Configure.help
--- linux-2.4.23-pre3/Documentation/Configure.help	2003-09-04 09:15:44.000000000 +0200
+++ linux-2.4.23-pre3-1/Documentation/Configure.help	2003-09-04 09:53:15.000000000 +0200
@@ -11557,7 +11557,7 @@
 
   The safe and default value for this is N.
 
-Marvell Yukon / SysKonnect SK-98xx and SK-95xx Gigabit Ethernet Adapter family support
+SysKonnect SK-98xx / SK-95xx / Marvell Yukon Chipset Support
 CONFIG_SK98LIN
   Say Y here if you have a Marvell Yukon or SysKonnect SK-98xx/SK-95xx
   compliant Gigabit Ethernet Adapter. The following adapters are supported
@@ -11620,122 +11620,6 @@
   say M here and read Documentation/modules.txt. This is recommended.
   The module will be called sk98lin.o.
 
-Marvell Yukon Chipset
-CONFIG_SK98LIN_T1
-  This driver supports:
-
-  - 3Com 3C940 Gigabit LOM Ethernet Adapter
-  - 3Com 3C941 Gigabit LOM Ethernet Adapter
-
-  Questions concerning this driver may be addressed to:
-    linux@syskonnect.de
-
-SysKonnect SK98xx Support
-CONFIG_SK98LIN_T2
-  This driver supports:
-
-  - SK-9821 Gigabit Ethernet Server Adapter (SK-NET GE-T)
-  - SK-9822 Gigabit Ethernet Server Adapter (SK-NET GE-T dual link)
-  - SK-9841 Gigabit Ethernet Server Adapter (SK-NET GE-LX)
-  - SK-9842 Gigabit Ethernet Server Adapter (SK-NET GE-LX dual link)
-  - SK-9843 Gigabit Ethernet Server Adapter (SK-NET GE-SX)
-  - SK-9844 Gigabit Ethernet Server Adapter (SK-NET GE-SX dual link)
-  - SK-9861 Gigabit Ethernet Server Adapter (SK-NET GE-SX Volition)
-  - SK-9862 Gigabit Ethernet Server Adapter (SK-NET GE-SX Volition dual link)
-  - SK-9871 Gigabit Ethernet Server Adapter (SK-NET GE-ZX)
-  - SK-9872 Gigabit Ethernet Server Adapter (SK-NET GE-ZX dual link)
-
-  Questions concerning this driver may be addressed to:
-    linux@syskonnect.de
-
-SysKonnect SK98xx Support
-CONFIG_SK98LIN_T3
-  This driver supports:
-
-  - Allied Telesyn AT-2970SX Gigabit Ethernet Adapter
-  - Allied Telesyn AT-2970LX Gigabit Ethernet Adapter
-  - Allied Telesyn AT-2970TX Gigabit Ethernet Adapter
-  - Allied Telesyn AT-2971SX Gigabit Ethernet Adapter
-  - Allied Telesyn AT-2971T Gigabit Ethernet Adapter
-  - Allied Telesyn AT-2970SX/2SC Gigabit Ethernet Adapter
-  - Allied Telesyn AT-2970LX/2SC Gigabit Ethernet Adapter
-  - Allied Telesyn AT-2970TX/2TX Gigabit Ethernet Adapter
-
-  Questions concerning this driver may be addressed to:
-    linux@syskonnect.de
-
-Marvell Yukon Chipset
-CONFIG_SK98LIN_T4
-  This driver supports:
-
-  - Marvell RDK-8001 Adapter
-  - Marvell RDK-8002 Adapter
-  - Marvell RDK-8003 Adapter
-  - Marvell RDK-8004 Adapter
-  - Marvell RDK-8006 Adapter
-  - Marvell RDK-8007 Adapter
-  - Marvell RDK-8008 Adapter
-  - Marvell RDK-8009 Adapter
-  - Marvell RDK-8011 Adapter
-  - Marvell RDK-8012 Adapter
-
-  Questions concerning this driver may be addressed to:
-    linux@syskonnect.de
-
-Marvell Yukon Chipset
-CONFIG_SK98LIN_T5
-  This driver supports:
-
-  - SK-9521 V2.0 10/100/1000Base-T Adapter
-  - SK-9821 V2.0 Gigabit Ethernet 10/100/1000Base-T Adapter
-  - SK-9841 V2.0 Gigabit Ethernet 1000Base-LX Adapter
-  - SK-9843 V2.0 Gigabit Ethernet 1000Base-SX Adapter
-  - SK-9851 V2.0 Gigabit Ethernet 1000Base-SX Adapter
-  - SK-9861 V2.0 Gigabit Ethernet 1000Base-SX Adapter
-  - SK-9871 V2.0 Gigabit Ethernet 1000Base-ZX Adapter
-  - SK-9521 10/100/1000Base-T Adapter
-
-  Questions concerning this driver may be addressed to:
-    linux@syskonnect.de
-
-Marvell Yukon Chipset
-CONFIG_SK98LIN_T6
-  This driver supports:
-
-  - DGE-530T Gigabit Ethernet Adapter
-
-  Questions concerning this driver may be addressed to:
-    linux@syskonnect.de
-
-Marvell Yukon Chipset
-CONFIG_SK98LIN_T7
-  This driver supports:
-
-  - Marvell Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
-
-  Questions concerning this driver may be addressed to:
-    linux@syskonnect.de
-
-Marvell Yukon Chipset
-CONFIG_SK98LIN_T8
-  This driver supports:
-
-  - N-Way PCI-Bus Giga-Card 1000/100/10Mbps(L)
-
-  Questions concerning this driver may be addressed to:
-    linux@syskonnect.de
-
-Marvell Yukon Chipset
-CONFIG_SK98LIN_T9
-  This driver supports:
-
-  - EG1032 v2 Instant Gigabit Network Adapter
-  - EG1064 v2 Instant Gigabit Network Adapter
-
-  Questions concerning this driver may be addressed to:
-    linux@syskonnect.de
-
-
 Sun GEM support
 CONFIG_SUNGEM
   Support for the Sun GEM chip, aka Sun GigabitEthernet/P 2.0.  See also

--------------070605030808000406060900--

