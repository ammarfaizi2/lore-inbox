Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268323AbUIPXV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268323AbUIPXV7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 19:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268435AbUIPXUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 19:20:33 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:37581 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S268337AbUIPXUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 19:20:11 -0400
Date: Thu, 16 Sep 2004 19:20:09 +0000 (UTC)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Ray Bryant <raybry@sgi.com>
Cc: Ray Bryant <raybry@austin.rr.com>, Andrew Morton <akpm@osdl.org>,
       lse-tech@lists.sourceforge.net, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] lockmeter: lockmeter fix for generic_read_trylock
In-Reply-To: <20040916230402.23023.89478.83475@tomahawk.engr.sgi.com>
Message-ID: <Pine.LNX.4.53.0409161918520.2897@musoma.fsmlabs.com>
References: <20040916230344.23023.79384.49263@tomahawk.engr.sgi.com>
 <20040916230402.23023.89478.83475@tomahawk.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004, Ray Bryant wrote:

> Update lockmeter.c with generic_raw_read_trylock fix.
>
> + * Generic declaration of the raw read_trylock() function,
> + * architectures are supposed to optimize this:
> + */
> +int __lockfunc generic_raw_read_trylock(rwlock_t *lock)
> +{
> +	_metered_read_lock(lock, __builtin_return_address(0));
> +	return 1;
> +}

What's really going on here? I'm slightly confused by the 
_metered_read_lock usage.

Thanks,
	Zwane

