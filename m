Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbTKILD5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 06:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbTKILD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 06:03:57 -0500
Received: from mel1.uecomm.net.au ([203.94.129.130]:46473 "EHLO
	mel1.unite.net.au") by vger.kernel.org with ESMTP id S262337AbTKILDz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 06:03:55 -0500
Subject: Re: Re:No backlight control on PowerBook G4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: Daniel Egger <degger@fhm.edu>
Cc: Dustin Lang <dalang@cs.ubc.ca>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1068371734.797.506.camel@sonja>
References: <Pine.GSO.4.53.0311021038450.3818@columbia.cs.ubc.ca>
	 <1067820334.692.38.camel@gaston>  <1067878624.7695.15.camel@sonja>
	 <1067896476.692.36.camel@gaston>  <1067976347.945.4.camel@sonja>
	 <1068078504.692.175.camel@gaston>  <1068198639.796.109.camel@sonja>
	 <1068346792.673.25.camel@gaston>  <1068371734.797.506.camel@sonja>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1068375805.6805.9.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 09 Nov 2003 22:03:25 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-11-09 at 20:55, Daniel Egger wrote:
> Am Son, den 09.11.2003 schrieb Benjamin Herrenschmidt um 03:59:
> 
> > > Still cannot try this because your kernel wouldn't even survive yaboot.
> 
> > Can you give details ? It should work just fine, except if I broke
> > something in the past few days when getting G5 support in, but I didn't
> > have any other report of this, so...
> 
> The report on the chrp image is all I have right now because every other
> image will result in a hang right after downloading the kernel via tftp.
> 
> Which of the two radeon drivers should I use anyway?

The new one.

> > Well, you are not supposed to use the zImage.chrp on a PowerMac,
> > and definitely not from yaboot.
> 
> With the Linus kernel it's the only one that works.
> 
> > Last I tried, then just netbooting vmlinux.elf-pmac worked fine
> > on all the "newworld" models I have here). For yaboot, you need
> > to load a plain vmlinux binary.
> 
> Yes, but the image is too big for yaboot. I'll have to patch it first.

It's fairly simple to "fix" yaboot to handle >4Mb images actually,
just change the size in of_fs.c

Ben.

