Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbVKVWAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbVKVWAX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 17:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbVKVWAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 17:00:22 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:1507 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030189AbVKVWAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 17:00:08 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Tue, 22 Nov 2005 22:00:02 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Jon Smirl <jonsmirl@gmail.com>
cc: Kasper Sandberg <lkml@metanurb.dk>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Christmas list for the kernel
In-Reply-To: <9e4733910511221341u695f6765k985ecf0c54daba49@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0511222158360.7002@hermes-1.csi.cam.ac.uk>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com> 
 <20051122204918.GA5299@kroah.com>  <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com>
  <1132694935.10574.2.camel@localhost> <9e4733910511221341u695f6765k985ecf0c54daba49@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005, Jon Smirl wrote:
> On 11/22/05, Kasper Sandberg <lkml@metanurb.dk> wrote:
> > > Currently you have to compile most of this stuff into the kernel.
> > forgive my ignorance, but whats stopping you from doing this now?
> 
> It would be better if all of the legacy drivers could exist on
> initramfs and only be loaded if the actual hardware is present. With
> the current code someone like Redhat has to compile all of the legacy
> support into their distribution kernel. That code will be present even
> on new systems that don't have the hardware.
> 
> An example of this is that the serial driver is hard coded to report
> four legacy serial ports when my system physically only has two. I
> have to change a #define and recompile the kernel to change this.
> 
> The goal should be able to build something like Knoppix without
> Knoppix needing any device probing scripts. Linux is 90% of the way
> there but not 100% yet.
> 
> X is also part of the problem. Even if the kernel nicely identifies
> all of the video hardware and input devices, X ignores this info and
> looks for everything again anyway. In a more friendly system X would
> use the info the kernel provides and automatically configure itself
> for the devices present or hotplugged. You could get rid of your
> xorg.cong file in this model.

Note quite.  You would still need it (or other means) to configure for 
example what screen resolutions and what modes to allow and things like 
that.  Also which devices are core pointer/keyboard and which extra and 
also some devices are supported in userspace and not in the kernel for 
which you need to configure them there.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
