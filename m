Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWBGBcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWBGBcZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 20:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWBGBcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 20:32:25 -0500
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:32446 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932178AbWBGBcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 20:32:24 -0500
From: Con Kolivas <kernel@kolivas.org>
To: ck@vds.kolivas.org
Subject: Re: [ck] Re: [PATCH] mm: implement swap prefetching
Date: Tue, 7 Feb 2006 12:32:52 +1100
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
References: <200602071028.30721.kernel@kolivas.org> <20060206163842.7ff70c49.akpm@osdl.org> <200602071229.25793.kernel@kolivas.org>
In-Reply-To: <200602071229.25793.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071232.52897.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2006 12:29 pm, Con Kolivas wrote:
> On Tue, 7 Feb 2006 11:38 am, Andrew Morton wrote:
> > Con Kolivas <kernel@kolivas.org> wrote:
> > > +	if (unlikely(!spin_trylock(&swapped.lock)))
> > > +		goto out;
> >
> > hm, spin_trylock() should internally do unlikely(), but it doesn't. 
> > (It's a bit of a mess, too).
>
> Good point. Perhaps I should submit a separate patch for this instead.

A quick look at this code made me change my mind; there's heaps that could do 
with this treatment in spinlock.h. I'll let someone else tackle it.

Cheers,
Con
