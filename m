Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbUBYRHI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 12:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUBYRHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 12:07:08 -0500
Received: from mail.acu.edu ([150.252.135.93]:9941 "EHLO nicanor.acu.edu")
	by vger.kernel.org with ESMTP id S261423AbUBYRHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 12:07:04 -0500
Date: Wed, 25 Feb 2004 11:06:29 -0600
From: Michael Joy <mdj00b@acu.edu>
Subject: Re: 2.6.3 Boot Failure on Nforce2 Board
In-reply-to: <403CCAA2.5070800@pobox.com>
To: LKML <linux-kernel@vger.kernel.org>
Message-id: <1077728789.14230.3.camel@physx01.acu.edu>
Organization: Abilene Christian University
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <1077723571.9844.22.camel@physx01.acu.edu>
 <403CCAA2.5070800@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This problem is completely independent of nvnet as I'm not using it for
2.6.3.. the dmesg dump is from our WORKING configuration. I can't use
forcedeth as the kernel won't even get to module loading to boot!

Again, this has nothing to do with binary driver problems.

Michael

On Wed, 2004-02-25 at 10:17, Jeff Garzik wrote:
> Michael Joy wrote:
> > Hello,
> > We're having an interesting problem with the latest kernel release. On
> > an Albatron KM18G, latest bios, 1024MB system with athlon xp proc, 2.6.3
> > refuses to boot. It hangs on initializing the ide devices.
> > 
> > [2.] Full description of the problem/report: The problem is most
> > definately related to the ide controller changes made in 2.6.3 as in
> > 2.4.22 we did not have this issue. We haven't tried any of the previous
> > kernels as this is a production system.
> > 
> > When booting the 2.6.3 kernel, either compiled by Mandrake (cooker) or
> > using the straight up source, the kernel hangs without any error on hda:
> > max request size : 128KiB.
> > 
> > I don't have a log of this as it won't initialize the HD (wd1200jb on an
> > 80pin cable) to log the dmesg dump. Anyways we have two identical
> > machines that do this. Both are nforce2 integrated gpu's, using onboard
> > networking and sound. They have 2x512 Kingston HyperX memory modules
> > which have been thouroughly tested in these machines with memtest and no
> > errors are found.
> > 
> > Of note is that these machines exhibit the random freezes (blank screen,
> > hard lock, normally associated with heavy disk thrashing) many other
> > nforce2 boards seem to be experiencing. To fix this, we boot them with
> > the noapic and nolapic option and the problem does not reappear. 
> 
> > i2c-nforce2             4392   0 (unused)
> 
> > nvnet                  30880   1 (autoclean)
> 
> 
> You appear to have a binary-only module, nvnet, loaded...  we cannot 
> debug problems with closed source code in your kernel.  Try "forcedeth" 
> NIC driver instead.
> 
> 	Jeff
> 
-- 
Michael Joy <mdj00b@acu.edu>
Abilene Christian University

