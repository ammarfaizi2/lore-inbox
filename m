Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154558-16160>; Fri, 18 Sep 1998 16:06:25 -0400
Received: from raptor.cqi.com ([205.252.44.227]:29723 "EHLO raptor.cqi.com" ident: "humbubba") by vger.rutgers.edu with ESMTP id <153987-16160>; Fri, 18 Sep 1998 14:27:09 -0400
From: RHS Linux User <humbubba@raptor.cqi.com>
Message-Id: <199809182157.RAA07779@raptor.cqi.com>
Subject: Helge, Forth is not an interpreter.
To: linux-kernel@vger.rutgers.edu
Date: Fri, 18 Sep 1998 17:57:46 -0400 (EDT)
Content-Type: text
Sender: owner-linux-kernel@vger.rutgers.edu


In reference to the wish for an "interpreter" in the kernel for
device drivers...

Forth is machine language for a virtual 2-stack machine.
This is a machine with no registers, not stacks implemented in
registers.
This machine language has ops at a very low level to implement
a compiler and an interpreter. 
Open Firmware is the example. The author of Open Firmware, Mitch
Bradley, was a bigwig on the ANSI Forth Standard commitee.

How the Forth virtual machine is implemented varies from silicon
to Java. A Forth running on a silicon 2 stack machine OUTperforms
anything else. gForth uses the labels-as-values capability of GNU
C ( which egcs seems to have also) to "thread" Forth primitives
together in what is called Indirect Threading in the Forth world.
This gives a level of performance unattainable in ANSI C. The first
Forth-in-C was written by the above Mitch Bradley, who invented 
"switch-threading" for it. His CForth was a single C switch statement.
One of the authors of GForth has an x86 Forth called BigForth.
It outperforms GNU C for some floating-point operations.

The reason for Open Firmware is this...
a driver manufacturer writes ONE driver in ANSI Forth. It is
distributed as ANSI Forth sourcecode. How it performs is 
entirely up to the OS. If that OS was on a silicon Forth engine
CPU that driver would compile to the screamingest stuff you've 
ever seen.

I don't know the specifics of Open Firmware, since Open here
has the usual meaning, but Forth compiles fully, to the limit
of how the Forth VM is implemented.
There would be a performance hit on Forth drivers in any Linux
scenario currently existing, but not in the scale that the 
term "interpreter" implies.
Having a compiler running in kernel space would be pretty wacky.
The unknowns that emerge is beyond my imagination. But due to the
succinct, efficient, minimalist design of Forth, those unknowns are
far less with Forth than anything else.


Rick Hohensee          http://cqi.com/~humbubba
colorg on EFnet IRC    #linux chanop
Forth  C   Linux   Perl graphics   music    Md., USA
This is your brain on colorg --> (@#*%@#() <---~~~_()()(
Any questions?







-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
