Return-Path: <linux-kernel-owner+w=401wt.eu-S965001AbWLMPsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbWLMPsw (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 10:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbWLMPsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 10:48:52 -0500
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:55344 "EHLO
	tama5.ecl.ntt.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965001AbWLMPsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 10:48:51 -0500
X-Greylist: delayed 10986 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 10:48:51 EST
To: catalin.marinas@gmail.com
Cc: linux-kernel@vger.kernel.org, michaelc@cs.wisc.edu,
       fujita.tomonori@lab.ntt.co.jp
Subject: Re: Possible memory leak in block/ll_rw_blk.c
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <b0943d9e0612130200k4f6ab672if4acde8a0dba12a4@mail.gmail.com>
References: <b0943d9e0612091516s600d2c5bp327ce5008a57381e@mail.gmail.com>
	<b0943d9e0612130200k4f6ab672if4acde8a0dba12a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20061213214552C.fujita.tomonori@lab.ntt.co.jp>
Date: Wed, 13 Dec 2006 21:45:52 +0900
X-Dispatcher: imput version 20040704(IM147)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Possible memory leak in block/ll_rw_blk.c
Date: Wed, 13 Dec 2006 10:00:05 +0000

> On 09/12/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > unreferenced object 0xdd9162b0 (size 64):
> >   [<c018d46f>] kmem_cache_alloc
> >   [<c0170b2e>] mempool_alloc_slab
> >   [<c01709cb>] mempool_alloc
> >   [<c01b7baa>] bio_alloc_bioset
> >   [<c01b7d0e>] bio_alloc
> >   [<c01b83f8>] bio_copy_user
> >   [<c021a380>] __blk_rq_map_user
> >   [<c021a4ff>] blk_rq_map_user
> >   [<c021e687>] sg_io
> >   [<c021ed3e>] scsi_cmd_ioctl
> >   [<c02bcc13>] sd_ioctl
> >   [<c021ca65>] blkdev_driver_ioctl
> >   [<c021cc27>] blkdev_ioctl
> >   [<c01ba72b>] block_ioctl
> >   [<c019ea36>] do_ioctl
> 
> I can confirm that the memory leak disappeared with commit
> 77d172ce2719b5ad2dc0637452c8871d9cba344c (by Fujita Tomonori).

Thanks. And sorry for introducing that bug.
