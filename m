Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131498AbRDFLrG>; Fri, 6 Apr 2001 07:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131502AbRDFLqq>; Fri, 6 Apr 2001 07:46:46 -0400
Received: from frege-d-math-north-g-west.math.ethz.ch ([129.132.145.3]:32185
	"EHLO frege.math.ethz.ch") by vger.kernel.org with ESMTP
	id <S131498AbRDFLqe>; Fri, 6 Apr 2001 07:46:34 -0400
Message-ID: <3ACDAC73.4110C6E4@math.ethz.ch>
Date: Fri, 06 Apr 2001 13:45:55 +0200
From: Giacomo Catenazzi <cate@math.ethz.ch>
Reply-To: cate@debian.org
X-Mailer: Mozilla 4.7C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: ankry@green.mif.pg.gda.pl
CC: linux-kernel@vger.kernel.org
Subject: Re: Arch specific/multiple Configure.help files?
In-Reply-To: <200104061035.MAA13189@sunrise.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrzej Krzysztofowicz wrote:
> 
> "Giacomo Catenazzi wrote:"
> > Johan Adolfsson wrote:
> > >
> > > Having the help close to the config sounds like a good idea
> > > from a maintenance point of view.
> >
> > But in 2.5.x the config.in are centralized, thus also
> > Configure.help sould be centralized.
> > And in this case I think that a big file hurts nobody.
> 
> What about common config options (like CONFIG_PCI, CONFIG_BINFMT_ELF,
> CONFIG_SMP, CONFIG_SERIAL), which have Configure.help entries wtitten in
> PC-centric style?
> 
> What is info about ISA/EISA bus for sparc users for? Why no info about SBUS
> there?
> What is COM3 for Amiga user?
> How can alpha user compile kernel for Pentium?
> What is the difference between ELF and A.OUT for architectures that do not
> support a.out at all?
> 
> IMO some, even very standard, options may need different explanations for
> different architectures.
> 
> Maybe some kind of architecture-specyfic #include in Configure.help entries?


Two possibilities: With std configuration language change:
: bool 'std IPC support' CONFIG_IPC
into
: bool 'arch specific IPC help' CONFIG_IPC_STRANGE_ARCH
: define_bool CONFIG_IPC CONFIG_IPC_STRANGE_ARCH

This is "clean" and is allowed by CML1 (and in CML2 with a
similar change).

Or we can use the method of Johan.
But if we move some option in i386/Configure.help, users of
other arch
instead of being little confused, their will see no help ->
worse!

Maybe before to make changes, all developers should read the
documentation
and update/change it in a non i386 centric view.

BTW some other arch will use i386 devices, thus or we
duplicate (and
that one of the copy will be old) some entry of we must make
configure.help
i386 centric (and provide other help for other arch). But
SPARC and SPARC64
will use some configuration (different to i386), thus we
should duplicate
half configuration in SPARC.. ?

	giacomo
