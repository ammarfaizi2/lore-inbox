Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269259AbUJFOpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269259AbUJFOpJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 10:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269272AbUJFOpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 10:45:09 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:37318 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269259AbUJFOpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 10:45:05 -0400
Date: Wed, 6 Oct 2004 16:41:52 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] ide-dma blacklist behaviour broken
Message-ID: <20041006144152.GK3638@suse.de>
References: <20041005142001.GR2433@suse.de> <20041005163730.A19554@infradead.org> <20041005154628.GG19971@suse.de> <1097016410.23923.8.camel@localhost.localdomain> <20041006054532.GA13631@suse.de> <1097069227.29255.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097069227.29255.2.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06 2004, Alan Cox wrote:
> On Mer, 2004-10-06 at 06:45, Jens Axboe wrote:
> > > We should actually probably nuke most of the IDE blacklist, much of the
> > > CD-ROM blacklist arose because we DMA rather than PIO'd the ATAPI CDB.
> > 
> > Hmm? When have we ever done that?
> 
> 2.0, 2.2, 2.4 to about 2.4.18 or so (Khalid Aziz eventually pinned it
> down and fixed it).

Ah, I think you are misreading it. It wasn't the DMA'ing of the atapi
cdb, that was always pio'ed to the drive. But DMA for the command itself
was turned on before the cdb had been transferred.

-- 
Jens Axboe

