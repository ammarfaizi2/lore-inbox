Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264585AbUGMGFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264585AbUGMGFY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 02:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbUGMGFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 02:05:24 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:46800 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264585AbUGMGFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 02:05:19 -0400
Date: Tue, 13 Jul 2004 08:04:38 +0200
From: Jens Axboe <axboe@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
       Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] CDRW packet writing support for 2.6.7-bk13
Message-ID: <20040713060437.GC14759@suse.de>
References: <m2lli36ec9.fsf@telia.com> <20040710232714.GA21633@infradead.org> <m2r7rjpd24.fsf@telia.com> <200407121825.47889.arnd@arndb.de> <20040712163439.GA27041@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040712163439.GA27041@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12 2004, Christoph Hellwig wrote:
> > - Merge pktcdvd completely into the cdrom subsystem so the existing cdrom
> >   device node passes everything down to pktcdvd if an RW medium is mounted
> >   writable.
> 
> Well, we had that already earlier on.  I'd prefer that and it seems Jens, too.
> But it's a lot of work, and definitly not 2.6 material.

Not really. I'd prefer adding the large block size support to UDF, so
the ide-cd/sr write setup would just automatically work without any
changes in that path. The needed changes would then just be in setup and
closing of the device.

-- 
Jens Axboe

