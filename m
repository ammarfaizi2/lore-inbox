Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281520AbRKHLt5>; Thu, 8 Nov 2001 06:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281521AbRKHLtq>; Thu, 8 Nov 2001 06:49:46 -0500
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:54542 "HELO
	ns.higherplane.net") by vger.kernel.org with SMTP
	id <S281520AbRKHLtm>; Thu, 8 Nov 2001 06:49:42 -0500
Date: Thu, 8 Nov 2001 22:49:51 +1100
From: john slee <indigoid@higherplane.net>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
Message-ID: <20011108224951.H2430@higherplane.net>
In-Reply-To: <20011108171947.G2430@higherplane.net> <200111080814.fA88EXn157226@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200111080814.fA88EXn157226@saturn.cs.uml.edu>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 03:14:32AM -0500, Albert D. Cahalan wrote:
> No, not a union mount. We didn't have that last time I looked,

i was under the impression al viro had them planned for 2.5...
hopefully i'm right as i find them rather useful at times under other
systems (openbsd)

> and I have some doubts that it would work all that well. Even

why not?  the two namespaces should not clash... and i really hope that
there aren't any tools out there referencing proc via inode num.  what
problems do you see?

> if it does work, it doesn't provide drop-in kernel compatibility
> and doesn't help encourage transition.

it doesn't exactly discourage transition either, and i don't see how
changing proc to hide/not hide stuff encourages it.  at some point it
has to be a distribution issue, regardless of the transitioning scheme.

if a union could be made to work (and as above i'd like to know why it
couldn't, if only for my own education :-) it means you don't have to go
removing stuff later on.

> It would be reasonable to have a proc filesystem that could
> hide or disable half of the content -- either process files
> or the misc junk.
> 
> Let's have a filesystem mounted as type "proc" hide everything
> but the process directories by default. You can still read
> /proc/cpuinfo, but you can't see it when you do "ls /proc".
> Let's have  a filesystem mounted as type "kern" disable the
> process directories by default.

imho this violates the principle of least-surprise, although i suppose
if you're mounting the fs you're probably expecting it so its probably
ok.

curious,

j.

-- 
R N G G   "Well, there it goes again... And we just sit 
 I G G G   here without opposable thumbs." -- gary larson
