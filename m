Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281809AbRLZQjU>; Wed, 26 Dec 2001 11:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284570AbRLZQjK>; Wed, 26 Dec 2001 11:39:10 -0500
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:16310 "EHLO
	swan.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S281795AbRLZQjE>; Wed, 26 Dec 2001 11:39:04 -0500
Message-ID: <3C2856F4.9BF7B835@home.com>
Date: Tue, 25 Dec 2001 05:37:40 -0500
From: Paul Boley <pboley@home.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: severe slowdown with 2.4 series w/heavy disk access
In-Reply-To: <3C295D5C.50EE365D@home.com> <01122609375800.01845@manta>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vda wrote:

> >
> >              total       used       free     shared    buffers
> > cached
> > Mem:        417472     412192       5280          0      20632
> > 315680
> > -/+ buffers/cache:      75880     341592
> > Swap:       136544          0     136544
> 
> It seems you think your memory is used for no purpose,
> but kernel just keeps page cache in your RAM (kernel bugs are indeed
> possible, but your test does not show any buggy behavior IMHO).

My whole system slows down (commands take a long time to execute,
decompression slows, ls in an empty dir takes 10 sec)

> 
> To verify this, you may repeat this experiment on a separate partition:
> 1) mount a partition
> 2) do the test as you described
> 3) umount the partition

I did this, and it uncached some, but I only had 60megs (out of 416)
free after unmounting the partition.  The cache went down to about 5
megs, and in-use was at 350 megs.

> 
> I believe you should see tons of free memory then, especially if your tarfile
> is also on that partition.
> Please report back if you would do the test.
> --
> vda
