Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbTELSge (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 14:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbTELSge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 14:36:34 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:37326 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262456AbTELSga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 14:36:30 -0400
Date: Mon, 12 May 2003 14:48:55 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: David Brownell <david-b@pacbell.net>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Patch for usb-ohci in 2.4 needs review & testing
Message-ID: <20030512144855.A2256@devserv.devel.redhat.com>
References: <20030510004012.A26322@devserv.devel.redhat.com> <3EBFC9A4.7020708@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EBFC9A4.7020708@pacbell.net>; from david-b@pacbell.net on Mon, May 12, 2003 at 09:19:48AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: David Brownell <david-b@pacbell.net>
> Date: Mon, 12 May 2003 09:19:48 -0700

> > The attached patch appears to fix a bug which was really making
> > my life difficult: dd if=/dev/scd0 produces corrupted ISOs when
> > reading off a USB CD-ROM on a box with no less than 2 P4 CPUs,
> > HyperThreading and ServerWorks chipset. However, I'm not
> > completely sure that I didn't break something.
> 
> Did the "ohci-hcd" backport give the same problem?
> Or did you not try that?

> That 2.5 code has had a lot more attention paid to it
> with respect to locking and similar less-common problems.
> Personally I'd rather see that version get the attention,
> so both 2.4 and 2.5 get the benefits, although I can also
> understand wanting changes that seem more incremental.

Greg sent me that, but I haven't tried it yet. Sorry.

Obviously, ohci-hcd is better, but you know where I work.
We have to support ancient codebases practically forever,
despite what press says. The ohci fix we talk about comes
from qualifying 2.4.9 on top of the line hardware, some of
which is not released yet.

> >  - The whole idea of checking jiffy-sized timeouts from an interrupt
> >    is revolting, but I am wary of unknown here, so I didn't kill it.
> >    If anyone knows how that abomination came to life, I'll be glad
> >    to know too.
> 
> It shouldn't actually be alive ... never enabled,
> because never debugged (and submitted by accident).
> Safe IMO to remove completely.

Heh. I'm afraid I won't be able to touch it, see above.

I'll look on the ohci-hcd, but certain events may be pushing
it to next week.

-- Pete
