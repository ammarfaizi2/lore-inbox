Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261379AbSJ1RGz>; Mon, 28 Oct 2002 12:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261384AbSJ1RGz>; Mon, 28 Oct 2002 12:06:55 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:35312 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S261379AbSJ1RGy>; Mon, 28 Oct 2002 12:06:54 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 28 Oct 2002 10:10:10 -0700
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: New nanosecond stat patch for 2.5.44
Message-ID: <20021028171010.GD17533@clusterfs.com>
Mail-Followup-To: Horst von Brand <vonbrand@inf.utfsm.cl>,
	Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
References: <20021027214913.GA17533@clusterfs.com> <200210272316.g9RNGQxd011519@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210272316.g9RNGQxd011519@pincoya.inf.utfsm.cl>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 27, 2002  20:16 -0300, Horst von Brand wrote:
> Andreas Dilger <adilger@clusterfs.com> said:
> > 1) It would be good if it were possible to select this with a config
> >    option (I don't care which way the default goes), so that people who
> >    don't need/care about the increased resolution don't need the extra
> >    space in their inodes and minor extra overhead.  To make this a lot
> >    easier to code, having something akin to the inode_update_time()
> >    which does all of the i_[acm]time updates as appropriate.
> 
> Please don't. Do not create incompatible versions of the same filesystem
> just because they were written on kernels compiled with different
> configurations. Superblock flags might be OK, but what is the point then?
> Better mount flags (mount with/without finegrained timestamps)?

I don't say anything about creating incompatible versions of the same
filesystem.  Configuring out nsec timestamps is no different than what
we have today.  Many filesystems do not support nsec timestamps anyways.

I just see this as one of many hundreds of "tiny" features that are
added to Linux that could easily be made a config option when they
are first added, but all just end up adding a tiny bit of bloat for
people that don't need it.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

