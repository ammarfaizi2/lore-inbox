Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317354AbSFRHyk>; Tue, 18 Jun 2002 03:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317359AbSFRHyj>; Tue, 18 Jun 2002 03:54:39 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:30455 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317354AbSFRHyi>; Tue, 18 Jun 2002 03:54:38 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 18 Jun 2002 01:51:18 -0600
To: Paul Menage <pmenage@ensim.com>
Cc: viro@math.psu.edu, torvalds@transmeta.com, linux-fsdevel@vger.kernel.org,
       trond.myklebust@fys.uio.no, jaharkes@cs.cmu.edu, braam@clusterfs.com,
       urban@teststation.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Push BKL into ->permission() calls
Message-ID: <20020618075118.GN22427@clusterfs.com>
Mail-Followup-To: Paul Menage <pmenage@ensim.com>, viro@math.psu.edu,
	torvalds@transmeta.com, linux-fsdevel@vger.kernel.org,
	trond.myklebust@fys.uio.no, jaharkes@cs.cmu.edu,
	braam@clusterfs.com, urban@teststation.com,
	linux-kernel@vger.kernel.org
References: <E17KDOn-0004vs-00@pmenage-dt.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17KDOn-0004vs-00@pmenage-dt.ensim.com>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 18, 2002  00:27 -0700, Paul Menage wrote:
> This patch (against 2.5.22) removes the BKL from around the call 
> to i_op->permission() in fs/namei.c, and pushes the BKL into those 
> filesystems that have permission() methods that require it:
>
> Out-of-tree filesystems that have their own permission() method will 
> need updating if they're relying on the BKL.

Please update Documentation/filesystems/porting with this info as part
of your patch.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

