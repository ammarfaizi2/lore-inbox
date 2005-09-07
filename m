Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbVIGTeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbVIGTeX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 15:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbVIGTeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 15:34:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6412 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932228AbVIGTeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 15:34:21 -0400
Date: Wed, 7 Sep 2005 21:34:26 +0200
From: Jens Axboe <axboe@suse.de>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Alok Kataria <alokk@calsoftinc.com>
Subject: Re: [patch 0/4] ide: Break ide_lock to per-hwgroup lock
Message-ID: <20050907193422.GS4785@suse.de>
References: <20050906233322.GA3642@localhost.localdomain> <20050907091923.GE4785@suse.de> <20050907192747.GC3769@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050907192747.GC3769@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07 2005, Ravikiran G Thirumalai wrote:
> On Wed, Sep 07, 2005 at 11:19:24AM +0200, Jens Axboe wrote:
> > On Tue, Sep 06 2005, Ravikiran G Thirumalai wrote:
> > > The following patchset breaks down the global ide_lock to per-hwgroup lock.
> > > We have taken the following approach.
> > 
> > Curious, what is the point of this?
> > 
> 
> On smp machines with multiple ide interfaces, we take per-group lock instead
> of a global lock, there by breaking the lock to per-irq hwgroups.

I realize the theory behind breaking up locks, I'm just wondering about
this specific case. Please show actual contention data promoting this
specific case, we don't break up locks "just because".

I'm asking because I've never heard anyone complain about IDE lock
contention and a proper patch usually comes with analysis of why it is
needed.

-- 
Jens Axboe

