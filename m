Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265003AbSKANda>; Fri, 1 Nov 2002 08:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265004AbSKANda>; Fri, 1 Nov 2002 08:33:30 -0500
Received: from main.gmane.org ([80.91.224.249]:32953 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S265003AbSKANd3>;
	Fri, 1 Nov 2002 08:33:29 -0500
To: linux-kernel@vger.kernel.org
X-Injected-Via-Gmane: http://gmane.org/
Path: not-for-mail
From: Nicholas Wourms <nwourms@netscape.net>
Subject: Re: 2.5.45 : Intermezzo [still] broken ?
Date: Fri, 01 Nov 2002 08:40:57 -0500
Message-ID: <apu04s$60l$1@main.gmane.org>
References: <3DC27B7C.5F02F35F@gatwick.westerngeco.slb.com>
Reply-To: nwourms@netscape.net
NNTP-Posting-Host: 130-127-121-177.generic.clemson.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Trace: main.gmane.org 1036157916 6165 130.127.121.177 (1 Nov 2002 13:38:36 GMT)
X-Complaints-To: usenet@main.gmane.org
NNTP-Posting-Date: Fri, 1 Nov 2002 13:38:36 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Loic Jaquemet wrote:

> Non-existing header files ...
> 
> Intermezzo was built as a module.
> 
> make -f scripts/Makefile.build obj=fs/intermezzo
>    rm -f fs/intermezzo/built-in.o; ar rcs fs/intermezzo/built-in.o
>   gcc -Wp,-MD,fs/intermezzo/.cache.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpr
> eferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic -nostdinc
> -iwithprefix include -DMODULE -include include/linux/modversions.h
> -DKBUILD_BASENAME=cache   -c -o
> fs/intermezzo/cache.o fs/intermezzo/cache.c
> Dans le fichier inclus à partir de fs/intermezzo/cache.c:42:
> include/linux/intermezzo_fs.h:30:34: linux/intermezzo_lib.h: Aucun
> fichier ou répertoire de ce type
> include/linux/intermezzo_fs.h:31:34: linux/intermezzo_idl.h: Aucun
> fichier ou répertoire de ce type
> [...]
> Dans le fichier inclus à partir de fs/intermezzo/cache.c:42:
> include/linux/intermezzo_fs.h: Au niveau supérieur:
> include/linux/intermezzo_fs.h:919: AVERTISSEMENT: « struct kml_rec »
> déclaré à l'intérieur de la liste de paramètres
> include/linux/intermezzo_fs.h:920: AVERTISSEMENT: « struct kml_rec »
> déclaré à l'intérieur de la liste de paramètres
> make[2]: *** [fs/intermezzo/cache.o] Erreur 1
> make[1]: *** [fs/intermezzo] Erreur 2
> make: *** [fs] Erreur 2

Look in the mailing list archives on the intermezzo sourceforge project 
page, you'll find a patch which resolves this.  However, the maintainers 
said they still think it won't work even if it does compile.

Cheers,
Nicholas


