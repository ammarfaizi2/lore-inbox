Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbVKQUiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbVKQUiE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 15:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbVKQUiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 15:38:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39838 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964836AbVKQUiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 15:38:02 -0500
Date: Thu, 17 Nov 2005 15:37:31 -0500
From: Dave Jones <davej@redhat.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Olivier Galibert <galibert@pobox.com>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051117203731.GG5772@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Lee Revell <rlrevell@joe-job.com>,
	Olivier Galibert <galibert@pobox.com>,
	Linux-pm mailing list <linux-pm@lists.osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com> <20051116164429.GA5630@kroah.com> <1132172445.25230.73.camel@localhost> <20051116220500.GF12505@elf.ucw.cz> <20051117170202.GB10402@dspnet.fr.eu.org> <1132257432.4438.8.camel@mindpipe> <20051117201204.GA32376@dspnet.fr.eu.org> <1132258855.4438.11.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132258855.4438.11.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 03:20:55PM -0500, Lee Revell wrote:
 > On Thu, 2005-11-17 at 21:12 +0100, Olivier Galibert wrote:
 > > On Thu, Nov 17, 2005 at 02:57:11PM -0500, Lee Revell wrote:
 > > > On Thu, 2005-11-17 at 18:02 +0100, Olivier Galibert wrote:
 > > > > On Wed, Nov 16, 2005 at 11:05:00PM +0100, Pavel Machek wrote:
 > > > > > Now... if something can be
 > > > > > done in userspace, it probably should.
 > > > > 
 > > > > And that usually means it just isn't done.  Cases in point:
 > > > > multichannel audio software mixing, video pixel formats conversion.
 > > > 
 > > > What are you talking about?  ALSA does mixing in userspace, it works
 > > > great.
 > > 
 > > You have an interesting definition of "great".
 > > 
 > > 1- It doesn't work without an annoyingly complex, extremely badly
 > >    documented user configuration. To the point that it doesn't work in
 > >    either an out-of-the-box, updated Fedora Core 3 nor an
 > >    out-of-the-box gentoo.
 > 
 > File a bug report with your distro then.  This is supposed to work OOTB.

I don't know about other distros, but here's how that usually goes for Fedora users..

1. user installs new release, and sound doesn't work.
2. user blames ALSA, bug gets filed against kernel.
3. I take a look, sometimes we get to play "ping pong the bug between
   userspace & kernel component" for a while
4. I throw my hands in the air and say "tell the upstream ALSA developers"
5. user does so
6. user comes back to Fedora bugzilla with the response
   "Alsa people told me its a Fedora bug".

So, given we ship unpatched[1] ALSA, my faith in the
possibility of ALSA working "OOTB" is somewhat lacking.

These bugs usually sit in our bugzilla, every so often
I'll ping them after I've rebased to a new release, and
surprise surprise, they magically get fixed.
(Although every release we seem to trade one set of
 working sound drivers for a new set of broken ones).


Colour me jaded.

		Dave

[1] kernel sound/ is unpatched.  alsa-utils is unpatched. alsa-lib carries
one patch from alsa cvs.

