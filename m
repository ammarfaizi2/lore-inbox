Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135170AbQL3UxC>; Sat, 30 Dec 2000 15:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135489AbQL3Uwx>; Sat, 30 Dec 2000 15:52:53 -0500
Received: from paloma12.e0k.nbg-hannover.de ([62.159.219.12]:3019 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S135170AbQL3Uwe>; Sat, 30 Dec 2000 15:52:34 -0500
From: Dieter Nützel <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: "Linux Kernel List" <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre6 weird with tdfx.o
Date: Sat, 30 Dec 2000 21:24:12 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: "Frank Jacobberger" <f1j@xmission.com>, "J Sloan" <jjs@pobox.com>,
        "Rik Faith" <faith@valinux.com>,
        "Dri-devel" <Dri-devel@lists.sourceforge.net>
MIME-Version: 1.0
Message-Id: <00123021241200.05112@SunWave1>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> J Sloan wrote:
>
> > Frank Jacobberger wrote:
> >
> > > This is a first for tdfx.o not loading with XFree 4.01.
> > >
> > > All prior kernel build through test13-pre5 would load just fine...
> > >
> > > Strange...
> >
> > Very strange - others on this list, self included,
> > have reported something a bit different:
> >
> > tdfx.o has not loaded in any kernel since -test12.

It haven't loaded since test13-pre1 for me.
Only the 'module version' was broken.
Last test12-pre7 was fine, here.
It was introduced with the Makefile cleanups.

[snip]
> Hi,
>
> This is lets it load.   The same missing symbols happen with mga as well... 
> This is from a patch posted here two weeks ago:
>
> --- linux/drivers/char/drm/drmP.old        Thu Dec 28 16:27:34 2000
> +++ linux/drivers/char/drm/drmP.h        Sat Dec 23 13:57:08 2000
> @@ -40,6 +40,7 @@
>  #include <asm/current.h>
>  #endif /* __alpha__ */
>  #include <linux/config.h>
> +#include <linux/modversions.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/miscdevice.h>
> 
> Not sure if this is more than a temporay fix though.
>
> Ed Tomlins
[snip]

I think this patch is very fine.
It works here without a hitch.
Rik?

> > The makefile changes have broken it.
> >
> > Are you certain tdfx.o loads for you in prior -test13
> > versions? If so, that would be a most disturbing
> > development...
> >
> > jjs
>
> Yes your right... I just haven't noticed... Why doesn't someone fix it?
>
> Frank

I am involved a little bit into the DRI development and I think it is because 
all the DRI guys (VA Linux) especially Rik Faith are out for vacation...:-)

Happy New Year!

-Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
Cognitive Systems Group
Vogt-Kölln-Straße 30
D-22527 Hamburg, Germany

email: nuetzel@kogs.informatik.uni-hamburg.de
@home: Dieter.Nuetzel@hamburg.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
