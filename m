Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLANIl>; Fri, 1 Dec 2000 08:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129414AbQLANIb>; Fri, 1 Dec 2000 08:08:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:26898 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129226AbQLANIP>;
	Fri, 1 Dec 2000 08:08:15 -0500
Date: Fri, 1 Dec 2000 13:37:45 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: corruption
Message-ID: <20001201133745.B21481@suse.de>
In-Reply-To: <b09.3a269edc.6bd12@trespassersw.daria.co.uk> <Pine.GSO.4.21.0011301400290.20801-100000@weyl.math.psu.edu> <3A26C82D.26267202@uow.edu.au> <3A26F77B.2800C58D@asiapacificm01.nt.com>, <3A26F77B.2800C58D@asiapacificm01.nt.com>; <20001201131814.C21309@suse.de> <3A279ABD.957C0EF@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A279ABD.957C0EF@uow.edu.au>; from andrewm@uow.edu.au on Fri, Dec 01, 2000 at 11:34:05PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01 2000, Andrew Morton wrote:
> > > mmmm... choc-chip.
> > >
> > > With the above patch applied the machine crashed after an hour. Crashed
> > > a second time during the e2fsck.  gdb backtrace:
> > 
> > Very interesting. IDE / SCSI?
> 
> hmm..  Overlapping emails.
> 
> The crash with e2fsck was easily repeatable with the above patch.  Just
> dirty a few buffers and run /sbin/sync.  It's due to the __make_request
> queue_head thing which you fixed in test12-pre3.  Yes, this was IDE.

Ah ok, I thought this was on test12-pre3.

> However the original problem of a list_del being performed on a wild
> pointer is being seen on SCSI systems.  I expect the above patch will
> catch it if it's still happening.

Indeed, and I don't think it's request queue_head related anymore. I
will look forward to seeing a trace, though :-)

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
