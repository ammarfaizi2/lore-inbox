Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286301AbRL2VZj>; Sat, 29 Dec 2001 16:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286266AbRL2VZa>; Sat, 29 Dec 2001 16:25:30 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:12456
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S286263AbRL2VZS>; Sat, 29 Dec 2001 16:25:18 -0500
Date: Sat, 29 Dec 2001 14:24:55 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: State of the new config & build system
Message-ID: <20011229212455.GB21928@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20011228141211.B15338@thyrsus.com> <Pine.LNX.4.33.0112281408170.23445-100000@penguin.transmeta.com> <20011228173151.B20254@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011228173151.B20254@thyrsus.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2001 at 05:31:51PM -0500, Eric S. Raymond wrote:
 
> When I talk about "rules that use architecture symbols to suppress
> things like bus types" I have in mind things like this:
[snip]
> unless (ISA or PCI) suppress dependent IDE

Just a minor point, but what about non-PCI/ISA ide?

> unless PCI suppress dependent USB HOTPLUG_PCI

And there's hope this will die soon too (USB) ...

> unless (X86 or ALPHA or MIPS32 or PPC) suppress usb

or SPARC or SPARC64 (iirc) or ARM (once !pci usb is allowed)...

> unless (X86 and PCI and EXPERIMENTAL) or PPC or ARM or SPARC suppress dependent IEEE1394

Wouldn't the experimental be global?  And maybe the PCI too?

> It seems to me *extremely* unlikely that a typical patch from a PPC maintainer
> would mess with any of these!  They're rules that are likely to be written
> once at the time a new port is added to the tree and seldom or ever changed
> afterwards.

But they will be modified for new arch X, or when constraint X (like
PCI) is removed.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
