Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287945AbSABUYO>; Wed, 2 Jan 2002 15:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287948AbSABUYF>; Wed, 2 Jan 2002 15:24:05 -0500
Received: from myfilelocker.comcast.net ([24.153.64.6]:26793 "EHLO mtaout45-01")
	by vger.kernel.org with ESMTP id <S287944AbSABUXo>;
	Wed, 2 Jan 2002 15:23:44 -0500
Date: Wed, 02 Jan 2002 15:23:38 -0500
From: Brian <hiryuu@envisiongames.net>
Subject: Re: Two hdds on one channel - why so slow?
In-Reply-To: <Pine.LNX.4.10.10201021052090.10050-100000@master.linux-ide.org>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <0GPB00E6IVBF4D@mtaout45-01.icomcast.net>
MIME-version: 1.0
X-Mailer: KMail [version 1.3.2]
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
In-Reply-To: <Pine.LNX.4.10.10201021052090.10050-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 January 2002 02:31 pm, Andre Hedrick wrote:
> Brian,
>
> This was true in the past and with many older drivers.  However when and
> if the new driver I have is adpoted, it will make SCSI cry.  So please
> stop polluting the issue.

Both the master and the slave may have requests in progress at once now?  
This is the first time I have heard that issue refuted.  In fact, we just 
bought an 8-drive 3ware 7800, with 8 channels and 8 cables, that seemed to 
further confirm that issue.

> Now I have managed to use two hosts w/ 4 channels no caching controller,
> no hardware raid, 4 7200RPM drives and software raid 0.  I was able to
> push 109MB/sec writing and 167MB/sec reading.

So each drive was a master on a chain to itself?  I am not denying the 
performance of this setup.  Also was this on the above hardware (the read 
speed would exceed a PCI 33/32 bus)

> Also under a similar environment, I was able to, using a single card, 4
> drives, not hardware-raid, no caching controller, reach 90MB/sec writing
> and reading was about 78MB/sec.

4 drives on two chains (master & slave on each) is certainly more 
interesting.  The write speed is impressive, but what cut the read 
performance in half?

> Now lets adjust cost of componets and SCSI loses big.

Indeed.  That 720GB file server totaled ~$3000.

	-- Brian
