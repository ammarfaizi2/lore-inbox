Return-Path: <linux-kernel-owner+w=401wt.eu-S932647AbWLMKAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647AbWLMKAH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 05:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbWLMKAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 05:00:07 -0500
Received: from nz-out-0506.google.com ([64.233.162.226]:57752 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932647AbWLMKAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 05:00:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SjLzlvtE6+/voJHoD4a+jPhkW7YUd3JrcjPufvX/zvBmjzEXafQmYE45w6D3RtMnNWNm0S9Hiy+gDpd0ihu2oMKYkrcXINDZlnhzxrmJagDXA2xynRVuDW7vdY6NB/cX2nopLEr6WyG/enWJW/pnFbt81ldLuVvM/nswZ8iuVcI=
Message-ID: <b0943d9e0612130200k4f6ab672if4acde8a0dba12a4@mail.gmail.com>
Date: Wed, 13 Dec 2006 10:00:05 +0000
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Possible memory leak in block/ll_rw_blk.c
Cc: "Mike Christie" <michaelc@cs.wisc.edu>,
       "FUJITA Tomonori" <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <b0943d9e0612091516s600d2c5bp327ce5008a57381e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b0943d9e0612091516s600d2c5bp327ce5008a57381e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> unreferenced object 0xdd9162b0 (size 64):
>   [<c018d46f>] kmem_cache_alloc
>   [<c0170b2e>] mempool_alloc_slab
>   [<c01709cb>] mempool_alloc
>   [<c01b7baa>] bio_alloc_bioset
>   [<c01b7d0e>] bio_alloc
>   [<c01b83f8>] bio_copy_user
>   [<c021a380>] __blk_rq_map_user
>   [<c021a4ff>] blk_rq_map_user
>   [<c021e687>] sg_io
>   [<c021ed3e>] scsi_cmd_ioctl
>   [<c02bcc13>] sd_ioctl
>   [<c021ca65>] blkdev_driver_ioctl
>   [<c021cc27>] blkdev_ioctl
>   [<c01ba72b>] block_ioctl
>   [<c019ea36>] do_ioctl

I can confirm that the memory leak disappeared with commit
77d172ce2719b5ad2dc0637452c8871d9cba344c (by Fujita Tomonori).

Regards.

-- 
Catalin
