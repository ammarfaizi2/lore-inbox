Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131714AbQKDIpH>; Sat, 4 Nov 2000 03:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132402AbQKDIo6>; Sat, 4 Nov 2000 03:44:58 -0500
Received: from windlord.Stanford.EDU ([171.64.13.23]:23751 "HELO
	windlord.stanford.edu") by vger.kernel.org with SMTP
	id <S132363AbQKDIor>; Sat, 4 Nov 2000 03:44:47 -0500
To: Michael Meissner <meissner@spectacle-pond.org>
Cc: Tim Riker <Tim@Rikers.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
In-Reply-To: <fa.g3i0smv.15loso7@ifi.uio.no> <fa.cjn9ksv.1a0m82t@ifi.uio.no>
	<ylbsvww97j.fsf@windlord.stanford.edu>
	<20001104034002.A26612@munchkin.spectacle-pond.org>
In-Reply-To: Michael Meissner's message of "Sat, 4 Nov 2000 03:40:02 -0500"
From: Russ Allbery <rra@stanford.edu>
Organization: The Eyrie
Date: 04 Nov 2000 00:44:39 -0800
Message-ID: <ylu29ounwo.fsf@windlord.stanford.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Meissner <meissner@spectacle-pond.org> writes:
> On Fri, Nov 03, 2000 at 10:19:12PM -0800, Russ Allbery wrote:

>> May I tentatively suggest that one point at which your resources could
>> productively be applied is towards improving the C99 compliance in gcc?
>> Clearly for the near to medium future the compiler that everyone will
>> use to build the Linux kernel will be gcc, which means that in order to
>> use any C99 syntax, it first has to be solid in gcc.  That means the
>> best way of introducing such things into the Linux kernel is to *first*
>> get the C99 support solid, reliable, and efficient in gcc, then once a
>> version of gcc is released with that support, help get Linux compiling
>> with that version of gcc.

>> *Then*, when that version of gcc can be made a prerequisite for the
>> kernel, you can start switching constructs over to the C99 syntax that
>> gcc supports.

> Hmmmmm.  Last month the compiler related thread on the kernel list was
> the kernel couldn't move to newer versions of the compiler because the
> compiler had changed things (where newer might mean either the latest
> snapshot de jour, or a tested/appropriately patched version based off of
> the snapshots, or even 2.95).

That's why I have the bit above about "help get Linux compiling with that
version of gcc."  My understanding is that the Linux core developers want
to support newer versions of gcc as they come out, but that it's a slow
process and relies on volunteers tracking down what's changed in gcc and
updating the kernel to either use coding constructs that work better with
a newer gcc or to use appropriate flags to turn off new gcc features that
don't work well with the kernel (like strict-aliasing).

Clearly people who have a strong interest in being able to use newer
versions of gcc for kernel compiles (such as people who want to
*eventually* be able to use some C99 features) are the best people to help
do this work since they'll be scratching their own itch, so to speak.

> Now people seem to be advocating moving the kernel to use features from
> C99 that haven't even been coded yet (which mean when coded using the
> latest codegen as well).

People may be advocating that, but I think that in my message above, I'm
pretty clearly *not* advocating this.  I'm saying that if the goal is to
eventually be able to use C99 syntax in the Linux kernel, the obvious
first step that has to be accomplished before that goal is even remotely
possible is to make sure that the compiler that the kernel uses has good
C99 support.  And that achieving this goal has many benefits for the
community as a whole at the same time.

We have to get to point A before we can get to point H.  That doesn't mean
that point A leads directly to point H without the intervening B-G.  :)

> Note, I seriously doubt Linus will want a flag day (ie, after a given
> kernel release, you must use revision n of the compiler, but before that
> release, you must use revision n-1 of the compiler), so you still have
> to maintain support for the old GCC way of doing things, in addition to
> the C99 way of doing things probably for a year or so.

It depends on the time scale.  I don't believe compilers older than 2.7.2
are really supported any more, are they?  And I would expect that before
*too* much longer, compilers older than egcs 1.1 won't be supported any
more, since some of the bugs in 2.7.2 are already raising their heads.

With time, the kernel does eventually change its minimum supported gcc
version number.  As soon as that minimum supported version number reaches
a version of gcc that supports a C99 feature, that feature can then
reasonably be used in the kernel.  It's quite possible, even likely, that
having the C99 feature isn't enough reason to move the minimum supported
version number by itself, but with enough patience it will creep forward
anyway.

-- 
Russ Allbery (rra@stanford.edu)             <http://www.eyrie.org/~eagle/>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
