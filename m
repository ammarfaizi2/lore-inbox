Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262237AbVBVHN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbVBVHN7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 02:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbVBVHN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 02:13:59 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:46306 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262232AbVBVHNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 02:13:54 -0500
Date: Tue, 22 Feb 2005 08:13:44 +0100
From: Jens Axboe <axboe@suse.de>
To: Greg Stark <gsstark@mit.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jeff Garzik <jgarzik@pobox.com>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi/sata write barrier support
Message-ID: <20050222071340.GC2835@suse.de>
References: <20050127120244.GO2751@suse.de> <87acpxurwf.fsf@stark.xeocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87acpxurwf.fsf@stark.xeocode.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21 2005, Greg Stark wrote:
> 
> Jens Axboe <axboe@suse.de> writes:
> 
> > For the longest time, only the old PATA drivers supported barrier writes
> > with journalled file systems. 
> 
> What about for fsync(2)? One of the most frequent sources of data loss on the
> postgres mailing list has to do with users with IDE drives where fsync returns
> even though the data hasn't actually reached the disk. A power outage can
> cause lost data or a corrupted database.
> 
> Is there any progress getting fsync to use this new infrastructure so it can
> actually satisfy its contract?

fsync has been working all along, since the initial barrier support for
ide. only ext3 and reiserfs support it.

-- 
Jens Axboe

