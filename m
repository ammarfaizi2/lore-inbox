Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277599AbRJRHiF>; Thu, 18 Oct 2001 03:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277601AbRJRHh4>; Thu, 18 Oct 2001 03:37:56 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:41186 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S277599AbRJRHhr>; Thu, 18 Oct 2001 03:37:47 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Ryan Mack <rmack@mackman.net>
Date: Thu, 18 Oct 2001 16:49:00 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15310.31580.322324.824333@notabene.cse.unsw.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [QUESTION] Stopping RAID devices from Magic SysRq?
In-Reply-To: message from Ryan Mack on Thursday October 11
In-Reply-To: <Pine.LNX.4.33.0110111739050.934-100000@mackman.net>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday October 11, rmack@mackman.net wrote:
> I was curious if anyone has previosly considered adding a raid-stop
> functionality to the magic sysrq command?  I realize that a full raid-stop
> would make the partition unavailable for read-only access, which may
> require the system to be immediately reset.  Is there a mechanism to
> remount a raid device read-only if all mounts from it are read-only (i.e.,
> marking the raid superblock clean, syncing, and then only allowing
> read-only access)?
> 
> Thanks, Ryan

This is a nice idea... but awkward.
Particularly if md.o is a module, setting the hooks up properly would
not be tidy.

What we really need is a general concept of setting all drvies to
read-only through the block-dev layer.... maybe in the big blockdev
rewrite that is planned for 2.5...

NeilBrown

> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
