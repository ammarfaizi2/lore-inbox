Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290255AbSAOT2t>; Tue, 15 Jan 2002 14:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290257AbSAOT2m>; Tue, 15 Jan 2002 14:28:42 -0500
Received: from Morgoth.esiway.net ([193.194.16.157]:781 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S290255AbSAOT2e>; Tue, 15 Jan 2002 14:28:34 -0500
Date: Tue, 15 Jan 2002 20:28:32 +0100 (CET)
From: Marco Colombo <marco@esi.it>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery --
 the elegant solution)
In-Reply-To: <Pine.LNX.3.95.1020115133220.818B-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33.0201151954010.11441-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002, Richard B. Johnson wrote:

> On Tue, 15 Jan 2002, Marco Colombo wrote:
> 
> > On 15 Jan 2002, Thomas Duffy wrote:
> > 
> > > On Tue, 2002-01-15 at 04:29, Andrew Pimlott wrote:
> > > 
> > > > - Building from source is good karma.
> 
> [SNIPPED...]
> 
> > 
> > Every distro supplies a package with the source used to build their own
> > kernel. Just recomplile it.
> 
> Really???  Have you ever tried this? RedHat provides a directory
> of random patches that won't patch regardless of the order in
> which you attempt patches (based upon date-stamps on patches or
> date-stamps on files). It's like somebody just copied in some
> junk, thinking nobody would ever bother.

Uh?

# cd /usr/src/linux-2.4
# make xconfig
(note that the autoconfigurator would provide a good starting point
here for a stripped down kernel, reducing compile time a lot!)
# make bzImage
# make modules
# make install
# make modules_install

# ls -al /boot/vmlinuz-2.4.9-13custom
/boot/vmlinuz-2.4.9-13custom

I've done that (with minimal variations) hundreds of times. It worked like
that since 4.1, IIRC. What Red Hat are you talking about? And it's no
different from what you do with a standard tree.

(you need the kernel-source RPMS, of course)


You encounter troubles when you apply some random patch to the RH tree.
It happens with almost every non vanilla tree out there...

> Some distributions don't even provide source. They provide
> copies of /usr/src/linux/include/asm and /usr/src/linux/include/linux
> but nothing else. You have to "find" source on the internet.

Name one, please. I can't believe it.

> Some distributions don't even provide that, instead they provide
> copies of /usr/src/linux/include/linux and /usr/src/linux/include/asm
> under /usr/include.

Name one, please. Really.

> The "good-ol-days" where you could get 72 floppies from Yggdrasil,
> install Linux, and spend the next 48 hours watching it compile
> are long gone.

Uh. SLS was the one. Less than 50 floppies. And it never took
48 to compile a kernel. Before 1.0 the kernel was so small than my
386/40, equipped with 4MB of RAM, managed to complile it in reasonable
time (<30mins) (not with X running). 0.96 (or was it 0.98) ate my disk
so many times during compile (HD Timeout...) that I must confess that
I've been a 386BSDer and a NetBSDer at times...  I can't remeber when
the problem has been fixed, BTW. Maybe when I switched to Slackware.

Kernel compile time has been nearly constant in time (since I was 
upgrading my HW meanwhile), in my experience.

> I have never found a distribution that uses modules, in which is
> was even remotely possible to duplicate the kernel supplied.

s|make xconfig|cp configs/kernel-2.4.9-athlon.config .config|

in the above. Works like a charm (ok, the kernel is named -custom, but
I like it this way).

Anyway, rpm --rebuild kernel-xxxx.src.rpm  does work, even if it's
obviously slow (I've never tried in on 7.x, though.  I'm reminiscent of
6.x days), since it produces all the binary packages...


Go get a better internet connection: the one you're using is corrupting
the packages you're downloading. Or it's corrupting the messages you're
sending.

> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).
> 
>     I was going to compile a list of innovations that could be
>     attributed to Microsoft. Once I realized that Ctrl-Alt-Del
>     was handled in the BIOS, I found that there aren't any.
> 
> 
> 

.TM.
-- 
      ____/  ____/   /
     /      /       /			Marco Colombo
    ___/  ___  /   /		      Technical Manager
   /          /   /			 ESI s.r.l.
 _____/ _____/  _/		       Colombo@ESI.it


