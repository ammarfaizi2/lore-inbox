Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287231AbRL2XMr>; Sat, 29 Dec 2001 18:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287230AbRL2XMi>; Sat, 29 Dec 2001 18:12:38 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:59561
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S287231AbRL2XMY>; Sat, 29 Dec 2001 18:12:24 -0500
Date: Sat, 29 Dec 2001 16:12:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: State of the new config & build system
Message-ID: <20011229231202.GE21928@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20011228141211.B15338@thyrsus.com> <Pine.LNX.4.33.0112281408170.23445-100000@penguin.transmeta.com> <20011228173151.B20254@thyrsus.com> <20011229212455.GB21928@cpe-24-221-152-185.az.sprintbbd.net> <20011229174354.B8526@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011229174354.B8526@thyrsus.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2001 at 05:43:54PM -0500, Eric S. Raymond wrote:
> Tom Rini <trini@kernel.crashing.org>:
> > > unless (ISA or PCI) suppress dependent IDE
> > 
> > Just a minor point, but what about non-PCI/ISA ide?
> 
> The CML1 rules seem to imply that this set is empty.

It's not.  In fact, I don't really see that implication either.  There's
lots of drivers hidden under a CONFIG_PCI check, but nothing under an
ISA check.  From ~line 104 to ~136 I suspect are all non-PCI and non-ISA
chipsets.

> > > unless (X86 and PCI and EXPERIMENTAL) or PPC or ARM or SPARC suppress dependent IEEE1394
> > 
> > Wouldn't the experimental be global?  And maybe the PCI too?
> 
> I don't understand what change you are suggesting.

unless EXPERIMENTAL and (((X86 or PPC or SPARC) and PCI) or ARM)
Since the experimental tag I believe would be a global thing, and I'm
thinking that ARM probably implies !PCI (since it does so often, but I
don't know for sure..).

> > > It seems to me *extremely* unlikely that a typical patch from a PPC
> > > maintainer would mess with any of these!  They're rules that are likely to
> > > be written once at the time a new port is added to the tree and seldom or
> > > ever changed afterwards.
> > 
> > But they will be modified for new arch X, or when constraint X (like
> > PCI) is removed.
> 
> Yes.

Not typical than, but it could/will happen, from arch maintainer Y.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
