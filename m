Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVDEEYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVDEEYV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 00:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVDEEYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 00:24:21 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:55774 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261441AbVDEEYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 00:24:16 -0400
Date: Tue, 5 Apr 2005 00:23:29 -0400
To: Greg KH <greg@kroah.com>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Michael Poole <mdpoole@troilus.org>,
       debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH 00/04] Load keyspan firmware with hotplug
Message-ID: <20050405042329.GA10171@delft.aura.cs.cmu.edu>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Sven Luther <sven.luther@wanadoo.fr>,
	Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
	debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
References: <20050404100929.GA23921@pegasos> <87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos> <20050404175130.GA11257@kroah.com> <20050404182753.GC31055@pegasos> <20050404191745.GB12141@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050404191745.GB12141@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 12:17:46PM -0700, Greg KH wrote:
> On Mon, Apr 04, 2005 at 08:27:53PM +0200, Sven Luther wrote:
> > Mmm, probably that 2001 discussion about the keyspan firmware, right ?
> > 
> >   http://lists.debian.org/debian-legal/2001/04/msg00145.html
> > 
> > Can you summarize the conclusion of the thread, or what you did get from it,
> > please ? 
> 
> That people didn't like the inclusion of firmware, I posted how you can
> fix it by moving it outside of the kernel, and asked for patches.
> 
> None have come.

Didn't know you were waiting for it. How about something like the
following series of patches?

[01/04] - add simple Intel IHEX format parser to the firmware loader.
[02/04] - make the keyspan driver use request_firmware.
[03/04] - converter program used to dump the keyspan headers as IHex files.
[04/04] - result of running the previous program.

This ofcourse doesn't actually solve Debian's distribution issues since
the keyspan firmware can only be distributed as part of 'Linux or other
Open Source operating system kernel'.

> So I refuse to listen to talk about this, as obviously, no one cares
> enough about this to actually fix the issue.

I got tired of always building my own kernels on Debian just to get my
serial dongle to work since their included keyspan.ko driver is so
useless that it isn't even worth having. The only way to use it with a
Debian kernel is to have the dongle in a powered hub and first boot into
Windows or a normal kernel.org kernel to get the thing initialized.
Didn't send the patch earlier since I wanted to split off the
pre-numeration part of the driver so that after intialization we can
unload the unused parts of the driver as well as the the firmware class
module.

Jan
