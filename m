Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129283AbRBVENK>; Wed, 21 Feb 2001 23:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129678AbRBVENB>; Wed, 21 Feb 2001 23:13:01 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:50445 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129283AbRBVEMt>; Wed, 21 Feb 2001 23:12:49 -0500
Date: Wed, 21 Feb 2001 22:12:25 -0600
To: Christoph Hellwig <hch@caldera.de>
Cc: lvm-devel@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: [lvm-devel] *** ANNOUNCEMENT *** LVM 0.9.1 beta5 available at www.sistina.com
Message-ID: <20010221221225.B21010@cadcamlab.org>
In-Reply-To: <20010221180035.N25927@athlon.random> <200102211718.SAA25997@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200102211718.SAA25997@ns.caldera.de>; from hch@caldera.de on Wed, Feb 21, 2001 at 06:18:24PM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Christoph Hellwig]
> It would be really good to have something devfs-like just for LVM in
> setups that don't use LVM, so we could avoid mounting root read/write
                        ^^^devfs?
> for device-creation.

For most people, read/write access to /dev is rarely needed -- how
often do you create new VGs or LVs?  How often do you run MAKEDEV or
vgscan?  Sometimes you need to change tty inodes but that's what
/dev/pts is for.

If you do need read-write access to /dev but not /, put it on a
separate filesystem.  Leave just a skeletal /dev in your root
filesystem, enough to bootstrap.

Peter
