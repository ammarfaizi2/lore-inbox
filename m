Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbUBZMYs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 07:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262780AbUBZMYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 07:24:48 -0500
Received: from 64-186-161-006.cyclades.com ([64.186.161.6]:60853 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262674AbUBZMYq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 07:24:46 -0500
Date: Thu, 26 Feb 2004 10:08:23 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Christian Leber <christian@leber.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.25 - large inode_cache
In-Reply-To: <20040226111912.GB4554@core.home>
Message-ID: <Pine.LNX.4.58L.0402261004310.5003@logos.cnet>
References: <20040226013313.GN29776@unthought.net> <20040226111912.GB4554@core.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Feb 2004, Christian Leber wrote:

> On Thu, Feb 26, 2004 at 02:33:14AM +0100, Jakob Oestergaard wrote:
> > Besides, after a few days of running, the machine will use about 100MB
> > of memory for cache, 100MB for buffers, about 100MB for userspace, and
> > the remaining 600-700 MB of memory for inode_cache and dentry_cache.
>
> I have the same problem (it's an dual PIII NFS fileserver with promise sx6000
> raid, 320 GB ext3 filesystem and only 512 MB Ram).
>
> After only 2 days running the bloatmeter output looks like:
>    inode_cache:   336585KB   357234KB   94.21
>   dentry_cache:    50305KB    56523KB   88.99
>        size-32:     1516KB     1695KB   89.46
>
> free output is this:
>              total       used       free     shared    buffers  cached
> Mem:        515980     506464       9516          0    2272      19204
> -/+ buffers/cache:     484988      30992
> Swap:      1951856       7992    1943864

This should be normal behaviour -- the i/d caches grew because of file
system activitity. This memory will be reclaimed in case theres pressure.

Is the behaviour different from previous 2.4 or 2.6 kernels?
