Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130237AbQK0P7v>; Mon, 27 Nov 2000 10:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130897AbQK0P7c>; Mon, 27 Nov 2000 10:59:32 -0500
Received: from 13dyn33.delft.casema.net ([212.64.76.33]:9999 "EHLO
        abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
        id <S130237AbQK0P73>; Mon, 27 Nov 2000 10:59:29 -0500
Message-Id: <200011271459.PAA18635@cave.bitwizard.nl>
Subject: Re: Universal debug macros.
In-Reply-To: <Pine.LNX.4.10.10011271630320.13242-100000@yle-server.ylenurme.sise>
 from Elmer Joandi at "Nov 27, 2000 04:42:13 pm"
To: Elmer Joandi <elmer@ylenurme.ee>
Date: Mon, 27 Nov 2000 15:59:58 +0100 (MET)
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Elmer Joandi wrote:
> 
> 
> On Mon, 27 Nov 2000, Rogier Wolff wrote:
> > Turns out that people will
> > prefer to run the "performance" kernel, and they will send in useless
> > bugreports like "my just hangs" much more often than now.
> 
> But look at positive side:

I disagree:

> 1. really few people run development kernels despite the "performance" so 
> 	it probably will be with nondebug kernels.

Nope. If Red Hat gives a choice between a "performance" and a "with
debugging" kernel, everyone will chose "performance" under the
impression that thye won't be debugging their server.

> 2. production kernels get more solid

Nope. The kernels in production WILL NOT be more solid. They will
crash unexpectedly without any reference to what caused the crash.

> 3. because there could be a lot more debug points in development kernels

No. you state that they would come "at no cost" that would mean that
YOU are suggesting that you'd run a "performance" kernel, with (most)
of the debugging disabled.

Which means that you'd have disabled the debugging in MY part of the
kernel.

> 4. Distributors are interested in shipping debug-kernels.

Even if SuSE, Red Hat and Mandrake are convinced that shipping
debug-kernels is a good idea, then there is going to be some
distribution that has "ships performance kernels" as on of their
selling points. We'll then lose the bug-reports from that part of the
linux-users.

> You see the part that lots of asserts and debug prints  may go.
> I see the advantage, that  a lot of them can come, at no cost.

> Besides, if you want to have some assert anyway, then do not write
> it with system-wide macro but make your own or mark it as "included
> allways".  Faulty logic.

Well, your system-wide macro should have that option. But it will
be too easy to just disable it, and lose the debugging info. 

Sure if we'd convert to using your solution right now, we'd leave in
lots of those asserts and debugging prints "by default" exactly as
they are now. There possbily wouldn't even be a byte difference in the
binary. But in time, there will be many places where it is seen as
appropriate to put the test out-of-commission when marked as
"production" kernel.


		Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
