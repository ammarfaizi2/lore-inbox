Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263687AbUFXHeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263687AbUFXHeA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 03:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbUFXHeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 03:34:00 -0400
Received: from guardian.hermes.si ([193.77.5.150]:47117 "EHLO
	guardian.hermes.si") by vger.kernel.org with ESMTP id S263687AbUFXHd6
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 03:33:58 -0400
Message-ID: <600B91D5E4B8D211A58C00902724252C01BC071A@piramida.hermes.si>
From: David Balazic <david.balazic@hermes.si>
To: Philippe Troin <phil@fifi.org>, "'Andries Brouwer'" <aebr@win.tue.nl>
Cc: David Balazic <david.balazic@hermes.si>,
       "'Linux-Kernel@vger.kernel.org'" <Linux-Kernel@vger.kernel.org>
Subject: RE: Disk copy, last sector problem
Date: Thu, 24 Jun 2004 09:32:28 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: 	Andries Brouwer[SMTP:aebr@win.tue.nl]
> 
> On Tue, Jun 22, 2004 at 09:52:54AM -0700, Philippe Troin wrote:
> > David Balazic <david.balazic@hermes.si> writes:
> > 
> > > Hi!
> > > 
> > > cat /dev/hda > /dev/hdc
> > > 
> > > This would not copy the entire disk as expected, but miss the last
> sector if
> > > the number of
> > > sectors on hda is odd. ( I used "cat" becasue it has the simplest
> syntax,
> > > "dd" and other behave the same ).
> > > Has this been fixed recently ?
> > > What about suppport of other sectors sizes, like 8kb ?
> > 
> > Have you tried setting the device block size to its sector size?
> > 
> >   blockdev --setbsz $(blockdev --getss /dev/...) /dev/...
> 
> If I understand correctly David is not reporting a problem, but
> vaguely recalls that there was a problem in this area long ago,
> and asks whet the current status is.
> 
> (Yes, today things are better, but not perfect yet :-))
> 
So the copy will still miss the last sector ?
But the blockdev command is a working workaround ?
Are there any downsides of setting the block size to
512 bytes right at boot for all hard drives ?
What about 8kb sectors, do they work ?

Thanks for your time ;-)
David
