Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130990AbQL1RM2>; Thu, 28 Dec 2000 12:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131093AbQL1RMT>; Thu, 28 Dec 2000 12:12:19 -0500
Received: from mercury.nildram.co.uk ([195.112.4.37]:27666 "EHLO
	mercury.nildram.co.uk") by vger.kernel.org with ESMTP
	id <S130990AbQL1RMH>; Thu, 28 Dec 2000 12:12:07 -0500
Message-ID: <3A4B6D13.49E9CB9F@magenta-netlogic.com>
Date: Thu, 28 Dec 2000 16:40:51 +0000
From: Tony Hoyle <tmh@magenta-netlogic.com>
Organization: Magenta Logic
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test13pre4-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dieter Nützel <Dieter.Nuetzel@hamburg.de>
CC: Nils Philippsen <nils@fht-esslingen.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Rik Faith <faith@valinux.com>,
        Dri-devel <Dri-devel@lists.sourceforge.net>
Subject: Re: test13-preX: DRM (tdfx.o) unresolved symbols fixed?
In-Reply-To: <Pine.LNX.4.30.0012270951360.21331-100000@rhlx01.fht-esslingen.de> <00122800503201.00902@SunWave1>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Nützel wrote:
> 
> Am Mittwoch, 27. Dezember 2000 11:07 schrieb Nils Philippsen:
> > Hi all,
> >
> > On Wed, 27 Dec 2000, Dieter [iso-8859-1] Nützel wrote:
> > > I got this since test13-pre1 (pre4, now):
> > >
> > > SunWave1>depmod -e
> > > depmod: *** Unresolved symbols in
> > > /lib/modules/2.4.0-test13-pre4/kernel/drivers/char/drm/tdfx.o
> >
> > [snipped]
> >
> > > Something missing in the 'new' drm/Makefile?
> >
This is a temporary fix:

--- drmP.old	Thu Dec 28 16:27:34 2000
+++ drmP.h	Sat Dec 23 13:57:08 2000
@@ -40,6 +40,7 @@
 #include <asm/current.h>
 #endif /* __alpha__ */
 #include <linux/config.h>
+#include <linux/modversions.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/miscdevice.h>

Tony

-- 
Can't think of a decent signature...

tmh@magenta-netlogic.com		http://www.nothing-on.tv
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
