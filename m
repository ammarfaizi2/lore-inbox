Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317956AbSGPTt3>; Tue, 16 Jul 2002 15:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317957AbSGPTt2>; Tue, 16 Jul 2002 15:49:28 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:52464 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317956AbSGPTt1>; Tue, 16 Jul 2002 15:49:27 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 16 Jul 2002 13:49:29 -0600
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Stelian Pop <stelian.pop@fr.alcove.com>, Sam Vilain <sam@vilain.net>,
       dax@gurulabs.com
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020716194929.GS442@clusterfs.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Stelian Pop <stelian.pop@fr.alcove.com>,
	Sam Vilain <sam@vilain.net>, dax@gurulabs.com
References: <1026736251.13885.108.camel@irongate.swansea.linux.org.uk> <E17U4YE-0000TL-00@hofmann> <20020715160357.GD442@clusterfs.com> <E17U9x9-0001Dc-00@hofmann> <20020716081531.GD7955@tahoe.alcove-fr> <20020716122756.GD4576@merlin.emma.line.org> <20020716124331.GJ7955@tahoe.alcove-fr> <20020716125301.GI4576@merlin.emma.line.org> <20020716140549.A11780@infradead.org> <20020716193831.GC22053@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020716193831.GC22053@merlin.emma.line.org>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 16, 2002  21:38 +0200, Matthias Andree wrote:
> On Tue, 16 Jul 2002, Christoph Hellwig wrote:
> > On Tue, Jul 16, 2002 at 02:53:01PM +0200, Matthias Andree wrote:
> > > Not if some day somebody implements file system level snapshots for
> > > Linux. Until then, better have garbled file contents constrained to a
> > > file than random data as on-disk layout changes with hefty directory
> > > updates.
> > 
> > or the blockdevice-level snapshots already implemented in Linux..
> 
> That would require three atomic steps:
> 
> 1. mount read-only, flushing all pending updates
> 2. take snapshot
> 3. mount read-write
> 
> and then backup the snapshot. A snapshots of a live file system won't
> do, it can be as inconsistent as it desires -- if your corrupt target is
> moving or not, dumping it is not of much use.

Luckily, there is already an interface which does this -
sync_supers_lockfs(), which the LVM code will use if it is patched in.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

