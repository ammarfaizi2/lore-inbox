Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129180AbQJ0HfQ>; Fri, 27 Oct 2000 03:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129128AbQJ0HfG>; Fri, 27 Oct 2000 03:35:06 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:8456 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129226AbQJ0Hex>; Fri, 27 Oct 2000 03:34:53 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: missing mxcsr initialization
Date: 27 Oct 2000 00:34:47 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8tbb6n$85r$1@cesium.transmeta.com>
In-Reply-To: <20001026021731.B23895@athlon.random> <E13oy7T-00043v-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Comment-To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved

Followup to:  <E13oy7T-00043v-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
>
> > > corrected for include the facts that the XMM feature bit is an Intel specific
> > > bit that other vendors may use for other things, so you need to test vendor ==
> > 			 ^^^
> > Note that they shouldn't do that! I would consider a very bad thing if they
> > goes out of sync on those bits.
> 
> CPUID is vendor specific. Every bit in those fields is vendor specific. Every
> piece of documentation tells you to check the CPU vendor.  Every time we didnt 
> bother we got burned.
> 
> I keep hearing people saying things like 'bad thing' 'assume standards'. Well
> all I can say is cite a vendor issued document which says 'dont bother checking
> the vendor'. 
> 

Intel does it because they want every other chip out there to act like
a 486.

> 
> And when you can't find that document, put the checks in so we dont crash on
> an Athlon or when using MTRR on a Cyrix III etc
> 

Chips that don't implement what they claim to implement are buggy and
should be treated as such.  SPECIAL-CASE THE BUGGY CHIPS, NOT THE
PROPERLY FUNCTIONING ONES.

	-hpa


-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
