Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTLGLBh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 06:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264410AbTLGLBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 06:01:37 -0500
Received: from quechua.inka.de ([193.197.184.2]:46250 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S263861AbTLGLBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 06:01:34 -0500
Date: Sun, 7 Dec 2003 12:01:22 +0100
From: Eduard Bloch <edi@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cdrecord hangs my computer
Message-ID: <20031207110122.GB13844@zombie.inka.de>
References: <Law9-F31u8ohMschTC00001183f@hotmail.com> <Pine.LNX.4.58.0312060011130.2092@home.osdl.org> <3FD1994C.10607@stinkfoot.org> <20031206084032.A3438@animx.eu.org> <Pine.LNX.4.58.0312061044450.2092@home.osdl.org> <20031206220227.GA19016@work.bitmover.com> <Pine.LNX.4.58.0312061429080.2092@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312061429080.2092@home.osdl.org>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>
* Linus Torvalds [Sat, Dec 06 2003, 02:32:08PM]:

> > Hey, that "piece of crap" has burned one heck of a lot of ISO images of
> > Linux over the years.
> 
> And so does windows. That doesn't make it good.

But somehow most Windows programers have easy way to deal with devices,
they have clear paths to get hardware access where on Linux there is
often something not thought out well which ruins your day. Examples?

If you have worked on a SCSI generic device and wish to get all the
block devices associated with this one in upper level, how do you get
that information? I tried to find a way a while ago and it simply
sucked.

For details: http://bugs.debian.org/93633/ (CDROM TOC cache is not
flushed on mount, kernel does not see new sessions on the disk). And
don't tell me that I am stupid and I have simply to reject and reinsert
the CD as everybody does. It is not mandatory on non-Linux, and why? ;)
There must be a more simple way to flush the TOC cache in the block
device driver (where it should not be located whatsoever, IMO).

Another example: how to get a list of module names for each
module corresponding to drivers that have detected hardware? AFAICS
there is no policy, no subsystem to manage this and there are no
guidelines for the driver writers. The only thing you can do is looking
around in procfs, guessing with some hocus pocus.

How to assign a network interface name when loading the NIC driver?

> > How about a nod of thanks to the author before you tell him you don't
> > like his interface?
> 
> I tried to tell him why numbers are bad. Very politely, explaining that a
> lot of devices cannot be enumerated by a traditional "bus/dev/lun" scheme.

Imagine, there would be an internal mapping between devfs names and
"bus/dev/lun" so cdrecord&Co. could query it to get the scsi-generic
device name they need. There is almost always a way to a compromise.

> He basically cursed at me, and told me that that is how SCSI works. Never
> mind that IDE isn't SCSI, and even SCSI doesn't work that way any more
> (iSCSI comes to mind).

Sorry, but if you drive SCSI protocols over IDE hardware, using the same
terminology and the same control methods, why should it not be used as
such? Or was it because Windows works that way so we should make it
different (worse)?

Telling that someone is a dick is easy if you have the absolute power in
your area of control, but listening to him and extracting good arguments
may make sence sometimes.

MfG,
Eduard.

