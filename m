Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267446AbTAGRoy>; Tue, 7 Jan 2003 12:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267448AbTAGRoy>; Tue, 7 Jan 2003 12:44:54 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:35572 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S267446AbTAGRox>; Tue, 7 Jan 2003 12:44:53 -0500
Date: Tue, 7 Jan 2003 10:53:15 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Max Valdez <maxvaldez@yahoo.com>
Cc: Jan Hudec <bulb@ucw.cz>, kernel <linux-kernel@vger.kernel.org>
Subject: Re: Undelete files on ext3 ??
Message-ID: <20030107105315.T31555@schatzie.adilger.int>
Mail-Followup-To: Max Valdez <maxvaldez@yahoo.com>, Jan Hudec <bulb@ucw.cz>,
	kernel <linux-kernel@vger.kernel.org>
References: <200301070859.h078xEnI000337@darkstar.example.net> <Pine.LNX.4.44.0301071004550.30728-100000@dns.toxicfilms.tv> <20030107094547.GG2141@vagabond> <1041961118.13635.10.camel@garaged.fis.unam.mx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1041961118.13635.10.camel@garaged.fis.unam.mx>; from maxvaldez@yahoo.com on Tue, Jan 07, 2003 at 11:38:38AM -0600
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 07, 2003  11:38 -0600, Max Valdez wrote:
> I think there must be some other differences between ext2 and ext3, I've
> tryed e2undel and unrm, both made for ext2, and none of them found any
> deleted inode.

Yes, in order to ensure that ext3 can safely resume an unlink after a
crash, it actually zeros out the block pointers in the inode, whereas
ext2 just marks these blocks as unused in the block bitmaps and marks
the inode as "deleted" and leaves the block pointers alone.

Your only hope is to "grep" for parts of your files that have been deleted
and hope for the best.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

