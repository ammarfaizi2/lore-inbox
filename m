Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266837AbSKZUS3>; Tue, 26 Nov 2002 15:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266839AbSKZUS3>; Tue, 26 Nov 2002 15:18:29 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:27118 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S266837AbSKZUS2>; Tue, 26 Nov 2002 15:18:28 -0500
Subject: Re: 2.5.49: kernel BUG at drivers/block/ll_rw_blk.c:1950!
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Srihari Vijayaraghavan <harisri@bigpond.com>, Jens Axboe <axboe@suse.de>,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
In-Reply-To: <3DE3D1D1.BE5B30ED@digeo.com>
References: <200211262203.20088.harisri@bigpond.com> 
	<3DE3D1D1.BE5B30ED@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Nov 2002 21:22:10 +0100
Message-Id: <1038342130.19337.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Jens, what is the policy here?  Should bio_add_page() for an
> empty bio "always succeed"?  (Bearing in mind that pages can
> be 64k...).    I guess -EIO would be better than a BUG.
> 
> Are there more RAID fixes pending?

the 64 kb pagesize 32kb chunk size case still needs fixing somehow; once
it is ataraid can start using devicemapper ;)
