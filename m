Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293635AbSCPBLn>; Fri, 15 Mar 2002 20:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293637AbSCPBLe>; Fri, 15 Mar 2002 20:11:34 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:10747
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293635AbSCPBLX>; Fri, 15 Mar 2002 20:11:23 -0500
Date: Fri, 15 Mar 2002 17:12:03 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Luigi Genoni <kernel@Expansa.sns.it>,
        Thunder from the hill <thunder@ngforever.de>,
        linux-kernel@vger.kernel.org, Martin Eriksson <nitrax@giron.wox.org>
Subject: Re: HPT370 RAID-1 or Software RAID-1, what's "best"?
Message-ID: <20020316011203.GB363@matchmail.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Luigi Genoni <kernel@Expansa.sns.it>,
	Thunder from the hill <thunder@ngforever.de>,
	linux-kernel@vger.kernel.org,
	Martin Eriksson <nitrax@giron.wox.org>
In-Reply-To: <Pine.LNX.4.44.0203151716120.30388-100000@Expansa.sns.it> <E16lvju-0004Bj-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16lvju-0004Bj-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 05:43:38PM +0000, Alan Cox wrote:
> > Hardware RAID is indeed better, but what you get using HPT370 IDE
> > controlelr is not hardware raid at all. Just read the code of the driver.
> > You get a software raid, period.
> 
> Its not always that simple either.
> 
> Software raid on aic7xxx totally blows away the Dell/AMI megaraid card I
> have, to the point the megaraid now resides in my testing bucket. The promise
> Supertrak 100 (now superceded by the SX6000) is also slower than the
> software IDE raid, but does use less CPU in RAID5 mode.
> 
> Some hardware raid cards do seem to be winners. The Dell Perc2/QC aacraid
> based boards (233Mhz ARM etc) really shift. When I've had the chance to
> borrow the disks to test I've seen it running over 100Mbytes/second. It
> also supports nice stuff like online reconfiguration of active volumes.
> [$$stupid from Dell $$notalot from ebay ;)]

Yep, but the aacraid controllers based on i960 don't do so well.  I was able
to double my throughput after switching to software raid (it acts like an
aic7xxx in scsi mode, even using the adaptec driver instead of aacraid).

Mike
