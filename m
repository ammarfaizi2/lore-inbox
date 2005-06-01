Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVFARyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVFARyX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 13:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVFARyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 13:54:23 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:8359 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261479AbVFARvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 13:51:07 -0400
Subject: 2.6.12-rc5-mm2 JFS problems ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: shaggy@us.ibm.com, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1117647023.26913.1587.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Jun 2005 10:30:25 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shaggy,

I keep running to JFS problems on 2.6.12-rc5-mm2 (never seen before).
I get following stacks while booting the machine. 

Known issue ?

Thanks,
Badari


fsck.jfs version 1.1.6, 28-Apr-2004
processing started: 6/1/2005 2.55.40
The current device is:  /dev/hda2
Block size in bytes:  4096
Filesystem size in blocks:  19842354
**Phase 0 - Replay Journal Log
Filesystem is clean.                                                
done
Bad page state at free_hot_cold_page (in process 'hotplug', page
ffff8100040f724
0)
flags:0x0100000000000804 mapping:0000000000000000 mapcount:0 count:0
Backtrace:
                                                                                                          
Call Trace:<ffffffff801630d1>{bad_page+113}
<ffffffff801634f4>{free_hot_cold_page+132}
       <ffffffff8025fc7d>{dtSearch+2189}
<ffffffff8024dc1c>{jfs_lookup+172}
       <ffffffff8019ce5f>{d_alloc+431} 
<ffffffff801910ff>{do_lookup+223}
       <ffffffff801936d3>{__link_path_walk+2627}
<ffffffff80193c84>{link_path_walk+180}
       <ffffffff80194300>{path_lookup+448}
<ffffffff8019556e>{__user_walk+62}
       <ffffffff8018c499>{vfs_stat+41}
<ffffffff8018c74f>{sys_newstat+31}
       <ffffffff8010dc1e>{system_call+126}
Trying to fix it up, but a reboot is needed


