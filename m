Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbVLEQoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbVLEQoZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 11:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbVLEQoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 11:44:25 -0500
Received: from krusty.dt.E-Technik.uni-dortmund.de ([129.217.163.1]:15046 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S1751378AbVLEQoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 11:44:24 -0500
Date: Mon, 5 Dec 2005 17:44:18 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Mark Lord <lkml@rtr.ca>, Rob Landley <rob@landley.net>,
       Adrian Bunk <bunk@stusta.de>, David Ranson <david@unsolicited.net>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@gmx.de>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051205164418.GA12725@merlin.emma.line.org>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	Mark Lord <lkml@rtr.ca>, Rob Landley <rob@landley.net>,
	Adrian Bunk <bunk@stusta.de>, David Ranson <david@unsolicited.net>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
References: <20051203135608.GJ31395@stusta.de> <4391D335.7040008@unsolicited.net> <20051203175355.GL31395@stusta.de> <200512042131.13015.rob@landley.net> <4394681B.20608@rtr.ca> <1133800090.21641.17.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133800090.21641.17.camel@mindpipe>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Dec 2005, Lee Revell wrote:

> On Mon, 2005-12-05 at 11:17 -0500, Mark Lord wrote:
> > >>>Ahh OK .. I don't use it, so wouldn't have been affected. That's one
> > >>>userspace interface broken during the series, does anyone have any more?
> > 
> > Ah.. another one, that I was just reminded of again
> > by the umpteenth person posting that their wireless
> > no longer is WPA capable after upgrading from 2.6.12.
> > 
> > Of course, the known solution for that issue is to
> > upgrade to the recently "fixed" latest wpa_supplicant
> > daemon in userspace, since the old one no longer works.
> > 
> > Things like this are all too regular an occurance.
> 
> The distro should have solved this problem by making sure that the
> kernel upgrade depends on a new wpa_supplicant package.  Don't they
> bother to test this stuff before they ship it?!?

This constant shifting the blame on someone else is becoming
offensive.

Diligent maintainers put "INCOMPATIBLE CHANGES" sections up front in
their release announcements or notes, that is the upstream maintainer's
chance to state "wpa_supplicant version >= 1.2.3 required" and really
pass the buck on to the distros. Without such upgrade-required-for:
notes, it's just rude. "We break everything but you need to find out for
yourself which..."

Let's not mention that section 2, 7 and 9 manual pages should be
maintained by the kernel developers rather than an external maintainer.

If you need a luminous example how release management works, look at
Postfix. I don't suggest taking Postfix's development model of printing
the diffs and using text marker and pencil, but the "Incompatible
changes", "Major changes" in Release Notes, with all the details in a
separate changelog, works rather well for distros and direct users.

My suggestion is to build upon the signed-off-by: stuff and require that
every incompatible change carry such a RFC2822-header-like line if it is
to be merged into baseline, and unconditionally back out all
incompatibilities that are later found but not documented.

Perhaps just making people actually write such notes can cut the number
of these shipwrecks.

-- 
Matthias Andree
