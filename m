Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132548AbQL1X3S>; Thu, 28 Dec 2000 18:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132691AbQL1X3I>; Thu, 28 Dec 2000 18:29:08 -0500
Received: from paloma13.e0k.nbg-hannover.de ([62.159.219.13]:21889 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S132548AbQL1X2y>; Thu, 28 Dec 2000 18:28:54 -0500
From: Dieter Nützel <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Tony Hoyle <tmh@magenta-netlogic.com>
Subject: Re: test13-preX: DRM (tdfx.o) unresolved symbols fixed?
Date: Fri, 29 Dec 2000 00:00:49 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: Nils Philippsen <nils@fht-esslingen.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Rik Faith <faith@valinux.com>,
        Dri-devel <Dri-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.30.0012270951360.21331-100000@rhlx01.fht-esslingen.de> <00122800503201.00902@SunWave1> <3A4B6D13.49E9CB9F@magenta-netlogic.com>
In-Reply-To: <3A4B6D13.49E9CB9F@magenta-netlogic.com>
MIME-Version: 1.0
Message-Id: <00122900004900.02693@SunWave1>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 28. Dezember 2000 17:40 schrieb Tony Hoyle:
> Dieter Nützel wrote:
> > Am Mittwoch, 27. Dezember 2000 11:07 schrieb Nils Philippsen:
> > > Hi all,
> > >
> > > On Wed, 27 Dec 2000, Dieter [iso-8859-1] Nützel wrote:
> > > > I got this since test13-pre1 (pre4, now):
> > > >
> > > > SunWave1>depmod -e
> > > > depmod: *** Unresolved symbols in
> > > > /lib/modules/2.4.0-test13-pre4/kernel/drivers/char/drm/tdfx.o
> > >
> > > [snipped]
> > >
> > > > Something missing in the 'new' drm/Makefile?
>
> This is a temporary fix:
>
> --- drmP.old	Thu Dec 28 16:27:34 2000
> +++ drmP.h	Sat Dec 23 13:57:08 2000
> @@ -40,6 +40,7 @@
>  #include <asm/current.h>
>  #endif /* __alpha__ */
>  #include <linux/config.h>
> +#include <linux/modversions.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/miscdevice.h>

If I compile agpgart and tdfx directly into the kernel, it works for me, too.

Thanks!
	Dieter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
