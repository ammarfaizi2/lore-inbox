Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265477AbRFVRoT>; Fri, 22 Jun 2001 13:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265475AbRFVRoK>; Fri, 22 Jun 2001 13:44:10 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:9353 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S265477AbRFVRnz>; Fri, 22 Jun 2001 13:43:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Craig Milo Rogers <rogers@ISI.EDU>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>
Subject: Fair Use (Was Re: Controversy over dynamic linking -- how to end the panic)
Date: Fri, 22 Jun 2001 08:32:44 -0400
X-Mailer: KMail [version 1.2]
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <1110.993155660@ISI.EDU>
In-Reply-To: <1110.993155660@ISI.EDU>
MIME-Version: 1.0
Message-Id: <01062208324405.00692@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 June 2001 16:34, Craig Milo Rogers wrote:

> 	The in-core kernel image, including a dynamically-loaded
> driver, is clearly a derived work per copyright law.  As above, the
> portion consisting only of the dynamically-loaded driver's binary code
> may or may not be a derived work per the GPL.  It doesn't much matter
> under the GPL, anyway, so long as the in-code kernel image isn't
> "copied or distributed".

It would  be entirely legal to generate a patch against the copyrighted work 
which contains no code from the copyrighted work, and which is seperately 
distributed.

This falls under fair use.  The "fortify" folks did it for netscape 
navigator.  Your instructions for a set of changes to someone else's work are 
a unique creation as long as they don't actually include any portion of the 
other person's work.  (And things like book reviews or parody may contains 
small sections of the work being referred to, exactly how much is nebulous 
and generally decided on a case by case basis if it ever gets to court.)

A tarball containing a set of source code for a new, independent module, 
which does not include any GPLed code, is obviously not a "derivative work" 
in legal terms.  (It may be inspired by, but ideas aren't copyrighted, only 
the specific expression/implementation.  You can paraphrase an encyclopedia 
article for a school report, etc.  Just don't quote verbatim.)

Now the COMPILED version is where the fun begins.  Distributing a precompiled 
binary of this module means that GPL code was used during the compilation (at 
the very least header files), and that an argument could be made that 
technically this binary is a derivative work, and distribution of it might 
trigger licensing terms of the GPL.

Considering that the implied use of headers (I.E. .h files) is to allow their 
inclusion in other programs and therefore the creation of other programs, 
it's possible that an argument could be made that header files (originally 
distributed with a .h extension by the person who issued the license in the 
first place) are intended to be used to create other programs, and therefore 
this is fair use and not the creation of a derived work.  After all, the 
copyright holder of the code made a distinction between .c and .h files, when 
the functional aspects of the language dont' demand it.  And normally, .h 
files do not directly result in code in the output (inline macros being an 
exception that doesn't change the overall nature and intent of the file).  
But it'd be a coin flip whether the judge would buy that argument.

Now what LINUS seems to have done is offer an nebulous and imprecisely worded 
second license on at least the header files of Linux, which allows the 
creation of precompiled binaries as seperate items, as long as none of the 
existing Linux code has to be modified in any way to create these modules.  
(Allowing this sort of thing while still being GPL compatable with a larger 
work is, incidentally, the intent of the LGPL.  But he didn't use it.)

Binary modules created under this second license (and a verbal permission can 
be a legal license, as much as any oral agreement is ever likely to stand up 
in court), can therefore be distributed on a Linux compilation CD readily as 
any other piece of non-GPL code can (such as the binary-only version of 
netscape on the Red Hat CD's).  Nobody's claiming that such an anthology is 
creating a derived work, merely a collective distribution mechanism for the 
seperately licensed entities.  (Like an FTP site you can take with you.)

Run-time linking of the modules with the Linux code is a seperate issue, 
almost certainly falling under fair use.  You are not distributing the 
result, and you have a license for both components saying that they are in 
fact legal copies, therefore what you do with them is your business.  (What 
use a legal copy is put to is NOT subject to copyright law.  Contract law as 
part of the license terms maybe, but that's a can of worms we won't open just 
now, especially such fun aspects as "standing" and "informed consent"...)

The only real legal question is whether Linus has the authority to offer the 
second license allowing the creation of non-GPL binary modules.  A case could 
be made that he does, and not just due to the anthology copyright, but 
because posession really is 9/10 of the law.

The "binary modules" clause has been out there for years now without being 
challeneged.  Everybody's known about it, the statute of limitations for 
objecting to it has probably gone by.  Everyone submitting code to Linus for 
a long time has been implying acceptance of his license terms for 
distribution of that code.

A paralell could also be dawn between intellectual property law and regular 
property law, along the lines of homesteading.  If you find an abandoned 
house and live in it long enough, especially if you make significant changes 
like fixing it up, it's considered to have been abandoned to you, and you 
gain ownership of it.  If the original owner comes back after long enough and 
complains, the court basically decides which gets to keep it and it may very 
well go to the current occupant.  (I'm trying to remember the name of this 
legal principle, strangely enough they teach it in courses on real estate as 
"something to watch out about if you're a landlord".)

Linus has been maintainer of Linux since day 1.  There are other active 
copyright holders on portions of the code (alan, ingo, andrea, rik, stephen, 
etc.) but they've all pretty much gone along with Linus's license terms.  The 
only potential problem would be long-inactive participants, or contributors 
of very small patches, who might raise a stink.  The question of whether 
they'd have significant standing is something a judge honestly might throw 
out (for the same reason linking oracle against the linux headers ain't gonna 
make oracle GPL no matter what the license may say.)

Remember, we're talking civil court here, not criminal.  This is an offense 
against copyrights and contracts, not breaking laws passed by legislatures 
and committing a misdemeanor or a felony.  What you can really sue for in 
civil court (other than monetary damages, where you have to either prove 
financial harm or convince a judge/jury to punish the other guy with punitive 
damage awards) is injunctive relief in terms of a restraining order.  You can 
get them to stop distributing your code, either to stop offering it or to 
take your contribution out of what they offer. 

So the only practical recourse the minor copyright holder on a Linux snippet 
might have is to request the removal of their contribution from the whole.  
That probably WOULD be within their rights to do.  (In the oracle clase, we 
could say "you can't distribute the version linked against our headers!  Stop 
that!" and probably win in court.  But we couldn't get ownership of the rest 
of their source code because the magnitude of the "offense" wouldn't fit the 
scale of the "punishment", and because the scope of the case doesn't really 
extend to the rest of oracle's code.  Civil courts are big on that sort of 
thing.)

So the real-world danger is that somebody we haven't heard from since 1993 
objects to the concept of binary modules and requests we remove 10 lines from 
the serial driver.  Which we could do, and patch our way around, in about 15 
minutes, end of problem.

Of course, I'm not a lawyer either.  (And I have no trainign in stock market 
investing either, but I wrote a column on it for three years.  I'm 
self-taught in Java and taught a course on it at the local community college. 
 My respect for "credentials" is just amazing, as you can tell...)

Rob
