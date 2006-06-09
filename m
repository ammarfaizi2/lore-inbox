Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030350AbWFIS3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbWFIS3k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbWFIS3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:29:40 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:12945 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1030350AbWFIS3j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:29:39 -0400
Date: Fri, 9 Jun 2006 12:29:45 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609182945.GD5964@schatzie.adilger.int>
Mail-Followup-To: Jeff Garzik <jeff@garzik.org>,
	Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	cmm@us.ibm.com, linux-fsdevel@vger.kernel.org
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int> <44898EE3.6080903@garzik.org> <m3r71ycprd.fsf@bzzz.home.net> <44899778.1010705@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44899778.1010705@garzik.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 09, 2006  11:44 -0400, Jeff Garzik wrote:
> b) watch users boot w/ extents, accidentally do something silly like 
> writing data to a file, and become locked into a new subset of kernels?
> 
> The simple act of writing data to a file has become an _irrevocable 
> filesystem upgrade event_.

You keep on saying this, but you know it won't happen TODAY.  On the contrary,
if extents are merged today, I don't see distros making it a default mount
option for YEARS (it won't be the default for RHEL5, which is the only distro
that has participation on the ext3 developers, I can't comment for others).

WHEN extents become the default (which I hope they will at some point, like
dir_index and large inodes, that have been around for years already too)
then it will be mostly a non-issue (how many times do you boot into 2.2?).

The only exception is if you have a filesystem larger than 16TB you have
to use extents, which isn't an issue either way.  I don't think they will
ever become the default for e.g. root or boot filesystems, just for
compatibility reasons, but are highly desirable for e.g. mythtv or other
"large file" using filesystems.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

