Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261224AbSJ1OVP>; Mon, 28 Oct 2002 09:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261228AbSJ1OVP>; Mon, 28 Oct 2002 09:21:15 -0500
Received: from rth.ninka.net ([216.101.162.244]:6318 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S261224AbSJ1OVP>;
	Mon, 28 Oct 2002 09:21:15 -0500
Subject: Re: [patch][cft] zero-copy dma cd writing and ripping
From: "David S. Miller" <davem@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
In-Reply-To: <20021028124240.GC872@suse.de>
References: <20021018155650.GJ15494@suse.de>
	<20021028.043507.104714061.davem@redhat.com>  <20021028124240.GC872@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Oct 2002 06:40:48 -0800
Message-Id: <1035816048.8970.1.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-28 at 04:42, Jens Axboe wrote:
> > This work reminds me that get_user_pages() (or it's callers)
> > need to be doing some flush_dcache_page()
> 
> Was wondering about that. Can you tell me what it needs? And what about
> bio_unmap_user(), surely that needs to flush cache as well for reads?

Documentation/cachetlb.txt describes where flush_dcache_page is needed.
If that doesn't describe it enough for you, that is a bug and please
tell me what part is confusing so I may make the document better.

