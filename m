Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317299AbSFRD11>; Mon, 17 Jun 2002 23:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317301AbSFRD10>; Mon, 17 Jun 2002 23:27:26 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:49654 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317299AbSFRD1Z>; Mon, 17 Jun 2002 23:27:25 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 17 Jun 2002 21:25:44 -0600
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
Subject: Re: ext2 errors w/2.5.x
Message-ID: <20020618032544.GM22427@clusterfs.com>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
References: <20020617.195611.61846581.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020617.195611.61846581.davem@redhat.com>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 17, 2002  19:56 -0700, David S. Miller wrote:
> I started seeing these occaisionally on my SMP boxes about a month or
> two ago, is anyone else seeing something similar?
> 
> EXT2-fs error (device sd(8,17)): ext2_find_entry: zero-length directory entry
> 
> Upon reboot e2fsck is forced to run (since the partition is marked as
> having errors by the kernel) and no problems are discovered.
> 
> Any clues?

This would appear to be from accessing a buffer (page) which has not yet
been read from disk.  Otherwise you would have an error from e2fsck also.
Andrew has been mucking the most in this area...

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

