Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVAMIHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVAMIHW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 03:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVAMIHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 03:07:22 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:30179 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S261194AbVAMIHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 03:07:17 -0500
Date: Thu, 13 Jan 2005 17:02:18 +0900 (JST)
Message-Id: <20050113.170218.77038944.taka@valinux.co.jp>
To: mel@csn.ul.ie
Cc: matthew.e.tolentino@intel.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Avoiding fragmentation through different allocator
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <Pine.LNX.4.58.0501122247390.18142@skynet>
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB008C77C45@fmsmsx406.amr.corp.intel.com>
	<Pine.LNX.4.58.0501122247390.18142@skynet>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

The global list looks interesting.

> > >Instead of having one global MAX_ORDER-sized array of free
> > >lists, there are
> > >three, one for each type of allocation. Finally, there is a
> > >list of pages of
> > >size 2^MAX_ORDER which is a global pool of the largest pages
> > >the kernel deals with.

> > is it so that the pages can
> > evolve according to system demands (assuming MAX_ORDER sized
> > chunks are eventually available again)?
> >
> 
> Exactly. Once a 2^MAX_ORDER block has been merged again, it will not be
> reserved until the next split.

FYI, MAX_ORDER is huge in some architectures.
I guess another watermark should be introduced instead of MAX_ORDER.

Thanks,
Hirokazu Takahashi.
