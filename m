Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311816AbSCTQmy>; Wed, 20 Mar 2002 11:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311819AbSCTQmp>; Wed, 20 Mar 2002 11:42:45 -0500
Received: from Expansa.sns.it ([192.167.206.189]:28421 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S311816AbSCTQm3>;
	Wed, 20 Mar 2002 11:42:29 -0500
Date: Wed, 20 Mar 2002 17:42:28 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: oops at boot with 2.5.7 and i810
In-Reply-To: <3C98AFFE.3000908@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0203201742170.8733-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yes, as I said at the beginning

On Wed, 20 Mar 2002, Martin Dalecki wrote:

> Luigi Genoni wrote:
> >
> > On Tue, 19 Mar 2002, Martin Dalecki wrote:
> >
> >
> >>Luigi Genoni wrote:
> >>
> >>>that is: __get_hash_table
>
> OK I have been looking that the correspodning function
> and found it only to be related to filesystem super-block
> operations as well as buffer_head manipulation... Quite
> out of order if you ask me. So the chances are that there
> are just particular problems with your compiler/build
>
> In esp. fs/buffer is the only place where it get's used!
>
> /fs/buffer.c:struct buffer_head * __get_hash_table(struct block_device *bdev,
> sector_t block, int size)
> ./fs/buffer.c:          bh = __get_hash_table(bdev, block, size);
> ./fs/buffer.c:  old_bh = __get_hash_table(bh->b_bdev, bh->b_blocknr, bh->b_size);
>
> Let me guess: You root partition is on a ReiserFS?
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

