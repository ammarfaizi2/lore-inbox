Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130676AbQLCASK>; Sat, 2 Dec 2000 19:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130750AbQLCASA>; Sat, 2 Dec 2000 19:18:00 -0500
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:42642 "HELO tsx-prime.MIT.EDU")
	by vger.kernel.org with SMTP id <S130676AbQLCARx>;
	Sat, 2 Dec 2000 19:17:53 -0500
Date: Sat, 2 Dec 2000 18:46:59 -0500
Message-Id: <200012022346.SAA17503@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: pavel@suse.cz, alan@lxorguk.ukuu.org.uk,
        kernel@blackhole.compendium-tech.com, hps@tanstaafl.de,
        linux-kernel@vger.kernel.org
In-Reply-To: Alan Cox's message of Sat, 2 Dec 2000 17:18:43 +0000 (GMT),
	<E142GJB-0001kK-00@the-village.bc.nu>
Subject: Re: Fasttrak100 questions...
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Sat, 2 Dec 2000 17:18:43 +0000 (GMT)
   From: Alan Cox <alan@lxorguk.ukuu.org.uk>

   > This is currently happening with lucent winmodem driver: there's
   > modified version of serial.c, and customers are asked to compile it
   > and (staticaly-)link it against proprietary code to get usable
   > driver. Is that okay or not?

   Probably not, its up to Ted to enforce I suspect.

Well, it's not up to just me, given that Linus also has his copyright on
the code (although I doubt there's more than a few lines which are
originally his).  There are some other people who have contributed code
to the serial driver in the past, although most have probably not given
me more than a dozen lines of code or so, which seems to be the
(completely untested in court) standard which the FSF uses to decide
whether or not they need to get formal legal papers signed.  

The legal issues are also incredibly murky, since the customers create
the derived work, and issues of intent aside, you can't necessarily use
intent to change the legal definition of "derived work".  (Be glad;
although it can be used to create a loophole in GPL, just meditate a
while on what the MPAA could do with such an "intent" argument before
you decide whether or not it's a good thing.  Or think what Microsoft
could do if they could make their EULA's as infectious as the GPL with
the "intent" argument.)  The whole dynamic linking argument is a very
slippery slope; where do you draw the line?  Does a shell script which
calls a GPL program get infected?  What about a propietary C program
which makes a system() call to invoke a GPL'ed bash?  What about an RPC
call across the network?  What about a GNOME Corba interface?  Is it OK
if it's on separate machines, but are they considered a single program
if the CORBA client and server are on the same machine, since now they
share the same VM?

In any case, the FSF has their opinion, and at least one Ivy League law
professor laughed aloud when he was asked what he thought about the
FSF's legal theories; other people have their own.  Most importantly,
none of this has been tested in court.  So it's probably not worth
trying to settle this on the linux-kernel list.

As far as this particular case is concerned, at least Lucent is shipping
part of the driver in source.  Some of the other winmodem drivers are
shipping a pure binary module, which means it will only work against a
single kernel version, which locks out users form upgrading to newer
kernels if they still want to use their winmodem.  So at least Lucent is
trying to be at least somewhat good guys about this.  

I could threaten to sue them, but it's not clear to me what good it will
do, short of depriving some users from being able to use their
winmodem.  I suppose we could encourage them to rewrite the
modified-serial.c for scratch, but aside from making some GPL fanatics
feel good, enriching some consultant and making Lucent a little poorer,
what good does it really do in the long run?  And I have better things
to do with my time.  At the same time, I certainly won't bless what they
are doing.  What they are doing is clearly wrong, and illegal.  But it
is an imperfect world that we live in, as the events in Florida have
been clearly demonstrating over the past month.

Given the limited time that I have, I'd much rather spend it going after
the Rockwell/Connexant winmodem driver, which also pretty clearly uses
serial.c, but for which they've only distributed a single .o file for a
specific kernel version.  Or I could spend it on programming.....

						- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
