Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132187AbQKWAE1>; Wed, 22 Nov 2000 19:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132208AbQKWAES>; Wed, 22 Nov 2000 19:04:18 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:47113 "EHLO saturn.cs.uml.edu")
        by vger.kernel.org with ESMTP id <S132187AbQKWAEB>;
        Wed, 22 Nov 2000 19:04:01 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200011222332.eAMNWZj269304@saturn.cs.uml.edu>
Subject: Re: silly [< >] and other excess
To: kaos@ocs.com.au (Keith Owens)
Date: Wed, 22 Nov 2000 18:32:35 -0500 (EST)
Cc: christian.gennerat@vz.cit.alcatel.fr (Christian Gennerat),
        Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3626.974931750@ocs3.ocs-net> from "Keith Owens" at Nov 23, 2000 09:22:30 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:
> Christian Gennerat <christian.gennerat@vz.cit.alcatel.fr> wrote:
>> Andries.Brouwer@cwi.nl a =E9crit :

>>>  I also left something else
>>> that always annoyed me: valuable screen space (on a 24x80 vt)
>>> is lost by these silly [< >] around addresses in an Oops.
>>> They provide no information at all, but on the other hand
>>> cause loss of information because these lines no longer
>>> fit in 80 columns causing line wrap and the loss of the
>>> top of the Oops.]

> You just broke ksymoops.

You can fix it. Keeping useful info on the screen is more important.

> Removing the [< >] is a bad idea, they are
> one of the few things that identifies the addresses in the log,
> otherwise they just look like hex numbers.  ksymoops has to scan log
> files which can contain anything and somehow pick out the interesting
> lines, you need some identifier on the lines.

If you see register names followed by hex numbers, you have
some debug data. Scan forward and backward 25 lines, grabbing
all 8-digit and 16-digit hex numbers. Sort the numbers, then
look up all of them.

Crude solutions don't break as often as fancy solutions.

> There should be no need to restrict the number of lines printed, it is
> limited by the top of the kernel stack.  If there are more than 32
> trace entries on the stack then they should be printed.

It could fill the screen. There is an expansion of 4-to-13 when
using the silly brackets, and a PC stack can be 6 or 7 kB long,
or perhaps many megabytes due to stack overflow. The standard
VGA screen only allows 4000 bytes of data.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
