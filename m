Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264770AbTIDG4W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 02:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264772AbTIDG4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 02:56:21 -0400
Received: from [62.241.33.80] ([62.241.33.80]:6408 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264770AbTIDG4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 02:56:18 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Supphachoke Suntiwichaya <mrchoke@opentle.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: [PATCH 2.4.23-pre4] Fixup 'make xconfig' (was Re: Linux 2.4.23-pre3)
Date: Thu, 4 Sep 2003 08:52:23 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0309031851310.30503-100000@logos.cnet> <3F56AF00.8030002@opentle.org>
In-Reply-To: <3F56AF00.8030002@opentle.org>
X-Operating-System: Linux 2.4.20-wolk4.10s i686 GNU/Linux
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_nEuV/u+Ferh9pFr"
Message-Id: <200309040852.23476.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_nEuV/u+Ferh9pFr
Content-Type: text/plain;
  charset="tis-620"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 04 September 2003 05:18, Supphachoke Suntiwichaya wrote:

Hi Mrchoke,

> I can't make xconfig ::
> [root@potter linux-2.4.23-pre3]# make xconfig
> rm -f include/asm
> ( cd include ; ln -sf asm-i386 asm)
> make -C scripts kconfig.tk
> make[1]: Entering directory `/usr/src/linux-2.4.23-pre3/scripts'
> cat header.tk >> ./kconfig.tk
> ./tkparse < ../arch/i386/config.in >> kconfig.tk
> drivers/char/Config.in: 270: bad if condition
> make[1]: *** [kconfig.tk] Error 1
> make[1]: Leaving directory `/usr/src/linux-2.4.23-pre3/scripts'
> make: *** [xconfig] Error 2

I can ... with the attached fix :p

Marcelo, please apply this too. Thank you.

ciao, Marc

--Boundary-00=_nEuV/u+Ferh9pFr
Content-Type: text/x-diff;
  charset="tis-620";
  name="2.4-xconfig-fixup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.4-xconfig-fixup.patch"

--- a/drivers/char/Config.in	2003-09-04 08:38:07.000000000 +0200
+++ b/drivres/char/Config.in	2003-09-04 08:49:43.000000000 +0200
@@ -267,7 +267,7 @@ if [ "$CONFIG_ARCH_NETWINDER" = "y" ]; t
 fi
 dep_tristate 'NatSemi SCx200 GPIO Support' CONFIG_SCx200_GPIO $CONFIG_SCx200
 
-if [ "$CONFIG_IA64_GENERIC" = "y" -o "$CONFIG_IA64_SGI_SN2" = 'y' ] ; then
+if [ "$CONFIG_IA64_GENERIC" = "y" -o "$CONFIG_IA64_SGI_SN2" = "y" ] ; then
    bool 'SGI SN2 fetchop support' CONFIG_FETCHOP
 fi
 

--Boundary-00=_nEuV/u+Ferh9pFr--

