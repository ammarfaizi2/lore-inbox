Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbVIGMGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVIGMGJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 08:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVIGMGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 08:06:09 -0400
Received: from dizz-a.telos.de ([212.63.141.211]:32648 "EHLO mail.telos.de")
	by vger.kernel.org with ESMTP id S1751203AbVIGMGI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 08:06:08 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: kbuild & C++
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Date: Wed, 7 Sep 2005 14:04:58 +0200
Message-ID: <809C13DD6142E74ABE20C65B11A2439809C4C0@www.telos.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kbuild & C++
Thread-Index: AcWzkv6CJZ5YdfTXSD6u46UVfUIVagACyb6Q
From: "Budde, Marco" <budde@telos.de>
To: "Bernd Petrovitsch" <bernd@firmix.at>
Cc: <linux-kernel@vger.kernel.org>
X-telosmf: done
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Yes, this is a general problem with integrated c/c++ stuff like
> Win-Visual C++. 

not all Windows users do not know what they are doing :-).
Speaking for myself: I am programming under Linux and
Windows (with more than 10 years experience in C and C++)
and I do know the differences. So please do not call
people idiots only because the are writing software under
Windows.

> People think that they can mix it freely, 

They can do.

> in fact they
> are using *only* C++ (it just happens that some part of the source is
> compilable with a C compiler, but since you compile everything with
the
> C++ compiler pressing F9, no one sees the difference).

So if I compile a library with gcc and link the code to a g++
program, the complete program gets compiled with the C++ compiler?
Interesting :-).

> Why do you think are all these "#ifdef _cpluplus" stuff in the header
> files for?

To support mixed code, because otherwise e.g. a C++ compiler cannot
use a library compiled with a C compiler.

> We re on linux-kernel@ here, so we don't care *here* for user-space
> software (only for the interface - i.e. sys-calls).

When you develop a complete product consisting of the embedded
firmware, the driver, and the user space software, you always have
to decide, where to put the code. And in such a case it is really
nice, when you can use the same language in all layers.

> And for embedded usage C++ is unsusable in user-space too since it
will
> ex-bloat the whole software if people simply pull-in usual and/or
common
> C++ libraries like the STL and use them without knowing how much
object
> code they explode with it (if used without thinking).

This applies for all languages. If you do not know, what you are doing,
you can write really awful code. And I cannot agree, that C++ results to
larger code. 

> Which is again wrong. You can OO software without OO languages (though
> you loose some nice features and checking).

If you are an experienced OO programmer, you do not want to use
languages like plain C, because they result into worse code and
make life more difficult. If you do not like any kind of abstraction,
why are you using C instead of pure assembler?

> Is is impossible anyways since the in-kernel interfaces are probably
> quite different (though I don't know anything about ).

A lot of code (backend code) does not need any access to
libraries/interfaces.

> First, how much of it is really the source of a kernel driver (in the
> sense of a Unix/Linux kernel driver)?

At the moment you really need all the code to control all variants of
the hardware. Yes, it is not a good design. We know it, our customer
knows it, but at the moment we have to live with the situation.

> And second, no one expects that you convert your driver source. Just
> write it from scratch 

Can you estimate what such a redesign would cost our customers?
You would need several years to redesign the concept.

cu, Marco

