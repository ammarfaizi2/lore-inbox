Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291121AbSBYQAV>; Mon, 25 Feb 2002 11:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291082AbSBYQAL>; Mon, 25 Feb 2002 11:00:11 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:13551 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S291121AbSBYP77>;
	Mon, 25 Feb 2002 10:59:59 -0500
Date: Sun, 24 Feb 2002 22:08:13 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Steven Walter <srwalter@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020224220813.F12832@lynx.adilger.int>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020224212727.A15097@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020224212727.A15097@hapablap.dyn.dhs.org>; from srwalter@yahoo.com on Sun, Feb 24, 2002 at 09:27:27PM -0600
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 24, 2002  21:27 -0600, Steven Walter wrote:
> After unintentionally deleting some file, I noticed what appears to be
> an incosistency (or at least a change) in ext3.  Running debugfs and
> executing the command "lsdel", I saw no inodes listed since I last ran
> the partition as ext2.  Does ext3 not add its deleted inodes to whatever
> list ext2 does?  And can this be fixed without compromising the speed or
> data-integrity of ext3?

Known problem.  Apparently difficult to fix, unfortunately.  It's not so
much that ext2 adds deleted inodes to a list, as that it simply marks the
inode "deleted" and doesn't overwrite any of the inode data on the disk.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

