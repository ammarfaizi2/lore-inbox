Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbWD0SxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbWD0SxF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 14:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWD0SxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 14:53:04 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:3027 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965012AbWD0SxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 14:53:02 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [-mm patch] mm/vmscan.c: make shrink_all_zones() static
Date: Thu, 27 Apr 2006 20:52:29 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
References: <20060427014141.06b88072.akpm@osdl.org> <20060427180314.GJ3570@stusta.de>
In-Reply-To: <20060427180314.GJ3570@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604272052.30148.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 April 2006 20:03, Adrian Bunk wrote:
> On Thu, Apr 27, 2006 at 01:41:41AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.17-rc1-mm3:
> >...
> > +swsusp-rework-memory-shrinker-rev-2.patch
> > 
> >  Memory management updates
> >...
> 
> 
> This patch makes the needlessly global shrink_all_zones() static.

Thanks for fixing.

Greetings,
Rafael


> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.17-rc2-mm1-full/mm/vmscan.c.old	2006-04-27 18:09:55.000000000 +0200
> +++ linux-2.6.17-rc2-mm1-full/mm/vmscan.c	2006-04-27 18:10:14.000000000 +0200
> @@ -1291,8 +1291,8 @@
>   *
>   * For pass > 3 we also try to shrink the LRU lists that contain a few pages
>   */
> -unsigned long shrink_all_zones(unsigned long nr_pages, int pass, int prio,
> -				struct scan_control *sc)
> +static unsigned long shrink_all_zones(unsigned long nr_pages, int pass,
> +				      int prio, struct scan_control *sc)
>  {
>  	struct zone *zone;
>  	unsigned long nr_to_scan, ret = 0;
> 
> 
> 
