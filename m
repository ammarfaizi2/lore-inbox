Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262476AbTCRPcy>; Tue, 18 Mar 2003 10:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262479AbTCRPcy>; Tue, 18 Mar 2003 10:32:54 -0500
Received: from verein.lst.de ([212.34.181.86]:40967 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S262476AbTCRPcw>;
	Tue, 18 Mar 2003 10:32:52 -0500
Date: Tue, 18 Mar 2003 16:40:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Christoph Hellwig <hch@lst.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Remaining occurances of DEVFS_FL_AUTO_DEVNUM in 2.5.65
Message-ID: <20030318164037.A6878@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Adrian Bunk <bunk@fs.tum.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0303171429040.2827-100000@penguin.transmeta.com> <20030318124516.GC18135@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030318124516.GC18135@fs.tum.de>; from bunk@fs.tum.de on Tue, Mar 18, 2003 at 01:45:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2003 at 01:45:16PM +0100, Adrian Bunk wrote:
> On Mon, Mar 17, 2003 at 02:31:01PM -0800, Linus Torvalds wrote:
> >...
> > Summary of changes from v2.5.64 to v2.5.65
> > ============================================
> >...
> > Christoph Hellwig <hch@lst.de>:
> >...
> >   o remaining bits of DEVFS_FL_AUTO_DEVNUM
> >...
> 
> The following files in 2.5.65 still contain DEVFS_FL_AUTO_DEVNUM:
> 
> arch/ia64/sn/io/xbow.c:                        0, DEVFS_FL_AUTO_DEVNUM,
> arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c:                0, DEVFS_FL_AUTO_DEVNUM,
> arch/ia64/sn/io/sn2/xbow.c:             DEVFS_FL_AUTO_DEVNUM, 0, 0,
> arch/ia64/sn/io/sn2/klgraph.c:          0, DEVFS_FL_AUTO_DEVNUM,
> arch/ia64/sn/io/klgraph.c:          0, DEVFS_FL_AUTO_DEVNUM,
> arch/ia64/sn/io/klgraph.c:          0, DEVFS_FL_AUTO_DEVNUM,
> arch/ia64/sn/io/klgraph.c:          0, DEVFS_FL_AUTO_DEVNUM,
> arch/ia64/sn/io/sn1/pcibr.c:                0, DEVFS_FL_AUTO_DEVNUM,
> arch/ia64/sn/io/ifconfig_net.c:                 0, DEVFS_FL_AUTO_DEVNUM,
> arch/ia64/sn/io/ioconfig_bus.c:                 0, DEVFS_FL_AUTO_DEVNUM,
> arch/ia64/sn/io/hcl.c:                  0, DEVFS_FL_AUTO_DEVNUM,

This code is currently not working at all on 2.5 and will get it's
own filesystem instead.

> drivers/media/dvb/dvb-core/dvbdev.c:    #define DVB_DEVFS_FLAGS          (DEVFS_FL_DEFAULT|DEVFS_FL_AUTO_DEVNUM)
> 
> 
> The last one causes a compile error on i386 with CONFIG_DVB_DEVFS_ONLY 
> enabled.

I thought I removed that config option, need to check whether that hunk
got left.

