Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbVIGT1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbVIGT1t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 15:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbVIGT1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 15:27:49 -0400
Received: from serv01.siteground.net ([70.85.91.68]:24450 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751284AbVIGT1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 15:27:48 -0400
Date: Wed, 7 Sep 2005 12:27:47 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Jens Axboe <axboe@suse.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Alok Kataria <alokk@calsoftinc.com>
Subject: Re: [patch 0/4] ide: Break ide_lock to per-hwgroup lock
Message-ID: <20050907192747.GC3769@localhost.localdomain>
References: <20050906233322.GA3642@localhost.localdomain> <20050907091923.GE4785@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050907091923.GE4785@suse.de>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2005 at 11:19:24AM +0200, Jens Axboe wrote:
> On Tue, Sep 06 2005, Ravikiran G Thirumalai wrote:
> > The following patchset breaks down the global ide_lock to per-hwgroup lock.
> > We have taken the following approach.
> 
> Curious, what is the point of this?
> 

On smp machines with multiple ide interfaces, we take per-group lock instead
of a global lock, there by breaking the lock to per-irq hwgroups.

Thanks,
Kiran
