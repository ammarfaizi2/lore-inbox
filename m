Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313322AbSDGNxX>; Sun, 7 Apr 2002 09:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313325AbSDGNxW>; Sun, 7 Apr 2002 09:53:22 -0400
Received: from fungus.teststation.com ([212.32.186.211]:40196 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S313322AbSDGNxW>; Sun, 7 Apr 2002 09:53:22 -0400
Date: Sun, 7 Apr 2002 15:52:58 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [patch] Re: 2.4.19-pre6 dead Makefile entries
In-Reply-To: <27694.1018177299@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.33.0204071541030.4531-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Apr 2002, Keith Owens wrote:

> The more rigorous error checking in kbuild 2.5 found several Makefile
> entries for objects that have no source.   kbuild 2.4 silently ignores
...
> fs/nls/Makefile                 nls_cp1252.o
>                                 nls_cp1253.o
>                                 nls_cp1254.o
>                                 nls_cp1256.o
>                                 nls_cp1257.o
>                                 nls_cp1258.o
>                                 nls_iso8859_10.o
>                                 nls_abc.o

The abc one is mine and should never have escaped from my test setup. The
others look pretty unused to me, so I think the following should be
applied to both 2.4 and 2.5.

/Urban


diff -urN -X exclude linux-2.4.19-pre5-orig/fs/nls/Makefile linux/fs/nls/Makefile
--- linux-2.4.19-pre5-orig/fs/nls/Makefile	Mon Apr  1 12:39:15 2002
+++ linux/fs/nls/Makefile	Sun Apr  7 15:36:34 2002
@@ -29,12 +29,6 @@
 obj-$(CONFIG_NLS_CODEPAGE_950)	+= nls_cp950.o nls_big5.o
 obj-$(CONFIG_NLS_CODEPAGE_1250)	+= nls_cp1250.o
 obj-$(CONFIG_NLS_CODEPAGE_1251)	+= nls_cp1251.o
-obj-$(CONFIG_NLS_CODEPAGE_1252)	+= nls_cp1252.o
-obj-$(CONFIG_NLS_CODEPAGE_1253)	+= nls_cp1253.o
-obj-$(CONFIG_NLS_CODEPAGE_1254)	+= nls_cp1254.o
-obj-$(CONFIG_NLS_CODEPAGE_1256)	+= nls_cp1256.o
-obj-$(CONFIG_NLS_CODEPAGE_1257)	+= nls_cp1257.o
-obj-$(CONFIG_NLS_CODEPAGE_1258)	+= nls_cp1258.o
 obj-$(CONFIG_NLS_ISO8859_1)	+= nls_iso8859-1.o
 obj-$(CONFIG_NLS_ISO8859_2)	+= nls_iso8859-2.o
 obj-$(CONFIG_NLS_ISO8859_3)	+= nls_iso8859-3.o
@@ -44,13 +38,11 @@
 obj-$(CONFIG_NLS_ISO8859_7)	+= nls_iso8859-7.o
 obj-$(CONFIG_NLS_ISO8859_8)	+= nls_cp1255.o nls_iso8859-8.o
 obj-$(CONFIG_NLS_ISO8859_9)	+= nls_iso8859-9.o
-obj-$(CONFIG_NLS_ISO8859_10)	+= nls_iso8859-10.o
 obj-$(CONFIG_NLS_ISO8859_13)	+= nls_iso8859-13.o
 obj-$(CONFIG_NLS_ISO8859_14)	+= nls_iso8859-14.o
 obj-$(CONFIG_NLS_ISO8859_15)	+= nls_iso8859-15.o
 obj-$(CONFIG_NLS_KOI8_R)	+= nls_koi8-r.o
 obj-$(CONFIG_NLS_KOI8_U)	+= nls_koi8-u.o nls_koi8-ru.o
-obj-$(CONFIG_NLS_ABC)		+= nls_abc.o
 obj-$(CONFIG_NLS_UTF8)		+= nls_utf8.o
 
 export-objs = $(obj-y)

