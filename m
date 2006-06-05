Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932417AbWFEFZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWFEFZE (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 01:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWFEFZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 01:25:04 -0400
Received: from xenotime.net ([66.160.160.81]:58332 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932417AbWFEFZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 01:25:02 -0400
Date: Sun, 4 Jun 2006 22:27:48 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: barryn@pobox.com, linux-kernel@vger.kernel.org, bunk@stusta.de,
        greg@kroah.com
Subject: Re: [PATCH] sisusb: fix build (Re: 2.6.17-rc5-mm3: sisusbvga build
 failure)
Message-Id: <20060604222748.861bac85.rdunlap@xenotime.net>
In-Reply-To: <20060604221117.b9dfdcfc.akpm@osdl.org>
References: <986ed62e0606042140v78dc2c7cpb3cf7793954d2dce@mail.gmail.com>
	<20060604220347.6f963375.rdunlap@xenotime.net>
	<20060604221117.b9dfdcfc.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jun 2006 22:11:17 -0700 Andrew Morton wrote:

> On Sun, 4 Jun 2006 22:03:47 -0700
> "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> 
> > From: Randy Dunlap <rdunlap@xenotime.net>
> > 
> > Fix build errors caused by missing header file.
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> > ---
> >  drivers/usb/misc/sisusbvga/sisusb.h |    2 +-
> >  1 files changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- linux-2617-rc5mm3.orig/drivers/usb/misc/sisusbvga/sisusb.h
> > +++ linux-2617-rc5mm3/drivers/usb/misc/sisusbvga/sisusb.h
> > @@ -65,8 +65,8 @@
> >  #ifdef INCL_SISUSB_CON
> >  #include <linux/console.h>
> >  #include <linux/vt_kern.h>
> > -#include "sisusb_struct.h"
> >  #endif
> > +#include "sisusb_struct.h"
> 
> OK, but with that applied it still fails:
> 
> In file included from drivers/usb/misc/sisusbvga/sisusb.c:56:
> drivers/usb/misc/sisusbvga/sisusb_init.h:837: warning: 'struct vc_data' declared inside parameter list
> drivers/usb/misc/sisusbvga/sisusb_init.h:837: warning: its scope is only this definition or declaration, which is probably not what you want
> drivers/usb/misc/sisusbvga/sisusb.c:1339: error: static declaration of 'sisusb_setidxreg' follows non-static declaration
> drivers/usb/misc/sisusbvga/sisusb_init.h:819: error: previous declaration of 'sisusb_setidxreg' was here
> drivers/usb/misc/sisusbvga/sisusb.c:1351: error: static declaration of 'sisusb_getidxreg' follows non-static declaration
> drivers/usb/misc/sisusbvga/sisusb_init.h:821: error: previous declaration of 'sisusb_getidxreg' was here
> drivers/usb/misc/sisusbvga/sisusb.c:1364: error: static declaration of 'sisusb_setidxregandor' follows non-static declaration
> drivers/usb/misc/sisusbvga/sisusb_init.h:823: error: previous declaration of 'sisusb_setidxregandor' was here
> drivers/usb/misc/sisusbvga/sisusb.c:1395: error: static declaration of 'sisusb_setidxregor' follows non-static declaration
> drivers/usb/misc/sisusbvga/sisusb_init.h:825: error: previous declaration of 'sisusb_setidxregor' was here
> drivers/usb/misc/sisusbvga/sisusb.c:1404: error: static declaration of 'sisusb_setidxregand' follows non-static declaration
> drivers/usb/misc/sisusbvga/sisusb_init.h:827: error: previous declaration of 'sisusb_setidxregand' was here
> make[1]: *** [drivers/usb/misc/sisusbvga/sisusb.o] Error 1
> 
> Culprit is gregkh-usb-usb-sisusbvga-possible-cleanups.patch

Yes, I was just about to retract that patch.  Sorry.
I probably can't fix it tonight.

---
~Randy
