Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262779AbVGNAOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262779AbVGNAOB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 20:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbVGNANt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 20:13:49 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:9433 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262842AbVGNAMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 20:12:33 -0400
Date: Thu, 14 Jul 2005 02:12:29 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: =?UTF-8?Q?Egry_G=E1bor?= <gaboregry@t-online.hu>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Massimo Maiurana <maiurana@inwind.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       KernelFR <kernelfr@traduc.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: [PATCH 18/19] Kconfig I18N: LKC: whitespace removing
In-Reply-To: <1121275984.2975.49.camel@spirit>
Message-ID: <Pine.LNX.4.61.0507140210480.3728@scrub.home>
References: <1121273456.2975.3.camel@spirit> <1121275984.2975.49.camel@spirit>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811837-645214870-1121299949=:3728"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811837-645214870-1121299949=:3728
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Wed, 13 Jul 2005, Egry G=E1bor wrote:

> diff -puN scripts/kconfig/zconf.l~kconfig-i18n-18-whitespace-fix scripts/=
kconfig/zconf.l
> --- linux-2.6.13-rc3-i18n-kconfig/scripts/kconfig/zconf.l~kconfig-i18n-18=
-whitespace-fix=092005-07-13 18:32:20.000000000 +0200
> +++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/kconfig/zconf.l=092005-=
07-13 18:32:20.000000000 +0200
> @@ -57,6 +57,17 @@ void append_string(const char *str, int=20
>  =09*text_ptr =3D 0;
>  }
> =20
> +void append_helpstring(const char *str, int size)
> +{
> +=09while (size) {
> +=09=09if ((str[size-1] !=3D ' ') && (str[size-1] !=3D '\t'))
> +=09=09=09break;
> +=09=09size--;
> +=09}
> +
> +=09append_string (str, size);
> +}
> +
>  void alloc_string(const char *str, int size)
>  {
>  =09text =3D malloc(size + 1);
> @@ -225,7 +236,7 @@ n=09[A-Za-z0-9_]
>  =09=09append_string("\n", 1);
>  =09}
>  =09[^ \t\n].* {
> -=09=09append_string(yytext, yyleng);
> +=09=09append_helpstring(yytext, yyleng);
>  =09=09if (!first_ts)
>  =09=09=09first_ts =3D last_ts;
>  =09}

Simply integrate the function into the caller.

bye, Roman
---1463811837-645214870-1121299949=:3728--
