Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264564AbTKNR7n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 12:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264566AbTKNR7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 12:59:43 -0500
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:24057 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S264564AbTKNR7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 12:59:42 -0500
Date: Fri, 14 Nov 2003 10:57:24 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 / EXT3-fs warning...ext3_unlink: Deleting nonexistent file
Message-ID: <20031114105724.D11847@schatzie.adilger.int>
Mail-Followup-To: Florian Lohoff <flo@rfc822.org>,
	linux-kernel@vger.kernel.org
References: <20031114174254.GA5594@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031114174254.GA5594@paradigm.rfc822.org>; from flo@rfc822.org on Fri, Nov 14, 2003 at 06:42:54PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 14, 2003  18:42 +0100, Florian Lohoff wrote:
> i seem to have experienced some ext3 inconsistencys - After some reboots
> today i was wondering why cron wasnt running and discovered that
> starting cron failed because /var/run/crond.pid could not be written.
> ls did not show and file under that name. touch showed i/o error on that
> file although other file in that directory could be touched.
> 
> When i tried to rm crond.pid this showed up:
> 
> EXT3-fs warning (device hda8): ext3_unlink: Deleting nonexistent file (107669), 0
> 
> After that i could touch the file again and crond did not refuse to start anymore.

This sounds like the htree "get back deleted entry on directory split" bug
that was fixed months ago in 2.6 htree, but not in any 2.4 patches.  Did
you test htree on this system under 2.4 recently?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

