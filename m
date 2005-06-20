Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVFTK1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVFTK1L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 06:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVFTK1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 06:27:09 -0400
Received: from outmx012.isp.belgacom.be ([195.238.3.70]:18612 "EHLO
	outmx012.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261329AbVFTKZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 06:25:24 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.12] XFS: Undeletable directory
Date: Mon, 20 Jun 2005 12:25:10 +0200
User-Agent: KMail/1.8.1
Cc: Nathan Scott <nathans@sgi.com>, linux-xfs@oss.sgi.com
References: <200506191904.49639.lkml@kcore.org> <20050620070459.GB1549@frodo>
In-Reply-To: <20050620070459.GB1549@frodo>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506201225.11129.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 June 2005 09:04, Nathan Scott wrote:
> What does:  xfs_db -r -c 'inode 4207214' -c print /dev/XXX
> report?

precious:/lost+found/4207214# xfs_db -r -c 'inode 4207214' -c print /dev/hda6
core.magic = 0x494e
core.mode = 040777
core.version = 1
core.format = 2 (extents)
core.nlinkv1 = 2
core.uid = 0
core.gid = 0
core.flushiter = 275
core.atime.sec = Sun Jun 19 20:38:29 2005
core.atime.nsec = 790399992
core.mtime.sec = Sun Jun 19 20:37:45 2005
core.mtime.nsec = 608116720
core.ctime.sec = Sun Jun 19 20:38:16 2005
core.ctime.nsec = 795375536
core.size = 8192
core.nblocks = 2
core.extsize = 0
core.nextents = 2
core.naextents = 0
core.forkoff = 0
core.aformat = 2 (extents)
core.dmevmask = 0
core.dmstate = 0
core.newrtbm = 0
core.prealloc = 0
core.realtime = 0
core.immutable = 0
core.append = 0
core.sync = 0
core.noatime = 0
core.nodump = 0
core.rtinherit = 0
core.projinherit = 0
core.nosymlinks = 0
core.gen = 0
next_unlinked = null
u.bmx[0-1] = [startoff,startblock,blockcount,extentflag] 0:[1,286547,1,0] 1:[8388608,286559,1,0]
precious:/lost+found/4207214# 

> If it comes to it, you can always zero out individual inode fields
> for that inode in xfs_db (with -x option to enable write mode) and
> then xfs_repair should be able to get past it.

Any idea how this should be set?

Thanks.
-- 
Hacker's Law:
	The belief that enhanced understanding will necessarily stir
	a nation to action is one of mankind's oldest illusions.
