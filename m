Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbVJVPVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbVJVPVq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 11:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbVJVPVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 11:21:46 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:61590 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751271AbVJVPVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 11:21:46 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH] mm - swap prefetch magnify
Date: Sun, 23 Oct 2005 01:21:30 +1000
User-Agent: KMail/1.8.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ck list <ck@vds.kolivas.org>
References: <200510221120.44473.kernel@kolivas.org> <200510221147.59059.kernel@kolivas.org> <4d8e3fd30510220241i6c370dd1x512561cb6a1bc250@mail.gmail.com>
In-Reply-To: <4d8e3fd30510220241i6c370dd1x512561cb6a1bc250@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510230121.31048.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Oct 2005 19:41, Paolo Ciarrocchi wrote:
> On 10/22/05, Con Kolivas <kernel@kolivas.org> wrote:
> > On Sat, 22 Oct 2005 11:20, Con Kolivas wrote:
> > > Testing has confirmed much larger prefetch values work well.
> >
> > Bah.. Sorry take this one instead. Just make sure that no matter how
> > little ram we have prefetch is enabled.
>
> Con,
> would you be so kind to post more information about the test you've done ?

My concern was to not cause a detriment to performance in any noticeable way. 
The prefetch sizes were tested on a number of machines with different speed 
hard drive / ram size combinations to ensure none of the default values ever 
caused any significant I/O wait, or that heavy memory requiring compiles took 
any longer to complete as these constantly need new ram allocations and I 
wanted to ensure that prefetching into ram didn't slow down those 
allocations. Furthermore, the time taken to actually prefetch the application 
is now more than 5 times faster because of the larger default prefetch 
values.

Cheers,
Con
