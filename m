Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQKKXbQ>; Sat, 11 Nov 2000 18:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129457AbQKKXa5>; Sat, 11 Nov 2000 18:30:57 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:32780 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129391AbQKKXax>; Sat, 11 Nov 2000 18:30:53 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Where is it written?
Date: 11 Nov 2000 15:30:43 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8ukkr3$f2h$1@cesium.transmeta.com>
In-Reply-To: <20001110184031.A2704@munchkin.spectacle-pond.org> <20001110192751.A2766@munchkin.spectacle-pond.org> <20001111163204.B6367@inspiron.suse.de> <20001111171749.A32100@wire.cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20001111171749.A32100@wire.cadcamlab.org>
By author:    Peter Samuelson <peter@cadcamlab.org>
In newsgroup: linux.dev.kernel
> 
> [Andrea Arcangeli]
> > Can you think at one case where it's better to push the parameter on
> > the stack instead of passing them through the callee clobbered
> > ebx/eax/edx?
> 
> Well it's safer if you are lazy about prototyping varargs functions.
> But of course by doing that you're treading on thin ice anyway, in
> terms of type promotion and portability.  So I guess it's much better
> to say "varargs functions MUST be prototyped" and use the registers.
> 

It definitely is now.  At the time the original x86 ABI was created, a
lot of C code was still K&R, and thus prototypes didn't exist...

> 
> AIUI gcc can cope OK with multiple ABIs to be chosen at runtime, am I
> right?  IRIX, HP-UX and AIX all have both 32-bit and 64-bit ABIs.
> 

I don't think we want to introduce a new ABI in user space at this
time.  If we ever have to major-rev the ABI (libc.so.7), then we
should consider this.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
