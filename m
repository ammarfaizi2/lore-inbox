Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268602AbUJKCDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268602AbUJKCDL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 22:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268609AbUJKCDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 22:03:11 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:21977 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268602AbUJKCDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 22:03:06 -0400
Date: Mon, 11 Oct 2004 12:02:48 +1000
From: Nathan Scott <nathans@sgi.com>
To: Aaron Peterson <aaron@alpete.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Maximum block dev size / filesystem size
Message-ID: <20041011120248.F4948977@wobbly.melbourne.sgi.com>
References: <1097180361.491.25.camel@main> <1097177960.31547.132.camel@localhost.localdomain> <1097244833.491.31.camel@main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1097244833.491.31.camel@main>; from aaron@alpete.com on Fri, Oct 08, 2004 at 10:13:53AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 10:13:53AM -0400, Aaron Peterson wrote:
> On Thu, 2004-10-07 at 15:39, Alan Cox wrote:
> > On Iau, 2004-10-07 at 21:19, Aaron Peterson wrote:
> > > I work for a company with a 15 TB SAN.  All opinions about the
> > > disadvantages of creating really large filesystems aside, I'm trying to
> > > find out what is the maximum filesystem size we can allocate on our SAN
> > > that a linux box (x86) can really use.
> > 
> > For 2.4.x 1Tb (2Tb works for some devices but its a bit variable)
> > 
> > > What I can't seem to find anywhere is whether the 2 TB block device
> > > limit has improved/grown with 2.6 kernels (on x86 hardware).  Perhaps
> > > I've looked in the wrong places, but I haven't found anything.
> > 
> > 2.6 fixed this problem although it appears not for some specialist
> > cases. Last time I checked LVM logical volumes over 2Tb were reported
> > problematic.
> 
> I've read that the other main difficulty besides block device size
> limits is problems with the ext2 management tools themselves.  So, how
> would you rate my chances of using a 2.6 kernel with XFS (and xfs
> management tools of course) with a 5 TB filesystem?  Probably not a well
> tested scenerio to say the least...

Assuming the device driver(s) you pick are happy with 64 bit sector
numbers, you should expect this to work (iow, you should not have
any trouble from XFS itself).  SGI ships 2.4 product with specific
supported drivers and the LBD patch (both 32 and 64 bit boxen) in
order to use large devices.

cheers.

-- 
Nathan
