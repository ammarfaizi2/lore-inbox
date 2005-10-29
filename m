Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbVJ2EBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbVJ2EBS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 00:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbVJ2EBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 00:01:18 -0400
Received: from koto.vergenet.net ([210.128.90.7]:58317 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1750827AbVJ2EBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 00:01:17 -0400
Date: Sat, 29 Oct 2005 12:45:17 +0900
From: "Simon Horman [Horms]" <horms@debian.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: 333776@bugs.debian.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bug#333776: linux-2.6: vfat driver in 2.6.12 is not properly case-insensitive
Message-ID: <20051029034516.GN4961@verge.net.au>
References: <20051013165529.GA2472@tennyson.dodds.net> <20051014023216.GJ8848@verge.net.au> <20051015003549.GB11040@tennyson.dodds.net> <20051028082252.GC11045@verge.net.au> <874q71wv2b.fsf@devron.myhome.or.jp> <87zmotvfwj.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zmotvfwj.fsf@devron.myhome.or.jp>
X-Cluestick: seven
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2005 at 12:07:40AM +0900, OGAWA Hirofumi wrote:
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:
> 
> > Horms <horms@verge.net.au> writes:
> >
> >> static struct nls_table table = {
> >>         .charset        = "utf8",
> >>         .uni2char       = uni2char,
> >>         .char2uni       = char2uni,
> >>         .charset2lower  = identity,     /* no conversion */
> >>         .charset2upper  = identity,
> >>         .owner          = THIS_MODULE,
> >> };
> >>
> >> I guess it is charset2lower or charset2upper that vfat is calling,
> >> which make no conversion, thus leading to the problem I outlined above.
> >>
> >> My question is: Is this behaviour correct, or is it a bug?
> >
> > This is known bug. For fixing this bug cleanly, we will need to much
> > change the both of nls and filesystems.
> 
> And fatfs has "utf8" option, probably the behavior is preferable than
> "iocharset=utf8".  However, unfortunately "utf8" has problem too.

Thanks
