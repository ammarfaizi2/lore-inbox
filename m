Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265115AbRFUTBK>; Thu, 21 Jun 2001 15:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265111AbRFUTBA>; Thu, 21 Jun 2001 15:01:00 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:58247 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S265110AbRFUTAv>; Thu, 21 Jun 2001 15:00:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Pete Zaitcev <zaitcev@redhat.com>, landley@webofficenow.com
Subject: Re: [OT] Threads, inelegance, and Java
Date: Thu, 21 Jun 2001 09:59:47 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010620042544.E24183@vitelus.com> <mailman.993083762.1429.linux-kernel2news@redhat.com> <200106210313.f5L3DZ124717@devserv.devel.redhat.com>
In-Reply-To: <200106210313.f5L3DZ124717@devserv.devel.redhat.com>
MIME-Version: 1.0
Message-Id: <01062109594701.00845@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 June 2001 23:13, Pete Zaitcev wrote:
> > Then again JavaOS was an abortion on top of Slowaris. [...]
>
> This is a false statemenet, Rob. It was an abortion, all right,
> but not related to Solaris in any way at all.

I worked on the sucker for six months at IBM in 1997.  I don't know if the 
code we worked on is the code you're thinking of, but we had a unix kernel 
(which my coworkers SAID was solaris) with a JVM running on top of it as the 
init task.  Ported to Power PC by some overseas IBM lab (might have been the 
japanese guys).  We had two flavors of it to test, one the Power PC build and 
one the Intel build, and to make the Intel build work first we installed 
Solaris for Intel.

Other fun little details included that when I left IBM it still couldn't read 
from the hard drive, so the entire system TFTP'd itself through the network 
at boot, including a compressed ramdisk image containing Lotus Desktop.  The 
machine required 64 megs of memory to run that (~32 megs or so of which was 
for the ramdisk, and no it didn't run executables straight out of the 
ramdisk, it copied them into MORE ram to run).

> JavaOS existed in two flavours minimum, which had very little
> in common. The historically first of them (Luna), was a home-made
> executive with pretty rudimentary abilities.

I believe that's what we were using, and that home-made executive was a 
stripped down version of the solaris kernel.

> Second flavour of JavaOS was made on top of
> Chorus, and, _I think_, used large parts of Luna in the the
> JVM department, but it had decent kernel, with such novations
> as a device driver interface :)

You haven't lived until you've seen java code, with inline assembly, claiming 
to be a video framebuffer device driver thing.  That sort of thing gives you 
a real appreciation for the portions of your life where you DON'T have to 
deal with that kind of thing.

I only had to go into there to debug stuff though, mostly I was working on 
the application end of things.  (Taking third party closed source 
beta-release nonsense from people who wanted a single point of contact with 
IBM who turned out to be someone in Poughkipsee who had quit the company a 
couple weeks back.  So it didn't work, we didn't have source, the people who 
supplied it wouldn't talk to us, and when we did trace a problem to the 
JavaOS code and reported it to Sun they went "we fixed that over a month ago 
and we've been sending you twice-weekly drops!"  But of course our codebase 
didn't sync with their codebase more than once a month or so because there 
was so much porting effort involved...

And you wonder why I quit...

> Such a thing existed. I do not remember its proper name,
> but I remember that it booted from hard disk. Floppy
> was too small for it.

Maybe.  Wouldn't have been nearly as big as JavaOS, though.  FAR better 
suited to an embedded system...

> > Porting half of Solaris to Power PC for JavaOS has got to be one of the
> > most peverse things I've seen in my professional career.
>
> I never heard of PPC port of either of JavaOSes, although
> Chorus runs on PPC. Perhaps this is what you mean.

It was called "JavaOS for Business"...

http://www.javaworld.com/javaworld/jw-05-1998/jw-05-idgns.javaos.html

And was killed about a year later...

http://news.cnet.com/news/0-1003-200-346375.html?tag=bplst

I worked on it for six months in the second half of 1997.

> Solaris for PPC existed, but never was widespread.
> It did not have JVM bundled.

We mostly used AIX on the PPC systems that weren't directly testing the new 
code.

> > I'm upset that Red Hat 7.1 won't install on that old laptop because it
> > only has 24 megs of ram and RedHat won't install in that. [...]
>
> You blew adding a swap partition, I suspect...

This was before it let me run fdisk or Disk Druid.  I'll try again this 
weekend...

> -- Pete

Rob
