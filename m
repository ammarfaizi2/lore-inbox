Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136798AbREBD3n>; Tue, 1 May 2001 23:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136804AbREBD3f>; Tue, 1 May 2001 23:29:35 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:26628 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S136798AbREBD3Q>;
	Tue, 1 May 2001 23:29:16 -0400
Message-Id: <200105020328.f423Ssvf011202@sleipnir.valparaiso.cl>
To: sjhill@cotw.com
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Question on including 'math.h' from C runtime... 
In-Reply-To: Message from "Steven J. Hill" <sjhill@cotw.com> 
   of "Tue, 01 May 2001 22:17:23 EST." <3AEF7C43.9955C970@cotw.com> 
Date: Tue, 01 May 2001 23:28:54 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Steven J. Hill" <sjhill@cotw.com> said:
> I checked in the archives and did not see a discussion of this
> anywhere. I have received some Linux kernel code from a project
> that I have inherited and a couple of the drivers are including
> math.h from the C library. This being the header file from
> '/usr/include/math.h' in most cases. There are only two places
> in the kernel that also include this header file. They are:
> 
>    drivers/atm/iphase.c
>    drivers/net/hamradio/soundmodem/gentbl.c
> 
> As far as I can tell '/usr/include/math.h' is just full of
> defines and the header files it includes are also a bunch
> of defines with a few macro functions sprinkled in. Can someone
> shed light on if this is bad or not and why it would be done
> or necessary? Thanks.

Floating point in-kernel is a no-no-no. What you see is use in helper
programs that are compiled as part of the kernel build. Check if that is
your case too.
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
