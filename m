Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318886AbSHEWJW>; Mon, 5 Aug 2002 18:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318887AbSHEWJW>; Mon, 5 Aug 2002 18:09:22 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:28317 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S318886AbSHEWJV>; Mon, 5 Aug 2002 18:09:21 -0400
Date: Mon, 5 Aug 2002 16:12:53 -0600
Message-Id: <200208052212.g75MCrN17655@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] devfs cleanups for 2.5.29
In-Reply-To: <Pine.LNX.4.44.0207311109560.28515-100000@serv>
References: <200207310032.g6V0WmW12258@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.44.0207311109560.28515-100000@serv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel writes:
> Hi,
> 
> On Tue, 30 Jul 2002, Richard Gooch wrote:
> 
> > > Are you sure it's save in devfs_open() too?
> >
> > Yes. RTFS.
> 
> I'm trying - without getting headache.

Take a valium.

> In the "devfs=only" case, where is the module count incremented, when a
> block device is opened?

The module count is incremented when the device is opened,
irrespective of whether it's a character or block device, or even a
"regular" file.

> > > Even if it's save/fixed, it's still code duplication.
> >
> > No. I leverage fops_get(), a common function.
> 
> Which is also insufficiently protected.

Incorrect.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
