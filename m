Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbTIOHex (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 03:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbTIOHex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 03:34:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:18586 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261181AbTIOHew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 03:34:52 -0400
Date: Mon, 15 Sep 2003 09:34:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.7 block ramblings (was Re: DMA for ide-scsi?)
Message-ID: <20030915073445.GC27105@suse.de>
References: <200309131101.h8DB1WNd021570@harpo.it.uu.se> <1063476275.8702.35.camel@dhcp23.swansea.linux.org.uk> <20030913184934.GB10047@gtf.org> <20030913190131.GD10047@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030913190131.GD10047@gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13 2003, Jeff Garzik wrote:
> Oh, and I'm pondering the best way to deliver out-of-bang ATA taskfiles
> and SCSI cdbs to a device.  (for the uninitiated, this is lower level
> than block devices / cdrom devices / etc.)
> 
>  ... AF_BLOCK is not out of the question ;-)

Eh... I wont comment on that. I think we are way into Garzik lala land
there :)

I'd prefer just keeping sg_io_hdr, but dumping sg. A fully fledged bsg
(block sg) implementation. That way programs continue to work like
before on ATAPI/SCSI, for ATA we can use it as a task file transport.

-- 
Jens Axboe

