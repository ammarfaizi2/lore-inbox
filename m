Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbVLBWdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbVLBWdh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 17:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbVLBWdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 17:33:37 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:7896 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750834AbVLBWdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 17:33:36 -0500
Subject: Re: [PATCH 0/4] linux-2.6-block: deactivating pagecache for
	benchmarks
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mail@dirk-gerdes.de, axboe@suse.de, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051202134431.005de2b2.akpm@osdl.org>
References: <1133443051.6110.32.camel@noti>
	 <20051201172520.7095e524.akpm@osdl.org>
	 <1133558692.21429.89.camel@localhost.localdomain>
	 <20051202134431.005de2b2.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 02 Dec 2005 14:33:42 -0800
Message-Id: <1133562822.21429.105.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-02 at 13:44 -0800, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > Wondering, if this shrinks shared memory pages (since they are backed by
> > tmpfs) ? (which is not what I want).
> 
> It'll reclaim unused pagecache pages.  What effect that has on
> idioticfs^Wtmpfs pages depends on the state of the pages.  If they're
> attached to tmpfs inodes then they won't be reclaimed because they have no
> backing store.  If they're attached to swapcache then they won't be
> reclaimed because they have no superblock.
> 
> So I guess you got lucky.

Wow !! Thank you. Its not that often, I get lucky :)

Thanks,
Badari

