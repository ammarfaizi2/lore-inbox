Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbTIYQp2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 12:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbTIYQp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 12:45:28 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:6650 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S261361AbTIYQpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 12:45:25 -0400
Date: Thu, 25 Sep 2003 10:45:08 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: "Norris, Brent" <bnorris@Edmonson.k12.ky.us>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: 128G Limit in Reiserfs? Or the Kernel? Or something else?
Message-ID: <20030925104508.J2094@schatzie.adilger.int>
Mail-Followup-To: "Norris, Brent" <bnorris@Edmonson.k12.ky.us>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <9A8F8D67DC8ED311BF3E0008C7B9A0ADBAA86E@E151000N0>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <9A8F8D67DC8ED311BF3E0008C7B9A0ADBAA86E@E151000N0>; from bnorris@Edmonson.k12.ky.us on Thu, Sep 25, 2003 at 08:08:16AM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 25, 2003  08:08 -0500, Norris, Brent wrote:
> I seem to have hit an odd limit, that I didn't think existed.  I have a 250G
> WD IDE hard drive that I have just installed.  Since I couldn't put a Ext3
> filesystem on it (mount wouldn't recognize it) I decided to put a ReiserFS
> filesystem on it.

Just FYI, we have lots of ext3 filesystems that are 2TB in size, so I don't
think it is an ext3 problem.  What could be happening though is that when
you mke2fs the filesystem with your IDE problem it wraps writes over 128GB
back to zero and overwrites the superblock so mount doesn't see the ext3
superblock anymore.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

