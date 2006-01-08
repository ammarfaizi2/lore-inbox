Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161158AbWAHDDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161158AbWAHDDW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 22:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161159AbWAHDDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 22:03:22 -0500
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:17285 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1161158AbWAHDDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 22:03:21 -0500
From: kernel@kolivas.org
To: Marco Costalba <mcostalba@gmail.com>
Subject: Re: Typo in include/linux/mmzone.h
Date: Sun, 8 Jan 2006 14:03:15 +1100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <e5bfff550601071354k2c86afcs62d1526a3a1487cd@mail.gmail.com>
In-Reply-To: <e5bfff550601071354k2c86afcs62d1526a3a1487cd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601081403.15850.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 January 2006 08:54, Marco Costalba wrote:
> Hi,
>
>    probably there is a typo in your last patch:
> [PATCH] mm: add populated_zone() helper
>
> In
>
> +++ b/include/linux/mmzone.h
> @@ -388,6 +388,11 @@ static inline struct zone *next_zone(str
>  #define for_each_zone(zone) \
>  	for (zone = pgdat_list->node_zones; zone; zone = next_zone(zone))
>
> +static inline int populated_zone(struct zone *zone)
> +{
> +	return (!!zone->present_pages);
> +}
> +

No typo there at all. !! guarantees return of 1.

Cheers,
Con
