Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313206AbSDDPxk>; Thu, 4 Apr 2002 10:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313207AbSDDPxW>; Thu, 4 Apr 2002 10:53:22 -0500
Received: from chaos.analogic.com ([204.178.40.224]:35458 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S313206AbSDDPxF>; Thu, 4 Apr 2002 10:53:05 -0500
Date: Thu, 4 Apr 2002 10:55:02 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ingo Molnar <mingo@redhat.com>
cc: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>,
        Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <Pine.LNX.4.44.0204040747260.25330-100000@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.3.95.1020404095833.16825A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2002, Ingo Molnar wrote:

> 
> On Thu, 4 Apr 2002, Tigran Aivazian wrote:
> 
> > [...] Namely, in the sense that it is inconsistent with the similar
> > situation in the case of libraries or even system calls. I don't see why
> > exporting kernel symbols should be so radically different and extremely
> > sensitive to the nature of the consumer's license for some symbols but
> > not for others...
> 
> Tigran, the difference is very very fundamental, please think about it,
> and please try to ignore the fact that you are working for Veritas.
> Internal modules of the GPL kernel are just a technical modularization of
> a complete and unified GPL-ed work. We want it to stay consistent, we want
> *our* work to be fully and completely debuggable, supportable and we want
> to be able to understand and develop any part of it. This is our intent.
> 
> the moment you start to argue 'but why cannot we just add this set of
> EXPORTs and put our binary-only modules here and there' you are in essence
> questioning our freedom to specify the license of our work. You are
> abusing the internal modularization mechanizm to put in code that we
> cannot debug, cannot read and cannot develop and cannot support in any
> reasonable way. It's like exchanging kernel/sched.o with your binary-only
> implementation and not publishing the source code of it. If you want to
> play such games then you have to implement the other 4 million lines as
> well, nobody prevents you to do that.
> 
> system calls are a published, honored, maintained interface. User-space
> applications are indpendent works not derived from the GPL-ed kernel in
> any way. Hence the exception.
> 
> historically we have also chosen to to provide a different type of API
> towards more or less clearly separate works, like independently developed,
> non-GPL hardware drivers. Let yourself not be confused by the fact that
> the same technical mechanizm is also used to demand-link separate smaller
> parts of the kernel work as well.
> 
> The impact of binary-only modules on the kernel's development architecture
> is not zero but not overly significant either, so most of us are pretty
> pragmatic about that, as long as binary-only module vendors are not
> abusing this mechanizm to impact the integrity of the kernel and create
> clearly derived works without obeying the rules of the GPL. And it's clear
> that internal symbols are just that: internal, still part of the kernel
> work. [and directly resulting from that, they obey the GPL.]
> 
> I consider 'abuse' for example a kernel derivative with a 'modified'
> scheduler. The day it will be possible to put a binary-only sched.o into
> the kernel i'll stop doing Linux. I am not here to develop some 'lite'
> version of the OS, where all the interesting stuff happens behind closed
> doors. I'm not here either to see the quality of the OS degrade due to
> sloppy programming in widely used binary-only modules, without being able
> to fix it.
> 
> The GPL right now protects our work from being abused in such a way - it's
> illegal to provide a binary-only sched.o and compile a kernel product from
> that, because the resulting kernel is still one work and the whole work
> must still be under the GPL. It's equally illegal to recover the location
> of sched.o in the final kernel image and runtime relink it with a
> binary-only sched.o. It's equally illegal to accomplish the same over the
> internal module interface.
> 
> Think about it, every separate .o in the Linux kernel can be equivalently
> expressed in terms of a EXPORT-ed module interface, GPL-ed header files
> and a closed-source module. There is a good reason why the GPL forbids
> such freely defined 'module interfaces' to be added. Think of the GPL as
> the price you pay for being able to use the Linux kernel's source code or
> being allowed to link to it - you are not forced in any way to do that.
> 
> and no, you have no *right* to link a binary-only sched.o to the Linux
> kernel - even if you develop a sched.c 'separately' - and intuitively feel
> that it's somehow a separate work, the end result is still a derivative of
> the kernel. And this violation of the license is illegal in most
> countries, it's even a crime in some countries.
> 
> 	Ingo
> 


I am amazed with the number of "lawyers" we have here. Maybe it's
just some semantics or property of translation, but it is not
illegal to violate a license.

The term "illegal" historically refers to laws. Laws are rules
enacted by governments.

A license is permission, granted by a property owner, usually
but not always, setting forth the conditions of use.

If I give you permission to use my driveway for parking guests
during your party, I am granting you a "non-exclusive license to
use my property under specified conditions". If you abuse that
license, I can sue you.  However, the fact that you failed to
remove your vehicles after your party was not "illegal".

Individuals do not make laws. Governments do that. Individuals
can make contracts, issue licenses, and engage in all kinds of
commerce, but they cannot make laws. Therefore, the violation
of some contract, license, or other such agreement is not
illegal.

Please do not use this word when you are referring to a license.
The correct word, except where a contract is involved, is "tort".
In the case of a contract, the correct word is "breach". They
are not interchangeable. The recent attempts by the United States
Congress to turn "tort" into "unlawful" in the case of copy-protection
is an example of why we must protect these words.

The same applies to error messages and warnings issued by software.
There is no such thing as an "illegal operand" or "illegal" parameter.
The correct word is "invalid". Software does not make laws, therefore
has no right to use the word "illegal". Instead, software makes rules.
They do not have the power of law.

The GPL document is a "license". It does not have the power or
scope of "law". It is not even a "contract" because a contract
requires an agreement. The GPL document forces a license and
seems to imply some sort of an agreement, but an agreement cannot
be implied. It must be specifically stated and the parties to
that agreement must individually recognize that such an agreement
exists, usually by setting forth a signature by all parties to
that agreement.

Enforcement of a license is up to the property owner. If a licensee
violates the specifics, or even the intent of a license, the
property owner who issued that license, may bring civil action
against the violator. In the United States, (and it's different in
different states) such a civil action may prevail if the property
owner can show that he/she was harmed by the tort. For instance, if
you parked a truck on my property, rather than an automobile, you
may have violated either the wording or the intent of the license
issued, however it's unlikely that I would prevail in court bringing
an action against you unless your truck was so heavy it damaged my
property.

The intent of GPL "seems to be" to give contributors the credit
they deserve. It is not usually possible to foresee all possible
uses of a work at the time a license is granted. At the time
GPL was written, there was no possibility of "binary-only" modules
because there weren't even any modules.

If the contributors to Linux want the world to use Linux, they
need to understand that many companies cannot divulge or publish
their intellectual property (read supply source-code), even if
they wanted to. This could result in a stockholder lawsuit because
non-technical persons (stockholders) may think that their equity
value is being reduced by the company "giving away" intellectual
property that the stockholders paid for.

If you want Linux to be used in Airbus Industries, Boeing, etc.,
aircraft to replace those gawdawful flight-management systems now
used, you need to provide hooks so that "unpublished works" can
be linked into the Operating System. This is just an example, but
there is no way in hell that you will ever see the source-code for
such systems unless you worked for those companies. I personally
would rather have Linux in the FMS of the airplane I'm traveling on
then Win/CE.

There is an awful lot or energy being expended in an attempt to
exclude commercial and industrial use of Linux. This is very
counter-productive and may be quite harmful.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

