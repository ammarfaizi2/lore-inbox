Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312529AbSDJIbY>; Wed, 10 Apr 2002 04:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312532AbSDJIbX>; Wed, 10 Apr 2002 04:31:23 -0400
Received: from Expansa.sns.it ([192.167.206.189]:36873 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S312529AbSDJIbX>;
	Wed, 10 Apr 2002 04:31:23 -0400
Date: Wed, 10 Apr 2002 10:31:19 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Jurgen Philippaerts <jurgen@pophost.eunet.be>
cc: linux-kernel@vger.kernel.org
Subject: Re: arch/sparc64/kernel/traps.c
In-Reply-To: <20020409214734.GL9996@sparkie.is.traumatized.org>
Message-ID: <Pine.LNX.4.44.0204101030240.32110-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

what version of binutils are you using?
please upgrade them (sources from ftp.kernel.org).


On Tue, 9 Apr 2002, Jurgen Philippaerts wrote:

> On Tue, Apr 09, 2002 at 11:40:08PM +0200, David S. Miller wrote:
> >    From: Jurgen Philippaerts <jurgen@pophost.eunet.be>
> >    Date: Tue, 9 Apr 2002 23:20:00 +0200
> >
> >    TSTATE: 0000009911009601 TPC: 00000000005a39c0 TNPC: 00000000005a39c4
> >    Y: 00000000    Not tainted
> >
> > Please send this through ksymoops so that we get the kernel
> > symbols that match up to all these magic numbers in your OOPS.
>
> i would, if i could :)
> so, i downloaded ksymoops-2.4.5 (i assume this is the version i need)
>
> but it won't compile. sorry, my c knowledge is very basic.
> but i assume there's something wrong with my /usr/lib/libbfd.a ?
>
> gcc io.o ksyms.o ksymoops.o map.o misc.o object.o oops.o re.o
> symbol.o -Dlinux -Wall -Wno-conversion -Waggregate-return
> -Wstrict-prototypes -Wmissing-prototypes  -DDEF_KSYMS=\"/proc/ksyms\"
> -DDEF_LSMOD=\"/proc/modules\" -DDEF_OBJECTS=\"/lib/modules/*r/\"
> -DDEF_MAP=\"/usr/src/linux/System.map\" -Wl,-Bstatic -lbfd -liberty
> -Wl,-Bdynamic -o ksymoops
> /usr/lib/libbfd.a(merge.o): In function `merge_strings':
> merge.o(.text+0xc04): undefined reference to `htab_create'
> merge.o(.text+0xc2c): undefined reference to `htab_create'
> merge.o(.text+0xce4): undefined reference to
> `htab_find_slot_with_hash'
> merge.o(.text+0xd60): undefined reference to
> `htab_find_slot_with_hash'
> merge.o(.text+0xdd8): undefined reference to `htab_delete'
> merge.o(.text+0xdec): undefined reference to `htab_delete'
> collect2: ld returned 1 exit status
> make: *** [ksymoops] Error 1
>
>
> Jurgen.
> --
> http://www.tuxedo.org/~esr/faqs/smart-questions.html
>
> Linux sparkie 2.4.19-pre5 #1 Thu Apr 4 19:14:41 CEST 2002 sparc64 unknown
>  11:40pm  up 5 days,  3:53, 14 users,  load average: 0.07, 0.07, 0.04
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

