Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263647AbTJOQ6P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 12:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263650AbTJOQ6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 12:58:15 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:24048 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S263647AbTJOQ6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 12:58:13 -0400
Date: Wed, 15 Oct 2003 10:56:55 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: josh@temp123.org, linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031015105655.C1593@schatzie.adilger.int>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>, josh@temp123.org,
	linux-kernel@vger.kernel.org
References: <1066163449.4286.4.camel@Borogove> <1066235105.14783.1602.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1066235105.14783.1602.camel@hades.cambridge.redhat.com>; from dwmw2@infradead.org on Wed, Oct 15, 2003 at 05:25:06PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 15, 2003  17:25 +0100, David Woodhouse wrote:
> On Tue, 2003-10-14 at 16:30 -0400, Josh Litherland wrote:
> > Are there any filesystems which implement the transparent compression
> > attribute ?  (chattr +c)
> 
> JFFS2 doesn't implement 'chattr +c', which is in fact an EXT2-private
> ioctl. But it does do transparent compression.

Actually, reiserfs also supports ext2-compatible SETFLAGS/GETFLAGS ioctls.
This allows us to use the same tools for lsattr and chattr instead of using
lsattr.reiserfs, etc.  Our Lustre distributed filesystem does the same.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

