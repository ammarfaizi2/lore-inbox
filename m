Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268694AbUIGVmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268694AbUIGVmo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 17:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268261AbUIGVlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 17:41:31 -0400
Received: from mail.mellanox.co.il ([194.90.237.34]:31678 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S268704AbUIGVhg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 17:37:36 -0400
Date: Wed, 8 Sep 2004 00:36:16 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Is FIOQSIZE compatible? ( was Re: f_ops flag to speed up compatible ioctls in linux kernel)
Message-ID: <20040907213616.GA3018@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20040907104017.GB10096@mellanox.co.il> <20040907121418.GC25051@wotan.suse.de> <20040907134517.GA1016@mellanox.co.il> <20040907141524.GA13862@wotan.suse.de> <20040907142530.GB1016@mellanox.co.il> <20040907142945.GB20981@wotan.suse.de> <20040907143702.GC1016@mellanox.co.il> <20040907144452.GC20981@wotan.suse.de> <20040907144543.GA1340@mellanox.co.il> <20040907151022.GA32287@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907151022.GA32287@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Andi Kleen (ak@suse.de) "Re: [discuss] f_ops flag to speed up compatible ioctls in linux kernel":
> On Tue, Sep 07, 2004 at 05:45:43PM +0300, Michael S. Tsirkin wrote:
> > > > > but I cannot think of a good alternative. 
> > > > > 
> > > > 
> > > > Maybe one entry point with a flag?
> > > 
> > > That would be IMHO far uglier than two. 
> > > 
> > > -Andi
> > >
> > 
> > What would be a good name? ioctl32/ioctl64? ioctl_compat/ioctl_native?
> 
> Later two sound ok to me.
> 
> -Andi

Why is FIOQSIZE in arch/x86_64/ia32/ia32_ioctl.c and not in 
include/linux/compat_ioctl.h ?

It is as far as I can see returning simply loff_t which is 64 bit
on all architectures.

Thanks,
  MST
