Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161064AbWHSGsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161064AbWHSGsk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 02:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030310AbWHSGsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 02:48:40 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:13714 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S1030293AbWHSGsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 02:48:39 -0400
Date: Sat, 19 Aug 2006 02:48:32 -0400
From: Andy Gay <andy@andynet.net>
Subject: Re: [2.6.19 PATCH 4/7] ehea: ethtool interface
In-reply-to: <1155968305.1388.4.camel@localhost.localdomain>
To: michael@ellerman.id.au
Cc: Thomas Klein <osstklei@de.ibm.com>, Alexey Dobriyan <adobriyan@gmail.com>,
       Thomas Klein <tklein@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>, netdev@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Christoph Raisch <raisch@de.ibm.com>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>
Message-id: <1155970112.7302.434.camel@tahini.andynet.net>
MIME-version: 1.0
X-Mailer: Evolution 2.6.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <200608181333.23031.ossthema@de.ibm.com>
	<20060818140506.GC5201@martell.zuzino.mipt.ru>	<44E5DFA6.7040707@de.ibm.com>
	<1155968305.1388.4.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-19 at 16:18 +1000, Michael Ellerman wrote:

> 
> If you try to return an uninitialized value the compiler will warn you,
> you'll then look at the code and realise you missed a case, you might
> save yourself a bug. 

You *should* look at the code :)

So should we be reporting these as bugs?

andy@cx02:~/linux/linux-2.6.17.6$ script make.script
Script started, file is make.script
andy@cx02:~/linux/linux-2.6.17.6$ make

...

Script done, file is make.script
andy@cx02:~/linux/linux-2.6.17.6$ fgrep warning make.script
arch/i386/kernel/cpu/transmeta.c:12: warning: 'cpu_freq' may be used uninitialized in this function
fs/bio.c:169: warning: 'idx' may be used uninitialized in this function
fs/eventpoll.c:500: warning: 'fd' may be used uninitialized in this function
fs/isofs/namei.c:162: warning: 'offset' may be used uninitialized in this function
fs/isofs/namei.c:162: warning: 'block' may be used uninitialized in this function
fs/nfsd/nfsctl.c:292: warning: 'maxsize' may be used uninitialized in this function
fs/udf/balloc.c:751: warning: 'goal_eloc.logicalBlockNum' may be used uninitialized in this function
fs/udf/super.c:1358: warning: 'ino.partitionReferenceNum' may be used uninitialized in this function
fs/xfs/xfs_alloc_btree.c:611: warning: 'nkey.ar_startblock' may be used uninitialized in this function
fs/xfs/xfs_alloc_btree.c:611: warning: 'nkey.ar_blockcount' may be used uninitialized in this function
fs/xfs/xfs_bmap.c:2498: warning: 'rtx' is used uninitialized in this function
fs/xfs/xfs_bmap_btree.c:753: warning: 'nkey.br_startoff' may be used uninitialized in this function
fs/xfs/xfs_da_btree.c:151: warning: 'action' may be used uninitialized in this function
fs/xfs/xfs_dir.c:363: warning: 'totallen' may be used uninitialized in this function
fs/xfs/xfs_dir.c:363: warning: 'count' may be used uninitialized in this function
fs/xfs/xfs_ialloc_btree.c:545: warning: 'nkey.ir_startino' may be used uninitialized in this function
fs/xfs/xfs_inode.c:1958: warning: 'last_dip' may be used uninitialized in this function
fs/xfs/xfs_inode.c:1960: warning: 'last_offset' may be used uninitialized in this function
fs/xfs/xfs_log.c:1749: warning: 'iclog' may be used uninitialized in this function
fs/xfs/xfs_log_recover.c:523: warning: 'first_blk' may be used uninitialized in this function
ipc/msg.c:338: warning: 'setbuf.qbytes' may be used uninitialized in this function
ipc/msg.c:338: warning: 'setbuf.uid' may be used uninitialized in this function
ipc/msg.c:338: warning: 'setbuf.gid' may be used uninitialized in this function
ipc/msg.c:338: warning: 'setbuf.mode' may be used uninitialized in this function
ipc/sem.c:810: warning: 'setbuf.uid' may be used uninitialized in this function
ipc/sem.c:810: warning: 'setbuf.gid' may be used uninitialized in this function
ipc/sem.c:810: warning: 'setbuf.mode' may be used uninitialized in this function
drivers/md/dm-table.c:431: warning: 'dev' may be used uninitialized in this function
drivers/md/dm-ioctl.c:1388: warning: 'param' may be used uninitialized in this function
net/sched/sch_cbq.c:409: warning: 'ret' may be used uninitialized in this function
lib/zlib_inflate/inftrees.c:121: warning: 'r.base' may be used uninitialized in this function


