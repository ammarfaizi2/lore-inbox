Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316775AbSHTKTe>; Tue, 20 Aug 2002 06:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316788AbSHTKTe>; Tue, 20 Aug 2002 06:19:34 -0400
Received: from 212.68.254.82.brutele.be ([212.68.254.82]:60430 "EHLO debian")
	by vger.kernel.org with ESMTP id <S316775AbSHTKTd>;
	Tue, 20 Aug 2002 06:19:33 -0400
Date: Tue, 20 Aug 2002 12:23:40 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: linux-kernel@vger.kernel.org
Subject: Re: compil error with a LC_ALL="fr_BE@euro" !!! why ?
Message-ID: <20020820102339.GA19877@debian>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020820092101.GA19395@debian> <32252.1029836547@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32252.1029836547@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.28i
X-Operating-System: GNU/Linux
X-LUG: Linux Users Group Mons ( Linux-Mons )
X-URL: http://www.linux-mons.be
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks, this patch is ok for 2.4.20-pre4 with LC_ALL=fr_BE@euro and
gcc-3.2.

Can you put this patch in the new version of the kernel ?

Thanks

Stephane

On Tue, Aug 20, 2002 at 07:42:27PM +1000, Keith Owens wrote:
> On Tue, 20 Aug 2002 11:21:01 +0200, 
> Stephane Wirtel <stephane.wirtel@belgacom.net> wrote:
> >the compiler is gcc-3.2, don't forget this information.
> >make[1]: Entre dans le répertoire `/root/linux-2.4.20-pre4/kernel'
> >make all_targets
> >make[2]: Entre dans le répertoire `/root/linux-2.4.20-pre4/kernel'
> >gcc-3.2 -D__KERNEL__ -I/root/linux-2.4.20-pre4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon    -nostdinc  -DKBUILD_BASENAME=sched  -fno-omit-frame-pointer -c -o sched.o sched.c
> >Dans le fichier inclus à partir de /root/linux-2.4.20-pre4/include/linux/wait.h:13,
> >          à partir de /root/linux-2.4.20-pre4/include/linux/fs.h:12,
> >          à partir de /root/linux-2.4.20-pre4/include/linux/capability.h:17,
> >          à partir de /root/linux-2.4.20-pre4/include/linux/binfmts.h:5,
> >          à partir de /root/linux-2.4.20-pre4/include/linux/sched.h:9,
> >          à partir de /root/linux-2.4.20-pre4/include/linux/mm.h:4,
> >          à partir de sched.c:23:
> >/root/linux-2.4.20-pre4/include/linux/kernel.h:10:20: stdarg.h: Aucun fichier ou répertoire de ce type
> 
> Against 2.4.20-pre4.
> 
> --- Makefile.orig	Tue Aug 20 19:41:05 2002
> +++ Makefile	Tue Aug 20 19:41:16 2002
> @@ -260,7 +260,7 @@ include arch/$(ARCH)/Makefile
>  # 'kbuild_2_4_nostdinc :=' or -I/usr/include for kernel code and you are not UML
>  # then your code is broken!  KAO.
>  
> -kbuild_2_4_nostdinc	:= -nostdinc $(shell $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')
> +kbuild_2_4_nostdinc	:= -nostdinc -iwithprefix include
>  export kbuild_2_4_nostdinc
>  
>  export	CPPFLAGS CFLAGS CFLAGS_KERNEL AFLAGS AFLAGS_KERNEL
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>
Web : www.linux-mons.be	 "Linux Is Not UniX !!!"
