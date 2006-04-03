Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWDCFTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWDCFTE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 01:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWDCFTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 01:19:03 -0400
Received: from mail27.syd.optusnet.com.au ([211.29.133.168]:953 "EHLO
	mail27.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751402AbWDCFTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 01:19:01 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: lowmem_reserve question
Date: Mon, 3 Apr 2006 15:18:48 +1000
User-Agent: KMail/1.9.1
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, ck@vds.kolivas.org,
       Andrew Morton <akpm@osdl.org>,
       linux list <linux-kernel@vger.kernel.org>
References: <200604021401.13331.kernel@kolivas.org> <200604031448.01391.kernel@kolivas.org> <1144041247.8198.8.camel@homer>
In-Reply-To: <1144041247.8198.8.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604031518.49184.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 April 2006 15:14, Mike Galbraith wrote:
> On Mon, 2006-04-03 at 14:48 +1000, Con Kolivas wrote:
> > On Monday 03 April 2006 14:42, Mike Galbraith wrote:
> > > On Mon, 2006-04-03 at 12:48 +1000, Con Kolivas wrote:
> > > > Furthermore, now that we have the option of up to 3GB lowmem split on
> > > > 32bit we can have a default lowmem_reserve of almost 12MB (if I'm
> > > > reading it right) which seems very tight with only 16MB of ZONE_DMA.
> > >
> > > I haven't crawled around in the vm for ages, but I think that's only
> > > 16MB if you support antique cards.
> >
> > That's what the ram is used for, but that is all the ZONE_DMA 32bit
> > machines get, whether you use it for that purpose or not. My concern is
> > that this will have all sorts of effects on the balancing since it will
> > always appear almost full.
>
> If that dinky 16MB zone still exists, and always appears nearly full, be
> happy.  It used to be a real PITA.

That's not the point. If you try to do any allocation anywhere else it also 
checks that zone, and it will find it full (always) leading to reclaim all 
over the place for no good reason. This has nothing to do with actually 
wanting to use that space or otherwise.

Cheers,
Con
