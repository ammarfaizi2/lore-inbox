Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316642AbSEQSkd>; Fri, 17 May 2002 14:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316641AbSEQSkc>; Fri, 17 May 2002 14:40:32 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:42992 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316642AbSEQSkc>; Fri, 17 May 2002 14:40:32 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 17 May 2002 12:36:13 -0600
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: phillips@bonn-fries.net, Peter Chubb <peter@chubb.wattle.id.au>,
        Anton Altaparmakov <aia21@cantab.net>,
        Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
        axboe@suse.de, akpm@zip.com.au, martin@dalecki.de,
        neilb@cse.unsw.edu.au
Subject: Re: [PATCH] remove 2TB block device limit
Message-ID: <20020517183613.GB21295@turbolinux.com>
Mail-Followup-To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
	phillips@bonn-fries.net, Peter Chubb <peter@chubb.wattle.id.au>,
	Anton Altaparmakov <aia21@cantab.net>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	axboe@suse.de, akpm@zip.com.au, martin@dalecki.de,
	neilb@cse.unsw.edu.au
In-Reply-To: <E178VRs-0008Va-00@starship> <200205171332.IAA93516@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 17, 2002  08:32 -0500, Jesse Pollard wrote:
> Note - most these really large filesystems allow the inode tables and
> bitmaps to be stored on disks with a relatively small blocksize (raid 5),
> and the data on different drives (striped) with a large block size (I believe
> ours is 64K to 128K sized data blocks, inode/bitmaps are 16K-32K.)
> 
> The division allows for high integrity of the meta data (which is also
> backed up daily (incremental) - but without the corresponding datablocks),
> along with maximum capacity for data. 1/5 of 200TB is about 40TB if raid5
> were used with everything.

Interestingly, this can also be done for Lustre, the OSS cluster
filesystem I am currently working on (http://www.clusterfs.com).
All of the filesystem metadata is actually stored on a separate server,
so its disk can be configured totally separately from the file data.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

