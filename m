Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261955AbSJZIJ7>; Sat, 26 Oct 2002 04:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261963AbSJZIJ6>; Sat, 26 Oct 2002 04:09:58 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:31222 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S261955AbSJZIJ6>; Sat, 26 Oct 2002 04:09:58 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Sat, 26 Oct 2002 02:13:18 -0600
To: Andi Kleen <ak@suse.de>
Cc: Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: The return of the return of crunch time (2.5 merge candidate list 1.6)
Message-ID: <20021026081318.GZ28822@clusterfs.com>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
References: <200210251557.55202.landley@trommello.org.suse.lists.linux.kernel> <p7365vptz49.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p7365vptz49.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 26, 2002  09:53 +0200, Andi Kleen wrote:
> Patches available on request or older versions from 
> ftp://ftp.firstfloor.org/pub/ak/v2.5/nsec*
> They don't actually add ns resolution, but jiffies resolution, which
> is 1ms on 2.5 and should be good enough for now. It reuses reserved fields
> in struct stat and doesn't need any user interface changes.
> 
> It requires editing of a lot of file systems in a straight forward way,
> so should be better done before the stable series starts.
> 
> There are some minor compatbility issues with fs that only support 
> second timestamps like ext2/ext3, see nsec.notes in the ftp directory
> or past threads on that on the list.

Just as an FYI - this is "in the pipes" for ext2/ext3 also, which the
(very basic) support for variable-sized inodes that Ted has already
submitted is the groundwork for (among other things).  We will then have
space to add usec timestamps to ext2/ext3 inodes for people who choose to
have larger inodes (new filesystems only, to start with), and when we get
more efficient EA storage we will also be able to store the "large inode
fields" into EAs for existing filesystems.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

