Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263655AbUC3Ntw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 08:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263657AbUC3Ntw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 08:49:52 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27275 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263655AbUC3Ntu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 08:49:50 -0500
Date: Tue, 30 Mar 2004 15:49:48 +0200
From: Jens Axboe <axboe@suse.de>
To: Marc Bevand <bevand_m@epita.fr>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040330134948.GX24370@suse.de>
References: <4066021A.20308@pobox.com> <40695FF6.3020401@epita.fr> <20040330130701.GV24370@suse.de> <20040330134811.GA5761@nash.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330134811.GA5761@nash.epita.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30 2004, Marc Bevand wrote:
> On 30 Mar 2004, Jens Axboe wrote:
> | On Tue, Mar 30 2004, Marc Bevand wrote:
> | [...]
> | > As other people were complaining that the 32MB max request size might be too
> | > high, I did give a try to 1MB (by replacing "65534" by "2046" in the patch).
> | > There is no visible differences between 32MB and 1MB.
> | 
> | As suspected. BTW, you want to use 2048 there, not 2046. The 64K-2
> | (which could be 64K-1) is just due to ->max_sectors being an unsigned
> | short currently.
> 
> Okay, I thought the 2 sectors were used to store some extra
> informations.
> 
> I also forgot to mention that there does not seem to have any
> *latency* differences between 32MB and 1MB. Strange...

That's because you are not generating requests that big anyways.

-- 
Jens Axboe

