Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWFHPcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWFHPcv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 11:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbWFHPcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 11:32:51 -0400
Received: from hera.kernel.org ([140.211.167.34]:6112 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S964873AbWFHPcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 11:32:50 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: klibc - another libc?
Date: Thu, 8 Jun 2006 08:32:19 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e69fu3$5ch$1@terminus.zytor.com>
References: <44869397.4000907@tls.msk.ru> <e67fok$h25$1@terminus.zytor.com> <Pine.LNX.4.64.0606080036250.17704@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1149780739 5522 127.0.0.1 (8 Jun 2006 15:32:19 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Thu, 8 Jun 2006 15:32:19 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.64.0606080036250.17704@scrub.home>
By author:    Roman Zippel <zippel@linux-m68k.org>
In newsgroup: linux.dev.kernel
>
> Hi,
> 
> On Wed, 7 Jun 2006, H. Peter Anvin wrote:
> 
> > To be able to *require* it, which means it can't significantly bloat
> > the total size of the kernel image.  klibc binaries are *extremely*
> > small.  Static kinit is only a few tens of kilobytes, a lot of which
> > is zlib.
> 
> Every project starts small and has the annoying tendency to grow.
> That still doesn't answer, why it has to be distributed with the kernel, 
> just install the thing somewhere under /lib and Kbuild can link to it. The 
> point is that it contains nothing kernel specific and doesn't has to be 
> rebult with every new kernel.
> 

Actually, that isn't quite true.  One of the ways klibc is kept small
is by not guaranteeing a stable ABI... and not having compatibility
support for older kernels.  This is one of the kinds of luxuries that
bundling offers.

Does it make bundling mandatory?  Not really.  In fact, people have
been using klibc in its standalone form for years.  However, I believe
there would be a lot of resistace to have the kernel tarball have
outside dependencies on anything but the most basic build tools.

	-hpa
