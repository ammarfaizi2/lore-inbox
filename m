Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271924AbRIUIKG>; Fri, 21 Sep 2001 04:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271836AbRIUIJ5>; Fri, 21 Sep 2001 04:09:57 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:17918 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S271940AbRIUIJx>; Fri, 21 Sep 2001 04:09:53 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Fri, 21 Sep 2001 02:09:38 -0600
To: David Hajek <david@atrey.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: high cpu load with sw raid1
Message-ID: <20010921020938.I14526@turbolinux.com>
Mail-Followup-To: David Hajek <david@atrey.karlin.mff.cuni.cz>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010920102616.A2753@pida.ulita.cz> <20010920124020.D14526@turbolinux.com> <20010921090720.A12970@pida.ulita.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010921090720.A12970@pida.ulita.cz>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 21, 2001  09:07 +0200, David Hajek wrote:
> On Thu, Sep 20, 2001, Andreas Dilger wrote:
> > On Sep 20, 2001  10:26 +0200, David Hajek wrote:
> > > I have linux box with 70GB SW Raid1. This box runs for half
> > > a year without problems but now I meet the high cpu load 
> > > problems. I suspect that it can be caused by not enough 
> > > free disk space on this md device. I see following:
> > > 
> > > 1 GB free  - load > 5
> > > 5 GB free  - load < 1
> > 
> > What filesystem are you using?  If it is reiserfs, and you have < 10%
> > of the disk free, it is very unhappy.  A patch to fix this is available.
> 
> I'm using ext2. I suspect high ext2 fragmentation, because when
> there are 'only' 1GB free the disk is _really_ busy. I doubt
> that it takes lot of time to find free blocks. 

OK, I just re-read your initial posting, and see you have a 70GB RAID,
so 1GB free is about 1.4% free, which makes for bad performance no
matter what filesystem you have.  In general, ext2 will have this 1%
free space spread evenly across all of the disk, so while 1GB is still
a lot of space, it is still a nearly full filesystem.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

