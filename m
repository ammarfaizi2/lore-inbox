Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161180AbWBTUs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161180AbWBTUs2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 15:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161181AbWBTUs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 15:48:28 -0500
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:35998 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1161180AbWBTUs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 15:48:27 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH] mm: Implement swap prefetching
Date: Tue, 21 Feb 2006 07:47:28 +1100
User-Agent: KMail/1.9.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ck list <ck@vds.kolivas.org>
References: <200602210044.52424.kernel@kolivas.org> <20060220190855.GB4414@inferi.kami.home>
In-Reply-To: <20060220190855.GB4414@inferi.kami.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602210747.28946.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 February 2006 06:08, Mattia Dongili wrote:
> Hello Con,
>
> On Tue, Feb 21, 2006 at 12:44:51AM +1100, Con Kolivas wrote:
> > Unchanged heavily tested v27 implementation of swap prefetching resynced
> > with 2.6.16-rc4-mm1.
>
> I used your patches in the last 2 or 3 -mm kernels (since s-p-v24). It's
> been working good until now.
>
> > Please consider for -mm.
>
> Just one minor note:
> [...]

> > +		if (TestSetPageLRU(page))
> > +			BUG();
>
> TestSetPageLRU is gone in -mm (see mm-pagelru-no-testset.patch), you
> should probably change it to
>
> 		BUG_ON(PageLRU(page));
> 		SetPageLRU(page);

Thanks!

Cheers,
Con
