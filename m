Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317528AbSFDXdC>; Tue, 4 Jun 2002 19:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317529AbSFDXdB>; Tue, 4 Jun 2002 19:33:01 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:53498 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317528AbSFDXdB>; Tue, 4 Jun 2002 19:33:01 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 4 Jun 2002 17:31:24 -0600
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] "laptop mode"
Message-ID: <20020604233124.GA18668@turbolinux.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3CFD453A.B6A43522@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 04, 2002  15:54 -0700, Andrew Morton wrote:
> laptop_writeback_centisecs
> --------------------------
> 
> This tunable determines the maximum age of dirty data when the machine
> is operating in Laptop mode.  The default value is 30000 - five
> minutes.  This means that if applications are generating a small amount
> of write traffic, the disk will spin up once per five minutes.

Just FYI, this is probably an optimally bad choice for the default disk
spinup interval, as many laptops spindown timers in the same ballpark.
I would say 15-20 minutes or more, unless there is a huge amount of
VM pressure or something.  Otherwise, you will quickly have a dead
laptop harddrive from the overly-frequent spinup/down cycles.

Yes, minutae, I know.  Otherwise a nice idea.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

