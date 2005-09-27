Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbVI0P5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbVI0P5t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 11:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbVI0P5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 11:57:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30784 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964988AbVI0P5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 11:57:48 -0400
Date: Tue, 27 Sep 2005 17:58:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Alok Kataria <alokk@calsoftinc.com>
Subject: Re: [patch 0/4] ide: Break ide_lock to per-hwgroup lock
Message-ID: <20050927155813.GG2811@suse.de>
References: <20050906233322.GA3642@localhost.localdomain> <20050907091923.GE4785@suse.de> <20050907192747.GC3769@localhost.localdomain> <20050907193422.GS4785@suse.de> <58cb370e050927063674bb47a7@mail.gmail.com> <20050927152026.GC3822@localhost.localdomain> <20050927152641.GF2811@suse.de> <20050927154201.GD3822@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050927154201.GD3822@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27 2005, Ravikiran G Thirumalai wrote:
> On Tue, Sep 27, 2005 at 05:26:42PM +0200, Jens Axboe wrote:
> > On Tue, Sep 27 2005, Ravikiran G Thirumalai wrote:
> > 
> > You should run it eg 10 times on each kernel to get a feel for the
> > variance of the results. Were you testing 2 or 4 disks?
> > 
> 
> Yes, I was planning to do that,  We were testing with 2 disks.

With 2 disks, the 5.5% sounds like an aweful lot. What block size were
the tests run with? To get the file system out of the way, you could run
something as simple as a dd on each device. That should show queueing
contention (which I guess is the prime area of contention) more
isolated. And profiles would still be very interesting to see :-)

-- 
Jens Axboe

