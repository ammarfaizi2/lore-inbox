Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318473AbSHNMeS>; Wed, 14 Aug 2002 08:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318486AbSHNMeS>; Wed, 14 Aug 2002 08:34:18 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:10223 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318473AbSHNMeR>; Wed, 14 Aug 2002 08:34:17 -0400
Subject: Re: GA-7DX+ crashes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matt Bernstein <mb/lkml@dcs.qmul.ac.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0208141239380.1472-100000@r2-pc.dcs.qmul.ac.uk>
References: <Pine.LNX.4.44.0208141239380.1472-100000@r2-pc.dcs.qmul.ac.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 14 Aug 2002 13:35:39 +0100
Message-Id: <1029328539.26226.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-14 at 13:12, Matt Bernstein wrote:
> We're very much at a loss as to why the 60 new PCs we've bought largely
> don't run Linux (various 2.4 kernels including 2.4.19, limbo1-BOOT) for
> very long without crashing. One of them seems to work OK; its /proc/pci is 
> identical, but the batch number on the southbridge seems one lower--is 
> this dodgy VIA hardware again? We'll be trying a different IDE controller 
> next, but 60 of those ain't cheap..

My immediate assumption would be a batch of bad hardware or faulty bios

> Has anyone else had success or failure stories in particular with this 
> motherboard? We don't really have a significant number of data points just 
> yet, but are willing to try pretty much anything anyone might suggest!
> 
> symptoms
> - random data corruption (sometimes memory, more often HDD)
> - somtimes oopsing, but never in the same place

We've seen similar on pure VIA chipset machines. The kernel has fixes to
work around the hardware problems there. We have no information on
workarounds (or if they are needed) for the AMD/VIA combo other than the
fact that the APIC cannot be used on them according to AMD docs.

> what we think we've ascertained so far
> - they pass memtest86
> - we've tried different HDDs, no effect
> - tried ide=nodma, possibly makes it crash after longer
> - tried noapic, no effect
> - tried all sorts of BIOS settings, no effect (except--possibly--turning 
> 	off the on board IDE controller and playing nfsroot games)
> - ..and yet they seem to run that other OS fine :-(
> - extra cooling/underclocking doesn't seem to help
> - seems to be fs-independent (tried ext3, reiserfs, jfs)

Boot it up in linu grab an lspci with the full config space of each
chip. Next boot it into windows and do the same. That may show what is
being patched up. New BIOS versions may also help

Other things to try

Disable all ACPI/APM
Disable any BIOS 'usb keyboard/mouse' support

Finally if they still don't work and your purchase order stated that you
intended to also run Linux on them then they are "not fit for the
purpose for which they were sold". If your purchase order didnt mention
that detail then someone wants kicking.


