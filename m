Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132853AbQLNU5f>; Thu, 14 Dec 2000 15:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133037AbQLNU5Z>; Thu, 14 Dec 2000 15:57:25 -0500
Received: from front4m.grolier.fr ([195.36.216.54]:34260 "EHLO
	front4m.grolier.fr") by vger.kernel.org with ESMTP
	id <S132853AbQLNU5S> convert rfc822-to-8bit; Thu, 14 Dec 2000 15:57:18 -0500
Date: Thu, 14 Dec 2000 20:26:31 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: "David S. Miller" <davem@redhat.com>, shirsch@adelphia.net,
        linux-kernel@vger.kernel.org
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released 
In-Reply-To: <200012140457.eBE4vNs43248@aslan.scsiguy.com>
Message-ID: <Pine.LNX.4.10.10012142008410.1470-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2000, Justin T. Gibbs wrote:

> >   Date: 	Wed, 13 Dec 2000 20:56:08 -0700
> >   From: "Justin T. Gibbs" <gibbs@scsiguy.com>
> >
> >   None-the-less, it seems to me that spamming the kernel namespace
> >   with "current" in at least the way that the 2.2 kernels do (does
> >   this occur in later kernels?) should be corrected.
> >
> >Justin, "current" is a pointer to the current thread executing on the
> >current processor under Linux.  It has existed since day one of the
> >Linux kernel and probably will exist till the end of it's life.
> >
> >I'm sure the BSD kernel has some similar bogosity :-)
> 
> BSD has curproc, but that is considerably less likely to be
> used in "inoccent code" than "current".  I mean, "current what?".
> It could be anything, current privledges, current process, current
> thread, the current time...

"buf, buffers, type, version" (of what ?) with FreeBSD kernel (if they
still exist), but they are global variables, not macros.

By the way, SYM-2, that is "FreeBSD sym back to Linux but still in
FreeBSD":), clashed on Linux "current" as well. Reason is that the
corresponding code was based on yours :)  (as indicated in the sym driver
source). I have changed "current" by "curr". This is as clear and has the
advantage of scaling better with "user" and "goal" (4 characters each).

   tinfo.goal
   tinfo.user
   tinfo.curr

Just a suggestion.

  Gérard.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
