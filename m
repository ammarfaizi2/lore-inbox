Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288395AbSAVJ3H>; Tue, 22 Jan 2002 04:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289212AbSAVJ25>; Tue, 22 Jan 2002 04:28:57 -0500
Received: from moutng0.kundenserver.de ([212.227.126.170]:40391 "EHLO
	moutng0.schlund.de") by vger.kernel.org with ESMTP
	id <S288395AbSAVJ2k>; Tue, 22 Jan 2002 04:28:40 -0500
Date: Tue, 22 Jan 2002 10:19:15 +0100 (MET)
From: Armin Schindler <mac@melware.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: <kkeil@suse.de>, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: missing memset in divas and eicon in 2.2.20
In-Reply-To: <200201212336.g0LNa9b25643@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.4.31.0201221017280.21391-100000@phoenix.one.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did you use plain 2.2.20 ?
I cannot reproduce this problem here, can you please send me your
kernel config.

Thanx,
Armin

On Tue, 22 Jan 2002, Peter T. Breuer wrote:
>   betty:/usr/local/src/linux-2.2.20% sudo depmod -ae -F System.map 2.2.20-SMP
>   depmod: *** Unresolved symbols in
>   /lib/modules/2.2.20-SMP/misc/divas.o depmod:         memset
>   depmod: *** Unresolved symbols in
>   /lib/modules/2.2.20-SMP/misc/eicon.o depmod:         memset
>
> Both compiled as modules, SMP kernel, i686 compile.  No, I didn't make a
> patch - I was too busy fighting with sct's patch for ext3, which is also
> slightly toasted in the deendencies department when compiled as a
> module.
>
> I don't know why these are missing memset. Of course memset is in the
> kernel and nobody else misses it one bit! Yes, they do include at least
> some header that incorporates memset (from linux/strings.h? Or in
> asm-i386?), because I tried copying an inline memset.h definition into
> their header files, and it produced a typical compiler error ("error
> before '?' .." sic) from a memset macro clash. One of the component
> sources of divas.o and eicon.o must be missing an #include
> <asm/strings.h>.
>
> Your mission is to find and eliminate that missing include.
>
> Good luck.
>
>
> ---------------------------------------------------------------------
> Peter T. Breuer                   MA CASM PhD (Ing.), Prof. Asoc.
> Area de Ingenieria Telematica	  E-mail: ptb@it.uc3m.es
> Dpto. Ingenieria		  Tel: +34 (9)1 624 87 81
> Universidad Carlos III de Madrid  Fax: +34 (9)1 624 8749/9430
> Butarque 15, Leganes/Madrid       URL: http://www.it.uc3m.es/~ptb
> E-28911 Spain                     Mob: +34 69 666 7835
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


- - -   - - -   - - -   - - -
Cytronics & Melware
Weinbergstrasse 39
55296 Loerzweiler / Germany
Tel: +49 6138 98110-0
Fax: +49 6138 98110-9
mailto:info@melware.de
http://www.melware.de
- - -   - - -   - - -   - - -


