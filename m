Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317191AbSICRCL>; Tue, 3 Sep 2002 13:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318813AbSICRCL>; Tue, 3 Sep 2002 13:02:11 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:764 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317191AbSICRCJ>; Tue, 3 Sep 2002 13:02:09 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 3 Sep 2002 11:04:16 -0600
To: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2 anomaly when making filesystem?
Message-ID: <20020903170416.GO32468@clusterfs.com>
Mail-Followup-To: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
	linux-kernel@vger.kernel.org
References: <3D747134.9290.1A2BFC@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D747134.9290.1A2BFC@localhost>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 03, 2002  08:22 +0200, Ulrich Windl wrote:
> Being curious, I dumped the metadata after creation and found some odd 
> thing: For several allocation groups there was a gap in the free 
> blocks. First I thought it is intentional; maybe to put administrative 
> data in the moddle of the allocation group, but then I found that other 
> groups had no such gap. I'll attach the dump at the end.
> 
> If it's intentional, maybe add some documentation about the layout to 
> the manual pages; if it's a bug, it would be nice to see it fixed.

It _is_ intentional.  The groups which have a gap do not have a backup
superblock or group descriptor table.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

