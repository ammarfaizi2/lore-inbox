Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264524AbUHMLzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264524AbUHMLzc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 07:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264717AbUHMLzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 07:55:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35810 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264524AbUHMLzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 07:55:05 -0400
Date: Fri, 13 Aug 2004 13:54:26 +0200
From: Jens Axboe <axboe@suse.de>
To: Chris Clayton <chris@theclaytons.giointernet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CDMRW in 2.6
Message-ID: <20040813115426.GN2663@suse.de>
References: <200408091625.31210.chris@theclaytons.giointernet.co.uk> <20040813071537.GE2321@suse.de> <200408131253.49321.chris@theclaytons.giointernet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408131253.49321.chris@theclaytons.giointernet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13 2004, Chris Clayton wrote:
> On Friday 13 Aug 2004 07:15, Jens Axboe wrote:
> > On Mon, Aug 09 2004, Chris Clayton wrote:
> > > cdrom: hdc: mrw address space DMA selected
> > > cdrom open: mrw_status 'mrw complete'
> > > hdc: command error: status=0x51 { DriveReady SeekComplete Error }
> > > hdc: command error: error=0x54
> > > end_request: I/O error, dev hdc, sector 1048576
> >
> > Command was aborted, probably the media isn't writable after all.  Can
> > you try and force a full format with cdrwtool?
> 
> Jens,
> 
> Did you mean cdrwtool or cdmrw?

Sorry, meant cdmrw of course.

> I've done a format with cdrwtool (cdrwtool -t 10 -d /dev/hdc -q) but
> when I try and mount it (mount -o rw,noatime -t udf /dev/hdc /cdmrw)
> and mount gives the message:
> 
> mount: block device /dev/hdc is write-protected, mounting read-only
> 
> dmesg shows no error after cdrwtool has run but has the following new
> messages after the media is mounted:
> 
> cdrom: hdc: mrw address space DMA selected
> cdrom open: mrw_status 'not mrw'
> UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'LinuxUDF', timestamp 
> 2004/08/13 12:35 (1000)
> 
> The media does, however, mount OK for packet writing (sudo mount -t
> udf -o rw,noatime /dev/pktcdvd/cdrw /cdrw) using another kernel
> patched with the packet writing patches Peter Osterlund has submitted
> for the -mm series.
> 
> I'll try a full (as opposed to quick) blank with cdrwtool plus a
> forced format with cdmrw and report back when that has finished.

Yes please do that, if that doesn't work it's really screwed.

-- 
Jens Axboe

