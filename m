Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283203AbRLDSZV>; Tue, 4 Dec 2001 13:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277380AbRLDSXZ>; Tue, 4 Dec 2001 13:23:25 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:61608
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S283254AbRLDSWf>; Tue, 4 Dec 2001 13:22:35 -0500
Date: Tue, 4 Dec 2001 11:22:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: raul@viadomus.com
Cc: linux-kernel@vger.kernel.org, matthias.andree@stud.uni-dortmund.de,
        esr@thyrsus.com, hch@caldera.de, kaos@ocs.com.au,
        kbuild-devel@lists.sourceforge.net, torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204182236.GM17651@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <E16BJ3x-0001qq-00@DervishD.viadomus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16BJ3x-0001qq-00@DervishD.viadomus.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 06:08:57PM +0100, Ra?l N??ez de Arenas Coronado wrote:
>     Hi Matthias :)
> 
> >Creating a dependency on Python? Is a non-issue.
> 
>     Maybe for you. For me it *is* an issue. I don't like more and
> more dependencies for the kernel. I mean, if I can drop kbuild and
> keep on building the kernel with the old good 'make config' I won't
> worry, but otherwise I don't think that kernel building depends on
> something like Python.

One of the things that I _think_ is happening is that lots of other
scripts/ files are being redone, and thus removing them from the list,
so in effect we're trading out one or two for just Python.

>     Why must I install Python in order to compile the kernel? I don't
> understand this. I think there are better alternatives, but kbuild
> seems to be imposed any way.

kbuild != CML2.  It all boils down to the current 'language' having no
real definitive spec, and having 3+ incompatible parsers.  We could
either try and tweak the language slightly (and probably make it even
harder on external parsers) or throw it out and try again.  ESR wrote
CML2 with a Python interpreter, so it uses Python.  The spec for CML2 is
out there, and there's even a CML2-in-C project.  If you don't want to
use Python, go help (I believe Greg Banks is who ESR mentioned is in
charge of it) that project out and then convince Linus to include it.

> >You don't make the pen yourself when writing a letter either.
> 
>     I don't like to be forced in a particular pen, that's the reason
> why I use and develop for linux.

To carry this analogy out a bit more, the details on how to make a pen
exist, so if you don't like ESRs pen, go make your own.  That's why a
lot of people use Linux too.

> >What are the precise issues with Python? Just claiming it is an
> >issue is not useful for discussing this. Archive pointers are
> >welcome.
> 
>     Well, let's start writing kernel drivers with Python, Perl, PHP,
> awk, etc... And, why not, C++, Ada, Modula, etc...
> 
>     The kernel should depend just on the compiler and assembler, IMHO.

The right tools for the right job.  C is good for the kernel.  Python is
good at manipulating strings.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
