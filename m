Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263654AbUC3NsX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 08:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263655AbUC3NsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 08:48:23 -0500
Received: from deliver.epitech.net ([163.5.0.25]:51762 "HELO
	deliver.epitech.net") by vger.kernel.org with SMTP id S263654AbUC3NsV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 08:48:21 -0500
Date: Tue, 30 Mar 2004 15:48:12 +0200
From: Marc Bevand <bevand_m@epita.fr>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040330134811.GA5761@nash.epita.fr>
References: <4066021A.20308@pobox.com> <40695FF6.3020401@epita.fr> <20040330130701.GV24370@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330130701.GV24370@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Mar 2004, Jens Axboe wrote:
| On Tue, Mar 30 2004, Marc Bevand wrote:
| [...]
| > As other people were complaining that the 32MB max request size might be too
| > high, I did give a try to 1MB (by replacing "65534" by "2046" in the patch).
| > There is no visible differences between 32MB and 1MB.
| 
| As suspected. BTW, you want to use 2048 there, not 2046. The 64K-2
| (which could be 64K-1) is just due to ->max_sectors being an unsigned
| short currently.

Okay, I thought the 2 sectors were used to store some extra informations.

I also forgot to mention that there does not seem to have any *latency*
differences between 32MB and 1MB. Strange...

-- 
Marc Bevand                          http://www.epita.fr/~bevand_m
Computer Science School EPITA - System, Network and Security Dept.
