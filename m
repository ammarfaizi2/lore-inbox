Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265974AbRGCTiB>; Tue, 3 Jul 2001 15:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265971AbRGCThl>; Tue, 3 Jul 2001 15:37:41 -0400
Received: from ns.suse.de ([213.95.15.193]:52753 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S265972AbRGCThf>;
	Tue, 3 Jul 2001 15:37:35 -0400
Date: Tue, 3 Jul 2001 21:37:24 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: RE: ACPI fundamental locking problems
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDF2B@orsmsx35.jf.intel.com>
Message-ID: <Pine.LNX.4.30.0107032132440.1788-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2001, Grover, Andrew wrote:

> We're depending on vendors (aka the BIOS) for all the ACPI tables, as well
> as every other piece of a priori data we need to boot the OS.

And this is the part that I find terrifying.
The minute we rely on BIOS vendors, they seem to find wonderful new
ways to screw things up royally.

> Could I please ask that you at least show me a system where this is a
> problem before throwing out all the work we've done on ACPI because of this
> technical nit?

Currently, with what we extract from BIOS space, we can
blacklist/whitelist according to DMI entries. With ACPI providing AML
code that's executed in kernel space, there's no telling what could
happen.

The whole "black box, you don't need to know how this works, just call it"
approach is scary. With ACPI having access to IDE taskfile commands, the
possibilities for all sorts of evil exist. Just when we thought the CPRM
nightmare was over, we have the BIOS feeding us IDE commands to throw
at drives with vendors telling us "Trust it, it's ok, really."

Maybe I'm overly paranoid, but I'm sure I'm not the only one who feels
this way.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

