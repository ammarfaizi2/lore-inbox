Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129913AbQKLFVq>; Sun, 12 Nov 2000 00:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129996AbQKLFVg>; Sun, 12 Nov 2000 00:21:36 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:28946 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129913AbQKLFVc>; Sun, 12 Nov 2000 00:21:32 -0500
Message-ID: <3A0E28BD.CCA5D85F@transmeta.com>
Date: Sat, 11 Nov 2000 21:21:01 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10-pre3 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Where is it written?
In-Reply-To: <20001110184031.A2704@munchkin.spectacle-pond.org> <20001110192751.A2766@munchkin.spectacle-pond.org> <20001111163204.B6367@inspiron.suse.de> <20001111171749.A32100@wire.cadcamlab.org> <8ukkr3$f2h$1@cesium.transmeta.com> <20001111225428.A20749@wire.cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> 
> [Peter Anvin]
> > At the time the original x86 ABI was created, a lot of C code was
> > still K&R, and thus prototypes didn't exist...
> 
> True enough.  That does explain a lot.  But what about the Alpha?  From
> reading gcc source awhile back I seem to remember that most if not all
> parameters are passed in registers.  How does *that* work with varargs
> and no prototypes?  Or does it?
> 

It doesn't, but the Alpha is a *much* more recent ABI... the x86 ABI
really dates back to the 16-bit 8086-series CPUs.

> > I don't think we want to introduce a new ABI in user space at this
> > time.  If we ever have to major-rev the ABI (libc.so.7), then we
> > should consider this.
> 
> Ah, but kernel-side?  My point was that if gcc (and binutils) is
> flexible enough to let you pick an ABI at runtime, perhaps a RISCoid
> ABI for x86 could coexist with the SysV one, to be used initially for
> self-contained code like the kernel.  (And later, a possible transition
> in userspace.)

We tried once; at that point the register-based ABI support in gcc was
too buggy to be useful.  We might try again in 2.5 since we now have
increased the minimum gcc version for kernel compiles.  Binutils needs no
change.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
