Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314141AbSDLUtJ>; Fri, 12 Apr 2002 16:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314143AbSDLUtH>; Fri, 12 Apr 2002 16:49:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43533 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314141AbSDLUtG>; Fri, 12 Apr 2002 16:49:06 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
Date: 12 Apr 2002 13:48:53 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a97h7l$5jp$1@cesium.transmeta.com>
In-Reply-To: <m26669olcu.fsf@goliath.csn.tu-chemnitz.de> <E16Oocq-0005tX-00@the-village.bc.nu> <20020112062735.D511@toy.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020112062735.D511@toy.ucw.cz>
By author:    Pavel Machek <pavel@suse.cz>
In newsgroup: linux.dev.kernel
>
> HI!
> 
> > > is it possible to include an emulation for the CMOV* (and possible other
> > > i686 instructions) for processors that dont have these (k6, pentium
> > > etc.)? I think this should work like the fpu emulation. Even if its slow
> > 
> > The kernel isnt there to fix up the fact authors can't read. Its also very
> > hard to get emulations right. I grant that this wasn't helped by the fact
> > the gcc x86 folks also couldnt read the pentium pro manual correctly.
> 
> How long does it take until netscape binaries contain CMOV? We already do
> FPU emulation (you can do soft-float, so you do NOT need FP emulation!), so
> I guess this would begood freature.
> 

The difference is that the overhead of doing FP emulation is
acceptable when compared to softfloat; this is not the case for CMOV
unless you can somehow patch the binary on the fly.

At some point it might make sense to run "the one program" that you
otherwise can't live without, but I don't think it's gotten to that
stage yet.  Which is, in some ways, unfortunate.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
