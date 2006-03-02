Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751985AbWCBLWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbWCBLWv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 06:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWCBLWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 06:22:51 -0500
Received: from mail.dvmed.net ([216.237.124.58]:53172 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751985AbWCBLWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 06:22:50 -0500
Message-ID: <4406D588.5040900@pobox.com>
Date: Thu, 02 Mar 2006 06:22:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bsg, block layer sg
References: <20060302111945.GG4329@suse.de>
In-Reply-To: <20060302111945.GG4329@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Hi,
> 
> After all that SG_IO and cdrecord talk, I decided to brush off the bsg
> driver I wrote some time ago. Basically this is a full (aims to be at
> least, probably still some minor bits missing) SG v3 interface. It
> supports both SG_IO (which we just pass through for now), as well as
> read/write and readv/writev of sg_io_hdr structures.
> 
> What's new in this area is that the bsg character device is closely tied
> to the block device. This relationsship is depicted in sysfs. bsg
> devices will show up in /sys/class/bsg/<devname>, and there is a link
> from /sys/block/<devname>/queue/bsg to that directory. With some
> udev/hotplug magic, it should create device nodes for you automatically.
> 
> TODO:
> 
> - Fold block/scsi_ioctl.c and block/bsg.c into one
> - Further improve the sysfs relations between a device and bsg
> - Test and so on
> 
> Probably some bugs still pending, it works for me though.

For my part, this gets a strong ACK.  I've been waiting for something 
like this since an OLS discussion years ago.

Thanks Jens!

	Jeff



