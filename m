Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbTENIAE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 04:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbTENIAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 04:00:04 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:40600 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261247AbTENIAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 04:00:03 -0400
Date: Wed, 14 May 2003 10:12:29 +0200
From: Jens Axboe <axboe@suse.de>
To: Christopher Hoover <ch@murgatroid.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.68: Don't include SCSI block ioctls on non-scsi systems
Message-ID: <20030514081229.GB17033@suse.de>
References: <20030513202710.A32666@heavens.murgatroid.com> <20030514065752.A647@infradead.org> <20030514010801.A4080@heavens.murgatroid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514010801.A4080@heavens.murgatroid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14 2003, Christopher Hoover wrote:
> On Wed, May 14, 2003 at 06:57:52AM +0100, Christoph Hellwig wrote:
> > On Tue, May 13, 2003 at 08:29:20PM -0700, Christopher Hoover wrote:
> > > Unless I'm missing something, there doesn't seem to be a good reason
> > > for the block system to include SCSI ioctls unless there's a SCSI
> > > block device (CONFIG_BLK_DEV_SD) in the system.
> > 
> > That's broken.  You can use them on ide, sd and sr currently.
> 
> OK, let's try that again.

That's better, but block/scsi_ioctl.c is potentially useful on non ide
or scsi systems too.

I agree with the config option, though.

-- 
Jens Axboe

