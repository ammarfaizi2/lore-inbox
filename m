Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLKUnp>; Mon, 11 Dec 2000 15:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129716AbQLKUnf>; Mon, 11 Dec 2000 15:43:35 -0500
Received: from c1262263-a.grapid1.mi.home.com ([24.183.135.182]:63504 "EHLO
	mail.neruo.com") by vger.kernel.org with ESMTP id <S129226AbQLKUnX>;
	Mon, 11 Dec 2000 15:43:23 -0500
Subject: Re: [PATCH] aty128fb & >8bit
From: Brad Douglas <brad@neruo.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linux-fbdev@vuser.vu.union.edu
In-Reply-To: <20001210134847.F4810@opus.bloom.county>
Content-Type: multipart/mixed ; boundary="=-Lpuww38qm38IgZjOh5tq"
X-Mailer: Evolution 0.6 (Developer Preview)
Date: 12 Dec 2000 04:12:27 +0800
Mime-Version: 1.0
Message-Id: <20001211204332Z129226-439+2988@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Lpuww38qm38IgZjOh5tq
Content-Type: text/plain

> Hello.  I just noticed that in 2.2.18pre27 you can only use the aty128fb
> driver at 8 bit, because of some missing bits to drivers/video/Config.in.
> w/o this you can't use console at > 8 bit nor X.  I would consider this to
> be a good thing to squash for 2.2.18 final because 2.2.18 is the 1st release
> in a while that works well on PPC, and lots of PPCs have a rage128.

Also, this patch to make it compile as module.  How did these get removed?
I could have swore they used to work fine.

Sorry for the attachment.  This computer has evolution.

Brad Douglas
brad@neruo.com
http://www.linux-fbdev.org


--=-Lpuww38qm38IgZjOh5tq
Content-Type: text/x-makefile
Content-Disposition: attachment ; filename="patch-2.2.18pre25-videoMakefile"
Content-Transfer-Encoding: quoted-printable

--- linux-2.2.18pre25/drivers/video/Makefile	Mon Dec 11 12:05:55 2000
+++ linux/drivers/video/Makefile	Thu Dec  7 15:26:03 2000
@@ -106,6 +106,10 @@
=20
 ifeq ($(CONFIG_FB_ATY128),y)
   L_OBJS +=3D aty128fb.o
+else
+  ifeq ($(CONFIG_FB_ATY128),m)
+  MX_OBJS +=3D aty128fb.o
+  endif
 endif
=20
 ifeq ($(CONFIG_FB_IGA),y)


--=-Lpuww38qm38IgZjOh5tq--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
