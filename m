Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbVI2XKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbVI2XKM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbVI2XKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:10:12 -0400
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:30891 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751349AbVI2XKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:10:10 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] vm - swap_prefetch v12
Date: Fri, 30 Sep 2005 09:12:58 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
References: <200509300115.33060.kernel@kolivas.org> <20050929145400.1cc2b748.akpm@osdl.org>
In-Reply-To: <20050929145400.1cc2b748.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509300912.58722.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2005 07:54 am, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> > Once pages have been added to the swapped list, a timer is started,
> > testing for conditions suitable to prefetch swap pages every 5 seconds.
> > Suitable conditions are defined as lack of swapping out or in any pages,
> > and no watermark tests failing. Significant amounts of dirtied ram also
> > prevent prefetching. It then checks that we have spare ram looking for at
> > least 3* pages_high free per zone and if it succeeds that will prefetch
> > pages from swap.
>
> Did you consider poking around in gendisk.disk_stats to determine whether
> the swap disk(s) are idleish?

I didn't know where to look for that info. Thanks! I'm open to *any* 
suggestions and I'll look into it as I can't take this code much further 
without outside help.

Cheers,
Con
