Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129076AbQKQLxN>; Fri, 17 Nov 2000 06:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129097AbQKQLxD>; Fri, 17 Nov 2000 06:53:03 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:48644 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129076AbQKQLwx>; Fri, 17 Nov 2000 06:52:53 -0500
Date: Fri, 17 Nov 2000 05:22:26 -0600
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre21
Message-ID: <20001117052226.C2918@wire.cadcamlab.org>
In-Reply-To: <E13u4XD-0001oe-00@the-village.bc.nu> <20001116171618.A25545@athlon.random> <20001116115249.A8115@wirex.com> <20001117003000.B2918@wire.cadcamlab.org> <8v2js0$qpr$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <8v2js0$qpr$1@cesium.transmeta.com>; from hpa@zytor.com on Thu, Nov 16, 2000 at 10:40:00PM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [I wrote]
> >   mkdir("foo")
> >   chroot("foo")

[H. Peter Anvin]
> BUG: you *MUST* chdir() into the chroot jail before it does you any
> good at all!

No, it wasn't a bug!  It was a demonstration.  The above code is
executed not by the application but by the *attacker* who has managed
to 0wn the existing jail.

Doing the additional chroot("foo") without already being in "foo"
basically replaces the chroot jail you *were* in, so you are now out.

The sequence I posted is just the simplest un-chroot procedure I know,
to explain why chroot cannot sandbox the superuser.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
