Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290593AbSDINu4>; Tue, 9 Apr 2002 09:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292588AbSDINuz>; Tue, 9 Apr 2002 09:50:55 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:57596 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S290593AbSDINuz>; Tue, 9 Apr 2002 09:50:55 -0400
Message-ID: <3CB2F3F9.8325AC04@nortelnetworks.com>
Date: Tue, 09 Apr 2002 10:00:25 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: C++ and the kernel
In-Reply-To: <Pine.LNX.3.95.1020409085537.4291B-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Tue, 9 Apr 2002, Dr. David Alan Gilbert wrote:
> > There are many places in the kernel that are actually very OO - look at
> > filesystems for example. The super_operations sturcture is in effect a
> > virtual function table.
> 
> The file operations structure(s) are structures. They are not object-
> oriented in any way, and they are certainly not virtual. The code that
> manipulates them is quite physical and procedural, well defined, and
> visible to the rest of the kernel.

I disagree.  A filesystem has a certain set of semantics.  There are numerous
types of filesystems, each of which implements that set of semantics (and
possibly additional ones as well) in a different way.  This is a classic example
of a situation where oo style programming can be useful.  There are many cases
where C code is in essence implementing virtual functions using function
pointers.  C++ allows the compiler to do the hard work of keeping track of the
virtual functions.

> It is quite unlikely that a C++ compiler will make more efficient
> code than a C compiler. In fact, the code generator will likely
> be the same. The C++ compiler will end up generating some preamble
> code as part of the function-calling mechanism, that is not necessary
> in C. This means that it will generate a bit more code.

C++ has tigher constraints on code than C.  This can allow a compiler to
generate better code because it has more knowledge about what is going on.


> Making code "cleaner" is a matter of perspective.
> 
>         class A {
>         public: void func(char *st) { cout << st << endl; }
>         };
>         using A::func;
>         A a;
>         a.func("Hello World!");
> 
> Is not all that clean. In fact, I'm not sure I have it right. It's
> easier and clearer to write  puts("Hello World!");

Your example is needlessly complex, and I'm sure you know this.  A more
realistic comparison would be:

cout << "Hello World!\n";

Now I don't for a moment think that we should go and convert everything to C++. 
But I do think that certain features of the language can be useful, and that
there are cases when OO style programming makes the code easier to read and
understand.


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
