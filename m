Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264910AbTK3Nxx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 08:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbTK3Nxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 08:53:52 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:6784 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264910AbTK3Nxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 08:53:50 -0500
Date: Sun, 30 Nov 2003 13:58:34 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200311301358.hAUDwYtQ000206@81-2-122-30.bradfords.org.uk>
To: Andries Brouwer <aebr@win.tue.nl>,
       Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Cc: linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <20031130131314.GB5738@win.tue.nl>
References: <200311300220.hAU2K0dr019280@sunrise.pg.gda.pl>
 <200311300222.hAU2MqcB002434@green.mif.pg.gda.pl>
 <20031130131314.GB5738@win.tue.nl>
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Andries Brouwer <aebr@win.tue.nl>:
> On Sun, Nov 30, 2003 at 03:22:52AM +0100, Andrzej Krzysztofowicz wrote:
> 
> > > The BIOS reads the MBR and jumps to the code loaded from there.
> > > There is no need for any partition table, or, if there is a table,
> > > for any particular format. It is all up to the code that is found
> > > in the MBR.
> > 
> > I found some PC BIOS-es refuse to read the MBR if no active partition is
> > found in the partition table...
> 
> Yes. We are getting a bit away from disk geometries, but it is true
> that there are many broken BIOSes that in some way depend on partition
> table format or MBR format.

OK, there is broken hardware, but there are also people with
non-broken hardware who want to make better use of it :-).  I am not
recommending that everybody moves away from the standard partition
table format, I just want a better partitioning scheme for new
machines I build, (for which I would avoid using known broken
hardware).

> I recall the report that one BIOS tuned IDE modes by reading the MBR
> and seeing whether it ended with 0xaa55. If not it tried a lower speed.
> So on a disk without this MBR signature, the I/O would be slow.
> 
> BSD used to use an entirely different partition table scheme.
> And it was not uncommon to run a whole-disk BSD system, without
> any partitioning.

Hmmm, yes, you can use a BSD disk label on a whole disk, as opposed to
putting a BSD disk label on one partition of a disk.  I have never
tried to read such a disk on a Linux machine, though - do we support
that correctly?

> Increasingly often that caused problems with broken BIOSes
> that wanted to interpret partition table contents.
> 
> The categories of problems that come to mind are:
> - BIOS has a virus detection option and checks the MBR
> - BIOS inspects the partition table to find the hibernation partition
> - BIOS inspects the partition table to find the service partition
> - BIOS inspects the partition table to guess what geometry it should report
> 
> I recall that certain Thinkpads would not boot FreeBSD even with a DOS-type
> partition table because the BIOS did not like the a5 partition ID.
> 
> So, yes, you are right, practice is much more complicated than theory.

For building new, dedicated Linux machines, though, how much of that
do we have to concern ourselves with?

John.
