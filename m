Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131840AbQKKA2L>; Fri, 10 Nov 2000 19:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131879AbQKKA2B>; Fri, 10 Nov 2000 19:28:01 -0500
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:57092 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S131840AbQKKA1s>; Fri, 10 Nov 2000 19:27:48 -0500
Date: Fri, 10 Nov 2000 19:27:51 -0500
From: Michael Meissner <meissner@spectacle-pond.org>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Michael Meissner <meissner@spectacle-pond.org>,
        George Anzinger <george@mvista.com>,
        "linux-kernel@vger.redhat.com" <linux-kernel@vger.kernel.org>
Subject: Re: Where is it written?
Message-ID: <20001110192751.A2766@munchkin.spectacle-pond.org>
In-Reply-To: <20001110184031.A2704@munchkin.spectacle-pond.org> <200011110011.eAB0BbF244111@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200011110011.eAB0BbF244111@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Fri, Nov 10, 2000 at 07:11:37PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000 at 07:11:37PM -0500, Albert D. Cahalan wrote:
> Michael Meissner writes:
> 
> > It may be out of print by now, but the original reference
> > for the x86 ABI, is the:
> >
> > 	System V Application Binary Interface
> > 	Intel386 (tm) Processor Supplement
> >
> > When Cygnus purchased the manual I have, many moons ago,
> > it was published by AT&T, with a copyright date of 1991,
> 
> Gee that looks old. Might there be better calling conventions
> for the Pentium 4 or Athlon? Memory latency, vector registers,
> and more direct access to floating-point registers may mean
> we ought to change the calling conventions. One would start
> with the kernel of course, because it stands alone.

Generally with ABIs you don't want to mess with it (otherwise you can't be
guaranteed that a library built by somebody else will be compatible with your
code, without all sorts of bits in the e_flags field).  It allows multiple
compilers to be provided that all interoperate (as long as they follow the same
spec).

Don't get me wrong -- in my 25 years of compiler hacking, I've never seen an
ABI that I was completely happy with, including ABI's that I designed myself.
ABIs by their nature are a compromise.  That particular ABI was short sighted
in that it wants only 32-bit alignment for doubles, instead of 64-bit alignment
for instance, and also doesn't align the stack to higher alignment boundaries.

-- 
Michael Meissner, Red Hat, Inc.
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
