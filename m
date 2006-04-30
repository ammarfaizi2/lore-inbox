Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWD3VQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWD3VQK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 17:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWD3VQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 17:16:10 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31671 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750791AbWD3VQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 17:16:09 -0400
To: Martin Mares <mj@ucw.cz>
Cc: Avi Kivity <avi@argo.co.il>, Davi Arnaut <davi.lkml@gmail.com>,
       Willy Tarreau <willy@w.ods.org>, Denis Vlasenko <vda@ilport.com.ua>,
       dtor_core@ameritech.net, Kyle Moffett <mrmacman_g4@mac.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
	<d120d5000604251028h67e552ccq7084986db6f1cdeb@mail.gmail.com>
	<444E61FD.7070408@argo.co.il> <200604271810.07575.vda@ilport.com.ua>
	<20060427201531.GH13027@w.ods.org>
	<750c918d0604271408y2afef6fflf380e4d0a6c1cec6@mail.gmail.com>
	<4451E185.9030107@argo.co.il>
	<mj+md-20060428.105455.7620.atrey@ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 30 Apr 2006 15:15:18 -0600
In-Reply-To: <mj+md-20060428.105455.7620.atrey@ucw.cz> (Martin Mares's
 message of "Fri, 28 Apr 2006 13:03:20 +0200")
Message-ID: <m1wtd6bw9l.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares <mj@ucw.cz> writes:

>> FWIW, userspace is moving away from C as unproductive and unsafe. KDE is 
>> of course C++, mozilla, openoffice are C++, and gnome is moving towards 
>> (of all things) C#.
>
> Maybe continuing to write application programs in C instead of using
> higher-level languages is silly and backward, but _stopping_ at the
> level of C++ or C# is equally silly.
>
> However, in the kernel space the main problems the people are spending
> their time with are rarely related to the language.

To some extent that is true.  There is a huge amount of work involved
with understanding the hardware.

The things we need to check in the kernel don't seem to coincide
to facility provided by any current programming language.  I can't get
the compiler to check that I don't overflow a 4K stack,  that I always
use the same permissions checks to guard the same class of objects,
that my aggressive refactoring didn't miss a subtle dependency by the
users of that code. 

Currently every language I know of are variations on a theme, that
helps to write applications and abstractions, but provides little
help in verifying those abstractions.   In essence what is
needed are compile to assertion checking.

Languages like C++ do seem to make it easier to get to a higher
level of abstraction, and share fundamental abstractions like
your object system with a large body of programs.  However once
you are at that level of abstraction in a language current languages
don't seem to provide much real additional help.

So I do agree that the improvement by a language switch is limited
by Amdahl's law, and since most coding time is spent thinking and
testing a language needs to show major gains in at least one
of those areas to really show improvement.

I think it is possible to show major gains in testing but I have
yet to see a language that address that issue.  C++ with it's slower
compiler, and greater complexity clearly will neither increase 
the frequency of tests nor the number of people qualified to review
the code.

Eric
