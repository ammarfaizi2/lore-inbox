Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263010AbUCSPf7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 10:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUCSPf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 10:35:59 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:31193 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263010AbUCSPf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 10:35:56 -0500
Date: Fri, 19 Mar 2004 16:35:54 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Chris Mason <mason@suse.com>
Subject: [PATCH] barrier patch set
Message-ID: <20040319153554.GC2933@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A first release of a collected barrier patchset for 2.6.5-rc1-mm2. I
have a few changes planned to support dm/md + sata, I'll do those
changes over the weekend.

Reiser has the best barrier support, ext3 works but only if things don't
go wrong. So only attempt to use the barrier feature on ext3 if on ide
drives, not SCSI nor SATA.

Also note that for reiser you need to add:

	-o barrier=flush

while ext3 currently wants:

	-o barrier=1

Cosmetic stuff that will get ironed out. You can find the patches here:

ftp://ftp.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.5-rc1-mm2/

ide-barrier-2.6.5-rc1-mm2-1
	ide/core part

ext3-barrier-2.6.5-rc1-mm2-1
	ext3 part

reiserfs-current-2.6.5-rc1-mm2-1
	current reiser tree, get it here in parts:

	ftp.suse.com/pub/people/mason/patches/data-logging/experimental/2.6.4

	(use series.mm for apply order)

reiserfs-barrier-2.6.5-rc1-mm2-1
	reiser part.

or just apply

all-barrier-2.6.5-rc1-mm2-1
	all rolled up into one patch.

-- 
Jens Axboe

