Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316750AbSHTJif>; Tue, 20 Aug 2002 05:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316753AbSHTJif>; Tue, 20 Aug 2002 05:38:35 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:39175 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316750AbSHTJif>;
	Tue, 20 Aug 2002 05:38:35 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compil error with a LC_ALL="fr_BE@euro" !!! why ? 
In-reply-to: Your message of "Tue, 20 Aug 2002 11:21:01 +0200."
             <20020820092101.GA19395@debian> 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Date: Tue, 20 Aug 2002 19:42:27 +1000
Message-ID: <32252.1029836547@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2002 11:21:01 +0200, 
Stephane Wirtel <stephane.wirtel@belgacom.net> wrote:
>the compiler is gcc-3.2, don't forget this information.
>make[1]: Entre dans le répertoire `/root/linux-2.4.20-pre4/kernel'
>make all_targets
>make[2]: Entre dans le répertoire `/root/linux-2.4.20-pre4/kernel'
>gcc-3.2 -D__KERNEL__ -I/root/linux-2.4.20-pre4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon    -nostdinc  -DKBUILD_BASENAME=sched  -fno-omit-frame-pointer -c -o sched.o sched.c
>Dans le fichier inclus à partir de /root/linux-2.4.20-pre4/include/linux/wait.h:13,
>          à partir de /root/linux-2.4.20-pre4/include/linux/fs.h:12,
>          à partir de /root/linux-2.4.20-pre4/include/linux/capability.h:17,
>          à partir de /root/linux-2.4.20-pre4/include/linux/binfmts.h:5,
>          à partir de /root/linux-2.4.20-pre4/include/linux/sched.h:9,
>          à partir de /root/linux-2.4.20-pre4/include/linux/mm.h:4,
>          à partir de sched.c:23:
>/root/linux-2.4.20-pre4/include/linux/kernel.h:10:20: stdarg.h: Aucun fichier ou répertoire de ce type

Against 2.4.20-pre4.

--- Makefile.orig	Tue Aug 20 19:41:05 2002
+++ Makefile	Tue Aug 20 19:41:16 2002
@@ -260,7 +260,7 @@ include arch/$(ARCH)/Makefile
 # 'kbuild_2_4_nostdinc :=' or -I/usr/include for kernel code and you are not UML
 # then your code is broken!  KAO.
 
-kbuild_2_4_nostdinc	:= -nostdinc $(shell $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')
+kbuild_2_4_nostdinc	:= -nostdinc -iwithprefix include
 export kbuild_2_4_nostdinc
 
 export	CPPFLAGS CFLAGS CFLAGS_KERNEL AFLAGS AFLAGS_KERNEL

