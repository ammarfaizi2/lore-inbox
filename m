Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268809AbRHBGFD>; Thu, 2 Aug 2001 02:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268810AbRHBGEy>; Thu, 2 Aug 2001 02:04:54 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:59264 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S268809AbRHBGEm>; Thu, 2 Aug 2001 02:04:42 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andreas Dilger <adilger@turbolinux.com>
Date: Thu, 2 Aug 2001 16:04:37 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15208.60789.17642.808680@notabene.cse.unsw.edu.au>
Cc: Roger Abrahamsson <hyperion@gnyrf.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: resizing of raid5?
In-Reply-To: message from Andreas Dilger on Wednesday August 1
In-Reply-To: <15207.63232.611617.37794@notabene.cse.unsw.edu.au>
	<200108011756.f71HuuL2006872@webber.adilger.int>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday August 1, adilger@turbolinux.com wrote:
> Neil Brown writes:
> > On Wednesday August 1, hyperion@gnyrf.net wrote:
> > > Just figured if anyone could give some information about resizing of
> > > software raid5 systems (2.4.x kernels)? I've been looking all over for
> > > information about if this is possible or not currently, and if not, how
> > > this system of raid cluster blocks work in conjunction with ext2.
> > 
> > The only way to resize a raid5 array is to back up, rebuild, and
> > re-load.  Any attempt to re-organise the data, or the linkage, to
> > avoid this would be more trouble that it is worth.
> 
> Hmm, this surprises me.  I would have thought it possible to do
> "resizing" at least by adding new stripes to the end of the current
> RAID 5 volume, using N+1 new "disks" to make up a new stripe group.

But would you bother.  just make another RAID5 set and append it to
the end using RAID-linear or LVM.  Achieve the same effect at a more
accessible level.  Or am I misunderstanding you?

NeilBrown

