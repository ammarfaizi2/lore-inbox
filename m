Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261294AbSJHP2h>; Tue, 8 Oct 2002 11:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbSJHP2g>; Tue, 8 Oct 2002 11:28:36 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:17916 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S261294AbSJHP2g>; Tue, 8 Oct 2002 11:28:36 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 8 Oct 2002 09:31:50 -0600
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 -  (NUMA))
Message-ID: <20021008153150.GG3045@clusterfs.com>
Mail-Followup-To: Helge Hafting <helgehaf@aitel.hist.no>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE> <1281002684.1033892373@[10.10.2.3]> <E17ybuZ-0003tz-00@starship> <3DA1D30E.B3255E7D@digeo.com> <3DA1D969.8050005@nortelnetworks.com> <3DA1E250.1C5F7220@digeo.com> <3DA2E385.A16F9325@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA2E385.A16F9325@aitel.hist.no>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 08, 2002  15:54 +0200, Helge Hafting wrote:
> Andrew Morton wrote:
> > Part of the problem here is that it has got worse over time.  The
> > size of a blockgroup is hardwired to blocksize*bits-in-a-byte*blocksize.
> > But disks keep on getting bigger.  Five years ago (when, presumably, this
> > algorithm was designed), a typical partition had, what?  Maybe four
> > blockgroups?  Now it has hundreds, and so the "levelling" is levelling
> > across hundreds of blockgroups and not just a handful.
> 
> If having only "a few" block groups really work better 
> (even for todays bigger disks) then bigger
> block groups seems like a solution.
> 
> changing the on-disk format might not be popular, but there
> is no need for that.  Simply regard several on-disk block
> groups as a bigger "allocation group" when using the above
> algorithm.  This should be perfectly backwards compatible.

We already have plans for something like this - a "meta blockgroup".
This will help us with several things, actually, so it is likely to
be implemented.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

