Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbRETVKF>; Sun, 20 May 2001 17:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262221AbRETVJz>; Sun, 20 May 2001 17:09:55 -0400
Received: from blount.mail.mindspring.net ([207.69.200.226]:10514 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S262220AbRETVJq>; Sun, 20 May 2001 17:09:46 -0400
Subject: Re: Background to the argument about CML2 design philosophy
From: Robert "M." Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20010520164700.H4488@thyrsus.com>
In-Reply-To: <20010518112625.A14309@thyrsus.com>
	<20010518113726.A29617@devserv.devel.redhat.com>
	<20010518114922.C14309@thyrsus.com> <8485.990357599@redhat.com>
	<20010520111856.C3431@thyrsus.com> <15823.990372866@redhat.com>
	<20010520114411.A3600@thyrsus.com> <16267.990374170@redhat.com>
	<20010520131457.A3769@thyrsus.com> <18686.990380851@redhat.com> 
	<20010520164700.H4488@thyrsus.com>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 20 May 2001 17:10:01 -0400
Message-Id: <990393002.1322.4.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 May 2001 16:47:00 -0400, Eric S. Raymond wrote:
> In order to prevent that happening, I would like to have some recognized
> criterion for configuration cases that are so perverse that it is a 
> net loss to accept the additional complexity of handling them within the
> configurator.
> 
> A lot of people (including, apparently, you) are saying there are no such
> cases.  I wonder if you'll change your minds when you have to handle the
> overhead yourselves?

I feel that there should *never ever* be a legit situation that the
configuration tool does not allow. Not ever. Two reasons:

First, I tend to trust the config tools (perhaps too much).  If they
tell me x implies y, or x implies not y, I will believe it.  I won't
think "hm, the code must be wrong, let me hand edit the config" (which
is something I don't want to have to do, anyhow).

Second, I like having a lean kernel.  Here is an example (I realize this
probably won't ever manifest into a real rule): INTEL_I815 implies
INTEL_RNG, DRM_I810, INTEL_AGP, I810_TCO, PCI, etc etc. -- I don't want
the RNG or TCO watchdog.  I don't use the on-board graphics.  Nor, if my
i815 model supported it, the sound.  There are people who want to
customize their kernel (hell, everyone at this level of the game).
There are people, like David, who have custom setups.  We need to
support this, without hacking the config (especially if I have to rehack
it after every make oldconfig!).

I like your design to abstract away low levels features to a more
general design.  This makes it easier for the novice, and more intuitive
for everyone.  But not at the expense of limiting possible cases.

-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net

