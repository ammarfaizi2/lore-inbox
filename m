Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbTHZQX2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 12:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262846AbTHZQX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 12:23:28 -0400
Received: from dirac.phys.uwm.edu ([129.89.57.19]:24727 "EHLO
	dirac.phys.uwm.edu") by vger.kernel.org with ESMTP id S262166AbTHZQXZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 12:23:25 -0400
Date: Tue, 26 Aug 2003 11:23:19 -0500 (CDT)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: dougg@torque.net, Christoph Hellwig <hch@infradead.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-test4] blocking access to mounted scsi devices
In-Reply-To: <1061906937.1830.11.camel@mulgrave>
Message-ID: <Pine.GSO.4.21.0308261122020.576-100000@dirac.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 26 Aug 2003, James Bottomley wrote:
> On Tue, 2003-08-26 at 05:20, Douglas Gilbert wrote:
> > Christoph Hellwig wrote:
> > > That's because both mount (or e.g. volume managers) claims
> > > devices for exclusive use, as does drivers/block/scsi_ioctl.c
> > 
> > Well it is reasonable that mount should exclude other attempts
> > to mount. However the device holding the root file system
> > may be an ATA or SCSI disk and the ide-disk and sd drivers
> > do not support SMART probing directly.
> 
> Hang on, that's not the way it's supposed to work.
> 
> Mount should be on partition devices (like /dev/sda1) whereas the tools
> should be on whole disc devices (like /dev/sda).  I thought we'd agreed
> that even opening a partition exclusively wouldn't affect the ability to
> open the whole disc device (but opening the whole disc device
> exclusively would block access to all partitions).

This sounds exactly right -- tools like smartmontools address the whole
device, not a partition.

Cheers,
	Bruce

