Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266130AbUBCUup (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 15:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266143AbUBCUup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 15:50:45 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:51331 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266130AbUBCUum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 15:50:42 -0500
Date: Tue, 3 Feb 2004 20:59:31 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402032059.i13KxV5v003730@81-2-122-30.bradfords.org.uk>
To: "Richard B. Johnson" <root@chaos.analogic.com>,
       =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: John Bradford <john@grabjohn.com>,
       =?iso-8859-1?q?Martin_Povoln=FD?= <xpovolny@aurora.fi.muni.cz>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0402031509100.32547@chaos>
References: <20040203131837.GF3967@aurora.fi.muni.cz>
 <Pine.LNX.4.53.0402030839380.31203@chaos>
 <401FB78A.5010902@zvala.cz>
 <Pine.LNX.4.53.0402031018170.31411@chaos>
 <200402031602.i13G2NFi002400@81-2-122-30.bradfords.org.uk>
 <yw1xsmhsf882.fsf@kth.se>
 <200402031635.i13GZJ9Q002866@81-2-122-30.bradfords.org.uk>
 <20040203174606.GG3967@aurora.fi.muni.cz>
 <200402031853.i13Ir1e0003202@81-2-122-30.bradfords.org.uk>
 <yw1xn080m1d2.fsf@kth.se>
 <Pine.LNX.4.53.0402031509100.32547@chaos>
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I had to borrow a R/W CDROM because most everybody uses CR-R only
> here. That's why it took so long to check. With SCSI, Linux 2.4.24,
> cdrecord fails to umount the drive before it burns it. The result
> is that the previous directory still remains at the mount-point.
> This, even though cdrecord ejected the drive to "re-read" its
> status.
> 
> Bottom line: If the CDROM isn't umounted first, you can still
> get a directory entry even though the CDROM has been written with
> about 500 magabytes of new data.

You're describing a different problem.  The original poster is
unmounting the disc before erasing it.

It would be nice if cdrecord checked that the device it was about to
write to wasn't already mounted, and complained if it was.

John.
