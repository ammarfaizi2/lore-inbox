Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129615AbRBQQMj>; Sat, 17 Feb 2001 11:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130048AbRBQQM3>; Sat, 17 Feb 2001 11:12:29 -0500
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:26958
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131847AbRBQQMS>; Sat, 17 Feb 2001 11:12:18 -0500
Message-Id: <200102171612.KAA00937@localhost.localdomain>
X-Mailer: exmh version 2.1.1 10/15/1999
To: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
cc: linux-kernel@vger.kernel.org
Subject: Re: Flushing buffer and page cache
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 17 Feb 2001 10:12:11 -0600
From: James Bottomley <James.Bottomley@SteelEye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it possible to flush all entries in the buffer cache corresponding
> to a single block device (i.e. simply drop them if they aren't dirty,
> or write them to disk and drop them after this if they are dirty)?

Yes, just send the BLKFLSBUF ioctl to the device this syncs the device then 
removes all the buffers from the cache.  We use it as a tool to move a SAN 
device around a cluster, which is similar to what you want to do.

James Bottomley



