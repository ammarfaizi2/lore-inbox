Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286968AbSBGJ6k>; Thu, 7 Feb 2002 04:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287045AbSBGJ6b>; Thu, 7 Feb 2002 04:58:31 -0500
Received: from Expansa.sns.it ([192.167.206.189]:14095 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S286968AbSBGJ6Z>;
	Thu, 7 Feb 2002 04:58:25 -0500
Date: Thu, 7 Feb 2002 10:58:27 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Oleg Drokin <green@namesys.com>
cc: reiserfs-dev@namesys.com, <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-dev] oops with reiserfs and kernel 2.5.4-pre1 on
 sparc64
In-Reply-To: <20020207092012.C6351@namesys.com>
Message-ID: <Pine.LNX.4.44.0202071058010.25208-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Feb 2002, Oleg Drokin wrote:

> Hello!
>
> On Wed, Feb 06, 2002 at 06:53:47PM +0100, Luigi Genoni wrote:
>
> > I was trying 2.5.4-pre1 on sparc64 sun4u ultra2,
> > with 1GB memory and scsi controller ess.
> > This system has just one CPU.
> > >>TPC; 0046cf7c <grow_buffers+5c/e0>   <=====
> > >>O7;  0046cf38 <grow_buffers+18/e0>
> > >>I7;  0046b260 <__getblk+20/60>
> > Trace; 0046b260 <__getblk+20/60>
> > Trace; 0046b56c <__bread+c/a0>
> > Trace; 004d1374 <journal_init+214/8e0>
> This looks like VFS have exploded for whatever reson, I think
> because one ot these checks failed:
> linux/fs/buffer.c:
>         if (size & (get_hardsect_size(to_kdev_t(bdev->bd_dev))-1))
>                 BUG();
>         /* Size must be within 512 bytes and PAGE_SIZE */
>         if (size < 512 || size > PAGE_SIZE)
>                 BUG();
>
> Can any of sparc64 people comment on what kind of exception will one
> get for __builtin_trap?
> Second BUG() seems to be out of the question, though.
> Do you have CONFIG_DEBUG_BUGVERBOSE enabled?
No, I have not

