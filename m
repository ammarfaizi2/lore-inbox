Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262939AbUDBEPG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 23:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262933AbUDBEPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 23:15:06 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:48010 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262939AbUDBEO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 23:14:59 -0500
Date: Fri, 2 Apr 2004 15:13:55 +1000
From: Nathan Scott <nathans@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: ST alloc failures
Message-ID: <20040402051355.GA1604@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm seeing a bunch of large allocation attempts failing from
the SCSI tape driver when doing dumps and restores ... (this
is with a stock 2.6.4 kernel).

xfsdump: page allocation failure. order:8, mode:0xd0
Call Trace:
 [<c013982b>] __alloc_pages+0x33b/0x3d0
 [<c03805ac>] enlarge_buffer+0xdc/0x1b0
 [<c03819a3>] st_map_user_pages+0x33/0x90
 [<c037cf24>] setup_buffering+0xb4/0x160
 [<c037dd19>] st_read+0x109/0x450
 [<c01173e3>] kernel_map_pages+0x33/0x68
 [<c015464f>] vfs_read+0xaf/0x120
 [<c0153c48>] sys_open+0x78/0x90
 [<c01548df>] sys_read+0x3f/0x60
 [<c01094e1>] sysenter_past_esp+0x52/0x71

xfsdump: page allocation failure. order:7, mode:0xd0
Call Trace:
 [<c013982b>] __alloc_pages+0x33b/0x3d0
 [<c03805ac>] enlarge_buffer+0xdc/0x1b0
 [<c03819a3>] st_map_user_pages+0x33/0x90
 [<c037cf24>] setup_buffering+0xb4/0x160
 [<c037dd19>] st_read+0x109/0x450
 [<c01173e3>] kernel_map_pages+0x33/0x68
 [<c015464f>] vfs_read+0xaf/0x120
 [<c0153c48>] sys_open+0x78/0x90
 [<c01548df>] sys_read+0x3f/0x60
 [<c01094e1>] sysenter_past_esp+0x52/0x71

xfsrestore: page allocation failure. order:8, mode:0xd0
Call Trace:
 [<c013982b>] __alloc_pages+0x33b/0x3d0
 [<c03805ac>] enlarge_buffer+0xdc/0x1b0
 [<c03819a3>] st_map_user_pages+0x33/0x90
 [<c037cf24>] setup_buffering+0xb4/0x160
 [<c037dd19>] st_read+0x109/0x450
 [<c01173e3>] kernel_map_pages+0x33/0x68
 [<c015464f>] vfs_read+0xaf/0x120
 [<c0153c48>] sys_open+0x78/0x90
 [<c01548df>] sys_read+0x3f/0x60
 [<c01094e1>] sysenter_past_esp+0x52/0x71

xfsrestore: page allocation failure. order:7, mode:0xd0
Call Trace:
 [<c013982b>] __alloc_pages+0x33b/0x3d0
 [<c03805ac>] enlarge_buffer+0xdc/0x1b0
 [<c03819a3>] st_map_user_pages+0x33/0x90
 [<c037cf24>] setup_buffering+0xb4/0x160
 [<c037dd19>] st_read+0x109/0x450
 [<c01173e3>] kernel_map_pages+0x33/0x68
 [<c015464f>] vfs_read+0xaf/0x120
 [<c0153c48>] sys_open+0x78/0x90
 [<c01548df>] sys_read+0x3f/0x60
 [<c01094e1>] sysenter_past_esp+0x52/0x71


cheers.

-- 
Nathan
