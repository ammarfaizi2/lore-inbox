Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbTDEChk (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 21:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbTDEChk (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 21:37:40 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:15349 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S261711AbTDEChj (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 21:37:39 -0500
Date: Fri, 4 Apr 2003 19:49:02 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Brian Litzinger <brian@localhost.localdomain>,
       linux-kernel@vger.kernel.org
Subject: Re: Can't recover from broken ext3 journal
Message-ID: <20030404194902.D1422@schatzie.adilger.int>
Mail-Followup-To: Brian Litzinger <brian@localhost.localdomain>,
	linux-kernel@vger.kernel.org
References: <20030326093027.GA14108@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030326093027.GA14108@localhost.localdomain>; from brian@worldcontrol.com on Wed, Mar 26, 2003 at 01:30:27AM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 26, 2003  01:30 -0800, brian@worldcontrol.com wrote:
> I had a harddrive develop hard IO errors in the section of the drive
> that holds the ext3 journal.
> 
> If it try to fsck the filesystem, fsck eventually terminates after
> trying to replay the journal.
> 
> I tried to use debugfs but that fails in similar way.
> 
> When I use tune2fs to try to turn off the journal, even with
> the -f option, it simply reports 'the needs_recovery flag is
> set, please run e2fsck'.
> 
> I've replaced the drive and restored from backups, however, it seems
> rather poor design that I should lose *all* my data on the drive simply
> because the journal won't replay due to an disk error.

debugfs -w -R "feature ^has_journal ^needs_recovery" /dev/whatever
e2fsck -f /dev/whatever

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

