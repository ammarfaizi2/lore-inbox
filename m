Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313163AbSDIN1q>; Tue, 9 Apr 2002 09:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSDIN1p>; Tue, 9 Apr 2002 09:27:45 -0400
Received: from chaos.analogic.com ([204.178.40.224]:63360 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S313163AbSDIN1l>; Tue, 9 Apr 2002 09:27:41 -0400
Date: Tue, 9 Apr 2002 09:28:59 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        "T. A." <tkhoadfdsaf@hotmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: C++ and the kernel
In-Reply-To: <20020409122622.GN612@gallifrey>
Message-ID: <Pine.LNX.3.95.1020409085537.4291B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2002, Dr. David Alan Gilbert wrote:

> * Richard B. Johnson (root@chaos.analogic.com) wrote:
> > 
> > I would like to rewrite the kernel in FORTRAN because this was
> > one of the first languages I learned.
> > 
> > Seriously, the kernel MUST be written in a procedural language.
> > It is the mechanism by which something is accomplished that defines
> > an operating system kernel.
> > 
> > C++ is an object-oriented language, in fact the opposite of a
> > procedural language. It is not suitable.
> 
> Bollox!
> 
> There are many places in the kernel that are actually very OO - look at
> filesystems for example. The super_operations sturcture is in effect a
> virtual function table.
> 

The file operations structure(s) are structures. They are not object-
oriented in any way, and they are certainly not virtual. The code that
manipulates them is quite physical and procedural, well defined, and
visible to the rest of the kernel.

> Sure making every file an object is probably OTT; but large scale things
> like a filesystem, a network device or the like probably actually fit
> very well.

Err.  From the outside-in, any well-defined software functionality
can look like an "object". In fact, any well-defined and well functioning
software is indistinguishable from magic, therefore can be represented
as an object in the true object-oriented sense.

> 
> Sure, there are a lot of features of C++ to stay clear of - exception
> handling probably being one of them, and I wouldn't let the C++ stuff
> anywhere near the memory management code.
>


C++ is designed for user-mode programming. It expects to interface
with a complete operating system with well-defined characteristics.
It is not designed to be part of an operating system kernel.

 
> Point being that it is a case of using the write tool for the job.  C++
> douesn't add any extra overhead just by calling it C++ and not using any
> of the features; careful use of the features where appropriate does no
> harm and might actually make the code cleaner, and possibly more
> efficient.
> 

It is quite unlikely that a C++ compiler will make more efficient
code than a C compiler. In fact, the code generator will likely
be the same. The C++ compiler will end up generating some preamble
code as part of the function-calling mechanism, that is not necessary
in C. This means that it will generate a bit more code.

Making code "cleaner" is a matter of perspective.

	class A {
        public: void func(char *st) { cout << st << endl; }
        };
        using A::func;
        A a;
        a.func("Hello World!");


Is not all that clean. In fact, I'm not sure I have it right. It's
easier and clearer to write  puts("Hello World!");

> I will agree going head in and just throwing C++ at it is a bad thing.
> 
> Dave


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

