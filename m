Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbUCHRkI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 12:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbUCHRkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 12:40:08 -0500
Received: from thunk.org ([140.239.227.29]:57061 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262630AbUCHRkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 12:40:01 -0500
Date: Mon, 8 Mar 2004 12:39:40 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Grigor Gatchev <grigor@serdica.org>
Cc: Mike Fedyk <mfedyk@matchmail.com>,
       Christer Weinigel <christer@weinigel.se>, linux-kernel@vger.kernel.org
Subject: Re: A Layered Kernel: Proposal
Message-ID: <20040308173940.GD5263@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Grigor Gatchev <grigor@serdica.org>,
	Mike Fedyk <mfedyk@matchmail.com>,
	Christer Weinigel <christer@weinigel.se>,
	linux-kernel@vger.kernel.org
References: <404BE46F.1000000@matchmail.com> <Pine.LNX.4.44.0403081311020.21912-100000@lugburz.zadnik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403081311020.21912-100000@lugburz.zadnik.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2004 at 02:23:43PM +0200, Grigor Gatchev wrote:
> 
> Also, does "think API changes, nothing generalised *at all*" mean anything
> different from "think code, no design *at all*"? If this is some practical
> joke, it is not funny. (I can't believe that a kernel programmer will not
> know why design is needed, where is its place in the production of a
> software, and how it should and how it should not be done.)

So give us a design.  Make a concrete proposal.  Tell us what the
API's --- with C function prototypes --- should look like, and how we
should migrate what we have to your new beautiful nirvana.

Engineering is the task of trading off various different principals;
in general it is impossible to satisfy all of them 100%.  For example,
Mach tried to be highly layered, with strict memory protections to
protect one part of the kernel from another --- all good things, in a
generic sense.  Streams tried to be extremely layered as well, and had
a design that a computer science professor would love.  Both turned
out to be spectacular failures because their performance sucked like
you wouldn't believe.

Saying "layered programming good" is useless.  Sure, we agree.  But
it's not the only consideration we have to take into account.
Furthermore, the Linux kernel has a decent amount of layering already,
although it is a pragmatist's sort of layering, where we use it when
it is useful and ignore when it gets in the way.  Given your
high-level descriptions, perhaps the best description of what we
currently have in Linux is that it uses a C-based (because no one has
ever bothered to create a C++ obfuscated contest --- it's too easy),
multiple-inheritance model, where each device driver can use
common-denominator code as necessary (from the PCI sublayer, the tty
layer, the SCSI layer, the network layer, etc.), but it is always
possible for each driver to provide specific overrides as necessary
for the hardware.

Is my description of Linux's device model accurate?  Sure.  Is it
useful in terms of telling us what we ought to do in order to improve
our architecture?  Not really.  It's just a buzzword-compliant,
high-level description which is great for getting great grades from
clueless C.S. professors that are more in love with theory than
practice.  But that's about all it's good for.

In order for it to be at all useful, it has to go to the next level.
So if you would like to tell us how we can do a better job, please
submit a proposal.  But it will have to be a detailed one, not one
that is filled with high-level buzzwords and hand-waving.

					- Ted

