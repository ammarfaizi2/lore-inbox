Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWEEWhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWEEWhL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 18:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWEEWhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 18:37:11 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:46040 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932354AbWEEWhJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 18:37:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n3ramoPBPPxbP+4jeXkGwCOYmFNTaE7j9f+g1I/TznDL6DFdbsaLf7DJUA0MMwLpox02Qzfw4zC4FWnRi5JSn3P5O4C9TQzzc1WdFiEAgtMtWZQWyz6pQ6W8XUFMu2XQe/r05VQWXTVcQSJOfxeDFRt1NuGEvgCsJGIz5q56rVQ=
Message-ID: <ea59786f0605051537o65338d7dr1f842927047494d5@mail.gmail.com>
Date: Fri, 5 May 2006 15:37:08 -0700
From: "Constantine Sapuntzakis" <csapuntz@gmail.com>
To: "Jens Axboe" <axboe@suse.de>
Subject: Re: [PATCH] loop.c: respect bio barrier and sync
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060505145437.GW4324@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ea59786f0605041919w337c7164id5f4e7b3efa818e0@mail.gmail.com>
	 <20060505145437.GW4324@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about the patch as attachments.

> - You should handle sync_file() failure. If we don't have !f_op (will
>   that ever hit, btw?) or ->fsync(), then fail the barrier with
>   -EOPNOTSUPP. For fsync failure, well... You probably want to just
>   error the bio with -EIO then.

Will fix.

> - Does this work for all loop_device types?

What are the other loop_device types?

BTW, should/does an fsync on a block device translate into a disk flush?
I was looking at sync_blockdev and couldn't figure out how that happened.

Thanks,
-Costa
