Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261724AbSKFJkS>; Wed, 6 Nov 2002 04:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262209AbSKFJkS>; Wed, 6 Nov 2002 04:40:18 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:61170 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S261724AbSKFJkS>; Wed, 6 Nov 2002 04:40:18 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 6 Nov 2002 02:44:25 -0700
To: Christopher Li <chrisl@vmware.com>
Cc: "'Jeremy Fitzhardinge '" <jeremy@goop.org>,
       "'Ext2 devel '" <ext2-devel@lists.sourceforge.net>,
       "'Linux Kernel List '" <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] bug in ext3 htree rename: doesn't delete old nam e, leaves ino with bad nlink
Message-ID: <20021106094425.GP588@clusterfs.com>
Mail-Followup-To: Christopher Li <chrisl@vmware.com>,
	'Jeremy Fitzhardinge ' <jeremy@goop.org>,
	'Ext2 devel ' <ext2-devel@lists.sourceforge.net>,
	'Linux Kernel List ' <linux-kernel@vger.kernel.org>
References: <3C77B405ABE6D611A93A00065B3FFBBA080B3D@PA-EXCH2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C77B405ABE6D611A93A00065B3FFBBA080B3D@PA-EXCH2>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 06, 2002  01:03 -0800, Christopher Li wrote:
> Jeremy Fitzhardinge wrote:
> >Update it in what way?  In principle a rename is an atomic operation, so
> >other things shouldn't be able to observe the directory in an
> >intermediate state.
> 
> I mean when split dir entry blocks, it will move the dir entry inside
> that block. I am not clear about do we need to invalidate the dentry
> cache for those changed entry. I need to check the source.

I am not aware of anything stored in a dentry which would be affected
by the directory or changes therein at all.  The file name is allocated
as part of the dentry, and also only holds an inode pointer.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

