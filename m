Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132497AbRDNRpR>; Sat, 14 Apr 2001 13:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132496AbRDNRpI>; Sat, 14 Apr 2001 13:45:08 -0400
Received: from web5203.mail.yahoo.com ([216.115.106.97]:13836 "HELO
	web5203.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S132497AbRDNRos>; Sat, 14 Apr 2001 13:44:48 -0400
Message-ID: <20010414174446.26073.qmail@web5203.mail.yahoo.com>
Date: Sat, 14 Apr 2001 10:44:46 -0700 (PDT)
From: Rob Landley <telomerase@yahoo.com>
Subject: Re: How do I make a circular pipe?
To: Michael Meissner <meissner@spectacle-pond.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010413235028.B4197@munchkin.spectacle-pond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  Apparently, the pipe
> > fd's evaporate when the process does an execve.
> 
> Check out:
> 
> 	#include <unistd.h>
> 	#include <fcntl.h>
> 
> 		 /* ... */
> 
> 	fcntl (fd, F_SETFD, (long) FD_CLOEXEC);
> 
> to set/reset the close on exec bit.

Cool.  That's EXACTLY what I was looking for.  Thanks.

Thanks also to the people who pointed out pppd's "pty"
option (yes I read the docs on that, but they're a bit
cryptic).  And yes, my pseudo-code example used fd[0]
twice.  Thanks.  You can stop emailing me now. :)

> You might want to check out something like Stevens
> advanced UNIX programming, though it is probably
> somewhat dated :-)

I've got about fifteen books with names like that, but
strangely in real world situations I keep trying to
use the man pages instead.  Sad, I know...

> At a guess I would say that the reason is you don't
> have as much control with pipes as you do with
> devices.  Under the standard termios, you can tell
> the system to not return from the read until either
n
> characters have been read, or a given character such
> as a newline has been read.  You can also switch to
> alternative line disciplines that are more targeted
> to a given application such as PPP, etc.

Hmmm.  And the reason these cool toys aren't available
as some kind of wrapper around a normal read-from-fd
is...?  (Performance?)

> You probably want to check out pseudo tty's (pty's),
> which allow you to create your own terminal.

This occurred to me in the car on the way home after
five hours messing with this.   (Of course. :)

> Here is the glibc documentation,

Thanks.

Info.  Never thought to check info.  Here I am
checking linuxdoc's howtos, man pages, and google... 
Sigh...  I don't suppose there's an info2html tool
anywhere?

Well what do you know, there is.  (I LIKE Google.)

http://www.cs.dartmouth.edu/~jonh/info2html/

Rob

__________________________________________________
Do You Yahoo!?
Get email at your own domain with Yahoo! Mail. 
http://personal.mail.yahoo.com/
