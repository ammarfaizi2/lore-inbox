Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314014AbSDKKUE>; Thu, 11 Apr 2002 06:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314015AbSDKKUD>; Thu, 11 Apr 2002 06:20:03 -0400
Received: from Expansa.sns.it ([192.167.206.189]:59653 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S314014AbSDKKUC>;
	Thu, 11 Apr 2002 06:20:02 -0400
Date: Thu, 11 Apr 2002 12:19:35 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: Mike Fedyk <mfedyk@matchmail.com>, Richard Gooch <rgooch@ras.ucalgary.ca>,
        Andreas Dilger <adilger@clusterfs.com>, <linux-kernel@vger.kernel.org>,
        Keith Owens <kaos@ocs.com.au>
Subject: Re: RAID superblock confusion
In-Reply-To: <15541.137.92102.72095@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.44.0204111216300.17814-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Apr 2002, Neil Brown wrote:

> On Wednesday April 10, mfedyk@matchmail.com wrote:
> > On Thu, Apr 11, 2002 at 11:38:19AM +1000, Neil Brown wrote:
> > > autodetect is the other alternative.  However, as has been mentioned,
> > > it does not and cannot work with md as a module.  This is because
> > > devices can only be register for autodetection after md.o is loaded,
> > > and autodetection is done at the time that md is loaded.  So
> > > autodetection can only work if the device driver and md are loaded at
> > > simultaneously.  i.e. they are compiled into the kernel.
> >
> > Ahh, but if you use initrd you can even have the ide and scsi drivers as
> > modules.
> >
> > What is needed is to make the disk modules depend on the raid modules (only
> > if the raid code is enabled of course) so that modprobe can load the raid
> > modules first.
you are supposing that I load md modules and raid module together, mostly
during boot with initrd. In the reality I have some servers with more that
200 days of uptime, and I have to change external disks sometime. I do
usually have two external boxes, and something like 8/20 disks (two scsi
controllers),  and different raid on different disks. You see, it is not
that easy.

Luigi


