Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266218AbSLSV37>; Thu, 19 Dec 2002 16:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266224AbSLSV37>; Thu, 19 Dec 2002 16:29:59 -0500
Received: from air-2.osdl.org ([65.172.181.6]:13750 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266218AbSLSV35>;
	Thu, 19 Dec 2002 16:29:57 -0500
Date: Thu, 19 Dec 2002 13:32:57 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: John Bradford <john@grabjohn.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Dedicated kernel bug database
In-Reply-To: <200212192140.gBJLexVt003143@darkstar.example.net>
Message-ID: <Pine.LNX.4.33L2.0212191330120.30841-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2002, John Bradford wrote:

| > >Interesting - so the first stage in reporting a bug would be to select
| > >the latest 2.4 and 2.5 kernels that you've noticed it in, and get a
| > >list of known bugs fixed in those versions.  Also, if you'd selected
| > >the maintainer, (from an automatically generated list from the
| > >MAINTAINERS file), it could just search *their* changes in the changelog.
| > >
| > It's often difficult to pick a maintainer for a bug - it may not be the
| > fault of a single subsystem.
|
| Yes, that's true.

or maybe it's just difficult to tell which subsystem has a problem...

| > As an example, I recently had a problem getting USB and network to
| > function (on kernels 2.5.5x).
| > I noticed that toggling Local APIC would also toggle which of the
| > two devices worked.
| > Disabling ACPI allows both deviecs to function regardless of local APIC.
| >
| > So, where is the problem?
| > 1) Network driver?  It doesn't work with ACPI and both Local APIC and
| > IO-APIC.
| > 2) USB driver?  It doesn't work with ACPI and no UP APIC.
| > 3) APIC?  Causes weird problems with various drivers when ACPI is turned on.
| > 4) ACPI?  Causes weird problems with various drivers when APIC is toggled.
|
| The way I imagine it working would be that you could assign it to
| multiple maintainers, (perhaps with a maximum to discourage the
| sending of all bugs to everybody, or alternatively, you could lower
| the priority of a bug sent to multiple people, on the basis that it
| was more likely to get solved anyway, so you are, in effect, balancing
| out the attention it gets).
|
| In the case you point out, as it's primarily networking and USB, the
| bug would get assigned to Andrew Morton, Jeff Garzik, and Greg
| Kroah-Hartman, who would all be relevant people to contact.

Hm, I see this problem as more of a generic interrupt routing or ACPI
problem, not networking or USB.

| > (this exact bug was in Bugzilla, though I hadn't checked there before
| > mailing lkml ;)
| >
| > I'm not exactly a neophyte to the kernel, and I would have to do a lot
| > more digging to find the right maintainer to send this to.  Also, the
| > person(s) to whom the bug is reported will depend on how much debugging
| > work I do, and in what order I do it.
|
| Good point.
|
| > I'm not trying to discourage you - just raising a potential gotcha.
|
| Overall, though, would you rather be presented with a list of
| categories, or a list of people and what parts of the code they
| maintain.  Personally, I think that a list of people is more
| intuitive, rather than an abstract list of categories, but I could be
| wrong.

Do we have anyone targeted for interrupt routing problems (PIC, IO APIC,
ACPI, etc.)?

-- 
~Randy

