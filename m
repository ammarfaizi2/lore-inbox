Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275746AbRI0Crx>; Wed, 26 Sep 2001 22:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275747AbRI0Crm>; Wed, 26 Sep 2001 22:47:42 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:45300 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S275746AbRI0Cr3>; Wed, 26 Sep 2001 22:47:29 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Wed, 26 Sep 2001 20:46:55 -0600
To: Maintaniner on duty <hugh@norma.kjist.ac.kr>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10aa1 not umounting the root file system during shut-down
Message-ID: <20010926204655.G1140@turbolinux.com>
Mail-Followup-To: Maintaniner on duty <hugh@norma.kjist.ac.kr>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3BB27912.7090303@norma.kjist.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BB27912.7090303@norma.kjist.ac.kr>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 27, 2001  09:55 +0900, Maintaniner on duty wrote:
> I don't know whether this bug is a problem of 2.4.10 or its aa1 or
> the "umount" program under SuSE-7.2 for Intel.
> But things changed between 2.4.10pre5 and 2.4.10aa1.
> 
> During the boot, the root file system is always picked up
> by "fsck" as unmounted cleanly.

This may be related to the blkdev-in-pagecache issue.  If the
root filesystem is not unmounted cleanly, it may be that e2fsck
will NEVER be able to mark the filesystem clean.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

