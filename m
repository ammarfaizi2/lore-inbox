Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWCPRxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWCPRxO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbWCPRxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:53:14 -0500
Received: from mx.pathscale.com ([64.160.42.68]:36295 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932429AbWCPRxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:53:13 -0500
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
	driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Roland Dreier <rdreier@cisco.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0603161738010.23812@goblin.wat.veritas.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	 <ada4q27fban.fsf@cisco.com>
	 <1141948516.10693.55.camel@serpentine.pathscale.com>
	 <ada1wxbdv7a.fsf@cisco.com>
	 <1141949262.10693.69.camel@serpentine.pathscale.com>
	 <20060309163740.0b589ea4.akpm@osdl.org>
	 <1142470579.6994.78.camel@localhost.localdomain>
	 <ada3bhjuph2.fsf@cisco.com>
	 <1142475069.6994.114.camel@localhost.localdomain>
	 <adaslpjt8rg.fsf@cisco.com>
	 <1142477579.6994.124.camel@localhost.localdomain>
	 <20060315192813.71a5d31a.akpm@osdl.org>
	 <1142485103.25297.13.camel@camp4.serpentine.com>
	 <20060315213813.747b5967.akpm@osdl.org>  <ada8xrbszmx.fsf@cisco.com>
	 <1142521943.25297.42.camel@camp4.serpentine.com>
	 <Pine.LNX.4.61.0603161738010.23812@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Thu, 16 Mar 2006 09:53:12 -0800
Message-Id: <1142531592.25297.149.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-16 at 17:46 +0000, Hugh Dickins wrote:

> > >   It seems one should do
> > > get_page() in .nopage, and then the driver can do dma_free_coherent()
> > > when the vma is released.
> > 
> > If that were the case, I'm unclear on how I would do this.  Add a
> > vmops->close method along with the existing vmops->nopage handler?
> 
> If neither mmap nor nopage allocated something, then vmops->close
> would be the wrong point at which to free it, I think.

I think I've satisfied myself that what we're now doing is fairly sane,
so I think we're OK.  I'm sure I'll be corrected in the next round of
driver submission patches if I'm wrong :-)

	<b

