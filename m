Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbTIEN23 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 09:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbTIEN23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 09:28:29 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:39920 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262600AbTIEN21
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 09:28:27 -0400
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: insecure <insecure@mail.od.ua>, Michael Frank <mhf@linuxmail.org>,
       Yann Droneaud <yann.droneaud@mbda.fr>,
       fruhwirth clemens <clemens-dated-1063536166.2852@endorphin.org>
Subject: Re: nasm over gas?
Date: Fri, 5 Sep 2003 08:27:17 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
References: <20030904104245.GA1823@leto2.endorphin.org> <200309042257.12739.mhf@linuxmail.org> <200309050128.47002.insecure@mail.od.ua>
In-Reply-To: <200309050128.47002.insecure@mail.od.ua>
MIME-Version: 1.0
Message-Id: <03090508271700.01152@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 September 2003 17:28, insecure wrote:
> On Thursday 04 September 2003 17:57, Michael Frank wrote:
> > Concur, not worthwhile to start using a fairly unsupported tool in the
> > kernel.
> >
> > As to using assembler, It is better to get rid of it but in special
> > cases. Todays compilers are the better coders in 98+% of applications,
> > and if you
>
> Better coders? Show me the evidence.
>
> > follow some of the discussions here on the list, you will be amazed what
> > people do with a C compiler - all portable and much more maintainable.
>
> Portable yes. Maintainable yes. Better code _no_.
>
> I'd say compiler generated asm code quality can be anywhere in between of
> "hair raising crawling horror" and "not so bad although I can do better".
>
> I have never seen really clever compiler yet. Writing a good compiler
> is a very tough thing to do.

Actually, you mean "writing a good optimizer is a very tough thing to do".

The problem is NOT the compiler, or the coder. A "well defined" algorithm
such as the twofish mentioned CAN be compiled well by almost any compiler,
but the code optimizer MUST be at the highest level. There is also the
problem that what is optimum for one CPU, is NOT optimum for the next
generation, even if it uses the same identical architecture. This is where
the human coder can beat the compiler. That person will make many, many passes
through the code, and try similar/related instructions to optimize the result.
This amount of optimization also means that the result may not work at all on
a different processor member of the architecture, it is MUCH more likely to
run slower. Even minor things like the size of cache in the processor will
affect the human coder.

This a compiler cannot do since the optimizer is targeted toward a family of
processors and not a single member of that family. It will provide the most
compatibility. And since it is in a higher level language, the translation to
many other architectures is possible, even those that do not have available
human coders. The advantage the compiler has is that the optimizer can recieve
input from MANY excellent coders contributing rules for code generation. This
give the compiler the ability to surpass 90+% of the coders, and exceed the
productivity of all the assember coders.

The final question is "Is it fast enough?"

Only if this question is NO does it make sense to do assember. It doesn't
matter if it can be faster. And portability means you don't have to speed
hours rewriting it...

