Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266125AbSLSVVL>; Thu, 19 Dec 2002 16:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266179AbSLSVVL>; Thu, 19 Dec 2002 16:21:11 -0500
Received: from [81.2.122.30] ([81.2.122.30]:54793 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266125AbSLSVVK>;
	Thu, 19 Dec 2002 16:21:10 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212192140.gBJLexVt003143@darkstar.example.net>
Subject: Re: Dedicated kernel bug database
To: linux-kernel@vger.kernel.org
Date: Thu, 19 Dec 2002 21:40:59 +0000 (GMT)
In-Reply-To: <3E023602.8080007@verizon.net> from "Stephen Wille Padnos" at Dec 19, 2002 04:11:30 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Interesting - so the first stage in reporting a bug would be to select
> >the latest 2.4 and 2.5 kernels that you've noticed it in, and get a
> >list of known bugs fixed in those versions.  Also, if you'd selected
> >the maintainer, (from an automatically generated list from the
> >MAINTAINERS file), it could just search *their* changes in the changelog.
> >
> It's often difficult to pick a maintainer for a bug - it may not be the 
> fault of a single subsystem.

Yes, that's true.

> As an example, I recently had a problem getting USB and network to
> function (on kernels 2.5.5x).
> I noticed that toggling Local APIC would also toggle which of the
> two devices worked.
> Disabling ACPI allows both deviecs to function regardless of local APIC.
> 
> So, where is the problem?
> 1) Network driver?  It doesn't work with ACPI and both Local APIC and 
> IO-APIC.
> 2) USB driver?  It doesn't work with ACPI and no UP APIC.
> 3) APIC?  Causes weird problems with various drivers when ACPI is turned on.
> 4) ACPI?  Causes weird problems with various drivers when APIC is toggled.

The way I imagine it working would be that you could assign it to
multiple maintainers, (perhaps with a maximum to discourage the
sending of all bugs to everybody, or alternatively, you could lower
the priority of a bug sent to multiple people, on the basis that it
was more likely to get solved anyway, so you are, in effect, balancing
out the attention it gets).

In the case you point out, as it's primarily networking and USB, the
bug would get assigned to Andrew Morton, Jeff Garzik, and Greg
Kroah-Hartman, who would all be relevant people to contact.

> (this exact bug was in Bugzilla, though I hadn't checked there before 
> mailing lkml ;)
> 
> I'm not exactly a neophyte to the kernel, and I would have to do a lot 
> more digging to find the right maintainer to send this to.  Also, the 
> person(s) to whom the bug is reported will depend on how much debugging 
> work I do, and in what order I do it.

Good point.

> I'm not trying to discourage you - just raising a potential gotcha.

Overall, though, would you rather be presented with a list of
categories, or a list of people and what parts of the code they
maintain.  Personally, I think that a list of people is more
intuitive, rather than an abstract list of categories, but I could be
wrong.

John.
