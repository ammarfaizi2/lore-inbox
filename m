Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137169AbREKQ37>; Fri, 11 May 2001 12:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137168AbREKQ3v>; Fri, 11 May 2001 12:29:51 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:8414 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S137167AbREKQ3h>; Fri, 11 May 2001 12:29:37 -0400
Date: Fri, 11 May 2001 16:41:25 +0100 (BST)
From: Mark Hemment <markhe@veritas.com>
To: null <null@null.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: nasty SCSI performance drop-outs (potential test case)
In-Reply-To: <Pine.LNX.4.21.0105111006390.32238-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0105111635140.31900-100000@alloc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 May 2001, null wrote: 
> Time to mkfs the same two 5GB LUNs in parallel is 54 seconds.  Hmmm.
> Bandwidth on two CPUs is totally consumed (99.9%) and a third CPU is
> usually consumed by the kupdated process.  Activity lights on the storage
> device are mostly idle during this time.

  I see you've got 1.2GBytes, so are using HIGHMEM support?

  I sumbitted a patch a few weeks back, against the buffer cache, which
makes it behave better with HIGHMEM.  The patch improved the time take to
create large filesystems.

  This got picked up by Alan in his -ac series.  Can't remember exactly
when Alan merged it, but it is definitely in 2.4.4-ac3.  I'd recommend
giving it a try.

Mark


