Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317691AbSGKAsp>; Wed, 10 Jul 2002 20:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317693AbSGKAso>; Wed, 10 Jul 2002 20:48:44 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:46830 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317691AbSGKAsn>; Wed, 10 Jul 2002 20:48:43 -0400
Date: Wed, 10 Jul 2002 18:49:33 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Marc-Christian Petersen <mcp@linux-systeme.de>
Cc: Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org
Subject: Re: htree directory indexing 2.4.18-2 BUG with highmem and also high i/o
Message-ID: <20020711004933.GD1045@clusterfs.com>
Mail-Followup-To: Marc-Christian Petersen <mcp@linux-systeme.de>,
	Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org
References: <200207092333.01130.mcp@linux-systeme.de> <20020710210153.GA1045@clusterfs.com> <E17SQE4-00029R-00@starship> <200207110103.37380.mcp@linux-systeme.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207110103.37380.mcp@linux-systeme.de>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 11, 2002  01:03 +0200, Marc-Christian Petersen wrote:
> > On Wednesday 10 July 2002 23:01, Andreas Dilger wrote:
> > > The ext2 htree patch probably needs to add a "kmap()" and "kunmap()"
> > > in the function that reads a page and scans the directory for the
> > > name it is looking for.  I can't be any more specific than this
> > > right now since I only have the ext3 version of this patch, and it
> > > does not have page-cache based directories (it is still using the
> > > buffer cache).
> 
> Say, where can i find those patch for ext3? I've searched a long time and 
> never found it?! :|

The most up-to-date version is in the ext3 CVS tree at sourceforge:
http://sourceforge.net/projects/gkernel/

the ext3 package therein has "features-branch" on which the ext3 htree
patch has already been applied (along with other ext3 fixes).  If you
only want the ext3 htree patch, you can also get it from the "lustre"
sourceforge project at "lustre/extN/htree-ext3-2.4.18.diff".

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

