Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264034AbUDFWYD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 18:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264037AbUDFWYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 18:24:03 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:51213 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264034AbUDFWXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 18:23:53 -0400
Message-ID: <407332E0.2040809@techsource.com>
Date: Tue, 06 Apr 2004 18:44:48 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
CC: root@chaos.analogic.com, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel stack challenge
References: <20040406211550.30263.qmail@web40514.mail.yahoo.com>
In-Reply-To: <20040406211550.30263.qmail@web40514.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Sergiy Lozovsky wrote:

> 
> So, you still didn't say a word why it was a bad
> choice. Can you share your thought on that?

I've seen (and produced) lots of words to that effect.

> 
> I didn't just pick up LISP - I EXPLAINED my reasons.
> if you missed my explanation here is a short summary.
> 
> 1. I needed solution to implement some procedural
> functionality within the kernel. This functionality
> should be expressed with some high level language
> (shorter development time and more compact source
> code). This functionality should be
> loadable/unloadable to the kernel.

This isn't a problem.

> 
> 2. Size of the interpreter should be minimal.

You say your LISP interpreter is about 100K.  This is hardly minimal. 
There are things which are much smaller which will do the job AND won't 
have the stack-exploding side-effects.

> 
> 3. Kind of real time - no ordinary garbage collector.
> And automatic memory management at the same time.

How about one which doesn't NEED garbage collection?  For instance, if 
you were to make it object-based, rather than object-oriented, then 
you'd pre-allocate all structures at compile time.  Ada is(was?) like this.

> 
> 4. Easiest syntax possible - so interpreter would be
> compact. Simpler - the better :-) I don't like
> complicated things :-)

LISP completely violates this requirement.  There are languages which 
have MUCH simpler syntax than LISP.

And I'm talking simpler for the PROGRAMMER.  It can be as complex as you 
like for the compiler, because THE COMPILER WOULD BE IN USERSPACE.

> 
> 5. Well known. So there would be people around who
> already know this language and expectations are clear.
> And there are books around about this language.

LISP completely violates this requirement.  While I appreciate the power 
of LISP for abstraction, list processing, and how it lends itself 
towards many AI-related tasks, it's not a commonly-used language.

Besides, you have already invalidated this point by stating that the 
people actually USING this policy engine would never look at the code, 
because they would select amongst a set of canned policies using a web 
browser.  In this case, the form of the policy code is completely 
irrelevant.

> 6. Ability to handle/represent complex data
> structures.

LISP is not superior to other languages in this regard.  I 
handle/represent complex data structures in C, C++, Java, Javascript, 
PHP, SQL, BASIC, Pascal, Tcl... I guess FORTRAN is the only one I don't 
do complex structures in.

> 7. Errors/bugs in loadable functions should not cause
> trouble for other tasks and kernel itself. (To the
> extent possible for sure).

The only way to be sure of this is to do the processing in userspace. 
Putting that aside, any carefully-written interpreter would be able to 
provide this security.  Furthermore, something simpler than a LISP 
interpreter would be easier to VERIFY that it was secure.

> 
> 8. It should be universal (general purpose) language
> which gives ability to make any manipulations with
> numbers, strings, bits and data structures. So I would
> be sure that functionality I want to express is not
> limited by the language.

Again, LISP is not superior to other languages in this regard.

> That's why particular LISP interpreter was chosen.
> It's wrong to say that just language was chosen. I
> would never start work of fitting Common Lisp into the
> kernel. Particular general purpose language
> interpreter was chosen.

You have to understand that you're speaking to a list full of zealots 
that understand zealotry VERY WELL.  Even Linux scratches his head (or 
so I assume) every time some Linux zealot comes along wanting to run 
Linux on some two-bit (pun intended) processor that was never designed 
to run an OS.

Thus, when someone comes along suggesting that they put a beast like a 
LISP interpreter into the Kernel, something that violates Linux 
philosophy on SOOO many levels, the "he must be a LISP zealot" red 
lights start flashing, because only a LISP/whatever zealot would choose 
to do something so ostensibly impractical.  That is to say, someone who 
was NOT a LISP/whatever zealot would have chosen something more 
appropriate, while we have observed so many times 
Linux/LISP/MacOS/BeOS/Perl/Ruby/Python/whatever zealots who want to push 
their square peg into every round hole they can find.  (so to speak)

I personally like to write Nuclear Bomb simulators in BASH to run on 
5mhz processors with 1K of RAM.  *snort*

