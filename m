Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130304AbQKPQSZ>; Thu, 16 Nov 2000 11:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131006AbQKPQSP>; Thu, 16 Nov 2000 11:18:15 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:21262 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S130304AbQKPQSG>; Thu, 16 Nov 2000 11:18:06 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200011161547.QAA23000@green.mif.pg.gda.pl>
Subject: Re: PCI configuration changes
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Thu, 16 Nov 2000 16:47:46 +0100 (CET)
Cc: peter@cadcamlab.org (Peter Samuelson),
        linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <3A13FD32.2E0C6721@mandrakesoft.com> from "Jeff Garzik" at Nov 16, 2000 10:28:50 AM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Peter Samuelson wrote:
> > [Andrzej Krzysztofowicz]
> > > Note, that as CONFIG_MCA is defined only for i386 the dependencies on
> > > $CONFIG_MCA are no-op for other architectures (in
> > > Configure/Menuconfig).  Either CONFIG_MCA should be defined for all
> > > architectures or there should be if ... fi around these lines.
> > 
> > Looks good to me.  Anything to remove clutter from config menus....
> 
> Patch looks ok to me, applied.

I think the following i386 chunk should be added to the patch:


--- arch/i386/config.in.old	Tue Nov 14 23:18:12 2000
+++ arch/i386/config.in	Tue Nov 14 23:19:10 2000
@@ -198,6 +198,8 @@
 
 if [ "$CONFIG_VISWS" != "y" ]; then
    bool 'MCA support' CONFIG_MCA
+else
+   define_bool CONFIG_MCA n
 fi
 
 bool 'Support for hot-pluggable devices' CONFIG_HOTPLUG


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
