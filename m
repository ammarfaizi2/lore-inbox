Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbUJZFr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbUJZFr4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 01:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUJZFpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 01:45:04 -0400
Received: from math.ut.ee ([193.40.5.125]:35020 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261925AbUJZFgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 01:36:02 -0400
Date: Tue, 26 Oct 2004 08:36:00 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: hddtemp hangs with USB SCSI disks; blk_execute_rq again
Message-ID: <Pine.GSO.4.44.0410260827240.8730-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

hddtemp startup script hangs on my machine. Just the hddtemp process is
in D state (blk_execute_rq) and unkillable, other processes run fine.
The startup script calls hddtemp -wn /dev/sda. /dev/sda
is a CF slot in a USB 6-in-1 memory card reader, currently empty.
/proc/partitions shows only 2 ide disks.

Since hddtemp is not converted to SG_IO yet, the kernel logs
program hddtemp is using a deprecated SCSI ioctl, please convert it to SG_IO
but this should not cause hddtemp to hang.

This is another case of process hanging in blk_execute_rq, see the
recent thread "readcd hangs in blk_execute_rq" (also reported by me but
about a different computer).

I have noticed it some weeks ago but didn't have time then to
investigate and disabled hddtemp. Today I looked at it again and now I'm
reporting it.

-- 
Meelis Roos (mroos@linux.ee)

