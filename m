Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbTDMJhA (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 05:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263408AbTDMJhA (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 05:37:00 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:20096 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263407AbTDMJg7 (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 05:36:59 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304130951.h3D9pK7A000529@81-2-122-30.bradfords.org.uk>
Subject: Re: Benefits from computing physical IDE disk geometry?
To: tmiller10@cfl.rr.com (Timothy Miller)
Date: Sun, 13 Apr 2003 10:51:19 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <001301c30145$5ff85fb0$6801a8c0@epimetheus> from "Timothy Miller" at Apr 12, 2003 06:46:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any good SCSI drive knows the physical geometry of the disk and can
> therefore optimally schedule reads and writes.  Although necessary features,
> like read queueing, are also available in the current SATA spec, I'm not
> sure most drives will implement it, at least not very well.
> 
> So, what if one were to write a program which would perform a bunch of
> seek-time tests to estimate an IDE disk's physical geometry?  It could then
> make that information available to the kernel to use to reorder accesses
> more optimally.  Additionally, discrepancies from expected seek times could
> be logged in the kernel and used to further improve efficiency over time.

On a system that's been set up with one large root partition, and
nothing else, you might get a noticable gain, but I would guess that
you could get a simliar gain by partitioning the disk and manually
placing, E.G. /var near the outside of the disk, and things like /etc
near the centre.  I.E. placing more active partitions on faster areas
of the disk.

> If it were good enough, many of the advantages of using SCSI disks would
> become less significant.

Not really - there are still a lot of advantages of SCSI that it
wouldn't address.

John.
