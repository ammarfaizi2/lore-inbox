Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264516AbRFTRjK>; Wed, 20 Jun 2001 13:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264517AbRFTRjA>; Wed, 20 Jun 2001 13:39:00 -0400
Received: from [195.63.194.11] ([195.63.194.11]:8210 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S264516AbRFTRiu>;
	Wed, 20 Jun 2001 13:38:50 -0400
Message-ID: <3B30DF30.9ED9889B@evision-ventures.com>
Date: Wed, 20 Jun 2001 19:36:48 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: landley@webofficenow.com, linux-kernel@vger.kernel.org
Subject: Re: [OT] Threads, inelegance, and Java
In-Reply-To: <20010620042544.E24183@vitelus.com> <01062007252301.00776@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:

> The same arguments were made 30 years ago about writing the OS in a high
> level language like C rather than in raw assembly.  And back in the days of
> the sub-1-mhz CPU, that really meant something.

And then those days we are still writing lot's of ASM in kernels...

> I don't know about that.  The 8 bit nature of java bytecode means you can
> suck WAY more instructions in across the memory bus in a given clock cycle,
> and you can also hold an insane amount of them in cache.  These are the real

What about the constant part of instructions? What about the alignment
characteristics
of current CPU busses?

> performance limiting factors, since the inside of your processor is clock
> multiplied into double digits nowdays, and that'll only increase as die sizes
> shrink, transistor budgets grow, and cache sizes get bigger.
> 
> In theory, a 2-core RISC or 3-core VLIW processor can execute an interpretive
> JVM pretty darn fast.  Think a jump-table based version (not quite an array

Bullshit! In theory the JVM resembles some very very old instruction
set well suited for a CISC CPU. In esp. the leak of registers is even
bigger
then on i386 arch. And bloody no compiler will be able to optimize this
sanely... And then there arises the problem of local variable management
and
so on. There where attempts already made to design a CPU according to
this
specs. As far as one can see they have all failed. Even Sun himself gave
up
his design. The compact instruction set is due to Javas inheritance from
the embedded world - nothing else. Too compact instruction set designs
make
for very nasty instruction decoders and therfore slow CPUs. This
complexity can be better overcome by the IBM memmory compressor chip
then in the instruction set itself.

> Or if you like the idea of a JIT, think about transmeta writing a code
> morphing layer that takes java bytecodes.  Ditch the VM and have the
> processor do it in-cache.

Blah blah blah. The performance of the Transmeta CPU SUCKS ROCKS. No
matter
what they try to make you beleve. A venerable classical desing like
the Geode outperforms them in any terms. There is simple significant
information
lost between compiled code and source code. Therefore no JIT compiler
in this world will ever match the optimization opportunities of a
classic
C compiler! IBM researched opportunities for code morphing long ago
before
Transmeta come to live - they ditched it for good reasons. Well the
actual
paper states that the theorethical performance was "just" 20% worser
then
a comparable normal design. Well "just 20%" is a half universe diameter
for
CPU designers.

> This doesn't mean java is really likely to outperform native code.  But it
> does mean that the theoretical performance problems aren't really that bad.
> Most java programs I've seen were written by rabid monkeys, but that's not
> the fault of the language. [1].

Think garbage collector - this explains nearly 90% of the performance
problems
Java code has. The remaining 10% are still by a factor of 10 bad in
comparision to classical code. Think zero copy on write - most Java code
induces insane
amounts of copyiing data around for no good reaons (Sring class and
friends
for example). Java code will never ever perform well.
 
> How many instructions does your average processor really NEED?  MIT's first
> computer had 4 instructions: load, save, add, and test/jump.  We only need 32
> or 64 bits for the data we're manipulating.  8 bit code is a large part of
> what allowed people to write early video games in 8k of ram.

Ton's of them. Please just remember how the RISC instruction set designs
evolved
over time. It was no accident!

-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort:
ru_RU.KOI8-R
