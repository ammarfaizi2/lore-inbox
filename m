Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268139AbUIGQtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268139AbUIGQtV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 12:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268165AbUIGQr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 12:47:29 -0400
Received: from mail.mellanox.co.il ([194.90.237.34]:51041 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S268130AbUIGOib
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:38:31 -0400
Date: Tue, 7 Sep 2004 17:37:02 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040907143702.GC1016@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20040901072245.GF13749@mellanox.co.il> <20040903080058.GB2402@wotan.suse.de> <20040907104017.GB10096@mellanox.co.il> <20040907121418.GC25051@wotan.suse.de> <20040907134517.GA1016@mellanox.co.il> <20040907141524.GA13862@wotan.suse.de> <20040907142530.GB1016@mellanox.co.il> <20040907142945.GB20981@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907142945.GB20981@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Andi Kleen (ak@suse.de) "Re: [discuss] f_ops flag to speed up compatible ioctls in linux kernel":
> On Tue, Sep 07, 2004 at 05:25:30PM +0300, Michael S. Tsirkin wrote:
> > > It may help your module, but won't solve the general problem shorter
> > > term.
> > But longer term it will be better, so why not go there?
> > Once the infrastructure is there, drivers will be able to be
> > migrated as required.
> 
> I have no problems with that. You would need two new entry points:
> one 64bit one without BKL and a 32bit one also without BKL. 
> 
> I think there were some objections to this scheme in the past,
> but I cannot think of a good alternative. 
> 

Maybe one entry point with a flag?
Compatible ioctls could just ignore the flag.

MST
