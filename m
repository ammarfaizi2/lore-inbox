Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290644AbSAYLeL>; Fri, 25 Jan 2002 06:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290645AbSAYLeB>; Fri, 25 Jan 2002 06:34:01 -0500
Received: from web20110.mail.yahoo.com ([216.136.226.47]:59147 "HELO
	web20110.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S290644AbSAYLdx>; Fri, 25 Jan 2002 06:33:53 -0500
Message-ID: <20020125113353.90801.qmail@web20110.mail.yahoo.com>
Date: Fri, 25 Jan 2002 03:33:53 -0800 (PST)
From: john carmack <migrate_linux@yahoo.com>
Subject: Re:RFC:Booleans and the kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > #include <stdio.h>
> > >
> > > int main()
> > > {
> > >         char x;
> > >
> > >         if ( x )
> > >         {
> > >                 printf ("\n We got here\n");
> > >         }
> > >         else
> > >         {
> > >                 // We never get here
> > >                 printf ("\n We never got
here\n");
> > >         }
> > >         exit (0);
> > > }
> > > covell@xxxxxx ~>gcc -Wall foo.c
> > > foo.c: In function `main':
> > > foo.c:17: warning: implicit declaration of
function `exit'

Version of my gcc:2.96
First of all i complied the file with the command gcc
file.c.I got an a.out file which worked properly.The
output is we got here properly.
So the compiler is pretty intelligent .

Now if you compile with gcc -Wall file.c it gives an
error called implicit declaration of function 'exit' 
.That is true refer to your system manual or man page
.It shows that void exit(int status) function which we
are using in the program needs a header file called
stdlib.h to be included.
If we include that header file by #include <stdlib.h>
in the program and compile with gcc -Wall file.c 
we don't get the error but we get the required output.

To get uninitialized variables we need to compile it
with the command gcc -Wall -O file.c or gcc
-Wuninitialized -O file.c.For me it gives an error
saying warning:'x' might be uninitialized.

I think it clarifies the doubt.


Before including functions it is a good thing to check
whether the header files are included because for me
while coding ,although my program(C code) was correct
since i didn't compile it properly with library
extension like -lm for math.h or didn't include some
header files it gave me an error.

Hope that solves your doubt.

-----*-------------------------------------------*-----


__________________________________________________
Do You Yahoo!?
Great stuff seeking new owners in Yahoo! Auctions! 
http://auctions.yahoo.com
