Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132450AbQKDGTo>; Sat, 4 Nov 2000 01:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132486AbQKDGTe>; Sat, 4 Nov 2000 01:19:34 -0500
Received: from windlord.Stanford.EDU ([171.64.13.23]:9927 "HELO
	windlord.stanford.edu") by vger.kernel.org with SMTP
	id <S132450AbQKDGTU>; Sat, 4 Nov 2000 01:19:20 -0500
To: Tim Riker <Tim@Rikers.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
In-Reply-To: <fa.g3i0smv.15loso7@ifi.uio.no> <fa.cjn9ksv.1a0m82t@ifi.uio.no>
In-Reply-To: Tim Riker's message of "Thu, 2 Nov 2000 23:22:36 GMT"
From: Russ Allbery <rra@stanford.edu>
Organization: The Eyrie
Date: 03 Nov 2000 22:19:12 -0800
Message-ID: <ylbsvww97j.fsf@windlord.stanford.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Riker <Tim@Rikers.org> writes:

> Agreed. C99 does not replace all the needed gcc features. We should
> start using the ones that make sense, and push for
> standardization/documentation on the rest.

> I'm perfectly happy with this as a long term goal. I'll put what effort
> I can into moving that direction without breaking the existing world as
> we know it.

May I tentatively suggest that one point at which your resources could
productively be applied is towards improving the C99 compliance in gcc?
Clearly for the near to medium future the compiler that everyone will use
to build the Linux kernel will be gcc, which means that in order to use
any C99 syntax, it first has to be solid in gcc.  That means the best way
of introducing such things into the Linux kernel is to *first* get the C99
support solid, reliable, and efficient in gcc, then once a version of gcc
is released with that support, help get Linux compiling with that version
of gcc.

*Then*, when that version of gcc can be made a prerequisite for the
kernel, you can start switching constructs over to the C99 syntax that gcc
supports.

This is obviously a slow and drawn-out process, but in the end the free
software community not only gets a better-documented syntax in the Linux
kernel code that's more likely to be clearly supported and not broken by
gcc in the future, but the broader community also gets a more closely
conforming compiler that supports the latest C features.

<http://gcc.gnu.org/c99status.html> has the current status of the
development versions of gcc.  There are a lot of items listed as Broken or
Missing that I'm sure the gcc developers would welcome volunteer help
with.

(Note that there is not and quite likely never will be any standard syntax
for in-line assembly, as the standardization committee considers it to be
outside their scope, so I doubt you'll ever be completely successful.  But
I think your goal is one that can reap benefits even when only partially
accomplished.)

-- 
Russ Allbery (rra@stanford.edu)             <http://www.eyrie.org/~eagle/>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
