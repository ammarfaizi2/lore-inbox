Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbTCRMeZ>; Tue, 18 Mar 2003 07:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262289AbTCRMeZ>; Tue, 18 Mar 2003 07:34:25 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:29175 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262215AbTCRMeY>; Tue, 18 Mar 2003 07:34:24 -0500
Date: Tue, 18 Mar 2003 13:45:16 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Remaining occurances of DEVFS_FL_AUTO_DEVNUM in 2.5.65
Message-ID: <20030318124516.GC18135@fs.tum.de>
References: <Pine.LNX.4.44.0303171429040.2827-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303171429040.2827-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 02:31:01PM -0800, Linus Torvalds wrote:
>...
> Summary of changes from v2.5.64 to v2.5.65
> ============================================
>...
> Christoph Hellwig <hch@lst.de>:
>...
>   o remaining bits of DEVFS_FL_AUTO_DEVNUM
>...

The following files in 2.5.65 still contain DEVFS_FL_AUTO_DEVNUM:

arch/ia64/sn/io/xbow.c:                        0, DEVFS_FL_AUTO_DEVNUM,
arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c:                0, DEVFS_FL_AUTO_DEVNUM,
arch/ia64/sn/io/sn2/xbow.c:             DEVFS_FL_AUTO_DEVNUM, 0, 0,
arch/ia64/sn/io/sn2/klgraph.c:          0, DEVFS_FL_AUTO_DEVNUM,
arch/ia64/sn/io/klgraph.c:          0, DEVFS_FL_AUTO_DEVNUM,
arch/ia64/sn/io/klgraph.c:          0, DEVFS_FL_AUTO_DEVNUM,
arch/ia64/sn/io/klgraph.c:          0, DEVFS_FL_AUTO_DEVNUM,
arch/ia64/sn/io/sn1/pcibr.c:                0, DEVFS_FL_AUTO_DEVNUM,
arch/ia64/sn/io/ifconfig_net.c:                 0, DEVFS_FL_AUTO_DEVNUM,
arch/ia64/sn/io/ioconfig_bus.c:                 0, DEVFS_FL_AUTO_DEVNUM,
arch/ia64/sn/io/hcl.c:                  0, DEVFS_FL_AUTO_DEVNUM,
drivers/media/dvb/dvb-core/dvbdev.c:    #define DVB_DEVFS_FLAGS          (DEVFS_FL_DEFAULT|DEVFS_FL_AUTO_DEVNUM)


The last one causes a compile error on i386 with CONFIG_DVB_DEVFS_ONLY 
enabled.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

