Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293632AbSDIQnJ>; Tue, 9 Apr 2002 12:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310206AbSDIQnI>; Tue, 9 Apr 2002 12:43:08 -0400
Received: from mail.uni-freiburg.de ([132.230.2.46]:40389 "EHLO
	uni-freiburg.de") by vger.kernel.org with ESMTP id <S293632AbSDIQnH> convert rfc822-to-8bit;
	Tue, 9 Apr 2002 12:43:07 -0400
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: C++ and the kernel
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
In-Reply-To: Chris Friesen's message of "Tue, 09 Apr 2002 10:00:25 -0400"
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/20.7
Date: 09 Apr 2002 18:45:40 +0200
Message-ID: <xb7y9fw6csr.fsf@camaro.informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=cn-big5
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Chris" == Chris Friesen <cfriesen@nortelnetworks.com> writes:

    >> It is quite unlikely that a C++ compiler will make more
    >> efficient code than a C compiler. In fact, the code generator
    >> will likely be the same. The C++ compiler will end up
    >> generating some preamble code as part of the function-calling
    >> mechanism, that is not necessary in C. This means that it will
    >> generate a bit more code.

    Chris> C++ has tigher constraints on code than C.  This can allow
    Chris> a compiler to generate better code because it has more
    Chris> knowledge about what is going on.

There are  also many  GNU extensions  to C that  makes it  possible to
generate  better  code,  e.g.    marking  certain  functions  as  pure
functions.



    Chris> Your example is needlessly complex, and I'm sure you know
    Chris> this.  A more realistic comparison would be:

    Chris> cout << "Hello World!\n";

This has demonstrated that you don't know C++ _very_ well.  Instead of
the trailing "\n", a C++ programemr ought to write:

        cout << "Hello World!" << endl;

You seem  to *understand* C++  even worse than Richard.   Even Richard
used "endl"  in his unnecessarily  complex example.  And you're  not a
better programmer, either,  because you failed to distill  out the EOL
concept and represent it in an abstract, OS/platform-independent way.


    Chris> Now I don't for a moment think that we should go and
    Chris> convert everything to = C++.=20 But I do think that certain
    Chris> features of the language can be useful, and tha= t there
    Chris> are cases when OO style programming makes the code easier
    Chris> to read and understand.

I don't find the current Linux fs code is too difficult to understand,
although it is doing OO in a non-OO language.  Rather, I think this is
easier  to maintain,  because you  don't have  to go  through  all the
burdens of writing the C++ code.  (It's easy to get a working C++ code
work.  But  making it efficient  (e.g.  sprinking "const"  to wherever
possible  so  that it  becomes  a potential  for  the  compiler to  do
optimization)  and   *flawless*  (e.g.   multithread-safe,  reentrant,
SMP-safe,   **side-effect-less**,  privatizing   all   dangerous  copy
constructors as  well as  assignment operators, no  memory leakage...)
would  be very  devoting.  The  time could  better be  spent on  the C
code.)

Unless  the  FS  code  gets  the complexity  comparable  to  Xt  (tall
inheritance  trees), I don't  think the  overhead of  doing it  in C++
worths.  (Xt is still bearable when used as a user.  But if you try to
extend it (by writing a few custom widget classes) or maintain code in
it, you'd wish it  were in C++.)  How deep would the  FS code grow to?
If it  is shallow, then  IMO, don't do  it in C++; you'll  be spending
more time for the cosmetics than really getting advantage out of it.


-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

