Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288686AbSA0V0V>; Sun, 27 Jan 2002 16:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288732AbSA0V0L>; Sun, 27 Jan 2002 16:26:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16141 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S288686AbSA0V0F>;
	Sun, 27 Jan 2002 16:26:05 -0500
Date: Sun, 27 Jan 2002 22:25:51 +0100
From: Jens Axboe <axboe@suse.de>
To: Robert Love <rml@tech9.net>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] Bus mastering support for IDE CDROM audio
Message-ID: <20020127222551.B7548@suse.de>
In-Reply-To: <3C5119E0.6E5C45B6@zip.com.au> <1012166472.812.7.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1012166472.812.7.camel@phantasy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27 2002, Robert Love wrote:
> On Fri, 2002-01-25 at 03:40, Andrew Morton wrote:
> > Reading audio from IDE CDROMs always uses PIO.  This patch
> > teaches the kernel to use DMA for the CDROMREADAUDIO ioctl.
> > [...]
> > This code has not been tested for its effects upon SCSI-based
> > CDROM readers.  It needs to be.
> 
> Andrew,
> 
> I wanted to confirm success of testing the patch with a SCSI CD-ROM
> (Plextor UltraPlex Wide on aic7xxx).  I used your updated patch off your
> website.
> 
> Audio rip completed without error.  Performance seems the same, which I
> assume is to be expected with SCSI readers.

sr already uses DMA for all transfers, so no performance gain was to be
expected there. problem is ide-cd using pio for all packet command data
transfers currently (modulo fs read write requests, of course)

not a whole lot of pio aic7xxx adapters out there :-)

-- 
Jens Axboe

