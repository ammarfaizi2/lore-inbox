Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290603AbSAYH76>; Fri, 25 Jan 2002 02:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290602AbSAYH7s>; Fri, 25 Jan 2002 02:59:48 -0500
Received: from sun.fadata.bg ([80.72.64.67]:7684 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S290598AbSAYH7b>;
	Fri, 25 Jan 2002 02:59:31 -0500
To: Alexander Viro <viro@math.psu.edu>
Cc: Xavier Bestel <xavier.bestel@free.fr>, timothy.covell@ashavan.org,
        Robert Love <rml@tech9.net>, Oliver Xymoron <oxymoron@waste.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: booleans and the kernel
In-Reply-To: <Pine.GSO.4.21.0201250109150.23657-100000@weyl.math.psu.edu>
X-No-CC: Reply to lists, not to me.
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <Pine.GSO.4.21.0201250109150.23657-100000@weyl.math.psu.edu>
Date: 25 Jan 2002 10:00:45 +0200
Message-ID: <877kq6amhe.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alexander" == Alexander Viro <viro@math.psu.edu> writes:
>> > int main()
>> > {
>> >         char x;
>> > 
>> >         if ( x )
>> >         {
>> >                 printf ("\n We got here\n");
>> >         }
>> >         else
>> >         {
>> >                 // We never get here
>> >                 printf ("\n We never got here\n");
>> >         }
>> >         exit (0);
>> > }
>> > covell@xxxxxx ~>gcc -Wall foo.c
>> > foo.c: In function `main':
>> > foo.c:17: warning: implicit declaration of function `exit'
>> 
>> I'm lost. What do you want to prove ? (Al Viro would say you just want
>> to show you don't know C ;)
>> And why do you think you never get there ?

Alexander> I suspect that our, ah, Java-loving friend doesn't realize that '\0' is
Alexander> a legitimate value of type char...

Alexander> BTW, he's got a funny compiler - I would expect at least a warning about
Alexander> use of uninitialized variable.

That warning would require data-flow analysis (reachable definitions
in this case), which is not enabled with certain levels of
optimization.

