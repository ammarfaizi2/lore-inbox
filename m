Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130635AbQKMF3L>; Mon, 13 Nov 2000 00:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130636AbQKMF3B>; Mon, 13 Nov 2000 00:29:01 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:49674 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130635AbQKMF2s>; Mon, 13 Nov 2000 00:28:48 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Where is it written?
Date: 12 Nov 2000 21:28:29 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8unu5t$it4$1@cesium.transmeta.com>
In-Reply-To: <20001110184031.A2704@munchkin.spectacle-pond.org> <20001111163204.B6367@inspiron.suse.de> <20001111171749.A32100@wire.cadcamlab.org> <20001112132328.C2366@athlon.random>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20001112132328.C2366@athlon.random>
By author:    Andrea Arcangeli <andrea@suse.de>
In newsgroup: linux.dev.kernel
> 
> I think it doesn't worth to break binary compatilibity at this late stage.
> 
> > design such.)  One issue: ideally you want to use 64-bit regs on AMD
> > Hammer for long longs, but then you leave out all legacy x68s. :(
> 
> We can't in compatibilty mode because the rex regs are available _only_ in
> 64bit mode and even assuming the hardware would support that I would not
> recommend that since as you said that binary would not run anymore on any other
> x86 so causing pain.  Recompiling a program with native x86-64 gcc 64bit (that
> uses the 64bit ABI) is the right way to go in that case (64bit mode uses 1
> 64bit register for long long as all other 64bit architectures of course).
> 

Well, you *could* run REX32, but REX32 is not x86 (x86 code doesn't
run in REX32 mode, and REX32 code doesn't run on an x86.)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
