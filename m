Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129873AbQKLEyw>; Sat, 11 Nov 2000 23:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129952AbQKLEyl>; Sat, 11 Nov 2000 23:54:41 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:49424 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129873AbQKLEyc>; Sat, 11 Nov 2000 23:54:32 -0500
Date: Sat, 11 Nov 2000 22:54:28 -0600
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where is it written?
Message-ID: <20001111225428.A20749@wire.cadcamlab.org>
In-Reply-To: <20001110184031.A2704@munchkin.spectacle-pond.org> <20001110192751.A2766@munchkin.spectacle-pond.org> <20001111163204.B6367@inspiron.suse.de> <20001111171749.A32100@wire.cadcamlab.org> <8ukkr3$f2h$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <8ukkr3$f2h$1@cesium.transmeta.com>; from hpa@zytor.com on Sat, Nov 11, 2000 at 03:30:43PM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Peter Anvin]
> At the time the original x86 ABI was created, a lot of C code was
> still K&R, and thus prototypes didn't exist...

True enough.  That does explain a lot.  But what about the Alpha?  From
reading gcc source awhile back I seem to remember that most if not all
parameters are passed in registers.  How does *that* work with varargs
and no prototypes?  Or does it?

> I don't think we want to introduce a new ABI in user space at this
> time.  If we ever have to major-rev the ABI (libc.so.7), then we
> should consider this.

Ah, but kernel-side?  My point was that if gcc (and binutils) is
flexible enough to let you pick an ABI at runtime, perhaps a RISCoid
ABI for x86 could coexist with the SysV one, to be used initially for
self-contained code like the kernel.  (And later, a possible transition
in userspace.)

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
