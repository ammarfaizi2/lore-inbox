Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbTAXR6Z>; Fri, 24 Jan 2003 12:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261872AbTAXR6Z>; Fri, 24 Jan 2003 12:58:25 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:47345 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S261615AbTAXR6Y>; Fri, 24 Jan 2003 12:58:24 -0500
Date: Fri, 24 Jan 2003 11:07:27 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Roman Dementiev <dementiev@mpi-sb.mpg.de>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: buffer leakage in kernel?
Message-ID: <20030124110727.N12662@schatzie.adilger.int>
Mail-Followup-To: Roman Dementiev <dementiev@mpi-sb.mpg.de>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <3E31364E.F3AFDCF0@mpi-sb.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E31364E.F3AFDCF0@mpi-sb.mpg.de>; from dementiev@mpi-sb.mpg.de on Fri, Jan 24, 2003 at 01:49:18PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 24, 2003  13:49 +0100, Roman Dementiev wrote:
> I've met with following problem (kernel 2.4.20-pre4 ):
> I write and read sequentially from/to 8 files each of 64 Gbytes (not a
> mistake, 64 Gbyte),
> each on different disk. The files are opened with flag O_DIRECT. I have
> 1 Gbyte RAM, no swap.
> While this scanning is running, number of "buffers" reported by ''free"
> and in /proc/meminfo
> is continuously increasing up to ~ 500 MB !! When the program exits
> normally or I break it, number
> of "buffers" does not decrease and even increases if I do operations on
> other files.
> 
> This is not nice at all when I have another applications running
> with memory consumption > 500 MB: when my "scanner" approaches 50G
> border on each disk, I've got numerous  "Out of memory" murders :(.
> Even 'ssh' to this machine is killed :(

There was a bug in vanilla 2.4.18 related to O_DIRECT that is fixed in the
RH kernel, but I don't know when/if it was merged into the main kernel.
As always, testing with the most recent kernel (2.4.21-pre3 currently)
will tell you whether that bug has been fixed already or not.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

