Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268115AbUIGOdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268115AbUIGOdk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 10:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268116AbUIGObj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 10:31:39 -0400
Received: from cantor.suse.de ([195.135.220.2]:65159 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268115AbUIGO3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:29:46 -0400
Date: Tue, 7 Sep 2004 16:29:46 +0200
From: Andi Kleen <ak@suse.de>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040907142945.GB20981@wotan.suse.de>
References: <20040901072245.GF13749@mellanox.co.il> <20040903080058.GB2402@wotan.suse.de> <20040907104017.GB10096@mellanox.co.il> <20040907121418.GC25051@wotan.suse.de> <20040907134517.GA1016@mellanox.co.il> <20040907141524.GA13862@wotan.suse.de> <20040907142530.GB1016@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907142530.GB1016@mellanox.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 05:25:30PM +0300, Michael S. Tsirkin wrote:
> > It may help your module, but won't solve the general problem shorter
> > term.
> But longer term it will be better, so why not go there?
> Once the infrastructure is there, drivers will be able to be
> migrated as required.

I have no problems with that. You would need two new entry points:
one 64bit one without BKL and a 32bit one also without BKL. 

I think there were some objections to this scheme in the past,
but I cannot think of a good alternative. 

-Andi
