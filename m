Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbTFDBB4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 21:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbTFDBB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 21:01:56 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:32773 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262437AbTFDBBz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 21:01:55 -0400
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: akpm@digeo.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fat-fs printk arg. fix
References: <20030603160200.04991141.rddunlap@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 04 Jun 2003 10:14:59 +0900
In-Reply-To: <20030603160200.04991141.rddunlap@osdl.org>
Message-ID: <87ptlu63u4.fsf@ibmpc.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> writes:

>  		printk(KERN_ERR "FAT: Directory bread(block %llu) failed\n",
> -		       phys);
> +		       (u64)phys);
>  		/* skip this block */
>  		*pos = (iblock + 1) << sb->s_blocksize_bits;
>  		goto next;

I was forgeting that issue of sector_t with printk. Thanks for
correcting.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
