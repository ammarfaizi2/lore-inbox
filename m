Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265650AbSKPILc>; Sat, 16 Nov 2002 03:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265656AbSKPILc>; Sat, 16 Nov 2002 03:11:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:49594 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265650AbSKPILb>;
	Sat, 16 Nov 2002 03:11:31 -0500
Date: Sat, 16 Nov 2002 09:18:28 +0100
From: Jens Axboe <axboe@suse.de>
To: Steve Lord <lord@sgi.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SCSI I/O performance problems when CONFIG_HIGHIO is off
Message-ID: <20021116081828.GB8495@suse.de>
References: <1037392310.13531.419.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037392310.13531.419.camel@jen.americas.sgi.com>
User-Agent: Mutt/1.4i
X-OS: Linux 2.4.20-pre10 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15 2002, Steve Lord wrote:
> Jens,
> 
> As you know, for the last week or so I have been battling some
> performance issues in XFS and 2.4.20-rc1. Well, we finally found
> the culprit back in 2.4.20-pre2.
> 
> When the block highmem patch was included, it added highmem_io to the
> scsi controller structure. This can only ever be set to one if
> CONFIG_HIGHIO is set. Yet there are several spots in the scsi
> code which test based on its value regardless.

Doh! You are right, this is a very stupid bug, thanks for catching it.
I'm on the road this weekend, I'' submit a patch to fix it as soon
as I get back.

> Jens, can you do something about this please?

Of course

> p.s. You now owe me a week's consulting some time ;-)

Indeed, sorry about that...

Jens

