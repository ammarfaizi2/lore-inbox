Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272980AbRJCLAD>; Wed, 3 Oct 2001 07:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273054AbRJCK7y>; Wed, 3 Oct 2001 06:59:54 -0400
Received: from h55p103-2.delphi.afb.lu.se ([130.235.187.175]:53143 "EHLO gin")
	by vger.kernel.org with ESMTP id <S272980AbRJCK7l>;
	Wed, 3 Oct 2001 06:59:41 -0400
Date: Wed, 3 Oct 2001 13:00:07 +0200
To: linux-kernel@vger.kernel.org
Cc: magnusm@0x63.nu
Subject: mount D-states on secound mount
Message-ID: <20011003130007.A32735@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
From: andersg@0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i run 2.4.10 with lvm-1.0.1-rc2 on a smp-system.

Mounting a filesystem a second time fails. (mount /dev/vg00/lv01 /ftp/www ;
mount /dev/vg00/lv01 /www ). The disk contains a reiserfs filesystem.
It worked in 2.4.9 with lvm-1.0.1-rc2. Is this a lvm problem?

Mount D-states here:

Trace; c02085bc <rwsem_down_read_failed+11c/144>
Trace; c020c5b2 <stext_lock+2296/7054>
Trace; c0147d04 <sync_inodes+14/4c>
Trace; c0134a8a <fsync_dev+3a/74>
Trace; c0134ace <sync_dev+a/10>
Trace; c01c5692 <lvm_blk_close+36/54>
Trace; c013b952 <blkdev_put+12e/188>
Trace; c01392fe <get_sb_bdev+1a2/300>
Trace; c0139df0 <do_kern_mount+e8/1b0>
Trace; c0139ef0 <do_add_mount+20/bc>
Trace; c013a17a <do_mount+14e/168>
Trace; c0139fdc <copy_mount_options+50/a0>
Trace; c013a242 <sys_mount+ae/10c>
Trace; c0106d7a <system_call+32/38>



-- 

//anders/g

