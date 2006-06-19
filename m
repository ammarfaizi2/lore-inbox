Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbWFSNFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWFSNFq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 09:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWFSNFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 09:05:46 -0400
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:22725 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932435AbWFSNFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 09:05:45 -0400
From: Con Kolivas <kernel@kolivas.org>
To: tglx@timesys.com
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and   dynamic HZ
Date: Mon, 19 Jun 2006 23:05:16 +1000
User-Agent: KMail/1.9.3
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
References: <1150643426.27073.17.camel@localhost.localdomain> <200606192209.38403.kernel@kolivas.org> <1150720304.27073.70.camel@localhost.localdomain>
In-Reply-To: <1150720304.27073.70.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606192305.17098.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 June 2006 22:31, Thomas Gleixner wrote:
> On Mon, 2006-06-19 at 22:09 +1000, Con Kolivas wrote:
> > Also suffers from:
> > WARNING: "timespec_to_jiffies" [fs/fuse/fuse.ko] undefined!
> >
> > Here is a fix
>
> Doh, where is the brown paperbag shop ?
>
> Thanks, applied.
>
> New queue:
>
> http://www.tglx.de/projects/hrtimers/2.6.17/patch-2.6.17-hrt-dyntick3.patch
>
> http://www.tglx.de/projects/hrtimers/2.6.17/patch-2.6.17-hrt-dyntick3.patch
>es.tar.bz2

Question:

In clockevents.c 
setup_global_clockevent and recalc_events call ret=setup_event()

and they act on ret but setup_event always returns 0

Was more planned for setup_event() ?

-- 
-ck
