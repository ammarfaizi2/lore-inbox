Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132050AbRAIVZo>; Tue, 9 Jan 2001 16:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132039AbRAIVZh>; Tue, 9 Jan 2001 16:25:37 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:6416 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129406AbRAIVZV>;
	Tue, 9 Jan 2001 16:25:21 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200101092124.f09LOcB326931@saturn.cs.uml.edu>
Subject: Re: [PATCH] More compile warning fixes for 2.4.0
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 9 Jan 2001 16:24:38 -0500 (EST)
Cc: acahalanrth@twiddle.net, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10101091048590.2070-100000@penguin.transmeta.com> from "Linus Torvalds" at Jan 09, 2001 10:51:23 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> On Tue, 9 Jan 2001, Albert D. Cahalan wrote:

>> [about labels w/o statements after them]
>>
>>>> Is this really a kernel bug? This is common idiom in C, so gcc
>>>> shouldn't warn about it. If it does, it is a bug in gcc IMHO.
>>>
>>> No, it is not a common idiom in C.  It has _never_ been valid C.
>>>
>>> GCC originally allowed it due to a mistake in the grammar; we
>>> now warn for it.  Fix your source.
>>
>> Since neither -ansi nor -std=foo was specified, gcc should just
>> shut up and be happy. Consider this as another GNU extension.
>
> No, it was a gcc bug that gcc accepted the syntax in the first place.

Sure. I'd always thought it was intentional though.

> Let the gcc people fix the bugs they find without complaining about them.
> After all, gcc would have been perfectly correct in signalling this as a
> syntax error, and aborted compilation. The fact that gcc only warns about
> it is a sign of grace - it's not as if it is a _useful_ extension that
> gives the programmer anything new and should be left in for that reason.

It is slightly useful: appearance, ease-of-use, etc.

Code is partly for humans to read, and is often written by
humans too. The standard syntax has worthless ugly junk.
The extension doesn't break any valid K&R, C90, or C99 code.

Obviously, considering the kernel source, people _like_ this:

void foo(void){
  if(bar()) goto out;
  baz();
out:
}

If it broke valid C99 code, then sure, it would have to go.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
