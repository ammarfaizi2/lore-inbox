Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131131AbQKACbV>; Tue, 31 Oct 2000 21:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131141AbQKACbM>; Tue, 31 Oct 2000 21:31:12 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:59917 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S131131AbQKACaz>;
	Tue, 31 Oct 2000 21:30:55 -0500
Message-Id: <200011010231.eA12UqR13473@sleipnir.valparaiso.cl>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks! 
In-Reply-To: Message from "Jeff V. Merkey" <jmerkey@timpanogas.org> 
   of "Tue, 31 Oct 2000 15:45:45 PDT." <39FF4B99.1746E06E@timpanogas.org> 
Date: Tue, 31 Oct 2000 23:30:52 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" <jmerkey@timpanogas.org> said:
> One more optimization it has.  NetWare never "calls" functions in the
> kernel.  There's a template of register assignments in between kernel
> modules that's very strict (esi contains a WTD head, edi has the target
> thread, etc.) and all function calls are jumps in a linear space. 
> layout of all functions are 16 bytes aligned for speed, and all
> arguments in kernel are passed via registers.  It's a level of
> optimization no C compiler does -- all of it was done by hand, and most
> function s in fast paths are layed out in 512 byte chunks to increases
> speed.  Stack memory activity in the NetWare kernel is almost
> non-existent in almost all of the "fast paths"

Nice! Now run that (i386 optimized?) beast on a machine that works
different (latest K7s perhaps?), and many optimizations break.

When you got that fixed, would you please port it to Alpha?

Sure, using C (with a not-overly-bright compiler) has a non-negligible
cost. But huge benefits too. The whole of software (including OS) design is
an excercise in delicate juggling among conflicting goals. Had Linus gone
down the "all-assembler, bummed to its limits" route, Linux would have been
dead by 0.03 or so, depending on the stubborness of its creator to be sure.
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
