Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbWDQBnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWDQBnR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 21:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWDQBmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 21:42:55 -0400
Received: from nproxy.gmail.com ([64.233.182.187]:50414 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750942AbWDQBmw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 21:42:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=m6/XuI1mweVw29xFVjJrh31gTn5D78uH+MJz+rKSMQ+/IHVr584ybSK1aybqmsa1AReV3420su68VgoDr5amIB9iBrecrcPawin46JeievwgeU31uxSL6kcntGc2YNWMMiMuHC4LdzfRZUmvY1evveMRk58Tt3l0fdrcwgK/e30=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Remove redundant NULL checks before [kv]free
Date: Mon, 17 Apr 2006 03:43:25 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604170343.25872.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's another round of [kv]free NULL check cleanup patches.
A few CodingStyle cleanups crept in as well while I was in the area.

This time I think I got all of them (or at least all my script found).
If someone wants to take a look at this in the future and want to use the
small PHP script I used to find these, then it should be available at 
ftp://ftp.kernel.org/pub/linux/kernel/people/juhl/scripts/find_kvfree.php 
shortly (at least I've put it on master.kernel.org, so I assume it'll get 
out there soon).


Complete diffstat for the series : 

 arch/ia64/kernel/topology.c               |    7 --
 arch/ia64/sn/kernel/xpc_partition.c       |    8 --
 arch/powerpc/platforms/powermac/low_i2c.c |    3
 arch/um/kernel/irq.c                      |   93 +++++++++++++++---------------
 arch/um/os-Linux/irq.c                    |   47 +++++++--------
 drivers/char/agp/sgi-agp.c                |    5 -
 drivers/char/hvcs.c                       |   11 +--
 drivers/message/fusion/mptfc.c            |    6 -
 drivers/message/fusion/mptsas.c           |    3
 drivers/net/fs_enet/fs_enet-mii.c         |    3
 drivers/net/wireless/ipw2200.c            |   22 +------
 drivers/scsi/libata-scsi.c                |    4 -
 drivers/video/au1100fb.c                  |    3
 fs/ocfs2/vote.c                           |    8 --
 kernel/auditsc.c                          |    6 -
 net/ipv4/ipcomp.c                         |    7 --
 net/tipc/name_distr.c                     |    3
 17 files changed, 100 insertions(+), 139 deletions(-)

--
Jesper Juhl <jesper.juhl@gmail.com>

