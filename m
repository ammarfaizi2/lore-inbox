Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314885AbSFYHuc>; Tue, 25 Jun 2002 03:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSFYHub>; Tue, 25 Jun 2002 03:50:31 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:51703 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S314885AbSFYHub>; Tue, 25 Jun 2002 03:50:31 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 25 Jun 2002 01:48:04 -0600
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: "Amit  Agrawal, Noida" <amitag@noida.hcltech.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Bogus LBD patch
Message-ID: <20020625074804.GA5858@clusterfs.com>
Mail-Followup-To: Peter Chubb <peter@chubb.wattle.id.au>,
	"Amit  Agrawal, Noida" <amitag@noida.hcltech.com>,
	linux-kernel@vger.kernel.org
References: <E04CF3F88ACBD5119EFE00508BBB21210331C254@exch-01.noida.hcltech.com> <15640.5302.257228.579646@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15640.5302.257228.579646@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 25, 2002  16:59 +1000, Peter Chubb wrote:
> I found that ext2 has too much metadata for the amount of disc space I
> have for the sparse file approach to work.

You can easily change this by reducing the number of inodes created.
If you specify "mke2fs -N 1 <dev>" you will get the minimum possible
number of inodes created.  There is currently a 16TB limit on ext2/3
filesystems, unless you are testing on a platform with 8kB+ PAGE_SIZE
and have the e2fsprogs from the BK repository, in which case you can
create 8kB blocks (for 32TB filesystems).

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

