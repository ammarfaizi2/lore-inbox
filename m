Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbUC2Ntn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 08:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbUC2Ntm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 08:49:42 -0500
Received: from mlf.linux.rulez.org ([192.188.244.13]:25619 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S262499AbUC2NsK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 08:48:10 -0500
Date: Mon, 29 Mar 2004 15:48:01 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: ntfs-dev <linux-ntfs-dev@lists.sourceforge.net>,
       Andries Brouwer <aeb@cwi.nl>, linux-kernel@vger.kernel.org
Subject: Re: [Linux-NTFS-Dev] Geometry determination
In-Reply-To: <1080564842.5545.19.camel@imp.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.21.0403291512030.6684-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Mar 2004, Anton Altaparmakov wrote:

> I have been experimenting a little with what Windows / Linux 2.4 / Linux
> 2.6 think the geometry of a couple of HDs is and the results are not
> very promising.  )-:
> 
> Using Linux 2.4, HDIO_GETGEO ioctl, I get the same Heads and Sectors per
> Track as Windows on both HDs I tried it on.  This is the good news. 
> I.e. at least on those two disks mkntfs as it stands now would create
> Windows bootable partitions.
> 
> The bad news is that Linux 2.4, HDIO_GETGEO ioctl returns wrong values

You mean 2.6? That's what I'm saying also for a while. It's a known issue
and people are complaining about it because kernel breaks things (e.g.
they can't boot anymore and think Linux thrashed their systems).

I don't know who is the kernel maintainer today but apparently nobody.  
Old maintainer, Andries Brouwer, only repeates that the geometry doesn't
exists even if he was/is proved and pointed out to be wrong many times.

The issue was discussed long, several times on linux-kernel without a
satisfying solution.

	Szaka

> for both HDs.  (It said Heads were 16 both time when Linux 2.4 said 255
> for one of the HDs and 128 for the other.)
> 
> So while mkntfs will work at the moment in a few months/years time it
> will probably never work any more without user specified geometry.  )-:
> 
> I have unfortunately not found _any_ way to get the values returned by
> Linux 2.4 / Windows on a Linux 2.6 system and I tried looking in
> /proc/ide, using hdparm, and using .  )-:
> 
> This is very annoying to say the least.  )-:
> 
> Any ideas?
> 
> Of course, this all might have been coincidence and someone else testing
> a different set of two HDs might find the opposite.
> 
> What we really want to know is how Windows determines the geometry? 
> Anyone know?
> 
> Best regards,
> 
> 	Anton
> 




