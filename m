Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319435AbSILFFI>; Thu, 12 Sep 2002 01:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319436AbSILFFI>; Thu, 12 Sep 2002 01:05:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7138 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S319435AbSILFFH>;
	Thu, 12 Sep 2002 01:05:07 -0400
Date: Thu, 12 Sep 2002 07:06:20 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Phil Stracchino <alaric@babcom.com>, linux-kernel@vger.kernel.org
Subject: Re: CDROM driver does not support Linux partition tables
Message-ID: <20020912050620.GG30234@suse.de>
References: <20020904181952.GA1158@babylon5.babcom.com> <1031182512.3017.139.camel@irongate.swansea.linux.org.uk> <20020911211959.GA31724@babylon5.babcom.com> <1031779715.2838.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031779715.2838.4.camel@irongate.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11 2002, Alan Cox wrote:
> On Wed, 2002-09-11 at 22:19, Phil Stracchino wrote:
> >  
> > A deficiency in the Linux CDROM driver was just brought to my attention.
> > Even on a kernel configured with support for UFS and Sun partition
> > tables, it doesn't appear to be possible to mount any but the first
> > slice of a Sun CDROM containing multiple slices.  Essentially, it seems
> > that Solaris partition table support doesn't trickle down to the CDROM
> > driver.
> > 
> > Is this something that's supposed to happen, and is there a reason why
> > it's not supported, or is it simply that no-one has asked for it to be
> > supported and/or no-one has gotten around to implementing it because of 
> > lack of demand?
> 
> It ought to be supportable on scsi cd or with ide-scsi. ide-cd has no
> minor space for partitioning, ide-scsi/sr do support partitions.

The opposite, surely? sr uses one minor per cd-rom, ide-cd has 64.

-- 
Jens Axboe

