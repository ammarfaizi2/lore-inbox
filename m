Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbTKVLw4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 06:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbTKVLw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 06:52:56 -0500
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:49140 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S262225AbTKVLwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 06:52:55 -0500
Date: Sat, 22 Nov 2003 04:48:34 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Christoph Hellwig <hch@infradead.org>, Juergen Hasch <lkml@elbonia.de>,
       Michael Welles <mike@bangstate.com>, linux-kernel@vger.kernel.org
Subject: Re: Using get_cwd inside a module.
Message-ID: <20031122044833.R20568@schatzie.adilger.int>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Juergen Hasch <lkml@elbonia.de>,
	Michael Welles <mike@bangstate.com>, linux-kernel@vger.kernel.org
References: <3FBEA83B.1060001@bangstate.com> <20031122083035.A30106@infradead.org> <200311221033.35108.lkml@elbonia.de> <20031122101559.A30932@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031122101559.A30932@infradead.org>; from hch@infradead.org on Sat, Nov 22, 2003 at 10:15:59AM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 22, 2003  10:15 +0000, Christoph Hellwig wrote:
> On Sat, Nov 22, 2003 at 10:33:34AM +0100, Juergen Hasch wrote:
> > Dnotify doesn't return the file names that changed, changedfiles does.
> > I've looked into this, because Samba would benefit from such a functionality.
> > 
> > So maybe it would be possible to teach dnotify to return file names
> > (e.g. using netlink) ?
> 
> Well, you can't return filenames.  There's no unique path to a give
> file. 

Since the caller is already watching a specific directory, it doesn't
need to know the full pathname, just the inode number that changed.
Then Samba et. al. could do an inode->name(s) lookup on the directory.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

