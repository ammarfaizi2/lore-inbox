Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWDZNuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWDZNuw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 09:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWDZNuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 09:50:52 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:5783 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932443AbWDZNuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 09:50:52 -0400
Subject: Re: [PATCH] likely cleanup: revert unlikely in ll_back_merge_fn
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jens Axboe <axboe@suse.de>
Cc: Hua Zhong <hzhong@gmail.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20060426052049.GV4102@suse.de>
References: <20060425183026.GR4102@suse.de>
	 <004d01c668b0$a9c79540$853d010a@nuitysystems.com>
	 <20060426052049.GV4102@suse.de>
Content-Type: text/plain
Date: Wed, 26 Apr 2006 08:50:35 -0500
Message-Id: <1146059435.3908.3.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-26 at 07:20 +0200, Jens Axboe wrote:
> But blk_recount_segments() sets the BIO_SEG_VALID flag. Ugh ok
> __bio_add_page() basically kills the flag. James, I think you are the
> author of that addition, does it really need to be so restrictive?
> 
>         /* If we may be able to merge these biovecs, force a recount */
>         if (bio->bi_vcnt && (BIOVEC_PHYS_MERGEABLE(bvec-1, bvec) ||
>             BIOVEC_VIRT_MERGEABLE(bvec-1, bvec)))
>                 bio->bi_flags &= ~(1 << BIO_SEG_VALID);

Help me out here ... I can't find this chunk of code in the current
tree.  Where is it?

James


