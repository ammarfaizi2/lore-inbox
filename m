Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316043AbSFATRC>; Sat, 1 Jun 2002 15:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316620AbSFATRA>; Sat, 1 Jun 2002 15:17:00 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:51186 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316043AbSFATQy>; Sat, 1 Jun 2002 15:16:54 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Sat, 1 Jun 2002 13:15:14 -0600
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 9/16] direct-to-BIO writeback for writeback-mode ext3
Message-ID: <20020601191514.GA7905@turbolinux.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3CF88903.E253A075@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 01, 2002  01:42 -0700, Andrew Morton wrote:
> Turn on direct-to-BIO writeback for ext3 in data=writeback mode.

A minor note on this (especially minor since I believe data=journal
doesn't even work in 2.5), but you should probably also change the
address ops in ext3/ioctl.c if you enable/disable per-inode data
journaling.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

