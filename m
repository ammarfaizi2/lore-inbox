Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288774AbSADVSy>; Fri, 4 Jan 2002 16:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288769AbSADVSp>; Fri, 4 Jan 2002 16:18:45 -0500
Received: from ns.suse.de ([213.95.15.193]:22278 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288767AbSADVSe>;
	Fri, 4 Jan 2002 16:18:34 -0500
Date: Fri, 4 Jan 2002 22:18:32 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: "Eric S. Raymond" <esr@thyrsus.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020104155912.A23345@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0201042214410.20620-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Eric S. Raymond wrote:

> OK.  So can I ask ACPI if the board has ISA slots?

You can ask it what temperature your coffee pot is.
It's an incredibly capable (some may say too capable).
grab the spec and take a read (http://www.acpi.info iirc)

>  Does it answer reliably?

Brings us back to.. "Can I trust a BIOS writer not to fsck things up"

That, and ACPI support under Linux is still not-quite-there
(but getting there). Coupled with Pat Mochels work with driverfs,
we should eventually be able to get a complete enumerated tree
of devices mountable somewhere.

The only problem then, is that some boxes may not be running ACPI
aware kernels, requiring you to parse the ACPI tables in userspace.
(Not as easy as DMI, ACPI is a turing complete language requiring
a bytecode (AML) parser)

(Or you could just say fsck it if a acpi/driverfs aware kernel isn't
 present, which any sane person would)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

