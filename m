Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312459AbSCYRGL>; Mon, 25 Mar 2002 12:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312460AbSCYRGB>; Mon, 25 Mar 2002 12:06:01 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:58047 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S312459AbSCYRFs>;
	Mon, 25 Mar 2002 12:05:48 -0500
Date: Mon, 25 Mar 2002 12:05:46 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: devfs mounted twice in linux 2.4.19-pre3 (fwd)
Message-ID: <Pine.GSO.4.21.0203251205290.12228-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2002, Richard Gooch wrote:

> Christoph Hellwig writes:
> > In article <200203250008.g2P08hr18250@vindaloo.ras.ucalgary.ca> you wrote:
> > >   Hi, Al. What is the intended behaviour of MNT_DETACH
> > > wrt. /proc/mounts? It appears that detaching a FS leaves behind an
> > > apparently stale entry in /proc/mounts. Is this intentional?
> > 
> > mount(8) code for MNT_DETACH is mine, not viro's.  And yes, leaving
> > stale entry there is a bug - I will submit a patch to clear it.
> 
> This is not a problem with mount(8). It's a kernel problem. When
> sys_umount(..., MNT_DETACH) is called from kernel space, it doesn't
> clean up /proc/mounts.

Which kernel version it is?

It works here, so I'd love to see testcase.


