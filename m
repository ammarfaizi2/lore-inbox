Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQKQSG3>; Fri, 17 Nov 2000 13:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129094AbQKQSGT>; Fri, 17 Nov 2000 13:06:19 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:32524 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129069AbQKQSGI>; Fri, 17 Nov 2000 13:06:08 -0500
Message-ID: <3A156C69.FB651C57@transmeta.com>
Date: Fri, 17 Nov 2000 09:35:37 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10-pre3 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre21
In-Reply-To: <E13u4XD-0001oe-00@the-village.bc.nu> <20001116171618.A25545@athlon.random> <20001116115249.A8115@wirex.com> <20001117003000.B2918@wire.cadcamlab.org> <8v2js0$qpr$1@cesium.transmeta.com> <20001117052226.C2918@wire.cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> 
>   [I wrote]
> > >   mkdir("foo")
> > >   chroot("foo")
> 
> [H. Peter Anvin]
> > BUG: you *MUST* chdir() into the chroot jail before it does you any
> > good at all!
> 
> No, it wasn't a bug!  It was a demonstration.  The above code is
> executed not by the application but by the *attacker* who has managed
> to 0wn the existing jail.
> 
> Doing the additional chroot("foo") without already being in "foo"
> basically replaces the chroot jail you *were* in, so you are now out.
> 
> The sequence I posted is just the simplest un-chroot procedure I know,
> to explain why chroot cannot sandbox the superuser.
> 

Right.  Gotcha.

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
