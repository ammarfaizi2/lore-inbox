Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285589AbSAZQri>; Sat, 26 Jan 2002 11:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285618AbSAZQr2>; Sat, 26 Jan 2002 11:47:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40973 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S285589AbSAZQrV>;
	Sat, 26 Jan 2002 11:47:21 -0500
Message-ID: <3C52DD96.183322F9@mandrakesoft.com>
Date: Sat, 26 Jan 2002 11:47:18 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.3-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Eriksson <nitrax@giron.wox.org>
CC: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] ACPI mentioned on lwn.net/kernel
In-Reply-To: <200201251550.g0PFoIPa002738@tigger.cs.uni-dortmund.de> <200201250802.32508.bodnar42@phalynx.dhs.org> <jeelkes8y5.fsf@sykes.suse.de> <a2sv2s$ge3$1@penguin.transmeta.com> <20020126034106.F5730@kushida.apsleyroad.org> <012d01c1a687$faa11120$0201a8c0@HOMER>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Eriksson wrote:
> 
> ----- Original Message -----
> From: "Jamie Lokier" <lk@tantalophile.demon.co.uk>
> To: "Linus Torvalds" <torvalds@transmeta.com>
> Cc: <linux-kernel@vger.kernel.org>
> Sent: Saturday, January 26, 2002 4:41 AM
> Subject: Re: [ACPI] ACPI mentioned on lwn.net/kernel
> 
> > Linus Torvalds wrote:
> > > It's sad that gcc relegates "optimize for size" to a second-class
> > > citizen.  Instead of having a "-Os" (that optimizes for size and doesn't
> > > work together with other optimizations), it would be better to have a
> > > "-Olargecode", which explicitly enables "don't care about code size" for
> > > those (few) applications where it makes sense.
> >
> > Btw, there have been suggestions that -Os may actually be faster for x86
> > code on current processors.
> 
> Hmm.. I tried to compile the kernel with -Os (gcc 2.96-98) and I just got a
> ~1% smaller vmlinux and a ~3% smaller bzImage. Maybe the size optimizations
> doesn't show on these files? Internal data structures that are much bigger
> than "real" code?

That doesn't tell us much unless you benchmark any speed
improvements/degradations noticed.  Hidden in that 1% may be more
favorable I-cache usage, better register usage... who knows.

It would also be interesting to compile key files like kernel/sched.c or
mm/vmscan.c in assembly using O2 and Os, and compare the output with
diff -u.

	Jeff



-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
