Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266369AbSLIXxr>; Mon, 9 Dec 2002 18:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266387AbSLIXxr>; Mon, 9 Dec 2002 18:53:47 -0500
Received: from intra.cyclades.com ([64.186.161.6]:8200 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP
	id <S266369AbSLIXxl>; Mon, 9 Dec 2002 18:53:41 -0500
From: henrique <henrique2.gobbi@cyclades.com>
Reply-To: henrique2.gobbi@cyclades.com
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [DRIVER PATCH] drivers/char/cyclades.c (it was Re: one more in cyclades)
Date: Mon, 9 Dec 2002 16:01:18 +0000
User-Agent: KMail/1.4.1
References: <200212070526.gB75QYY32603@work.bitmover.com>
In-Reply-To: <200212070526.gB75QYY32603@work.bitmover.com>
Cc: Larry McVoy <lm@bitmover.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_6I0VJ44ZXNNY9JZH1L0X"
Message-Id: <200212091601.18941.henrique2.gobbi@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_6I0VJ44ZXNNY9JZH1L0X
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

This is the patch to fix some compilation problems this driver was having=
=2E It=20
is against the kernel 2.5.50 driver. Please apply it for the next release=
=2E

thank you
Henrique

-------------------------------------------------------------------------=
-------------
--- cyclades.c.old      Mon Dec  9 15:48:53 2002
+++ cyclades.c  Mon Dec  9 15:49:44 2002
@@ -12,7 +12,7 @@
  *
  * Initially written by Randolph Bentson <bentson@grieg.seaslug.org>.
  * Modified and maintained by Marcio Saito <marcio@cyclades.com>.
- * Currently maintained by Ivan Passos <ivan@cyclades.com>.
+ * Currently maintained by Henrique Gobbi <henrique.gobbi@cyclades.com>.
  *
  * For Technical support and installation problems, please send e-mail
  * to support@cyclades.com.
@@ -884,7 +884,7 @@
=20

 static int cyz_timeron =3D 0;
 static struct timer_list cyz_timerlist =3D TIMER_INITIALIZER(cyz_poll, 0=
, 0);
-};
+
 #else /* CONFIG_CYZ_INTR */
 static void cyz_rx_restart(unsigned long);
 static struct timer_list cyz_rx_full_timer[NR_PORTS];
-------------------------------------------------------------------------=
--------------

On Saturday 07 December 2002 05:26 am, Larry McVoy wrote:
> make -f scripts/Makefile.build obj=3Ddrivers/char
>   gcc -Wp,-MD,drivers/char/.consolemap_deftbl.o.d -D__KERNEL__ -Iinclud=
e
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
> -fno-common -pipe -mpreferred-stack-boundary=3D2 -march=3Dathlon
> -Iarch/i386/mach-generic -fomit-frame-pointer -nostdinc -iwithprefix
> include    -DKBUILD_BASENAME=3Dconsolemap_deftbl
> -DKBUILD_MODNAME=3Dconsolemap_deftbl   -c -o drivers/char/consolemap_de=
ftbl.o
> drivers/char/consolemap_deftbl.c gcc -Wp,-MD,drivers/char/.defkeymap.o.=
d
> -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=3D2
> -march=3Dathlon -Iarch/i386/mach-generic -fomit-frame-pointer -nostdinc
> -iwithprefix include    -DKBUILD_BASENAME=3Ddefkeymap
> -DKBUILD_MODNAME=3Ddefkeymap   -c -o drivers/char/defkeymap.o
> drivers/char/defkeymap.c gcc -Wp,-MD,drivers/char/.cyclades.o.d
> -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=3D2
> -march=3Dathlon -Iarch/i386/mach-generic -fomit-frame-pointer -nostdinc
> -iwithprefix include    -DKBUILD_BASENAME=3Dcyclades
> -DKBUILD_MODNAME=3Dcyclades   -c -o drivers/char/cyclades.o
> drivers/char/cyclades.c drivers/char/cyclades.c:887: parse error before=
 `}'
> make[2]: *** [drivers/char/cyclades.o] Error 1
> make[1]: *** [drivers/char] Error 2
> make: *** [drivers] Error 2
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--------------Boundary-00=_6I0VJ44ZXNNY9JZH1L0X
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="cyclades.c-2.5.50.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cyclades.c-2.5.50.patch"

--- cyclades.c.old	Mon Dec  9 15:48:53 2002
+++ cyclades.c	Mon Dec  9 15:49:44 2002
@@ -12,7 +12,7 @@
  *
  * Initially written by Randolph Bentson <bentson@grieg.seaslug.org>.
  * Modified and maintained by Marcio Saito <marcio@cyclades.com>.
- * Currently maintained by Ivan Passos <ivan@cyclades.com>.
+ * Currently maintained by Henrique Gobbi <henrique.gobbi@cyclades.com>.
  *
  * For Technical support and installation problems, please send e-mail
  * to support@cyclades.com.
@@ -884,7 +884,7 @@
 
 static int cyz_timeron = 0;
 static struct timer_list cyz_timerlist = TIMER_INITIALIZER(cyz_poll, 0, 0);
-};
+
 #else /* CONFIG_CYZ_INTR */
 static void cyz_rx_restart(unsigned long);
 static struct timer_list cyz_rx_full_timer[NR_PORTS];

--------------Boundary-00=_6I0VJ44ZXNNY9JZH1L0X--

