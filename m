Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbUJZJLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbUJZJLE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 05:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbUJZJLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 05:11:04 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:14505 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261929AbUJZJKz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 05:10:55 -0400
Date: Tue, 26 Oct 2004 11:10:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: hddtemp hangs with USB SCSI disks; blk_execute_rq again
Message-ID: <20041026091027.GC13562@suse.de>
References: <Pine.GSO.4.44.0410260827240.8730-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0410260827240.8730-100000@math.ut.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26 2004, Meelis Roos wrote:
> Hi,
> 
> hddtemp startup script hangs on my machine. Just the hddtemp process is
> in D state (blk_execute_rq) and unkillable, other processes run fine.
> The startup script calls hddtemp -wn /dev/sda. /dev/sda
> is a CF slot in a USB 6-in-1 memory card reader, currently empty.
> /proc/partitions shows only 2 ide disks.
> 
> Since hddtemp is not converted to SG_IO yet, the kernel logs
> program hddtemp is using a deprecated SCSI ioctl, please convert it to SG_IO
> but this should not cause hddtemp to hang.

No, but it's very possible for the issue to be buggy and thus hang the
device. The old method is more risky since it lacks certain information
(such as data direction).

> This is another case of process hanging in blk_execute_rq, see the
> recent thread "readcd hangs in blk_execute_rq" (also reported by me but
> about a different computer).

Well since most user issued io goes through that path, you haven't
really discovered much else than that very fact :-)

> I have noticed it some weeks ago but didn't have time then to
> investigate and disabled hddtemp. Today I looked at it again and now I'm
> reporting it.

Report it to the hddtemp people and let them diagnose it.

-- 
Jens Axboe

