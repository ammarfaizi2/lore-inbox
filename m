Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbTIENo5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 09:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbTIENo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 09:44:57 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:3456 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262736AbTIENox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 09:44:53 -0400
Date: Fri, 5 Sep 2003 14:57:46 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309051357.h85DvkLX000207@81-2-122-30.bradfords.org.uk>
To: root@chaos.analogic.com
Subject: Re: nasm over gas?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Are there any buffer overflows or other security holes?
> > > > How can you be sure about it?
> > >
> > > How can you be sure? Mathematical program verification applies quite badly
> > > to assembler.
> >
> > The point is, if somebody does find a bug they will want to
> > re-assemble with Gas after they've fixed it.
> >
> > > > If your code fails on any one of these questions, forget about it.  If
> > > > it survives them, post your results and have someone else verify them.
> > >
> > > I'm sorry, your critique is too generel to be useful.
> >
> > It's not, all the time the argument is not against the assembler code,
> > but rather against $assembler!=Gas.
> >
> > John.
>
> All assemblers suck. However, they are exceeding useful. The
> code ends up being exactly what you write. Usually one only
> needs to learn one assembler per platform. It was a real shock
> for me to have to learn GAS, it was "backwards", seemed to
> think everything was a '68000, and basically sucked. However,
> once I learned how to use it, it became a useful tool.

Not sure whether you're agreeing with me or not, quite possibly
because my last comment used a double negative and was somewhat
ambiguous :-).

What I meant was that if a piece of perfect code exists, (and as you
point out, this can be mathematically _proven_ with assembler code,
not just demonstrated), the requirement for an open source assembler
other than Gas is not so much of a problem, because nobody should need
to touch that code.  If they do, they can translate it to Gas syntax.

If the possibility of bugs exists in the code, relying on
$assembler!=Gas is a bad thing, because there will be fewer people
willing to maintain it.

> The test of code that works in the 'real' world is called
> regression-testing. Basically, you run the stuff. You execute
> all "known" possible execution paths. If it works, it works.
> If it doesn't, you fix it until it does.

I totally agree.

> You need to test procedures as "black-boxes" with
> specified inputs and outputs. You also have to violate the
> input specifications and show that an error, so created, doesn't
> propagate. Such an error need not crash or kill the system, but
> it must be detected so that invalid output doesn't occur.
>
> Error-checkers like Lint, that use a specific langage such as 'C',
> can provide the programmer with a false sense of security. You
> end up with 'perfect' code with all the unwanted return-values
> cast to "void", but the logic remains wrong and will fail once
> the high-bit in an integer is set. So, in some sense, writing
> procedures in assembly is "safer". You know what the code will
> do before you run it. If you don't, stay away from assembly.

This is part of what makes someone a 'real' programmer, in my
opinion.

In my experience, 'Unreal' programmers tend to excessively re-use code
from other applications they've written, and just hack it about until
it works, at times leaving in code for features that are never used in
the new context :-).

John.
