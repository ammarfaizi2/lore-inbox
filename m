Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbWHRNIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbWHRNIM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 09:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWHRNIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 09:08:12 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:19161 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932365AbWHRNIK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 09:08:10 -0400
Date: Fri, 18 Aug 2006 07:08:08 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Pavel Machek <pavel@suse.cz>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Alex Tomas <alex@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 1/9] extents for ext4
Message-ID: <20060818130808.GS6634@schatzie.adilger.int>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	"Randy.Dunlap" <rdunlap@xenotime.net>,
	Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
	cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <1155172827.3161.80.camel@localhost.localdomain> <20060809233940.50162afb.akpm@osdl.org> <m37j1hlyzv.fsf@bzzz.home.net> <20060811135737.1abfa0f6.rdunlap@xenotime.net> <20060815154019.GD4032@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060815154019.GD4032@ucw.cz>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 15, 2006  15:40 +0000, Pavel Machek wrote:
> > --- linux-2618-rc4-ext4.orig/include/linux/ext4_fs_extents.h
> > +++ linux-2618-rc4-ext4/include/linux/ext4_fs_extents.h
> > @@ -22,29 +22,29 @@
> >  #include <linux/ext4_fs.h>
> >  
> >  /*
> > - * with AGRESSIVE_TEST defined capacity of index/leaf blocks
> > - * become very little, so index split, in-depth growing and
> > - * other hard changes happens much more often
> > - * this is for debug purposes only
> > + * With AGRESSIVE_TEST defined, the capacity of index/leaf blocks
> > + * becomes very small, so index split, in-depth growing and
> > + * other hard changes happen much more often.
> > + * This is for debug purposes only.
> >   */
> >  #define AGRESSIVE_TEST_
> 
> Using _ for disabling is unusual/nasty.

I've always thought the same.  I'd prefer just commenting out the whole
line.

> Can't we simply #undef it?

Use of #undef is not so great, since that means it isn't possible to
#define this flag in another header, on the make command-line, etc.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

