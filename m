Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286339AbSBCHPR>; Sun, 3 Feb 2002 02:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286411AbSBCHPG>; Sun, 3 Feb 2002 02:15:06 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:29908 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S286339AbSBCHOt>; Sun, 3 Feb 2002 02:14:49 -0500
Date: Sun, 3 Feb 2002 08:12:17 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: =?iso-8859-1?q?Kurt=20Johnson?= <gorydetailz@yahoo.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: cant compile 2.5.3-dj1
In-Reply-To: <20020203032247.61375.qmail@web14608.mail.yahoo.com>
Message-ID: <Pine.NEB.4.44.0202030811260.9676-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Feb 2002, Kurt Johnson wrote:

> Hello,
>...

Hi Kurt,

> filesystems.c
> filesystems.c:36: syntax error before `int'
> make[2]: *** [filesystems.o] Error 1
> make[2]: Leaving directory
> `/usr/local/src/linux-2.5/fs'
> make[1]: *** [first_rule] Error 2
> make[1]: Leaving directory
> `/usr/local/src/linux-2.5/fs'
> make: *** [_dir_fs] Error 2
>
> Is this a known issue? If so, is there any patch?

This is a known issue. The patch is:

--- fs/filesystems.c.old	Fri Feb  1 08:55:12 2002
+++ fs/filesystems.c	Fri Feb  1 08:55:41 2002
@@ -12,6 +12,7 @@
 #include <linux/smp_lock.h>
 #include <linux/kmod.h>
 #include <linux/nfsd/interface.h>
+#include <linux/linkage.h>

 #if defined(CONFIG_NFSD_MODULE)
 struct nfsd_linkage *nfsd_linkage = NULL;



> Regards,
>
> /kj

cu
Adrian


